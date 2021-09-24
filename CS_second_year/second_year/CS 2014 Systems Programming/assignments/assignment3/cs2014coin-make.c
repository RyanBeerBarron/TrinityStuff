/*!
 * @file cs2014coin-make.c
 * @brief This is the implementation of the cs2014 coin maker
 *
 * It should go without saying that these coins are for play:-)
 * 
 * This is part of CS2014
 *    https://down.dsg.cs.tcd.ie/cs2014/examples/c-progs-2/README.html
 */

/* 
 * Copyright (c) 2017 stephen.farrell@cs.tcd.ie
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "cs2014coin.h"
#include "cs2014coin-int.h"
#include <arpa/inet.h>
#include "mbedtls/entropy.h"
#include "mbedtls/ctr_drbg.h"
#include "mbedtls/pk.h"

#define CS2014COIN_KEYLEN 158
#define CS2014COIN_NONCELEN 32
#define CS2014COIN_HASHLEN 32
#define CC_DEBUG 0

/*!
 * @brief make a coin
 * @param bits specifies how many bits need to be zero in the hash-output
 * @param buf is an allocated buffer for the coid
 * @param buflen is an in/out parameter reflecting the buffer-size/actual-coin-size 
 * @return the random byte
 *
 * Make me a coin of the required quality/strength
 *
 */

unsigned char* generate_nonce(int noncelen)
{
	srand(time(NULL));
	unsigned char* ptr = malloc(noncelen);
	for(size_t i=0; i<noncelen; i++)
	{
		*(ptr+i) = rand();
	}
	return ptr;
}
 void incr_nonce(unsigned char *ptr, unsigned char* guard_ptr)
    {
        if ((ptr-1)==guard_ptr) return;
        unsigned char ch=*(ptr-1);
        if (ch==255) {
            incr_nonce(ptr-1,guard_ptr);
            *(ptr-1)=0;
        } else {
            *(ptr-1)=(ch+1);
        }
        return;
	}
int cs2014coin_make(int bits, unsigned char *buf, int *buflen)
{
	int offset = 0;
	int temp;
	cs2014coin_t mycoin;
	mycoin.ciphersuite = CS2014COIN_CS_0;
	mycoin.bits = bits;
	mycoin.keylen = CS2014COIN_KEYLEN;
	mycoin.keyval;
	mycoin.noncelen = CS2014COIN_NONCELEN;
	mycoin.nonceval = generate_nonce(mycoin.noncelen);
	mycoin.hashlen = CS2014COIN_HASHLEN;
	mycoin.siglen;
	
	/*		Write ciphersuite in buffer		*/
	temp = htonl(mycoin.ciphersuite);
	memcpy(buf+offset, &temp, sizeof(temp));
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,4);
#endif	
	offset = offset+4;

	/*		Write bits in buffer		*/
	temp = htonl(mycoin.bits);
	memcpy(buf+offset, &temp, sizeof(temp));
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,4);
#endif	
	offset = offset+4;

	/*		Write key length in buffer		*/
	temp = htonl(mycoin.keylen);
	memcpy(buf+offset, &temp, sizeof(temp));
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,4);
#endif	
	offset = offset+4;



	/* Generate key and write it in mycoin.keyval	*/
	mbedtls_pk_context pkey;
	mbedtls_entropy_context entropy;
	mbedtls_ctr_drbg_context ctr_drbg;
	mbedtls_pk_init( &pkey );
	mbedtls_ctr_drbg_init( &ctr_drbg );
	mbedtls_entropy_init( &entropy );
	const char *pers = "gen_key";
	mbedtls_ctr_drbg_seed( &ctr_drbg, mbedtls_entropy_func, &entropy,(const unsigned char *) pers,strlen( pers ) );
	mbedtls_pk_setup( &pkey, mbedtls_pk_info_from_type( MBEDTLS_PK_ECKEY ) );
	mbedtls_ecp_gen_key( MBEDTLS_ECP_DP_SECP521R1 , mbedtls_pk_ec( pkey ),mbedtls_ctr_drbg_random, &ctr_drbg );
	unsigned char output_buf[16000];
	memset(output_buf, 0, 16000);
	size_t len;	
	len = mbedtls_pk_write_pubkey_der(&pkey,output_buf,16000);
	mycoin.keyval = output_buf+16000-len;


	/*		Write key in buffer		*/
	memcpy(buf+offset, mycoin.keyval, mycoin.keylen);
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,mycoin.keylen);
#endif	
	offset = offset + mycoin.keylen;


	/*		Write nonce length in buffer		*/
	temp = htonl(mycoin.noncelen);
	memcpy(buf+offset, &temp, sizeof(mycoin.noncelen));
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,4);
#endif	
	
	offset = offset+4;


	/*		Write nonce in buffer		*/
	memcpy(buf+offset, mycoin.nonceval, mycoin.noncelen);
	unsigned char* nonceptr;
	nonceptr = (buf+offset);
	size_t nonceSize = mycoin.noncelen;
	nonceptr = nonceptr+nonceSize-1;
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,mycoin.noncelen);
#endif	
	offset = offset + mycoin.noncelen;
	

	/*		Write hashPoW length in buffer		*/
	temp = htonl(mycoin.hashlen);
	memcpy(buf+offset, &temp, sizeof(mycoin.hashlen));
