# objc_runtime_1
Runtime学习一
1、Ivar的class_copyIvarList函数获取的实例变量和_属性。class_copyPropertyList函数只获取类的属性。
2、id objc_msgSend(id self, SEL op, ...)函数发送步骤：（注意还有objc_msgSendSuper，objc_msgSend_stret等函数）
 检测这个 selector 是不是要忽略的。比如 Mac OS X 开发，有了垃圾回收就不理会 retain, release 这些函数了。
 检测这个 target 是不是 nil 对象。ObjC 的特性是允许对一个 nil 对象执行任何一个方法不会 Crash，因为会被忽略掉。
 如果上面两个都过了，那就开始查找这个类的 IMP，先从 cache 里面找，完了找得到就跳到对应的函数去执行。
 如果 cache 找不到就找一下方法分发表。
 如果分发表找不到就到超类的分发表去找，一直找，直到找到NSObject类为止。
 如果还找不到就要开始进入动态方法解析了。
3、动态方法解析
①resolveInstanceMethod或者resolveClassMethod来动态添加特定方法
②通过forwardingTargetForSelector来快速重定向转发
③通过forwardInvocation来转发，这里还要重写methodSignatureForSelector方法。
4、object_getClass(obj)与[obj class]的区别：前者返回一个isa指针，后者返回自身；
