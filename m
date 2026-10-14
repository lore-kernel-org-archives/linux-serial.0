Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAC4EB872;
	Wed, 14 Oct 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982144; cv=none; b=meUlnEtm37Q2lSACihBccxLnoa0QdIyO2dLs0ocR+eSADnnq8T9oH5EQJpdjpx3WyLTggDupUbn+it++Uc/EtMjatXXDB0OUFdL0lxbul497u9rJVjjsTCTpLxKwxCClDsHXdREidPPUk/tswP1YO34+HovHhVFDuYPhK2NFFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982144; c=relaxed/simple;
	bh=e/AUeCl/PknWa4Xcu7AdncR90tMDRwZQkuNr5vQYg0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDynjrdE/7U0ii+nR8G+m5WvFVSvAGVYoHbAH+fwfdC44qoLVly6L03nKSrWPlTsfGdeLShEl+1KZhFggPTmwSK8jJDqbAfRO4EoTbsl0G+mu122ohavbEDB/xvRRlr67VH34JHGvkORadV8efWzc6/Iyo6u42o87WZq19xqS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBB11F000FF;
	Wed, 14 Oct 2026 12:48:46 +0000 (UTC)
Message-ID: <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
Date: Wed, 14 Oct 2026 22:48:41 +1000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20261014-expensive-shrewd-nautilus-abcab6@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 14/10/26 21:24, Krzysztof Kozlowski wrote:
> On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
>> Create documentation for a new binding to support the Freescale ColdFire
>> UART hardware block. This is found on pretty much all variants of the
>> M68K derived Freescale ColdFire family of System-on-Chip devices.
>>
>> It is not compatible with any other known UARTs.
> 
> You never tested this, so limited review.

It is tested. It is working and running on multiple ColdFire platforms.


>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> ---
>>  .../bindings/serial/fsl,mcf-uart.yaml         | 43 +++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
>> new file mode 100644
>> index 000000000000..d1dba518f67a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/fsl-mcf-uart.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale ColdFire UART
>> +
>> +maintainers:
>> +  - Greg Ungerer <gerg@linux-m68k.org>
>> +
>> +allof:
>> +  - $ref: serial.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: fsl,mcf-uart
> 
> What is the SoC name? MCF? Compatibles must be specific (see writing
> bindings doc).

Yes. MCF = "Motorola ColdFire". It is the SoC prefix used for naming of all
ColdFire parts (which is dozens of variants):

   MCF5206
   MCF5208
   MCF5307
   MCF54415
   etc

Even when Motorola became Freescale they stuck with MCF on all ColdFire parts.


>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    uart0: serial@fc060000 {
> 
> Drop unused label

Ok, will drop.

Thanks for the review.

Regards
Greg


