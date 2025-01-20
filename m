Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6841E9B2D;
	Mon, 20 Jan 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391492; cv=none; b=axhkjN7G30GkAtf8J07h4jQaM6vi/TKIkjfQCZ6BPju4XZJZTn+ABadIiijoce1Ov8cTTuVJ564Q5PJKsfNepW2TQrwuLRjK10bZxkKUkkGVVxRIRZrd4lvPpomDOeBfEQ/I4qezbdobyfSpj0dfnbbMST6oOValCADn72erNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391492; c=relaxed/simple;
	bh=trwLC4zNIFIC/P4kSySFiG1aFbXzs74eozLhDvJO9fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9SRmsfgw2YW9fQrnfbNHAQE+efVdam1BH+qXkMOZkniUd7ou2TPW7uKZ1m0KBFrws1jzWkz4wzpU1GyuduwW+vgpDvKaw5cvkesc/MhhHqbtHK2AotIIjfya8RQRaK5Q25u84pD6aWD61f6JS7Mqfvq/QU8It3Ql7ZHI3RLO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/2ZxDuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/2ZxDuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29574C4CEDD;
	Mon, 20 Jan 2025 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737391492;
	bh=trwLC4zNIFIC/P4kSySFiG1aFbXzs74eozLhDvJO9fE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q/2ZxDukAcGdufXEYcJ4ej70SNhuxXUoeBUC3/jRNHIaHjyAibmbJoB1Qjb2DBY1t
	 c+T6aOrG47U6HVEsxVNZJt5fNR7sE0LGbcrguml/nutfAAJt8gZ6hGtcOkV6m4DsA4
	 BFxmhRY7+RT3mlytAiB8fj7rQagf+uZyyg8WMNRh8NHSPmSPLn4gAuMxPo44JH2O8Y
	 TDydX8GHIJ1Vxsg5C73or2RDwKav0ApDT9Jiy9OT5wvTRLagSBKLBIG7Vr6scmDLTn
	 cVcYIuSVTSETyD+WsdEo+gIaSlIjsKIFOdgvBctImkzIg2Vso7MnEfvamCT7K/4mNj
	 ibRBEd7HSV1eA==
Message-ID: <2d515426-78d0-445a-aaad-a08ef7e36c86@kernel.org>
Date: Mon, 20 Jan 2025 17:44:46 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org, krzk+dt@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
 <20250119130105.2833517-2-benjamin.larsson@genexis.eu>
 <20250120-flashy-nice-tody-afa2ae@krzk-bin>
 <ba4b0ad4-e8ad-4420-be10-520efeba0c84@genexis.eu>
 <b3dd5f39-357e-4714-80af-f5c6b5e8ba68@kernel.org>
 <5d1d83b8-e3b6-4719-862f-3606d1783e73@genexis.eu>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <5d1d83b8-e3b6-4719-862f-3606d1783e73@genexis.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/2025 16:46, Benjamin Larsson wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> index 692aa05500fd..2fbb972e5460 100644
>>>>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> @@ -63,6 +63,8 @@ properties:
>>>>>          - const: mrvl,pxa-uart
>>>>>          - const: nuvoton,wpcm450-uart
>>>>>          - const: nuvoton,npcm750-uart
>>>>> +      - const: airoha,airoha-uart
>>>>> +      - const: airoha,airoha-hsuart
>>>> I assume you placed it matching existing order (kind of alphabetical for
>>>> compatibles with vendors)?
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Hi, I placed it after nuvoton that was the most recent addition to the
>>> serial8250_config uart_config[] table that was also added to the
>> But wasn't nuvoton placed in specific, ordered place?
> 
> Well not really as wpcm450-uart is placed before npcm750-uart in 

Uh, indeed. :/

> 8250.yaml. But I will move the entries to below ns16850 in the next 
> revision to keep the vendor list in alphabetical order.

Best regards,
Krzysztof
