Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266018C011
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225325; cv=none; b=SYFnxB2bGpnCVbZEIabkCcTZmOkNgTrijbHAyL7iF8VqBpKVExALCizfhVcZhX28hnP05cgJZS99x/cZ8Go3oI+Z2vFAiU8ivALMlVrZdgRQq7q+HtAql2zLGTuiQ7VQKDnKQrFSKl68gMtll/EiZv2AihyyfIIG/tDNt4U85H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225325; c=relaxed/simple;
	bh=8fiUgzEDAb/CPt2ThFku6rRgGJ1bHR98JE7uXO5Swkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYPcxYvnnJD1OWRk2RCqZ9gFQjof466VF18KOn7ksCBmSmY9CJcyCd5OuZWeyni7fvLuaenc2/Nyo8wFE7k170uPSnI4NZ5i1Isca1aB7EUw+cJTcavEHxB3MkIvnhbdXth1gKi2ZRc5rlyvVlB+xRkG/CPsYVE2wjXqoGOxbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlgFutvz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlgFutvz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso574215e9.3
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744225321; x=1744830121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROf/FyXlvK5lJYdCngxjxqdwGQ6incPFtb/OHbqnriY=;
        b=FlgFutvzgQss5o8R3pM4FGbLJbUZpuFbDFDCIgyfCR3MjN14g4P3jr1ZUXNJBw00zq
         pwB6vP7Qd8ivFe+kHFOKphDBt9tx08AXpBdlll/9Lj2OO/wSTNVlJakQrZpFq/as3vWe
         ZFdN4rboYHoG1UVnbphw+L1mEh+qr4Dh3ze0GynXjtg3v+hxXpuR26QwUSYanfdta4Fo
         UgZu8CN5WVXKAkG89cysLyob5D9SUPzQl0A3tZ+GneXd8pnpwIgTlUdFuQlBo/b+YH2U
         fd2C104Cf+MBI9h9gxNWQA8f2HOR94zHUaXZPE9mp+d3YEuWNS9RB5jZIvLT5IOGGGdN
         Mz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744225321; x=1744830121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROf/FyXlvK5lJYdCngxjxqdwGQ6incPFtb/OHbqnriY=;
        b=WKbfTquSQkn/qd3JLkQgPrb/c0wNb7q882zaZS07ZRrwbJa0ev9x1AtZ9zC8VmqKP/
         QzSEimjJY7k2Dd10cJ/q7/LN90WBGEB50i//qv24d03DYkcV+vvElOB7tTTIK4XIzIFT
         Xc8Jza2CUqaRsAbhK+wUniUnrGgXWl4gUXbaNxG1I4qLqHugx2Y/25nQLDboJvFZihh6
         SWOIwlZWu7q4gqs7fnwtNEGScKNcTafYCKa4vK1K1KsOdcnINZm4M7WLOXMqJRBIk0CZ
         JkCP9jqx/HIoLmCJTF7fzFNnrw2db4zfXQYq4hfaNnW3IzwIZXhRkb19/j+YwTCxtbKr
         DIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUltMiW5EsngIehHwLIiZdkNJPu1h8SQJwNq//q25/9pkQTOwZDWUM1OVR34TshVp+7W9HzrcGI4xfqMoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y64ZIp74DDYZz+QA+e7+EupIy1PpxMJutyq77MvLByX5ugjJ
	7l1oFFr0v/MDZ4dr89A2SPO/OZBbKxvie5wIF02iFCTlJWQmaFq1njkNi7Sgbtr+BNWFBwZnKBI
	Z
X-Gm-Gg: ASbGncv8T8v0JzjdI5jNLtD02y/D7kRdXyJt5RW5lDeVvVu0C45ET8W2c34I4WOYgEh
	LcrJcMgNxBU+gil/DubHxMPpGp7jqCgmvVGNteiCM3X2dUY1N15eDim/zFhfI0NWCp1GiOyMzDM
	uxNsZ4m7dFnvNXHdT3OyUMhDU7b3PvGrwsej2tsViGnuftW1VM4pauu3otYwIDhH3mkFJLhntdA
	EmrIS8d/yx5e4AURZiJySQDH+GLFmsz0OdG2xIg3rc/vcVsR0iyih3fUatf2dUFXxFc4YopoPc+
	aJWHCZqQIJ7a7RPKpO0TXbtj4BATG9Sd6X5lVl7X41Y5FsXyVtua
X-Google-Smtp-Source: AGHT+IEyIRkiTwSNNIAg2oHYPBzs0rkTcPyCv7biIBEY7Pp3zAUiU75B5HFIdfXkzJnkiyq2+BVokg==
X-Received: by 2002:a05:600c:3b16:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43f2d7b4f1cmr1323835e9.9.1744225321022;
        Wed, 09 Apr 2025 12:02:01 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d36f:db1a:e26c:8aa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361165sm2471277f8f.19.2025.04.09.12.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:02:00 -0700 (PDT)
Date: Wed, 9 Apr 2025 21:01:56 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Sam Day <me@samcday.com>
Subject: Re: [PATCH] serial: msm: Configure correct working mode before
 starting earlycon
Message-ID: <Z_bEJGwFIlPdBtAy@linaro.org>
References: <20250408-msm-serial-earlycon-v1-1-429080127530@linaro.org>
 <ac130f09d89b8efea8e0d24f1465c42f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac130f09d89b8efea8e0d24f1465c42f@kernel.org>

On Wed, Apr 09, 2025 at 11:11:00AM -0700, Stephen Boyd wrote:
> Quoting Stephan Gerhold (2025-04-08 10:22:47)
> > diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> > index 1b137e06844425584afe5d3f647e9537c6e2d658..3449945493ceb42369d2acafca925350fccc4f82 100644
> > --- a/drivers/tty/serial/msm_serial.c
> > +++ b/drivers/tty/serial/msm_serial.c
> > @@ -1746,6 +1746,12 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
> >         if (!device->port.membase)
> >                 return -ENODEV;
> >  
> > +       /* Disable DM / single-character modes */
> > +       msm_write(&device->port, 0, UARTDM_DMEN);
> > +       msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
> > +       msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
> > +       msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
> 
> In msm_complete_tx_dma() these are under an if condition checking the
> version of uartdm. Do we need that here? Although I also see that
> MSM_UART_CR_CMD_RESET_TX is unconditionally written in msm_reset() but
> not MSM_UART_CR_TX_ENABLE so maybe the condition check is wrong or the
> bit doesn't exist in earlier versions of the hardware so it doesn't
> really matter.

msm_reset() is called from msm_set_baud_rate(), and that one does

  msm_write(port, MSM_UART_CR_TX_ENABLE | MSM_UART_CR_RX_ENABLE, MSM_UART_CR);

unconditionally immediately after, so what I'm doing here matches what
the driver anyway does for all the IP versions.

I'm not sure why we have version checks to perform the reset/enable in
*some* code paths only for *some* IP versions. All of this feels
obsolete at this point, since "msm_port->is_uartdm > UARTDM_1P3" covers
all SoCs we still support upstream. There are no users of the v1.1 and
v1.2 compatibles upstream, even MSM8660 has v1.3 already. We might as
well drop those conditions at some point.

Even better, we still have code for some super old controller before all
the DM variants (qcom,msm-uart instead of qcom,msm-uart*dm*). No users
of that upstream either. :-)

Thanks,
Stephan
