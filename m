Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDB20E32B
	for <linux-serial@vger.kernel.org>; Mon, 21 Apr 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745221209; cv=none; b=VsgZ/4xhH/NGq0MigNO4bndzVFVjmp+QYT+SnO5yx/eSFJb63YfWxB4V0bTImm015ru2pewTq8tGpyFZ3JTASOheGKJtwUdYjRnTZjSrt9tjouTwHMIgBmSnV/F8kijxqRbkzXGvdW33kVcCvFUfz3SdqV6lWDhUVDkjY6iO8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745221209; c=relaxed/simple;
	bh=PeBXLRAj60k68zJj9ooHApuMSHQU/cTihkyhBpXJI2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHpsSsAuHuyemo7npiwYGoTf2oNnX1jAVfmcvTjBdUTmpbsfZ0GFiyTZJd4VIculs7hJmHWQ370i2moDKEpsbYNFL/GwI96zXfvZ5y8AgfzPLUFwVoFnp9yQtNK94fF3z5ATfDP2oFcIeV8P8x3SDtTDSU2D0hvUbpF4YzTbBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/UBuJYS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/UBuJYS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so41712955ad.0
        for <linux-serial@vger.kernel.org>; Mon, 21 Apr 2025 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745221207; x=1745826007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPWuv8niOHztMFrbbmt1uYkhWaXjAx35JzxahYfmqQA=;
        b=p/UBuJYSoz5y0zr2srUZMsmDIJ7ERTrlw4bwx4FF46ZVeFy0odZMqHkqYgVzjbQIEk
         LIloTkmxTK6jRVnKoNb/OrqURe17x0gWmJudvYao3FuY7GKfD10wl1onyzY50lWhFmE3
         LttLh3scodjgyE+6UoIyuh3lDIcY9bu9g4ctc5AkCzffjUseu6B0ae4EqMIzim1tSCGD
         3OLjfaETYT9gY/zBwvuTc/GNE+UbhvL5pMd8xdEg/Kh8MCO/CQGYXdrNvr/5CKG+f7G9
         Mp9u+K5eC4VZRcgwmoINDIFvw+InKrniQEBk8CGVe+so20xRwQzglLLMiyLnZr/G1uYo
         4w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745221207; x=1745826007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPWuv8niOHztMFrbbmt1uYkhWaXjAx35JzxahYfmqQA=;
        b=LkkgZheN7RzDNTnrgKIk2zl49S8KDDhO+2iMfkrwTjNkA6Y8ulBhrqWy/6ak1BQ0+n
         WtePojdsLkEz4PcQefhRXJFQLpEctRW78jpCU4IWUZsJKM0HXk3yacdtW7ld1oKXW5PC
         z+3+yoaMRcPJPBqoCX7J9U5kD5tHe6MwMxNUbpLQZf5R64tkpDHt/TmBeeylpW2fyP2O
         MKxlwb+DsfGsZ65l82lbQh4IGSQWvBbaUI6hw03w2IZ9Lj/PcY01nRAH18pf3jUF3Xac
         MFYgqq8RUO12synaBcq1xKxKTTFTHp9RICfkpoogdUcOpZofLNXMw4V2S4WJ+Q+skSfX
         lqDg==
X-Forwarded-Encrypted: i=1; AJvYcCWaCZEpW3VA3DnvRZEJiG4YkastjPZ30XylGZ0X+YA4UwAN+I22HUFInGtWb7B1+9GUGeWTOo41JfV6wDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYHqGZMyHmyCFCK8J7F0qFlwPhdM6svtSXdXXjl3io30J1fAv
	J8Ti1oduJ7/lZxsUBh94DYTk87UL2j3yGC/uMu3At+Ml1JKR65N3k9rKgJaAKfk=
X-Gm-Gg: ASbGncvM82ahqbCcFUuN73XHXClAH56xUOTBWdW4jhttPULgv/IDCORxaKr0TVvWSan
	ZjjvNHKVw8UJh2d1FZouWOhpQPMxarHG/G5wVdwNZdQyAkihP0paOWKD7YKFD2awpGPjSVLCZRx
	wQCQRERFfBrBgN1o2JjeAb5TIycL9O2yn73MysxfLbElc57tIH5kHWtngByK3Nk9af09oLUxVY1
	l2uw+XGMNCFNGnRNnRcAHjL/EWptCSL3WFqa5fdLdMuemATx4fzlLGUe/yig0CATpPKIXUwC3Ln
	/tPfbx5E1UaT+8xgEH2Jttr390j5myKdxlOs155Kww==
X-Google-Smtp-Source: AGHT+IFEQar7NeS6q6JkNznSin7X+7SGrcyiO8UetGUcotpj5g8KPklv9xVoi2zS1Z22WYAGg4pCjA==
X-Received: by 2002:a17:902:c40b:b0:221:331:1d46 with SMTP id d9443c01a7336-22c5356e4a8mr129549315ad.2.1745221206749;
        Mon, 21 Apr 2025 00:40:06 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda4d3sm59679655ad.47.2025.04.21.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:40:06 -0700 (PDT)
Date: Mon, 21 Apr 2025 13:10:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v2 1/9] opp: add new helper API dev_pm_opp_set_level()
Message-ID: <20250421074004.yttb42qq4p5xzi3o@vireshk-i7>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-2-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418151235.27787-2-quic_ptalari@quicinc.com>

On 18-04-25, 20:42, Praveen Talari wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 73e9a3b2f29b..a9bca9502f71 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -3151,3 +3151,25 @@ void dev_pm_opp_remove_table(struct device *dev)
>  	dev_pm_opp_put_opp_table(opp_table);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
> +
> +/*
> + * dev_pm_opp_set_level() - Configure device for a level
> + * @dev: device for which we do this operation
> + * @level: level to set to
> + *
> + * Return: 0 on success, a negative error number otherwise.
> + */
> +int dev_pm_opp_set_level(struct device *dev, unsigned int level)

I would rather move this to pm_opp.h as an inline helper.

> +{
> +	struct dev_pm_opp *opp = dev_pm_opp_find_level_exact(dev, level);
> +	int ret;
> +
> +	if (IS_ERR(opp))
> +		return -EINVAL;

Why not reuse the same error value ?

> +
> +	ret = dev_pm_opp_set_opp(dev, opp);
> +	dev_pm_opp_put(opp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_level);

Make the changes and send it separately (or with the series, your
choice), I will apply it to the OPP tree. Thanks.

-- 
viresh
