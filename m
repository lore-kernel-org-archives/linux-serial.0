Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAB55896;
	Mon, 12 Aug 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450190; cv=none; b=cqu4nGdaSXpjNi/ap3L/JMT4jyAGb2os5QrLpcUTk33mMNHnPX6OwUn+q+DRmLDkou166GNKQNiWDrs48SilK8EvPPKYsqL6rTQzZWkYff1Es52COZ1daV4BQkrsqcQ+x7TH3lXqjP3kOxoHmFW+UfpUYHguc+4mSXic0sPRL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450190; c=relaxed/simple;
	bh=MymABODoNzdcJuxFX81hO8y/q4Tq1tl0mnP5gVYW59w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K9C4RcmWHf85u/F3/4dqAH8kHJFpHaTkk+bVj1m4hGfyst6heE7B4GVbjl2FfPa38V0V9ei9+5xOrdpfbcHZ2MN+hU4m5vkItodtfqOBVZPRC/Oa5/ovcgR6FhgtksajFHoD/hrJms8PTtPvVJdcXg97opMIyG8VpFSGpigXXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8DxvptJw7lmMoYQAA--.16163S3;
	Mon, 12 Aug 2024 16:09:45 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxM+BIw7lmbv8PAA--.24071S2;
	Mon, 12 Aug 2024 16:09:44 +0800 (CST)
Message-ID: <32ff2c9b-1d34-4637-80ff-e8eefe253a95@loongson.cn>
Date: Mon, 12 Aug 2024 16:09:44 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: Add Loongson UART controller
To: Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <4d1f2426-b43c-4727-8387-f18edf937163@kernel.org>
 <f31609c4-1e47-49bc-9231-5b0353d35dc9@loongson.cn>
 <601adbfd-fbb6-48c6-b755-da1b5d321d6b@kernel.org>
 <89e71573-9365-2e61-bb38-759363df1b8b@loongson.cn>
 <5fdf6810-f729-42bf-a5fd-a2de02d0a894@kernel.org>
Content-Language: en-US
In-Reply-To: <5fdf6810-f729-42bf-a5fd-a2de02d0a894@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxM+BIw7lmbv8PAA--.24071S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgEHBGa4qZkJTwABsp
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyfGr15KrWrAryrtFyUXFc_yoW8ZFW3p3
	y5Ga47Aryvqr4Fvw40q348JrsIyr98Jr4DZw45JryUGa90gw12yrWayF45C3s7WryUZryj
	qr4Utayxua15uFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU2MKZDUUUU


在 2024/8/9 18:05, Krzysztof Kozlowski 写道:
> On 09/08/2024 11:55, 郑豪威 wrote:
>>>>>> +    description: Enables fractional-N division. Currently,
>>>>>> +      only LS2K1500 and LS2K2000 support this feature.
>>>>>> +
>>>>>> +  rts-invert:
>>>>>> +    description: Inverts the RTS value in the MCR register.
>>>>>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>>>>>> +      series CPUs, and Loongson LS7A bridge chips.
>>>>>> +
>>>>>> +  dtr-invert:
>>>>>> +    description: Inverts the DTR value in the MCR register.
>>>>>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>>>>>> +      series CPUs, and Loongson LS7A bridge chips.
>>>>>> +
>>>>>> +  cts-invert:
>>>>>> +    description: Inverts the CTS value in the MSR register.
>>>>>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>>>>>> +      and Loongson LS7A bridge chips.
>>>>>> +
>>>>>> +  dsr-invert:
>>>>>> +    description: Inverts the DSR value in the MSR register.
>>>>>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>>>>>> +      and Loongson LS7A bridge chips.
>>> Same questions for all these. Why choosing invert is a board level
>>> decision? If it "should be used" then why it is not used always?
>>>
>> Because these features are not applicable to all chips, such as
>> 'fractional-division',
> Hm?
>
>> which is currently supported only by 2K1500 and 2K2000, and for
>> Loongson-3 series
> These are SoCs. Compatible defines that. Please align with your
> colleagues, because *we talked about this* already.
>
> Best regards,
> Krzysztof

I consulted with my colleagues and would like to confirm with you. For 
the five

properties provided, fractional-division is offered as a new feature,  
supported by

2K1500 and 2K2000. As for the invert property, it is due to a bug in our 
controller,

and its usage may vary across different chips. Should we add different 
compatible

values to address these issues for different chips, whether they are new 
features or

controller bugs?


Best regards,

Haowei Zheng

