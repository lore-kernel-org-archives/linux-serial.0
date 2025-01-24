Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1E6CDBA
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731025; cv=none; b=i6F7jK3Q0cW6Glm+ye4Jb34bDHDIZTPGhrFrobebcz2IYCFGuVeAjDwBJdXAuPYl96IfzFUa7VDN0IOJ8MOZW5FXxMRCK1lmxTdAJ/54USwNmvnbCfpyhPdX96svgiDv/TOrXUGeKhINaGt8+JXP8ut4d3+2Uhc8+RWDAW1Tz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731025; c=relaxed/simple;
	bh=gN+7KPBjQ3apdp+svz6jKhy2+Bo20hn7fXqkj0diiq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPS+P8Eq9CaNZEEdXznrpUfqQtk/nOCkfM2HvSKfUw6LqEbmLHmqK3TGplHlAikfjYJMBsd5rePCf/zPkfJ3nAwfslpTOiqNd3B6ratyiv7B0hCbRFvJJuavqyd+GIWUl5G38nxaocr8JK4HYZjK8jE9ZDhw+s5lFfLvEfJXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BlLbmnyU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlLbmnyU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso2257294e87.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737731022; x=1738335822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7T+NCUqaMb1L5bzUtS5gNUEu0whQ9tB9Ycz/UKjNxK0=;
        b=BlLbmnyUT0ycV2izcUqK/Edmivp3CDhs7W7/4Fd+eyFeXh7WOoCRI6R5MdTyyhwvQF
         sCliwK/OYmOu1akAu3jlss+5Cq47MPG2VM+hpIWfSQd3pxZk33IwGFCXSRh6p3/Z7Gre
         x20au7Q2OsbMvF5S01jm8ekv+zmAJXQmyu1YtEuH2hZfZf1XhabTRCA+ngIxaOwxnsw/
         bSe3u2soMfXTzepPckPMxvutfzqGKHldaaWuaPauNZC4Mhl1Egdas+GrvkdaUvAacKNm
         SOoa0u4tKzqn68Ru021/yLmHTqo3t29tiQ5jqmxNAixj2Whsw+PY/tvyHCWZFuneK0WI
         cDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731022; x=1738335822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T+NCUqaMb1L5bzUtS5gNUEu0whQ9tB9Ycz/UKjNxK0=;
        b=nbN9F+/kZIu/PIqWITfhTVp5b3iY7qILm25z8TnpWIirc8hqSTb9NI61Q/bibl2HWq
         puuTNI6ilI6HIE22EfkmHLrLRk7np7MX0GVdzSgHYhE2IV9FMOqjJJopCJ8mV0HZ2nTF
         BoL2spsiE5bjnG9vKv6e14MXWB43CuMKHnICoVv4clJWjcTdjKqc2Gh8owy0Xcr+ea9p
         OxLMZVDPfRABGt6dkM9sPXprxngNr8ewraqWEtnffkBu0RSvByU5QqJ8u2mYsWAa+VBv
         ey4cfDrobm+b+430IFUwrhgQ2gMw2aJulXieyt1sFeOrQuwIUOuUk97p6oTNq9MZLMSg
         87mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgem4iPLNvi4AgXajJYYn1eQNl4fYHeurPmADqK2DjFPBfdnb2MqsSJvDXP8603u4JiIjkTPkiPjepuvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F5nX18OKqJ8DqRkh8cdr6Tl8Fo1zWabZQOla0XSaoBAmgmz2
	PHlfC8e+pIf/isg2VH1z0sJL/L1Dpb1pp29jq6XsCxmVQJBGgrovw3Kwq4NVvso=
X-Gm-Gg: ASbGncubV3ymY9lfFKdgC4g365D1H3ErGhUIhtO9oKsZ8w5a1OhCf02GsJhpuQurZz1
	KFkCCxVdXBxpd3ZyNj2hVEXSulw8phayBUZ8KcfCeMnpCHTPP09FJ1DbXwiHXLImzT5T6tzA2fo
	lubault+sK4NwXfDcKUcrRRU7oRSuwGg49uc205peuHTEFSGE0w1nYZmxPQCd8m911IMBW5dmZD
	+eN3ubJ6oDMUnGG3ymOe8Ca7obu2dX8nBFLLXXfOruA1nMOr6LnvvgtymjiHaC35pzm/ASUV5fV
	CSjCePPt2frjGivU26Dmpk8O3BjGe7jCt3uItDLYWluaFvgigA56nWMtBe7j
