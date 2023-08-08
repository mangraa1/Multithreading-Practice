import UIKit

//Thread
//Operation
//GCD

//------Parallel------
// Thread1 ------
// Thread2 ------

//------Сonsecutive------
// Thread1 - - - - - -
// Thread2  - - - - -

//------Async------
// 1Main(UI) -----
// 2Thread     -

//MARK: - Unix - POSIX

var thread = pthread_t(bitPattern: 0) // Create thread
var attribut = pthread_attr_t()

pthread_attr_init(&attribut)
pthread_create(&thread, &attribut, { pointer in
    print("test1")
    return nil
}, nil)

//MARK: - Thread

var nsthread = Thread  {
    print("test2")
}
nsthread.start()
