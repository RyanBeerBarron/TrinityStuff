"use strict";
let count = 25

function countdown(count) {
    if (count <= 0) {
        console.log("Finished")
        return
    }
    let p = new Promise(function (resolve, reject) {
        setTimeout( _ => resolve(count), 5000)
    })
    p.then(function (value) {
        console.log(value)
        countdown(value-5)
    })
}

let p = new Promise(function (resolve) {
    setTimeout( _ => {console.log(count); resolve(count-1)}, 1000)
})
for(let i=25; i>=0; i--) {
    p = p.then(value => new Promise(resolve =>
        setTimeout(function () {
            console.log(value);
            resolve(value-1);
        }, 1000)
    ))
}