X-Google-Smtp-Source: AGHT+IEQdJgfpDkA2kLfF64yUHBaMCdd2VK0VHt4hFo/cuvczFWmqHG+G2R0tRPk4Ktqceg412FjcA==
X-Received: by 2002:a05:6512:691:b0:542:29a6:db5a with SMTP id 2adb3069b0e04-5439c2820cemr10379948e87.35.1737731020389;
        Fri, 24 Jan 2025 07:03:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368537sm316786e87.108.2025.01.24.07.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:03:39 -0800 (PST)
Date: Fri, 24 Jan 2025 17:03:36 +0200
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
Message-ID: <ewwk5tvwlhu7cbev7su75ysooboq7ivloydvd3unwic2e6p7ap@bpyoqsrgvf6f>
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-3-quic_vdadhani@quicinc.com>
 <r4zfoaub3dwkirdbsolbl56xxa7ax5eusb2256c7ezlyl2s3vh@hit4g5cpzijw>
 <da7b9678-76cc-4e45-89e9-4e8d9c9a2005@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da7b9678-76cc-4e45-89e9-4e8d9c9a2005@quicinc.com>

On Fri, Jan 24, 2025 at 05:52:24PM +0530, Viken Dadhaniya wrote:
> 
> 
> On 1/24/2025 4:48 PM, Dmitry Baryshkov wrote:
> > On Fri, Jan 24, 2025 at 04:23:03PM +0530, Viken Dadhaniya wrote:
> > > Data transfer mode is fixed by TrustZone (TZ), which currently restricts
> > > developers from modifying the transfer mode from the APPS side.
> > > 
> > > Document the 'qcom,xfer-mode' properties to select the data transfer mode,
> > > either GPI DMA (Generic Packet Interface) or non-GPI mode (PIO/CPU DMA).
> > > 
> > > I2C controller can operate in one of two modes based on the
> > > 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> > 
> > Is it possible to load the firmware after it being loaded by TZ? Is it
> > possible to change the mode at runtime too?
> 
> No, firmware can be loaded either from the TZ side or APPS side.

You answer actually reads as "No, yes" (excuse me, non-native here).
Most likely you mean that it can not be reloaded once either TZ or APPS
has loaded it.

> In non-GPI mode, the transfer mode will change runtime between PIO and CPU
> DMA based on the data length.
> 
> We need to update the device tree property(qcom,xfer-mode) to change the
> mode between non-GPI and GPI.

So, is it actually possible to change the mode? E.g. if the TZ has
loaded the firmware and configured SE for PIO/SE DMA, is it possible to
change it to GPI DMA?

> 
> > 
> > > 
> > > Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > > ---
> > > 
> > > v1 -> v2:
> > > 
> > > - Drop 'qcom,load-firmware' property and add 'firmware-name' property in
> > >    qup common driver.
> > > - Update commit log.
> > > 
> > > v1 Link: https://lore.kernel.org/linux-kernel/20241204150326.1470749-2-quic_vdadhani@quicinc.com/
> > > ---
> > > ---
> > >   .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml        | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > index 9f66a3bb1f80..68e4bf0c84d1 100644
> > > --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> > > @@ -66,6 +66,12 @@ properties:
> > >     required-opps:
> > >       maxItems: 1
> > > +  qcom,xfer-mode:
> > > +    description: Set the value to 1 for non-GPI (FIFO/CPU DMA) mode and 3 for GPI DMA mode.
> > > +      The default mode is FIFO.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 3]
> > > +
> > >   required:
> > >     - compatible
> > >     - interrupts
> > > @@ -142,5 +148,6 @@ examples:
> > >           interconnect-names = "qup-core", "qup-config", "qup-memory";
> > >           power-domains = <&rpmhpd SC7180_CX>;
> > >           required-opps = <&rpmhpd_opp_low_svs>;
> > > +        qcom,xfer-mode = <1>;
> > 
> > What does <1> mean? Please provide corresponding defines.
> 
> Do we need to add a string instead of a number, like
> include/dt-bindings/dma/qcom-gpi.h?

You need to '#define FOO_BAR 1', then another one for 3. String is a
"string", it's not required here (in my opinion).

-- 
With best wishes
Dmitry