#if CC_DEBUG
	dumpbuf("Input:",buf+offset,4);
#endif	
	offset = offset + 4;

	/*		Write null hashPoW in buffer		*/
	memset(buf+offset, 0, mycoin.hashlen);

#if CC_DEBUG
	dumpbuf("Input:",buf+offset,mycoin.hashlen);
#endif

#if CC_DEBUG
	dumpbuf("Input:",buf,242);
#endif		
	/*		Generate the hash		*/
	int nonce_index = 174;		// Nonce starts there
	size_t powhashlen=242;
	int good_pow = 0;
	int iteration = 0;
	unsigned char powbuf[CC_BUFSIZ];
	unsigned char hashbuf[CC_BUFSIZ];
	memcpy(powbuf, buf, powhashlen);
	while(!good_pow && iteration<CS2014COIN_MAXITER)
	{
		//memcpy(powbuf, buf, powhashlen);
		mbedtls_md_context_t sha_ctx;
		mbedtls_md_init( &sha_ctx );
		int rv = mbedtls_md_setup( &sha_ctx, mbedtls_md_info_from_type( MBEDTLS_MD_SHA256 ), 1 );
		mbedtls_md_starts( &sha_ctx );
		mbedtls_md_update( &sha_ctx, (unsigned char *) powbuf, powhashlen );
		mbedtls_md_finish( &sha_ctx, hashbuf );
		if(zero_bits(mycoin.bits,hashbuf,32))
			good_pow = 1;
		else
		{
			iteration++;
			incr_nonce(powbuf+nonce_index+mycoin.noncelen,powbuf+nonce_index-1);
		}
	}
	if(iteration == CS2014COIN_MAXITER)
		return(CS2014COIN_GENERR);
	/*		Update buf with correct hash and nonce		*/
	memcpy(buf+powhashlen-32,hashbuf,32);		
	memcpy(buf+174,powbuf+174,mycoin.noncelen);

#if CC_DEBUG
	dumpbuf("Input:",buf+offset,mycoin.hashlen);
#endif	
	offset = offset + mycoin.hashlen;
	
#if CC_DEBUG
	dumpbuf("Input:",buf,powhashlen);
#endif		

	/*		Sign the coin		*/
	unsigned char sig_buf[CC_BUFSIZ];
	mbedtls_md_context_t sha_ctx;
	mbedtls_md_init( &sha_ctx );
	int rv = mbedtls_md_setup( &sha_ctx, mbedtls_md_info_from_type( MBEDTLS_MD_SHA256 ), 1 );
	mbedtls_md_starts( &sha_ctx );
	mbedtls_md_update( &sha_ctx, buf, powhashlen );
	mbedtls_md_finish( &sha_ctx, sig_buf );
#if CC_DEBUG	
	dumpbuf("Input:",sig_buf,mycoin.hashlen);
#endif	
	size_t sign_len;
	mbedtls_pk_sign(&pkey,MBEDTLS_MD_SHA256, sig_buf,mycoin.hashlen,buf+offset+4,&sign_len,mbedtls_ctr_drbg_random, &ctr_drbg );
	//mbedtls_pk_sign(&pkey,MBEDTLS_MD_SHA256, buf,powhashlen,buf+offset+4,	&sign_len,mbedtls_ctr_drbg_random, &ctr_drbg );
	mycoin.siglen = sign_len;
	temp =  htonl(mycoin.siglen);
	memcpy(buf+offset, &temp, sizeof(temp));
#if CC_DEBUG
	printf("\n%d",mycoin.siglen);
	dumpbuf("Input:",buf,powhashlen+sizeof(mycoin.siglen)+mycoin.siglen);
#endif	
	*buflen = powhashlen + sizeof(mycoin.siglen) + mycoin.siglen;
	return(CS2014COIN_GOOD);
}