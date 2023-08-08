import UIKit

//MARK: POSIX Threads

var pthread = pthread_t(bitPattern: 0)
var attribute = pthread_attr_t()

pthread_attr_init(&attribute)
pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0) // Priority

pthread_create(&pthread, &attribute, { pointer in
    print("test1")

    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0) // Priority override

    return nil
}, nil)

//MARK: - Thread

let nsThread = Thread {
    print("test2")
    print(qos_class_self())
}
nsThread.qualityOfService = .userInteractive
nsThread.start()

print(qos_class_main())
