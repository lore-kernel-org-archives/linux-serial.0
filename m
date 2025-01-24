Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9981CDFC1
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717488; cv=none; b=MREXhoDdPI9O9XGQcoWc49lhAr+InMqkY3oUZRCS667dHrTi9gHVMDQ/qjWCNNzSvTmZc5RjDdP6S8DkOl5MR/jtj9/b7WSAl6se4dFTrGLb/jrZHllppeRCjrHpjOPs97JZdLEYjSuA6Z9Ja0bHGbBIpQ9vwOJ9CyA1n5Qz0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717488; c=relaxed/simple;
	bh=T77o10XTx9CxIgLZenUyPw8caNMGGg9q3IEtg0qKC1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjqUy++xu+j1E/rwFYAhLwOzP6pIZnE8Fqjx90F/afUhRJln2mJTO320zwHu3NXA82503wgEkR7ueTPArStsXlbGzWT46Jb3M0ie4UKYwwpr1OAgBHbbt3tcWcYtz8XwC5CNb633/BJgSIvqx1TlWJS/TFlxnidU+NiKR0Rfr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7FmWY+L; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7FmWY+L"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3002c324e7eso17728581fa.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737717484; x=1738322284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0llOVDAU4gsmmjbiErKgwKuDgcLmaYcrMGcHc3GCiQ=;
        b=U7FmWY+LEqln8D9bLw0ileicGt18EuqnljDOQAYwV12tf8kCltWIzteOl6xL07XocY
         uCHjo7uDE17te39xLhcveBaFL+ccG3OG8v+ILwssoA7//x0OwUNmTkBpW+xW0bcVSc/V
         bm5kIZ0A/FKwjzu/6aPg9vIyI1Raes4vG/mAAIEH0/0CP/Xqrr4OTViS/FhdpJeVeplx
         L2SMfPvRVfrba2akLmz4UZ35N8il7pC0AmecCuOLnsqsPWPrU3jUplP2PADRP1YuaNsI
         DWtChRkOIu/AvxnhbJo0pdkh6an1ln+0RY9StPiSs5pxM2L1TkIXk9hUBnEvooir0FxY
         Y2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717484; x=1738322284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0llOVDAU4gsmmjbiErKgwKuDgcLmaYcrMGcHc3GCiQ=;
        b=AO/Eo0VCiRS9fp/7QnS7XMwsoSQdPVLqSkrbMbvjufpVF0eQHygSbN/hT7UyTZnqjh
         KvjhgvnuZeDcxCwC4pobmaihx6ydsFPEGSpWOREoOo+JW2wx8hdB0nL5cp7rK60U5ffT
         oakG6kNtFpDFWmmqm87+FgntON7RZQDOm/eS8rXolujDA4RfON0vGlcvrBZci/8GR67B
         ojoyF381BmfyaCxTQQozfFqFwnrjcn7/41sYsMA3rz6Lgbph3PQdzIwLHMFAj3NU73N1
         Z0hH0hgBMVGQ3vU5PlK/8XQazK72j0P53OVDp5ZKwdA5pRr8Tomtq6vXDcTmLXi+GhxV
         NJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs5koC/uMvznqf5l08WHCX4wysjhfWDnbFQYTCQSxZCQ+BWJKFLFWFYBdZnkg3/txh0QOqidxyNwPkVA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy17pVM7XveactuLGz/TQQL8CTFc4TeappMErn/9/ue0rtrAVQ
	0XoAEKp0/b9+1/7N64FrKN19eTroHxCQWnmQGP9F+JCkMKrpB+Z3L07IeRwqIs0=
X-Gm-Gg: ASbGncu2jSRNXbID1wqZxXpJhcDczxoVDCFGJaShRq9c0TsoVnMDs/r64EbN0roPqy1
	3ZE3Gbjzznw4NPBYSSkcBIR+c6dl8lGPYk5W4mCeVrDuS2vnCneBPPU9yMyfFaWeu8FVY8i0CAQ
	6uxJv8yDYUkpltgDBqWwg8uWjbF21PCeBz+86MiGILcKT580KMtcN/xYCUS2bg9JXQcIWCvZpt+
	tYGhQx2PA9MWMQPWEsewD3HjTj5nnc5EkLoNxJiA35DMThGA97VdQaG1NTUWzatHkar0lfUQNQL
	4noBXW62/3ZW6y3QpOsuB8yI4kFRWtX25gWW0WSA/cunHk/eiRqZJbWyK/W7
X-Google-Smtp-Source: AGHT+IEvnA4WjUqgAID/Sz4S55WqtF4SuOXbwQGAlWGJct+SYEIXS3XgIZ7BKsiqifM+MoW/qS4z4g==
X-Received: by 2002:ac2:4e0e:0:b0:53e:2f9d:6a73 with SMTP id 2adb3069b0e04-5439c1c60e7mr11960921e87.0.1737717484311;
        Fri, 24 Jan 2025 03:18:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c836845fsm257580e87.141.2025.01.24.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:18:03 -0800 (PST)
Date: Fri, 24 Jan 2025 13:18:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2 2/8] dt-bindings: i2c: qcom,i2c-geni: Add support for
 selecting data transfer mode
Message-ID: <r4zfoaub3dwkirdbsolbl56xxa7ax5eusb2256c7ezlyl2s3vh@hit4g5cpzijw>
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-3-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124105309.295769-3-quic_vdadhani@quicinc.com>

On Fri, Jan 24, 2025 at 04:23:03PM +0530, Viken Dadhaniya wrote:
> Data transfer mode is fixed by TrustZone (TZ), which currently restricts
> developers from modifying the transfer mode from the APPS side.
> 
> Document the 'qcom,xfer-mode' properties to select the data transfer mode,
> either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
> 
> I2C controller can operate in one of two modes based on the
> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.

Is it possible to load the firmware after it being loaded by TZ? Is it
possible to change the mode at runtime too?

> 
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
> 
> v1 -> v2:
> 
> - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
>   qup common driver.
> - Update commit log.
> 
> v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-2-quic_vdadhani@quicinc.com/
> ---
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml        | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..68e4bf0c84d1 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -66,6 +66,12 @@ properties:
>    required-opps:
>      maxItems: 1
>  
> +  qcom,xfer-mode:
> +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
> +      The default mode is FIFO.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 3]
> +
>  required:
>    - compatible
>    - interrupts
> @@ -142,5 +148,6 @@ examples:
>          interconnect-names = "qup-core", "qup-config", "qup-memory";
>          power-domains = <&rpmhpd SC7180_CX>;
>          required-opps = <&rpmhpd_opp_low_svs>;
> +        qcom,xfer-mode = <1>;

What does <1> mean? Please provide corresponding defines.

>      };
>  ...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
