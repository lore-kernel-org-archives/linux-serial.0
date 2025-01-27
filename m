Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97DCA64
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988034; cv=none; b=AYsKLMWFhh4xSuLsxQYptbd91r0oMyHDl5be9mrJH7rqLV1HbVSkMUv/5d1cng84wRdyEpeNL1fH7WbwObPPjC+nERzkZ6igQDenGjpPel10DF/Y9jAGLYNbiH0+TDgudZYSP22EgCzLHeRZ+oo9Qp1H8UOxlP6CLKo+JqHsWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988034; c=relaxed/simple;
	bh=v86r3EIlz1+h3GOoj/7Oe+SvuDCoWXauHahA8PSsQ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9fiXucu01GCAY8ezuPqf2JzPrLkKRe0k3PMO0v0E5m2loD0Z8leQoN4LrvE31Tx2DKlADEJPeRk1V0UbPCnU9EdK/+ll53vbnNjTQ4fVV9lxGMVxdSpXGQKzVVDtuGdPICvkwdUCJ/DcuIkkOiP3OAPcFODyp662bpX4ySrlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N/MxKlNW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/MxKlNW"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso4769782e87.2
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 06:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737988031; x=1738592831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tzvLpRdV8RsEmkfgVe41djDQCfra04Tf73tKiUg1ifQ=;
        b=N/MxKlNWmnaK3MPmZ+WC4ILOhFU3ZNQbxT1HssjhXgIYj0GI1fe8N9HnWvpDdKXJcp
         RQyqjR0RQvjOGLiTGjLD4kfH3cAtXAtKDLaLuwan26G2rP3WIAlXU1haB+QgRPbmGJNq
         sDMNjmi5B26TBfPHRtd95cpthOVsGKBdhLYeWQrYtXLLj7Bndw/RG4ISs2YV2PBTR7uy
         H4OrS9uOQ74sELt5al6DjbXzxu0s+jE/kQUC46w2ZXubIOIlT30aShhTXVDWRiMczVE2
         fLldxi74oQgDIA/+0o16jqCHQKCOP64tVFz6Qv0iJFlome98BlIIyIEqJQkJWh31NFEK
         IOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988031; x=1738592831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzvLpRdV8RsEmkfgVe41djDQCfra04Tf73tKiUg1ifQ=;
        b=Al21Lt1OA42c51ObFCib33q9c2z604vmzMPjbqOIZYs1nqWuNMt5EVrBUbBDbCqJZs
         L4QF9Oe2bTbyJgCU/ke2D3Y+mdiIi6oqzuCf/K79Zd2ebmyx34NGPdNWLP4O63JtoyG4
         2SEFRidsePlBOehqE0miRPzqKJkGWhDuLaqh02ZCKfEHaxlawNnNpnka+Rq7wGRcpGx4
         5w6MNtZOQr9P+oInkTnJCs9tAgMeSxFCqBdop4CD/D9qJxJgdopKTPgB3clz8+ye+MIh
         MshoDtnY24kxUPwfwuYPNwDVJHFV1lDtHGYCQsh0jy02vmzwPpuJF2Bs9gfy68Y4QyyR
         pDZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNNRptMtDAT38XZzFMQN0aE/cnEAbHtdtckNVKPXVYKvUtyWfvl6FRsIQ2GehC86JzKVmKFjTTgnehC2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3pywSZGBreCeM7Ji06MbfxtBkBWYvbgdeAU8sNStOayUfnEY
	N3kCLt6le2AGMIO/6XvQ2Qwu+Ma4QZrzF4/qSo5Qb+TayZWjgfEKqnhyqwey4kY=
X-Gm-Gg: ASbGncumkZanZ3lOmt9O8E9eUQKu0kYxTzHz1tJsXPsX/B8gtqc2uxduMEZVoywTO4T
	Wyb5x/mDb8LH/jIWK8swpHF2qPKrSuRNozlqf8LC1kaxdsM4NGBjZmEDeNZuPB9KHw80JuDPYG4
	pTpmsgRiTN2/PP5zZSVQMioB7XTOmunuFp8K7AD3OTFjZSs1ZdMwZ9vctCM8GSQX/9uBIxY//FX
	0jX+kmTo/7bYQlxHKEL2Sgl3n23rU0vPG4i7mQH/sseG9BCmyeEqLZKe8f1c1W3zOGIvjHpCQoU
	3XpuTziutBtIP9I5y2O6SUB7Y6L6MPBYMW/pPDkARpV4vN/Ij6QBeAYY8xUT
X-Google-Smtp-Source: AGHT+IE7G8wjtK979b4O6Nuj0hnM9/BLca8MZ6bqkJGxgYjf9X4Ezr5Qy4KlAM4toJWld4WHK+gA0Q==
X-Received: by 2002:a05:6512:b24:b0:540:2a92:7daa with SMTP id 2adb3069b0e04-5439c282032mr13583417e87.42.1737988030790;
        Mon, 27 Jan 2025 06:27:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368362sm1297614e87.124.2025.01.27.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:27:09 -0800 (PST)
Date: Mon, 27 Jan 2025 16:27:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or, andersson@kernel.org, 
	konradybcio@kernel.org, johan+linaro@kernel.org, dianders@chromium.org, 
	agross@kernel.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2 4/8] dt-bindings: serial: Add support for selecting
 data transfer mode
Message-ID: <dudqd2y42wy6iq2k73aphd5ol4mtq7z4c54zhd27rl745rrw5x@p3oummf2jke7>
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-5-quic_vdadhani@quicinc.com>
 <10060d39-87a4-4565-a2a6-80c93ac2266a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10060d39-87a4-4565-a2a6-80c93ac2266a@kernel.org>

On Mon, Jan 27, 2025 at 08:02:12AM +0100, Krzysztof Kozlowski wrote:
> On 24/01/2025 11:53, Viken Dadhaniya wrote:
> > Data transfer mode is fixed by TrustZone (TZ), which currently restricts
> > developers from modifying the transfer mode from the APPS side.
> > 
> > Document the 'qcom,xfer-mode' properties to select the data transfer mode,
> > either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
> > 
> > UART controller can operate in one of two modes based on the
> > 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> > 
> > Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > ---
> > 
> > v1 -> v2:
> > 
> > - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
> >   qup common driver.
> > - Update commit log.
> > 
> > v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-4-quic_vdadhani@quicinc.com/
> > ---
> > ---
> >  .../devicetree/bindings/serial/qcom,serial-geni-qcom.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
> > index dd33794b3534..383773b32e47 100644
> > --- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
> > +++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
> > @@ -56,6 +56,13 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  qcom,xfer-mode:
> > +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
> > +      The default mode is FIFO.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 3]
> > +
> > +
> 
> Just one blank line, but anyway, this property should not be in three
> places. Do you really expect that each of serial engines within one
> GeniQUP will be configured differently by TZ?

Yes, each SE is configured separately and it's quite frequent when
different SEs have different DMA configuration.

-- 
With best wishes
Dmitry
