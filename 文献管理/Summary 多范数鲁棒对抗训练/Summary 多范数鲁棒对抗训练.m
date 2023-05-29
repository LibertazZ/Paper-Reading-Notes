# 本总结包含的文献 

* Adversarial Training and Robustness for Multiple Perturbations
* Adversarial Robustness Against the Union of Multiple Perturbation Models 
* Learning to Generate Noise for Multi-Attack Robustness
* Adversarial Robustness against Multiple and Single lp-Threat Models via Quick Fine-Tuning of Robust Classifiers   
* Toward Efficient Robust Training against Union of ℓp Threat Models  

# Adversarial Training and Robustness for Multiple Perturbations
* 提出方法，MAX,AVG
* MAX本质上就是损失函数的修改，前者就是对一个mini-batch用几种范数独立地生成对抗样本，看那种对抗样本的损失值最大就用这种对抗样本进行本次batch的更新，其他的对抗样本就抛弃了。AVG方法是将这几种对抗样本的损失做平均之后进行反向传递。

# Adversarial Robustness Against the Union of Multiple Perturbation Models 
* 提出方法MSD
* MSD即联合最速下降攻击，与AVG的区别在于MSD使用三种范数获得三种扰动然后对扰动进行平均，添加到原始图片上之后求损失，AVG是每种扰动独立地添加到图片上独立求损失然后对损失值进行平均，简单来说就是进行平均的时机不同。

# Learning to Generate Noise for Multi-Attack Robustness
* 提出方法SAT
* 所谓随机对抗训练，每个minibatch从三种范数中等概率选择一种对抗样本生成方法。
此外损失函数部分进行了改进，引入了MNG（meta noise generator）机制去学习三种范数噪声的生成，并且引入一致性损失作为正则化项。 

# Adversarial Robustness against Multiple and Single lp-Threat Models via Quick Fine-Tuning of Robust Classifiers   
* E-AT极端范数对抗训练（也就是使用1和无穷两种极端的范数进行对抗训练期望达到对所有范数的鲁棒性）
* 通过一些结论证明只需要对1范数和无穷范数进行训练就能够实现对二范数的鲁棒性，因此训练时只使用了1范数和二范数的对抗样本，此外对每批图像会依概率选择两种范数中的一种作为对抗样本生成算法，不是等概率选择的，而是那种范数对抗样本的分类正确率低，选择该范数的概率值大。
* 此外关于训练过程，一种是从随机初始化网络开始直接使用E-AT进行对抗训练，第二种是使用一种范数按照常规对抗训练的流程进行对抗训练，在得到的对单一范数鲁棒的网络上使用E-AT进行微调得到多范数鲁棒性网络。 

# Toward Efficient Robust Training against Union of ℓp Threat Models  
* 俗称NCAT
* 原方法是NuAT是一种已有的基于核范数正则化的对抗训练损失函数，c的意思是加入了课程即训练过程中对抗攻击的强度逐渐增大来避免灾难性过拟合。，每次迭代的过程是将各种范数的攻击生成的噪声累加起来类似于MSD
* 特点在于每一步都是单步攻击。

