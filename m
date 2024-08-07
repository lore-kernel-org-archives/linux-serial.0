Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9C1C9DF3;
	Wed,  7 Aug 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019031; cv=none; b=n1Aodg4ULPPQ1duIg4u2J3L27xSFBBnjz5lIeEqSxQAyR0c8BocLpgp7JY47CxSSzhcVVbOsBoZp2OmlFB1SuEZ47ak9KcpMnNXz1W3u7cNwF4Ms725uVpsHqvl4ihGSUhxF6gUW3pLfCNheymfxROrmL66It4p5rsB+4OS8DNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019031; c=relaxed/simple;
	bh=ZQYMwzixvYDiYSkoVYrM7PzXcdK9+z4VeEcg+7dgiw8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nPpGbsuqk9Iji3vIP7orvi3NSTTgQRpKGPA7VTBJNKHBZX/naQLDhZJP+oWC9xVhRUKAwUXMCuxafugt+ZESVo0HUB5Iz1Hp8h18rwYzz12EsDrj5apVep/Exx4255F8LAIB3QsGs23JhxtfashBmtO+KK9hhbuC+kM2nf+EKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8DxyOkTL7Nm2CYKAA--.31717S3;
	Wed, 07 Aug 2024 16:23:47 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMAx3eMSL7NmNbUHAA--.11002S2;
	Wed, 07 Aug 2024 16:23:46 +0800 (CST)
Message-ID: <f31609c4-1e47-49bc-9231-5b0353d35dc9@loongson.cn>
Date: Wed, 7 Aug 2024 16:23:46 +0800
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
Content-Language: en-US
In-Reply-To: <4d1f2426-b43c-4727-8387-f18edf937163@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAx3eMSL7NmNbUHAA--.11002S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQECBGayEXMQKQAAsJ
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1UAw1xGryrArW7WFW8Zrc_yoW5ZF4kpa
	15CanFyr4qqr1xuws7ta4fAFn3Z393JFnrur4Dt34UKa909w1Sqr1ak3WY9397WryUZrW2
	q3Wjk3y7ua15ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz-eOUUUUU=


在 2024/8/4 16:43, Krzysztof Kozlowski 写道:
> On 04/08/2024 08:38,zhenghaowei@loongson.cn wrote:
>
> Due to lack of changelog, I assume you send the same patch, so:
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>
>
> Also:
>
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  fractional-division:
> Where are this and following defined? In which schema?
>
These and the ones below are new definitions, can I use them like this?

+  fractional-division:
+    description: Enables fractional-N division. Currently,
+      only LS2K1500 and LS2K2000 support this feature.
+    type: boolean

>> +    description: Enables fractional-N division. Currently,
>> +      only LS2K1500 and LS2K2000 support this feature.
>> +
>> +  rts-invert:
>> +    description: Inverts the RTS value in the MCR register.
>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>> +      series CPUs, and Loongson LS7A bridge chips.
>> +
>> +  dtr-invert:
>> +    description: Inverts the DTR value in the MCR register.
>> +      This should be used on Loongson-3 series CPUs, Loongson-2K
>> +      series CPUs, and Loongson LS7A bridge chips.
>> +
>> +  cts-invert:
>> +    description: Inverts the CTS value in the MSR register.
>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>> +      and Loongson LS7A bridge chips.
>> +
>> +  dsr-invert:
>> +    description: Inverts the DSR value in the MSR register.
>> +      This should be used on Loongson-2K0500, Loongson-2K1000,
>> +      and Loongson LS7A bridge chips.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +allOf:
>> +  - $ref: serial.yaml
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
>> +
>> +    serial@1fe001e0 {
>> +        compatible = "loongson,ls7a-uart";
>> +        reg = <0x0 0x1fe001e0 0x0 0x10>;
>> +        clock-frequency = <100000000>;
>> +        interrupt-parent = <&liointc>;
>> +        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
>> +        fractional-division;
>> +        rts-invert;
>> +        dtr-invert;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8766f3e5e87e..a6306327dba5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13189,6 +13189,13 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>>   F:	drivers/i2c/busses/i2c-ls2x.c
>>   
>> +LOONGSON UART DRIVER
>> +M:	Haowei Zheng<zhenghaowei@loongson.cn>
>> +L:	linux-serial@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/serial/loongson,ls7a-uart.yaml
>> +F:	drivers/tty/serial/8250/8250_loongson.c
> There is no such file.
>
> Best regards,
> Krzysztof

The file "drivers/tty/serial/8250/8250_loongson.c" will be created in 
the patch

"tty: serial: 8250: Add loongson uart driver support". Is it 
inappropriate to reference it here?


Best regards,

Haowei Zheng

