Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7A2F44;
	Fri, 11 Oct 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612350; cv=none; b=mAnFI9ZJT+IWffHILvChst5Ra28hIrDIjjRXlAO+ENORn7x+CrZJpuMxpYk4suFCq64vL46kv2w8NxHA8E2NBVUWF3lEdvX/Ws23VujaA/LD+s4pPVzmKaXNU4R1KyrPaL0ShGqrBHiIYUsXxS+Obo/ffhXTmLQjDekCepvtIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612350; c=relaxed/simple;
	bh=vHuEZcU46TUvH8mparYcu3kye8WC+W6Lnmy/CF/ZVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC0+BeSjhjFqifQSkgLcFqo03iOYtWmsS8SLgSny5xGyjRyvMuhu7/Wqi5U676hZhT+5Z7YMX7tir1PxKjbO68h79yfICZ6Hs6bYt83MD0yUE2dROfF9gD/msb2gxiA1gMFQ0Dfi7qYTUDlOOEWkA+Dl/WgxMTNcBP6STGFwMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN6UrIKQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN6UrIKQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71de9e1f374so1184115b3a.1;
        Thu, 10 Oct 2024 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612348; x=1729217148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBa0HVFlTx/ulHFaJHxBXCf+2rtUpuR2CqDm5ZXZhd0=;
        b=MN6UrIKQsiTbGH11RgVjVjVAdit3JuWJo1MlxH0SEm6ydcL3T/OcYw62StIONW+h4j
         rTBZTwzBxx5+CfVrzyMmHKhayUBaiv470HFHg+yrJJUsHjUpWiEM9qEOJhd+lIqIoWz7
         d3QjmE2pMX+1i8eSfFzbElNAj2NsArAxpZZqr5H7nhAwW2QmgIqgY/N6UmZVJxrvGXNp
         NdREOYMlLq67Y66CFmC6byB14tEsKx2dYp4rWB7Q0rjLzkqv6xF5AIYTPDgfe6vZPv/u
         XC9JvR3FSu2JZxGTjEOx8aIHuogb2fMdOeferKhEcUsd+XKZZLMlK2G6t60jJv6iIpFm
         fieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612348; x=1729217148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBa0HVFlTx/ulHFaJHxBXCf+2rtUpuR2CqDm5ZXZhd0=;
        b=dyJVYeuuuT14Q0Bt3QqKNSm6vlOICyg5T9aMCMQRPrcMPwi3gGKYq0ji2l2iQrIUa8
         el+jXfcZvakymY3IKVylo87geihE8b1yXEasLy76MsGhS9SGb4Enur5cXFsL5qIhTbco
         zItri+7q3LVgT30Fn/uMwinh4O6X6wWRadKCJlPTMwjY1GXjc4lJ3SsR0/8T44D7F5Rk
         JBCIDagMCGlrC9DJwB6Ujnu7hh6Hn8yY4/iY7H5hak/WCrip0Q65wKWPetXzHA/790+D
         KIrH/4d5/N1cy5zjwJjAVQB6RD2PyycUqHLPIGVTPt6vlMxw06dB4OkzuSUCoddDO+e3
         aHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEYQXyr8D+wegkCpwhzGVmU9DiV/mFXqgqE1HMWUp3j2DrlKqP8l+gwuTF3dxawhd/F6MQKYkfsJ3Y4prs@vger.kernel.org, AJvYcCWhjhjtZ9ZwLrVKZa5UtgGOzlD4eokO6SZRG/blJlfpDdwTruU9vGPaZPCRPyyjhNCk+gmdULO0XJD+@vger.kernel.org, AJvYcCXlR3ELflE2rERaNoTQk+Jsb01rQoaP0wuutg+qT7DepV/Bi3CaYtHqEURnIkp4Kt1dfN/lAPSflpfIgM++@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2FGdJQRTwghPfPXKan1+79LusbNd1BGZT6aPmirIm4p6TYE+w
	0KMRgjPIT0h0L0UvH3mCVX6x5elPZyUbCTD5KavLgQd4mdHLhsH8
X-Google-Smtp-Source: AGHT+IFoBLg3ADyoPXqJerURjjDOeJhY3kwc15+7Xmxl0MVsyk/aH5I59w5u81ACvlNiPkf/aVAZYg==
X-Received: by 2002:a05:6a21:478b:b0:1d8:a307:ac0a with SMTP id adf61e73a8af0-1d8bcf453c6mr1561286637.24.1728612348032;
        Thu, 10 Oct 2024 19:05:48 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aab9aa7sm1692652b3a.152.2024.10.10.19.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:05:47 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:05:40 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Message-ID: <lsv65gsdza77bfhoewuyqznts56hnz2b7cvqxngmy6gktfys35@g7bg5ruug3yc>
References: <20241009233908.153188-1-inochiama@gmail.com>
 <20241009233908.153188-3-inochiama@gmail.com>
 <ZwfsEpqgi9zH9P_t@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfsEpqgi9zH9P_t@smile.fi.intel.com>

On Thu, Oct 10, 2024 at 06:00:34PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 07:39:06AM +0800, Inochi Amaoto wrote:
> > SG2044 relys on an internal divisor when calculating bitrate, which
> > means a wrong clock for the most common bitrates. So add a quirk for
> > this uart device to skip the set rate call and only relys on the
> > internal UART divisor.
> 
> ...
> 
> > +static const struct dw8250_platform_data dw8250_sophgo_sg2044_data = {
> > +	.usr_reg = DW_UART_USR,
> > +	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> > +};
> > +
> >  static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> >  	.usr_reg = DW_UART_USR,
> >  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> 
> For the bare minimum this should be deduplicated as to have one record for now.
> 
> static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
> 	.usr_reg = DW_UART_USR,
> 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> };
> 
> If we need different quirks in the future, they can be split again.
> Or, if you certain that new quirks will come, mention this in
> the commit message.
> 

Yes, renaming this quirk as a common one is better. I will prefer if
this patch is necessary. Duplication is not a good idea.

> ...
> 
> >  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> >  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> >  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> > +	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_sophgo_sg2044_data },
> >  	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> 
> I think my proposal for having a common compatible for those two is a no-go
> as compatible strings are for the (unique) hardware and shouldn't be abstracted
> based on some Linux or other OS shortcuts / quirks.
> 

Yes, a common compatible is not a good idea. But it is OK to share a common quirk,
which means they have the same problem.

Regards,
Inochi
