Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709581742;
	Mon, 26 Aug 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655304; cv=none; b=OzKjDQBgvLWMHKFNAh0R7wRlb//OOZhnFJx/LousFxdewWb6nbhQrKN9+F2srD9tFOGP/RUkDmkpFwlYyyzl0yXvoqLqRUncXY/bowYz/CtqkDOVlXsQAx0vFpxuVQcwieIxOEMnA9JpwaWq3vIlKRDQ+5Edq8JM+NuaKU8XFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655304; c=relaxed/simple;
	bh=TNAB5I97eN+IOjitMnU+QdfY6Bt4DsWvWrLOVhlZJmw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t4XbZqJzJLRGpJsylCvXt1ETwuktGBK28aUcJLql8tx7SgC2nq/s3m5sQMF7KOmNSK1hJZ8tLn4pCfv+mw4MvqQ7/HaXa0HEQpBOHCNm/J7T/z7E/yra9qQX5HpJCkW2DtkdAJbbGd+qWmod4kpay44p55Pu9b45Yroz1thZDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8BxKurDJsxm3SMgAA--.908S3;
	Mon, 26 Aug 2024 14:54:59 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMBxsuHDJsxmGq8iAA--.41059S2;
	Mon, 26 Aug 2024 14:54:59 +0800 (CST)
Message-ID: <fb0ddbe0-8613-40ac-a3fb-9e544c50088d@loongson.cn>
Date: Mon, 26 Aug 2024 14:54:59 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v3 3/3] LoongArch: Update dts to support Loongson UART
 driver.
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, p.zabel@pengutronix.de, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
 <20240826024705.55474-4-zhenghaowei@loongson.cn>
 <gtbaqcnk4g3f4achlyiixu2bbb2rxoxoitbltqxavexjoyqxlf@furbr4zsirkz>
Content-Language: en-US
In-Reply-To: <gtbaqcnk4g3f4achlyiixu2bbb2rxoxoitbltqxavexjoyqxlf@furbr4zsirkz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxsuHDJsxmGq8iAA--.41059S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgEBBGbLHpsHPQAAsU
X-Coremail-Antispam: 1Uk129KBj9xXoWrtw4rtF47ZFWruryxXrW8GrX_yoW3Zrc_KF
	yDKw1qgw18GrWfXw4aq3W3Aa9Ig340y3Z5GrW0vw1S9343tr9Fkr4kAF95ua43WFZF9FWF
	9r1rGw1UCr1fGosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz-eOUUUUU=


在 2024/8/26 14:00, Krzysztof Kozlowski 写道:
> On Mon, Aug 26, 2024 at 10:47:05AM +0800,zhenghaowei@loongson.cn wrote:
>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>
>> Change to use the Loongson UART driver for Loongson-2K2000,
>> Loongson-2K1000 and Loongson-2K0500.
> Why?
>
> That's what commit msg should explain.  This is not bisectable and
> breaks users without any reasonable need/explanation.
>
> Best regards,
> Krzysztof

I got it, and I will provide detailed explanations like this:

We have provided separate UART drivers for ls2k0500,  ls2k1000, and

ls2k2000, which solves the issue of the full-featured serial port being

unusable. Additionally, we have implemented fractional division

functionality for ls2k2000.


Best regards,

Haowei Zheng

