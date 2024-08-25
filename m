Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461F88C11;
	Sun, 25 Aug 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724556871; cv=none; b=FboT0LZNg5HQdK41pdG/bIbDMF2q7DukTeumxVCeaSyakVRZBz0kLSpbBqfefjMK2gn7ya65LJGG5ZuMilFnxTnI7eOqKlB2OZUo32GghSUDsAc88TuU/k/z2Z3KYVyaj/MF9kkcxS/rZL4SeCu51lJ9ht66mf02tDhda8sZgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724556871; c=relaxed/simple;
	bh=GLh0c4J0+6QysF3awcYBVB6C1NnBKgCQzHe7q4s8x9k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HmVB3LCYU1IugzqL/PbItILkNZHoPhHBJdyQitJd6iYbvPGYL4l+0PBEhePpjb8lh12djPYChaOuZYzUA1praX+R/00crzPWAVcJlKU6oPQMQR5ZYJMF/teem9/UIiJmd1wbe8oQuR0i3L2hTXIiKszqHLDhwWQtEXh2GVdTcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8Axz5s7pspmVCsfAA--.38421S3;
	Sun, 25 Aug 2024 11:34:19 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMAx62Y5pspm62shAA--.6265S2;
	Sun, 25 Aug 2024 11:34:17 +0800 (CST)
Message-ID: <778e50bc-58db-42e6-aee3-3b1e01ca227d@loongson.cn>
Date: Sun, 25 Aug 2024 11:34:17 +0800
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
 p.zabel@pengutronix.de, zhuyinbo <zhuyinbo@loongson.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang <wanghongliang@loongson.cn>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, loongarch@lists.linux.dev
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
 <4d1f2426-b43c-4727-8387-f18edf937163@kernel.org>
 <f31609c4-1e47-49bc-9231-5b0353d35dc9@loongson.cn>
 <601adbfd-fbb6-48c6-b755-da1b5d321d6b@kernel.org>
 <89e71573-9365-2e61-bb38-759363df1b8b@loongson.cn>
 <5fdf6810-f729-42bf-a5fd-a2de02d0a894@kernel.org>
 <32ff2c9b-1d34-4637-80ff-e8eefe253a95@loongson.cn>
 <d9d76a4a-1552-462b-b946-6475645c6f59@kernel.org>
Content-Language: en-US
In-Reply-To: <d9d76a4a-1552-462b-b946-6475645c6f59@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx62Y5pspm62shAA--.6265S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgEABGbJzRsCPAAAsA
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1DJryDtrWkCr15CFyfAFc_yoWrKw17pF
	4rGanrGryUtr10vr4Ut3W8Jr95t3s8Jw1DXr48XF17Gayqqw1jqr1rZF4jgryfXr48Jryj
	qr1UKFy7ZF47Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aDUUUUU==


在 2024/8/12 16:25, Krzysztof Kozlowski 写道:
> On 12/08/2024 10:09, 郑豪威 wrote:
>> 在 2024/8/9 18:05, Krzysztof Kozlowski 写道:
>>> On 09/08/2024 11:55, 郑豪威 wrote:
>>>>>>>> +    description: Enables fractional-N division. Currently,
>>>>>>>> +      only LS2K1500 and LS2K2000 support this feature.
>>>>>>>> +
>>>>>>>> +  rts-invert:
>>>>>>>> +    description: Inverts the RTS value in the MCR register.
>>>>>>>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>>>>>>>> +      series CPUs, and Loongson LS7A bridge chips.
>>>>>>>> +
>>>>>>>> +  dtr-invert:
>>>>>>>> +    description: Inverts the DTR value in the MCR register.
>>>>>>>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>>>>>>>> +      series CPUs, and Loongson LS7A bridge chips.
>>>>>>>> +
>>>>>>>> +  cts-invert:
>>>>>>>> +    description: Inverts the CTS value in the MSR register.
>>>>>>>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>>>>>>>> +      and Loongson LS7A bridge chips.
>>>>>>>> +
>>>>>>>> +  dsr-invert:
>>>>>>>> +    description: Inverts the DSR value in the MSR register.
>>>>>>>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>>>>>>>> +      and Loongson LS7A bridge chips.
>>>>> Same questions for all these. Why choosing invert is a board level
>>>>> decision? If it "should be used" then why it is not used always?
>>>>>
>>>> Because these features are not applicable to all chips, such as
>>>> 'fractional-division',
>>> Hm?
>>>
>>>> which is currently supported only by 2K1500 and 2K2000, and for
>>>> Loongson-3 series
>>> These are SoCs. Compatible defines that. Please align with your
>>> colleagues, because *we talked about this* already.
>>>
>>> Best regards,
>>> Krzysztof
>> I consulted with my colleagues and would like to confirm with you. For
>> the five
>>
>> properties provided, fractional-division is offered as a new feature,
>> supported by
>>
>> 2K1500 and 2K2000. As for the invert property, it is due to a bug in our
>> controller,
>>
>> and its usage may vary across different chips. Should we add different
>> compatible
>>
>> values to address these issues for different chips, whether they are new
>> features or
>>
>> controller bugs?
> How did you align? We had already talks with you about this problem -
> you need specific compatibles. How you explain above properties, all of
> them are deducible from the compatible, so drop them.
>
> Your entire argument above does not address at all my concerns, so
> before you respond repeating the same, really talk with your colleagues.
>
> One of many previous discussions:
> https://lore.kernel.org/linux-devicetree/25c30964-6bd3-c7eb-640a-ba1f513b7675@linaro.org/
>
> https://lore.kernel.org/linux-devicetree/20230526-dolly-reheat-06c4d5658415@wendy/
>
> I wish we do not have to keep repeating the same to Loongson. Please
> STORE the feedback for any future submissions, so you will not repeat
> the same mistakes over and over.
>
> Best regards,
> Krzysztof

Hi:

I have been aligning with my colleagues over the past few days and

reviewing previous discussions. Based on these, I have made the

following modifications according to the differences in the controller:

+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - loongson,ls7a-uart
+          - loongson,ls3a5000-uart
+          - loongson,ls2k2000-uart
+      - items:
+          - enum:
+              - loongson,ls2k1000-uart
+              - loongson,ls2k0500-uart
+          - const: loongson,ls7a-uart
+      - items:
+          - enum:
+              - loongson,ls2k1500-uart
+          - const: loongson,ls2k2000-uart
+      - items:
+          - enum:
+              - loongson,ls3a6000-uart
+          - const: loongson,ls3a5000-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+allOf:
+  - $ref: serial.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    serial@1fe20000 {
+        compatible = "loongson,ls2k1000-uart", "loongson,ls7a-uart";
+        reg = <0x1fe20000 0x10>;
+        clock-frequency = <125000000>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <0x0 IRQ_TYPE_LEVEL_HIGH>;
+    };

Does this modification meet the expectation?

Best regards,

Haowei Zheng

