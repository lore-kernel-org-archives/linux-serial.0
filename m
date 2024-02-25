Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1E17991
	for <linux-serial@vger.kernel.org>; Sun, 25 Feb 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875758; cv=none; b=g7TI13DZWUD8XppL52lwzNQjodcyqTOwdF2kivTic3FVt5rOiS5GdrCgvY1qW8lhOP0qwVv1WhEjArsjEJxpTbQvsKeDyr4YolXTCBTiQIv/axHGsWbPGbUZWjs3rGZc3lWsrIKzFKEPEBFhWg53p0rtbeopiXoQqSAPuLSfhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875758; c=relaxed/simple;
	bh=l0BDmwoFZQU4Qu8uM6y70+fjd5okgH0neujfC6DKo38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caxd2sA5x6fJJTHYBXU9F22Erfvy81QDMrzqg+bTC95YTGyMnPMgR3LpIVT5mhCiC6FYbbzX4kMxYEsx2SjoxhytAkkaBN8Gm07QOglcVsUK2dwNrDj7oi6BiwLpb5m64gthBEDS/F1QlfnMDwzAUnDZlxhJkKd5Ex+LEnk0w1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AV8pNRHk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AV8pNRHk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so3265647e87.0
        for <linux-serial@vger.kernel.org>; Sun, 25 Feb 2024 07:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708875755; x=1709480555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qiNl5v0sTGoB43AgM/QCHru920Fxf0VXmh2hmLqHphQ=;
        b=AV8pNRHkA8zu5AE/mQLoquss3+hJcRna8DZDPK2nx9/9Bz9syQGZL5JgUwALic1Alr
         c43dvXiHZeuRAV0MvyJlCID0i++EWBvFY1/TK06Q0v0ZzxBou7Rm+2L1rJu8uwgzai8H
         4yOPcS628bJkZrE1W9s+tibeZ2c74LxYUP/SnsMItTGi1ydqEpraMpbFNSRDKBoQB/dY
         JdrpIk6kMJ3O8Nla01SoyncCDi6Fgz5FKUSSoaZkCQkkXc7QdyVMXXrk7CXY4qx0FX4N
         F7lw4V7R3UJHfYpCQ5eor9TGB1+f2m2A0g2e//wBm94hsYBgwD6ZgA0m13yCMb8QeOcI
         2hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708875755; x=1709480555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiNl5v0sTGoB43AgM/QCHru920Fxf0VXmh2hmLqHphQ=;
        b=uMyaxfYkUONOAXiSRhS1tKYSWhUse/O86MXZ33yYmTR8t2/NkygK0KODfxk5BSWLP3
         RHnqw+70QRn84n/NjSAGPA/EpwNQGsJbxGkndI/GrNeGjek1xB3ZIVxi71+gHN3WGcDm
         EiFfiXtgeCqzTEibdku1DNDWWXp2fxfcRwoBl9S3fHRSc69qZLNTYmB031tQJOrvanuD
         9agmg02mhvQ1Yrui9di4Rv3mwMdxJ8QoKwsw6pnOj5Uhk0ElmVHQuAR3Xx8Htsh1Q4Pe
         BHJrLQFyhcpg0zktqpHLCG8gnDuJ4v2hh/Ctly+tglS/jODCT3cdnmGaenoIPUmq94kv
         5ruw==
X-Forwarded-Encrypted: i=1; AJvYcCVBRxD6sVmXxoDGIweZkc6HsSeBmfeFYEYuGaArFt1crOWijpBKv6d7ubSVWyTEh/MNHs5wRLAHExVz44HRk31mH9zwJXk+stAw7TeE
X-Gm-Message-State: AOJu0YyFqvryXVXwAIQdQHNOXtOZx06CDVQ6KLJn1G+SFSdzmP9nNmiY
	u9AKtBapBglEV/rdPydFRY1gG336Iya5jzlYC568/KqPLGo7K/SdJRfwIao6JDCAyDh17bFMT7y
	F
X-Google-Smtp-Source: AGHT+IHsujxrH5G1TYoTfge92Qs/4nuyFMpW/s3Y919kI/vI3334Jt7mBVfpnctXCL3ku754093TGw==
X-Received: by 2002:a05:6512:527:b0:512:b3bf:b803 with SMTP id o7-20020a056512052700b00512b3bfb803mr2922414lfc.39.1708875754956;
        Sun, 25 Feb 2024 07:42:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id se16-20020a170906ce5000b00a3d0a094574sm1576572ejb.66.2024.02.25.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 07:42:34 -0800 (PST)
Message-ID: <174b85c4-107b-44ea-af81-4564101aa5ec@linaro.org>
Date: Sun, 25 Feb 2024 16:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: convert st,asc to DT schema
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240225100336.34122-1-rgallaispou@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240225100336.34122-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2024 11:03, Raphael Gallais-Pou wrote:
> Converts st,asc binding to DT schema format and update example.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  .../devicetree/bindings/serial/st,asc.yaml    | 57 +++++++++++++++++++
>  .../devicetree/bindings/serial/st-asc.txt     | 18 ------
>  2 files changed, 57 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/st,asc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/st-asc.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,asc.yaml b/Documentation/devicetree/bindings/serial/st,asc.yaml
> new file mode 100644
> index 000000000000..b26e1d247346
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/st,asc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/st,asc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi SoCs Serial Port
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,asc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

This wasn't here before and your commit msg does not explain it.

> +
> +  uart-has-rtscts: true

Drop, not needed.

> +
> +  st,hw-flow-ctrl:
> +    description: When set, enable hardware flow control.
> +    type: boolean
> +
> +  st,force-m1:
> +    description: When set, force asc to be in Mode-1. This is recommended for
> +      high bit rates above 19.2K.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks

Also something new.




Best regards,
Krzysztof

