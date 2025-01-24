Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9258614E
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731065; cv=none; b=DrCm/mGRwr+RCNTYdh/Eq9hA9VOIB7yoz7HqLNm8+2Ht3OKfiGOpCJkXGp5wS7geMRo+UcZfmXOODOiSwmwzC2GFoBQ3BRTdJ2n+nPRSLDkn0t+rhJOV236GA2+xmZsamZN99ef4sqyVbcNilLw6YhNRgcZbOw9+xNu4TObfhek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731065; c=relaxed/simple;
	bh=liY600PqK6SuQdA8zCm1S+bF6lwoZE93mLEyzx5DfHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thEErjjFtttm8haXYyqzBf1TLbJz1eaCKnMIztCof0zgYr00rIVmSARniUFP/sHLCd2HIoyYbo12Ngva+cUPGPoJib+nkxcEl/BO87B8rT9EmJ4LLpipc073zq9Fe+LHrfDFL/3GfPvs9SOBiyNBBCiAusbMFYKR98oKD4eoHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZ9RYmrg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZ9RYmrg"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543cc81ddebso461047e87.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737731061; x=1738335861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL8Ul2XcyUU343amcRNc5uIxhkMMSlT+CFrfiyK8B1g=;
        b=AZ9RYmrg/L63vTEDtxEQWasvEIvnald4/gbd53TszLmXXlyHW57crGX0OcXO8AjVN7
         T+TDxL5WasomnB+eKJQOn53pff85EBtF6asYiivLcrj6vG54A8kO8ZLx8pvvUf1pH60I
         mKv3czd/B+Uo1z7FvW2mE6KkfGSNRIrZBA/eb86icGQX210ivGCPeUZNWl+aJr5Ha1fS
         rMdj0WwExqxbe49Br2Qb306kLGxqmTDU16G6MlY6zbaOIKwK7i5kSuDv01woBaRRRgXl
         0k/jBxHvesYorRb/4CAbxE2XZiJ1fuqES1ZEdZ77EyiH3MNfKw7ONGYIxFxudFRpAJVb
         iEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731061; x=1738335861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL8Ul2XcyUU343amcRNc5uIxhkMMSlT+CFrfiyK8B1g=;
        b=C0pA4qFeVctKmarzMcukTpFb98yBJFhDkNGhpUUxiamNl2btqly63PDZMeua/z0Pgw
         PU3rY6Vv4wbsOy3TKb7rXhoypdxNHHzqXmuSjCELf9EqgdUD2TVLpODOU2Oq5NKKIE1U
         lCQeYvKU9ML/0zzuxgW1DY9NkulgDM56Rs43j4MBIuuQMnnWP/ALuMxU248fKzwsEWqr
         HC2uLXM4o1qXU4gBC4yJ5ThoH3x5ur09N9c5nDVL8wlVUtFqUXu1/+muPhU0i1kcgUcp
         5cI8Arx/7P2fi2+FzaIOOoLGnZ9iekhw/CF7izOGcxu+hxnHLlHk5a5UtobWpjUMm+i/
         OCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdih1lzj2eocDR9w7iE6ZTmI4Mgz2wx5DCEY40P50vqLC2ouEO1mdkxx93xNe+fmoFsDIrbVRpnpb7mrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInsP+uDzaKkgraOPSTgANmb1ihmpPR2LQLJlMWJlfKwnjXQXz
	nxuY5xREaIfWg1ALS7ETeAp20XAnPwCFShxUFb2ZKGObPND0GsgSrHMVsfInD8o=
X-Gm-Gg: ASbGncsZd0rvx1qqQ87hB19EyWyVHdu5dlkOD69DXbOnOO1x4zUJW7YCCm3phFu7s52
	098Dm3XcNDIVWoohuqapxCtihqlt/rPGPT9O2I1l8/+Bfg7gY+bsQ80V+35fwusIQkCQISOftKs
	S2L2XD3/mDlZsZ2aRhe6azH119qH6NsuOlrE1KU+cTHWEuxypCIlVOobq3h863mSjEqxX8Rm5AP
	BDGoZ3amV+8y+HyyqPvBHxcaGw1gOqmxT0XagJgrTv/dLiXPC/zG5OHd+do3XB0+ENloRVa9LrL
	oKpgY77fcGCpuDj0mBLOgUqmpsOarc6MCfGOSSPkeU2xJemn8Sga4VwcFCJ+
X-Google-Smtp-Source: AGHT+IHS9PHO9x4XDZcJT55m+6x+Q9EK3neB+9wDND3aZQ9uAKr907TwYhmNzs8zVGiWd1E2ypV6CQ==
X-Received: by 2002:a05:6512:33cf:b0:540:3572:1864 with SMTP id 2adb3069b0e04-5439c286c06mr11579332e87.44.1737731061182;
        Fri, 24 Jan 2025 07:04:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c836841asm317213e87.131.2025.01.24.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:04:19 -0800 (PST)
Date: Fri, 24 Jan 2025 17:04:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2 6/8] i2c: qcom-geni: Load i2c qup Firmware from linux
 side
Message-ID: <d3tydp3m7pehhiphupwybjlol5v2u3sabqotqximxmnswjlczb@jmdzpbrcrgou>
References: <20250124105309.295769-1-quic_vdadhani@quicinc.com>
 <20250124105309.295769-7-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124105309.295769-7-quic_vdadhani@quicinc.com>

On Fri, Jan 24, 2025 at 04:23:07PM +0530, Viken Dadhaniya wrote:
> Add provision to load firmware of Serial engine for I2C protocol from
> Linux Execution Environment on running on APPS processor.
> 
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 7bbd478171e0..9ad3b8c9a224 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -872,8 +872,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	}
>  	proto = geni_se_read_proto(&gi2c->se);
>  	if (proto != GENI_SE_I2C) {
> -		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
> -		goto err_resources;
> +		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);

Hmm, so if the SE has been configured to e.g. SPI by the TZ, can we
switch it to the I2C?

> +		if (ret) {
> +			dev_err(gi2c->se.dev, "i2c firmware load failed ret: %d\n", ret);
> +			goto err_resources;
> +		}
>  	}
>  
>  	if (desc && desc->no_dma_support)
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
