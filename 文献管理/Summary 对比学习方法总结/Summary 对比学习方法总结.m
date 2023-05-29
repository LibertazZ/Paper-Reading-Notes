# 本总结包含的文献 

* Unsupervised Feature Learning via Non-Parametric Instance Discrimination  
* Unsupervised Embedding Learning via Invariant and Spreading Instance Feature 
* Representation Learning with Contrastive Predictive Coding  
* Contrastive Multiview Coding    
* Momentum Contrast for Unsupervised Visual Representation Learning  
* A Simple Framework for Contrastive Learning of Visual Representations

# Unsupervised Feature Learning via Non-Parametric Instance Discrimination 
* 俗称InsDis，因为本文首次提出这个代理任务。
* 动机：来自于对神经网络在监督任务中自发地对相似的类别产生相近的输出结果，对差别较大的类别产生差异性较大的输出结果产生差异较大的结果，因此提出了InsDis这一代理任务，即认为一张图像就是一个一个类，这样神经网络会自发地对相似的图片产生相近的输出结果，很巧妙的构思。  
![图片alt](图片1.png "动机")
* 模型设计：初期的模型只是一个简单的卷积神经网络，输入图片，输出128维的特征向量。同时提出了memory bank这一结构，是一个形状为N，128的存储矩阵，N是训练集的样本数，保存了所有训练样本经过编码后的特征向量。
* 正负类的划分：这里没有提出严格的正类，一张图片当前经过网络输出特征向量直接与memory bank中存储的这张图片的特征向量计算余弦相似度。负类样，从memory bank中抽样得到的其他图片的特征向量。
* 损失函数：一个最原始的NCE损失函数，对于一张输入图片，使用NCEloss最大化当前经过网络输出特征向量直接与memory bank中存储的这张图片的特征向量计算余弦相似度，其他抽样得到的样本均作为负类，最小化他们的余弦相似度即可。  
![图片alt](图片2.png "流程")

# Unsupervised Embedding Learning via Invariant and Spreading Instance Feature 
* 俗称InvaSpread
* 动机：一张图片经过数据增强后，监督训练的神经网络能够对其产生相近的分类结果，而两张不同的图片，神经网络自然不能产生相近的结果，因此监督训练的网络能够捕捉数据增强前后同一张图片的相似性，那么通过无监督训练是否能更有目的性地学习到图片的本质特征。  
![图片alt](图片3.png "动机")
* 模型设计：使用同一个CNN提取图片的特征，对于原始图片与数据增强后的图片分别使用各自的FC进一步将CNN的提取特征转化为特征向量，并进行二范数归一化。  
![图片alt](图片4.png "流程")
* 正负类的划分：此时就有了合理的正负类划分，对于一批样本N中的某一个样本，其数据增强后的版本就是他的正类，而其余N-1张样本就是他的负类（这里负类不包括这N-1张样本的数据增强版）
* 损失函数：对于一批样本N中的某一个样本，原始版本经过第一个FC得到N个特征向量组1，我们使用损失函数的第一部分（一个以实例为一个类别的交叉熵损失函数）最小化当前样本被分类为其他N-1个类的概率。  
![图片alt](图片5.png "当前原始样本被分类为其他实例的概率，最小化此概率")  
数据增强版本经过一个FC后得到N个特征向量组2，每个数据增强的样本以特征向量组1为权重，最大化当前样本被分类为当前类的概率。  
![图片alt](图片6.png "当前增强样本被分类为当前实例的概率，最大化此概率")  
注意这里充当分类权重的向量均为特征向量组1  
对单个实例总的损失函数可以描述为：  
![图片alt](图片7.png )  

# Representation Learning with Contrastive Predictive Coding  
* 俗称CPC
* 动机：就是将设计了一个预测代理任务，通过上下文信息对接下来的序列内容的编码进行预测，预测的编码与真实接下来的序列内容的编码进行比对，达到最大化上下文信息与下面序列内容之间的互信息的目的，通过希望用这种预测加对比的任务来学习到一些信息。  
* 正负样本的划分：对于以上下文信息编码为输入，经过一个预测网络，得到的预测编码而言，正类自然就是真正的序列信息经过特征提取网络得到的编码信息，负类就是其他序列内容得到的编码信息。
* 损失函数于InsDis中提到的NCE相近，旨在拉近预测编码与真实编码的距离，同时拉远预测编码与负类编码直间的问题。  
![图片alt](图片8.png )   
![图片alt](图片9.png )   

# Contrastive Multiview Coding   
* 俗称CMC
* 动机：一张图片的多个视图并不影响人类对其语义信息的判断，这意味着语义信息等在多个视图中是共享的，如果能够提取到这些共享信息并对这些信息进行编码，这个编码就包含了一个图片的不同视图之间的共享信息，可以被用于执行其他下游任务。
* 与上述任务的不同：  
    1. InvaSpread使用原样本与数据增强版本构成正样本对，CMC使用一个图片的几个视图构建正样本组
    2. InvaSpread对原始样本与增强版本使用相同的卷积参数，最后的FC层是各自的，CMC对每一个视图都使用各自的特征提取网络
    3. CMC中每一个视图都是等价的，有N个视图，将构建N个memory bank，当以视图1为核心时,其余N-1个memory bank将作为权重矩阵，下面的操作与IstDIS一致，采用NCE损失，拉近同一个图片不同视图之间的特征向量的距离，图开不同图片直间的距离，每一个视图将轮流充当核心   
![图片alt](图片10.png )  
 
# Momentum Contrast for Unsupervised Visual Representation Learning
* 俗称Moco
* Moco的最大贡献是对前述工作的有效总结：  
![图片alt](图片11.png )  
    1. end to end形式所有正负类均来自当前minibatch输出的特征向量，那么所有正负样本都来自于同一个网络参数下输出的特征向量，这具有很好的一致性，但是受限于minibatch的大小，负样本的个数受到了限制。
    2. memory bank形式保存了整个训练集的特征向量，可以取得大量的负样本，但是memory bank中的特征向量更新不是同步的，每次只有当前minibatch对应的特征向量进行更新，整个epoch后memory bank才被完整跟新一次，这使得负样本来自于不同网络参数下的特征向量，一致性较差。
    3 Moco改进了memory bank的形式，改用FIFO的queue（先进先出的队列），队列中只有最近几代的minibatch，同时配合一个动量编码器，保证queue中的特征向量是使用几乎相同的网络参数进行提取的，且负样本的数量可以是数倍的minibatch大小，兼具一致性与较大的负样本数量。

# A Simple Framework for Contrastive Learning of Visual Representations
* 俗称Simclr  
* 二点贡献：  
![图片alt](图片12.png )  
    1. 神经网络提取的特征向量h经过一个两层的全连接结构得到z，用z计算对比损失，能有效提高特征向量h的质量
    2. 使用不同的数据增强有不同的效果，其中color distort与crop相组合效果最好
* 可以说这就是从Invanspread进化简化和抽象出来的算法。
 