Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FA286A8;
	Mon, 26 Aug 2024 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660271; cv=none; b=ogfgGvMmEY5ouxitHXh/eYXrsLPoMQTjhg98OxY1l/U5uxOfhBYzi4/WSIakXA4o9s2BrZhx+oPPH95fOvG5ZzViD6xXu0yXhKrLvVQvHTCa97Y3bB7EmXJNjzDKVMxkSCHxfuhenvvXSi2HKHDJ9UnTLZrAwj2CgP6mwFjNCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660271; c=relaxed/simple;
	bh=0UQMiKlAxZBABv9BZU1DcaWz3EixG0WaoKmBDiXqLVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQLzzaQCrbY4OW1bGe9znZK+le2Ruvu14fZHe3BWhkbpJpC/BsLl8jeg3FCoM903rq58/lHSZQTJZSdiv+wTToFQUa/6MNONbnkqDb4sUv/N65CtSQZVDe3QHMPKTS4rksgVt/fZmHKzH6MZ+6CGXsZVYZluiuw8Tsi96tEtzEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1ayR5uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1ayR5uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943DAC8CDD6;
	Mon, 26 Aug 2024 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724660271;
	bh=0UQMiKlAxZBABv9BZU1DcaWz3EixG0WaoKmBDiXqLVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j1ayR5uuhzhwDWtCD9OiJaZxjJUwHxN5U67VG0/OrcKakdCoxzSduPysV66IzuNd/
	 gUZackooW5cC6n8wYUzBTl/0PkpGuYaCUP+SXnwl4FZmMm5HU+PJtBMw6dSc9iP4RF
	 b1MjOKPLT1kleLl2RvRvCS4vJMtf3G43v+N8K9Gq+3WgrAG5OAVd/nQv97zQAsLgh9
	 DTUwbnezDOxJzj+gnQqK0YFTMkyB9eC9XCughrsztzezpUhkvxjItIBhwIyZxAjmCz
	 orObf5Uf2DDqX7ABe3HyzjoWje+JoEkw3XTlF6lM59IzDj2FbM3JONvmFzXd+7GCki
	 PD5w99BGnu/qQ==
Message-ID: <8b908c2b-c8bc-4b46-b6ff-e23f0ceaa92a@kernel.org>
Date: Mon, 26 Aug 2024 10:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: serial: Add Loongson UART controller
To: =?UTF-8?B?6YOR6LGq5aiB?= <zhenghaowei@loongson.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, p.zabel@pengutronix.de, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
 <20240826024705.55474-2-zhenghaowei@loongson.cn>
 <7346m2dmduzdrhzmhlnms24bltoczbajfxfh6wcxxplzydqskc@2xey7pdc24t3>
 <e0f40e93-a325-4db2-86af-5d2d29fb0095@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <e0f40e93-a325-4db2-86af-5d2d29fb0095@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/08/2024 08:54, 郑豪威 wrote:
> 
> 在 2024/8/26 13:59, Krzysztof Kozlowski 写道:
>> On Mon, Aug 26, 2024 at 10:47:03AM +0800,zhenghaowei@loongson.cn wrote:
>>> From: Haowei Zheng<zhenghaowei@loongson.cn>
>>>
>>> Add Loongson UART controller binding with DT schema format using
>>> json-schema.
>>>
>>> Signed-off-by: Haowei Zheng<zhenghaowei@loongson.cn>
>>> ---
>>>   .../bindings/serial/loongson,uart.yaml        | 63 +++++++++++++++++++
>>>   1 file changed, 63 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/serial/loongson,uart.yaml
>>>
>>> Changes in V2:
>>>
>>> - Correct the schema formatting errors.
>>>
>>> - file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'
>>>
>>> - Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.
>>>
>>> Changes in V3:
>>>
>>> - Change the filename from 'loongson,ls7a-uart.yaml' to 'loongson,uart.yaml'.
>>>
>>> - Drop newly defined features: fractional-division, rts-invert, dtr-invert,
>>>    cts-invert and dsr-invert.
>>>
>>> - Add three specific SoC: 'loongson,ls7a-uart', 'loongson,ls3a5000-uart' and
>>>    'loongson,ls2k2000-uart'.
>>>
>>> - Drop 'LOONGSON UART DRIVER' description in MAINTAINERS.
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/loongson,uart.yaml b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
>>> new file mode 100644
>>> index 000000000000..19a65dd5be9f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
>>> @@ -0,0 +1,63 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:http://devicetree.org/schemas/loongson,uart.yaml#
>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Loongson UART
>>> +
>>> +maintainers:
>>> +  - Haowei Zheng<zhenghaowei@loongson.cn>
>>> +
>>> +allOf:
>>> +  - $ref: serial.yaml
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - loongson,ls7a-uart
>> Quick look tells me there is no such soc like ls7a. If there is such,
>> please point me to the DTSI.
>>
> I had a problem with my description of ls7a, it's just a bridge chip, but
> 
> both ls2k0500 and ls2k1000 share the same UART controller as it.

I do not know what is a bridge chip, but anyway: provide DTSI.

No DTSI? Then how is it a chip?


> 
>>> +          - loongson,ls3a5000-uart
>>> +          - loongson,ls2k2000-uart
>>> +      - items:
>>> +          - enum:
>>> +              - loongson,ls2k1000-uart
>>> +              - loongson,ls2k0500-uart
>>> +          - const: loongson,ls7a-uart
>> Just use real SoC names.
> 
> The ls7a is not an SoC; it is typically used in conjunction with 
> Loongson 3 series

So no, drop. "Not a SoC" cannot be a standalone compatible and makes
little sense to have it here while all others use specific compatibles.

We keep repeating the same for Loongson and we are getting tired. There
is not much improvements from you. Who in Loongson is responsible for
managing your contributions so he/she/they will assure us you understand
what we ask you?

Best regards,
Krzysztof

