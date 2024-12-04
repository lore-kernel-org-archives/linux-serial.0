Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80B20DD74
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333174; cv=none; b=A7u8BB9YT4QmN06UqtDdqTFSeHQgAeN2o+yq5onRL5wxbLU1kpX4dx7MyBZB+a0WSBbMvKVRlWTRGV3swotER6bTrZSf3A6xSCUpApkeKPbqk4Tn1G7noutlqyK2YrEwiCXTBhquLNIsLquFIxI+pd1E471YtGhI8IB7oijsh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333174; c=relaxed/simple;
	bh=3XOKyfOtCe+byiVNEcWIU0XMb6iWf0YuG2kDOBxGSKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfBHCgosiFVfiX5Vr2xoLeoo+yts9IryjClTmaGiXlqxAJxVwYzBbumo6dNkkpfirGoo2WgxzGr/YV2NH52/sj4/agp0c9v8SkdVhK2SRZZRAEhGP9xNyO28JwUAHoIvgRcuEeoGWx/KvLgK8Ldycck9CqujPRUyfLXaIjz4eB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LSKG2vqp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSKG2vqp"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3001b14d696so5620141fa.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2024 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733333169; x=1733937969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=LSKG2vqprD3CCsdcM8jWHqrbrOpbuAGhAlFzg/M4LGr9jIQ2EBeekSdY8OU7LUL/2q
         QGfDRQQdYikv6OWWcgp1Qjso/q0Uxjqti+wqhT2Sk/eGIIt21TVLvYwOWj0g93FjI6+E
         3Hz3pNUf+i9ca7bS5qmDB/j1gKcQwjjgYfaYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333169; x=1733937969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=JGpjK/ramsLWZOpz90zDzed1U49fIO5IqX18pri+EVvblmtzjnDbpFT55gDSb89cz3
         WjImCuH43mL2zaGnmiCuLYoi99Htenod6wHX5+HJC2dK8+17De6a1uYGUw6dXdf3qMEj
         IsbRqMeMa4Jyiu2cMaM3whfxdaxz4TSzCjRQZ4gLQlwZq4ma3Eqb9xP9KWXFbRwVFvl5
         W1ySPdNDn4stCbnVIPWlp391osScbH0dY9iFtjfAi284YGB44Lso0hITHf7QrolsZRZV
         XwFALq2KWb2AQavFe1U/d272r8XfFX1nBdXS53S/ykRGMzmSwbmFsrl22dB1DebHHwJW
         uVuA==
X-Forwarded-Encrypted: i=1; AJvYcCWuUrICARLpnAo0PmIe1EqEb6WXS4+rOn2lX/GCZo+vYvHKJ+HmRMCcsCKXox09EymmuYHuSOzBaVxfiH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVhe+mLojwvSBHqsVNAV2ywnjKjRTE9i/pOZeQgFZ0mhSM6CL
	9a/Z/eSrhUDySsqbI5qpUiAVVgqSLz6xt1XPyaoN0N8Dn86EgS+p2PLi5T8jElt8Y21x3jX/ZHo
	92w==
X-Gm-Gg: ASbGncuIdptcaijo7xlijJvh+QrMhJvic1B9aUV/x396pXxi9ALQP099q0mlZnWjqqp
	nrspZOGO1nBIRuI5C15Fogs1pWpNbFEEzs/hgWJey1+jVW23mt9Velvhu+bYPGvmpMhHBvvpDmh
	niUk0HlXZ0se34tWn1C488rstCfLqdz9SCE+4jJlYkyw2wdIAJlwwYwnCBA4wjBLqrcocRYVTDC
	kyWBpk6LvbuZpOoIFtC1Vyf17KOpDJUR3bPsfSYWiP34ef8T5/Bca1ekmPcJ3gX8SWmNuQC6ynR
	7iDWh5F5TmASWEMU9g==
X-Google-Smtp-Source: AGHT+IGXcKaKTHF/VoD52LeKbjS09hWGqjbprcYWr99bT9D5YJchWgU/gnz32jMMP3dykM2qJtu1Ew==
X-Received: by 2002:a2e:bea2:0:b0:2ff:c3d2:b0ab with SMTP id 38308e7fff4ca-30009caa186mr41140521fa.29.1733333168998;
        Wed, 04 Dec 2024 09:26:08 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbe5466sm20463661fa.30.2024.12.04.09.26.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:26:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so72217861fa.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2024 09:26:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1rwlgDIy/ga25+z9t6Ggyo2TSEqNF2Q1hjU17nLioRQ9qJhDf2qeILB1lL439gO+MCo+O4Hz7/Mjjplo=@vger.kernel.org
X-Received: by 2002:a2e:a108:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-30009c3f871mr30428561fa.16.1733333166812; Wed, 04 Dec 2024
 09:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com> <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
In-Reply-To: <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 09:25:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, =quic_msavaliy@quicinc.com, 
	quic_anupkulk@quicinc.com, Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> support SE(Serial Engine) firmware loading from the protocol driver and t=
o
> select the data transfer mode, either GPI DMA (Generic Packet Interface)
> or non-GPI mode (PIO/CPU DMA).
>
> I2C controller can operate in one of two modes based on the
> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
>
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yam=
l b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..a26f34fce1bb 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -66,6 +66,15 @@ properties:
>    required-opps:
>      maxItems: 1
>
> +  qcom,load-firmware:
> +    type: boolean
> +    description: Optional property to load SE (serial engine) Firmware f=
rom protocol driver.
> +
> +  qcom,xfer-mode:
> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA mo=
de respectively.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]

I'm a little confused about this. I'll admit I haven't fully analyzed
your patch with actual code in it, but in the past "CPU DMA" mode and
"FIFO" mode were compatible with each other and then it was up to the
driver to decide which of the two modes made sense in any given
situation. For instance, last I looked at the i2c driver it tried to
use DMA for large transfers and FIFO for small transfers. The SPI
driver also has some cases where it will use DMA mode and then
fallback to FIFO mode.

...so what exactly is the point of differentiating between "FIFO" and
"CPU DMA" mode here?

Then when it comes to "GSI DMA" mode, my understanding is that the
firmware for "GSI DMA" mode is always loaded by Trustzone because the
whole point is that the GSI mode arbitrates between multiple clients.
Presumably if the firmware already loaded the GSI firmware then the
code would just detect that case. ...so there shouldn't need to be any
reason to specify GSI mode here either, right?

-Doug
