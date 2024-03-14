# C语言可变长数组

## 背景
最近在开发过程中无意写了一个bug，最后定位到有一个数组变量定义的长度居然是一个局部变量，让我惊讶的是，编译器居然没有报错和警告，因为在印象中，数组定义的长度不能是运行时的变量的。于是乎查阅了相关资料，发现其实这个就是c99及后面版本所具备的特性`variable length array(VLA)`，可变长数组。

## 可变长数组
什么是变长数组呢，查阅C99文档，vla是一种可以在运行时决定长度的数组，而不是在编译时决定长度，vla可以简化一些需要数组的运算，减少需要偏移计算等操作。既然是运行时，那空间是动态分配的，vla使用栈或者堆上去分配空间。要注意的是，vla必须是auto类型，不能被static extern修饰。

## 例子
### 一维可变长数组
```c
void VariableLengthArrayTest(uint32_t n)
{
    uint8_t arr1[n];
    uint8_t j = '0';
    for(uint32_t i=0;i<n;i++){
        arr1[i] = j++;
        LOG_I("arr1[%d]=%X @%p",i,arr1[i],&arr1[i]);
    }
    LOG_I("arr1@%p,sizeof(arr1):%d",arr1,sizeof(arr1));
    LOG_HEX("arr1",16,(const char*)&arr1,sizeof(arr1));
    
}

void main(void)
{
    for(uint32_t i=1;i<=4;i++)
    {
        VariableLengthArrayTest(i);
    }
}
```

### 运行结果
```c
[0] I/main: arr1[0]=30 @200233e8
[2] I/main: arr1@200233e8,sizeof(arr1):1
D/HEX arr1: 0000-000F: 30                                                  0
[7] I/main: arr1[0]=30 @200233e8
[9] I/main: arr1[1]=31 @200233e9
[11] I/main: arr1@200233e8,sizeof(arr1):2
D/HEX arr1: 0000-000F: 30 31                                               01
[17] I/main: arr1[0]=30 @200233e8
[19] I/main: arr1[1]=31 @200233e9
[21] I/main: arr1[2]=32 @200233ea
[23] I/main: arr1@200233e8,sizeof(arr1):3
D/HEX arr1: 0000-000F: 30 31 32                                            012
[29] I/main: arr1[0]=30 @200233e8
[30] I/main: arr1[1]=31 @200233e9
[32] I/main: arr1[2]=32 @200233ea
[34] I/main: arr1[3]=33 @200233eb
[36] I/main: arr1@200233e8,sizeof(arr1):4
D/HEX arr1: 0000-000F: 30 31 32 33                                         0123
```

### 多维数组
```c
void VariableLengthArrayTest2(uint32_t n,uint32_t j)
{
    uint8_t arr2[n][j];
    LOG_I("arr2@%p,sizeof(arr2):%d",arr2,sizeof(arr2));
}

void main(void)
{
    for(uint32_t i=1;i<=8;i++)
    {
        VariableLengthArrayTest2(i);
    }
}
```

### 运行结果
```c
[0] I/main: arr2@200233e8,sizeof(arr2):1
[2] I/main: arr2@200233e8,sizeof(arr2):4
[4] I/main: arr2@200233e8,sizeof(arr2):9
[7] I/main: arr2@200233e8,sizeof(arr2):16
[9] I/main: arr2@200233e8,sizeof(arr2):25
[11] I/main: arr2@200233e8,sizeof(arr2):36
[13] I/main: arr2@200233e8,sizeof(arr2):49
[16] I/main: arr2@200233e8,sizeof(arr2):64
```

## 总结
回到最前面，当我发现无意中定义了一个vla数组时，程序并没有跑起来，这是因为系统的堆区被我设置为0了，从定义无疑可以得知，vla需要使用堆或栈区来实现，而我使用的编译器使用的是堆区去实现，因此修改系统的堆大小后，程序如期运行。但对于这种运行时取决于堆栈区的操作，我一般还是避免使用的，因此最后还是改为定长数组了。

