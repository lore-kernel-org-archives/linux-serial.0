Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3C4EB2B;
	Mon, 26 Aug 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655289; cv=none; b=OHyUkDmdgyvGs43dZRnfEOyIwxx25j6pIBH0WBjb2CGd0jHDZ3+b+KHoMRmwdbz111iwBHcsgL98UOkqM/c+kmVgi71T/AGhkpoDSbD4M5p1qhtZWNTuyI103iB76llywZgnm3RzYQc0JMzWKa3zgkxcnztwNIsfCvcJaYiYGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655289; c=relaxed/simple;
	bh=WnelEQkz9msN7SegJG/9eJhWytSzJccHwwXnNHJPbSQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AYFrEWUnImmYZAK3eW/D+jLrtC80+vI6gV46wJ3luE6cIJ5fWox4/3MhhVF5NiD5jLsDfuEeyIXGsU6t83sAvOtfIhEfH31GIdT90L6EvZ6uLhcYoVo+ULegekIizBQ8g45YxZ7GWGr5GRLZTXF0nlzaYPBIFJDJtooLn9+BVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8AxmOmvJsxmwiMgAA--.64676S3;
	Mon, 26 Aug 2024 14:54:39 +0800 (CST)
Received: from [10.20.4.132] (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxTGetJsxmAK8iAA--.12952S2;
	Mon, 26 Aug 2024 14:54:37 +0800 (CST)
Message-ID: <e0f40e93-a325-4db2-86af-5d2d29fb0095@loongson.cn>
Date: Mon, 26 Aug 2024 14:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Subject: Re: [PATCH v3 1/3] dt-bindings: serial: Add Loongson UART controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, p.zabel@pengutronix.de, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
 <20240826024705.55474-2-zhenghaowei@loongson.cn>
 <7346m2dmduzdrhzmhlnms24bltoczbajfxfh6wcxxplzydqskc@2xey7pdc24t3>
Content-Language: en-US
In-Reply-To: <7346m2dmduzdrhzmhlnms24bltoczbajfxfh6wcxxplzydqskc@2xey7pdc24t3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxTGetJsxmAK8iAA--.12952S2
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgEBBGbLHpsHKwABsD
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1DAFyxWr45ur4kuFWUZFc_yoW5Wry8pr
	13C3ZrCw10qF17u390qFy8Ga1rZrZ5GanIqF47tw12kasYgas3Xr4fKr1UX3y3Ar18Xryj
	va4FgF47K3WUArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxUGYDUUUU


在 2024/8/26 13:59, Krzysztof Kozlowski 写道:
> On Mon, Aug 26, 2024 at 10:47:03AM +0800,zhenghaowei@loongson.cn wrote:
>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>
>> Add Loongson UART controller binding with DT schema format using
>> json-schema.
>>
>> Signed-off-by: Haowei Zheng<zhenghaowei@loongson.cn>
>> ---
>>   .../bindings/serial/loongson,uart.yaml        | 63 +++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/loongson,uart.yaml
>>
>> Changes in V2:
>>
>> - Correct the schema formatting errors.
>>
>> - file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'
>>
>> - Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.
>>
>> Changes in V3:
>>
>> - Change the filename from 'loongson,ls7a-uart.yaml' to 'loongson,uart.yaml'.
>>
>> - Drop newly defined features: fractional-division, rts-invert, dtr-invert,
>>    cts-invert and dsr-invert.
>>
>> - Add three specific SoC: 'loongson,ls7a-uart', 'loongson,ls3a5000-uart' and
>>    'loongson,ls2k2000-uart'.
>>
>> - Drop 'LOONGSON UART DRIVER' description in MAINTAINERS.
>>
>> diff --git a/Documentation/devicetree/bindings/serial/loongson,uart.yaml b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
>> new file mode 100644
>> index 000000000000..19a65dd5be9f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/loongson,uart.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Loongson UART
>> +
>> +maintainers:
>> +  - Haowei Zheng<zhenghaowei@loongson.cn>
>> +
>> +allOf:
>> +  - $ref: serial.yaml
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - loongson,ls7a-uart
> Quick look tells me there is no such soc like ls7a. If there is such,
> please point me to the DTSI.
>
I had a problem with my description of ls7a, it's just a bridge chip, but

both ls2k0500 and ls2k1000 share the same UART controller as it.

>> +          - loongson,ls3a5000-uart
>> +          - loongson,ls2k2000-uart
>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1000-uart
>> +              - loongson,ls2k0500-uart
>> +          - const: loongson,ls7a-uart
> Just use real SoC names.

The ls7a is not an SoC; it is typically used in conjunction with 
Loongson 3 series

processors and boots via ACPI. Currently, there is no corresponding DTSI 
provided.

>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1500-uart
>> +          - const: loongson,ls2k2000-uart
>> +      - items:
>> +          - enum:
>> +              - loongson,ls3a6000-uart
>> +          - const: loongson,ls3a5000-uart
> Best regards,
> Krzysztof

