Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503539;
	b=scTAq6IghQF3bigw4igEksFED8hbqO5AuFVtIcjIxTpuihg2jzviw+DNbhLsoVerc84I
	 D0Y5d8UM2kTb3BTmBKawmaaOyYEW9HbEVotwKVTMsi17btRlPu0L6/43uq9z2zcZkPa8J
	 Hh6TlO8nUP4N2UMAvAYP6f3pRJ6ozUV53SibDG3eRKIO+xZnciLa9o5HOzehH96KyoiKp
	 au+yqNeqVF1LU1ipT/6n7wDGXA46LgKFkYjDKBnz5UTL4bkYkCzvFewLtmM3tNi/jeJv3
	 FyJN5bJIUrBJ+/f7LC/Oa5GZs1LiiucEeIudYMC6AXB53XLu9l1Hl4Ixy7k4lPDlANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503539;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=0c/o13VUmTtvta2hEpnHq2PWiO16Lv/Z0jbNybTWp4M=;
	b=pvnN7Ko+a6iJpOEbqYEbtpd5TCfwIymYp/kaNunQOAqNdp2T2YgJDgo6HLa0khteU9bl
	 558BHyQAQGbfeiOlcTgxR5/jS03k2YM2h4sVt+Ul4KWKWOQljWAU1bdB/JmqfEcSlzar/
	 32fz09AXYlaNVuzJG3L5QAfbITctdbhvrigfG0ayfk8TqNXyQEo/KAaJGFCvtreQwj55o
	 x5mQykKj+gP/wqtjaZhOF6MoHw1nxYvCuUaLFK+M0HuIeks80ATZsvuwHV9B73iMuYrxc
	 GS7iZGqxQMaSrcfglpYxjAY/m96bHbC62q7dB5J/1PRGSMx2GBFGfSQtyrHEyC7TXzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C48606A31E;
	Tue, 24 Nov 2026 06:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C48606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8AxZ7WpNQVry3oiAA--.4715S3;
	Tue, 24 Nov 2026 14:58:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJDxRs2gNQVrtgI3AA--.31052S2;
	Tue, 24 Nov 2026 14:58:41 +0800 (CST)
Message-ID: <0009e3c5-dfff-4254-a06f-13c8664a1543@loongson.cn>
Date: Tue, 24 Nov 2026 14:58:40 +0800
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated
 Loongson-2K3000 UART compatible
To: Rob Herring <robh@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 conor+dt@kernel.org, Binbin Zhou <zhoubb.aaron@gmail.com>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
 <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
 <sashiko-outbox-196836@kernel.org> <20261119214532.GA757146-robh@kernel.org>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20261119214532.GA757146-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxRs2gNQVrtgI3AA--.31052S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGsFAH8DMQAAsp
X-Coremail-Antispam: 1Uk129KBj93XoWxZry5uw15CF1DtFW8Zw18JFc_yoW5Ary5pF
	ZxCa97KF1jqFnrW34vv3W8Aa18XrWDAF12kr4UGr12yF95J3yftrW3Ka1YqF4xAFy8JFW8
	XFy0gFW8GasruwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==

Hi Rob:

Sorry for the late reply.

On 2026/11/20 05:45, Rob Herring wrote:
> On Wed, Nov 04, 2026 at 07:52:04AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] dt-bindings: serial: 8250: duplicate ns16550a fallback block for ls2k3000
>> --
>>
>> commit 71974153fe22bc00d365059be9198364c9cfaa86
>> Author: Binbin Zhou <zhoubinbin@loongson.cn>
>>
>> dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compatible
>>
>> This commit documents the loongson,ls2k3000-uart compatible string with
>> ns16550a as a fallback so the driver can distinguish the Loongson-2K3000 UART
>> from earlier Loongson UARTs that require MCR/MSR signal inversion.
>>
>>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>>> index 01abd39509a7a..33c13c48ed56e 100644
>>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>>> @@ -196,6 +196,9 @@ properties:
>>>                 - loongson,ls2k2000-uart
>>>             - const: loongson,ls2k1500-uart
>>>             - const: ns16550a
>>> +      - items:
>>> +          - const: loongson,ls2k3000-uart
>>> +          - const: ns16550a
>>
>> [Severity: Low]
>> This isn't a bug, but properties:compatible in
>> Documentation/devicetree/bindings/serial/8250.yaml already has a two-item
>> block with const: ns16550a as the fallback that includes the other base
>> Loongson UART compatibles:
>>
>>        - items:
>>            - enum:
>>                ...
>>                - loongson,ls2k0500-uart
>>                - loongson,ls2k1500-uart
>>            - const: ns16550a
>>
>> Could loongson,ls2k3000-uart be added to that existing enum instead of adding
>> a separate two-item block?

Let me briefly explain why Loongson UART `compatible` is necessary at 
this time.
First, as described in the driver, each `compatible` type defines 
different driver data:
struct loongson_uart_ddata {
         bool has_frac;
         u8 mcr_invert;
         u8 msr_invert;
};
Since the Loongson-2k3000 has already fixed the hardware issues with 
mcr/msr, we need a new `compatible` to correspond to the updated 
`driver_data`.

static const struct loongson_uart_ddata ls2k3000_uart_data = {
         .has_frac = true,
         .mcr_invert = 0,
         .msr_invert = 0,
};

As for why a fallback to `ns16550a` is required in all cases, the DTS 
files for the Loongson-2K1000 and similar devices were merged into the 
repository before `8250_loongson.c`, and this approach was used at the 
time to maintain compatibility[1].


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13532b5186a7aa4dfd9885355c6af7562b75dd7f
> 
> Sashiko is correct. Please address this comment.
> 
> And please answer sashiko comments before the maintainers have to.

Okay, I'll keep that in mind next time.
> 
> Rob

-- 
Thanks.
Binbin