## one more thing
为了提高自己的英语写作能力，之后的公众号文章将尽量以双语形式提供，由于时间仓促及靠语感，因此会出现很多语法错误和表述错误也不奇怪，欢迎指正～


---

---
## Background
Recently, i found a bug though my daily develop which confuse me a lot, after some debugging,  i trace it back to an array which length is define as a variable. What surprise me is that the compiler didn't throw warning or error at all. So i search some document and find out its the new feature provide in C99, and its call `variable length array(VLA)`.

## what is variable length array?
So what is the variable length array?  It's an array data structure whose length is determined at runtime instead of at compile time. This can be simplify programming of numerical algorithms. Because it's runtime, the array space will be allocate in stack or heap, also vla must be defined as auto variables, and can not be decorate as static or extern.

## example
### one-dimensional VLA
```c
void VariableLengthArrayTest(uint32_t n)
{
    uint8_t arr1[n];
    uint8_t j = '0';
    for(uint32_t i=0;i<n;i++){
        arr1[i] = j++;
        LOG_I("arr1[%d]=%X @%p",i,arr1[i],&arr1[i]);
    }
    LOG_I("arr1@%p,sizeof(arr1):%d",arr1,sizeof(arr1));
    LOG_HEX("arr1",16,(const char*)&arr1,sizeof(arr1));
    
}

void main(void)
{
    for(uint32_t i=1;i<=4;i++)
    {
        VariableLengthArrayTest(i);
    }
}
```
### result
```c
[0] I/main: arr1[0]=30 @200233e8
[2] I/main: arr1@200233e8,sizeof(arr1):1
D/HEX arr1: 0000-000F: 30                                                  0
[7] I/main: arr1[0]=30 @200233e8
[9] I/main: arr1[1]=31 @200233e9
[11] I/main: arr1@200233e8,sizeof(arr1):2
D/HEX arr1: 0000-000F: 30 31                                               01
[17] I/main: arr1[0]=30 @200233e8
[19] I/main: arr1[1]=31 @200233e9
[21] I/main: arr1[2]=32 @200233ea
[23] I/main: arr1@200233e8,sizeof(arr1):3
D/HEX arr1: 0000-000F: 30 31 32                                            012
[29] I/main: arr1[0]=30 @200233e8
[30] I/main: arr1[1]=31 @200233e9
[32] I/main: arr1[2]=32 @200233ea
[34] I/main: arr1[3]=33 @200233eb
[36] I/main: arr1@200233e8,sizeof(arr1):4
D/HEX arr1: 0000-000F: 30 31 32 33                                         0123
```

### multi-dimensional VLA
```c
void VariableLengthArrayTest2(uint32_t n,uint32_t j)
{
    uint8_t arr2[n][j];
    LOG_I("arr2@%p,sizeof(arr2):%d",arr2,sizeof(arr2));
}

void main(void)
{
    for(uint32_t i=1;i<=8;i++)
    {
        VariableLengthArrayTest2(i);
    }
}
```
### result
```c
[0] I/main: arr2@200233e8,sizeof(arr2):1
[2] I/main: arr2@200233e8,sizeof(arr2):4
[4] I/main: arr2@200233e8,sizeof(arr2):9
[7] I/main: arr2@200233e8,sizeof(arr2):16
[9] I/main: arr2@200233e8,sizeof(arr2):25
[11] I/main: arr2@200233e8,sizeof(arr2):36
[13] I/main: arr2@200233e8,sizeof(arr2):49
[16] I/main: arr2@200233e8,sizeof(arr2):64
```

## conclusion
So back to the beginning, when i unconscious define an array as VLA, the program didn't run as i expected. Because my heap is set to 0, and my compiler implemented vla as heap-base. So when i resize the heap size, the program work as i expected. Through my develop experience, it's very danger to use runtime base operation, such as malloc()/free(), because it will add uncertainty to your program. Finally i redefined this array to normal array(compile time).