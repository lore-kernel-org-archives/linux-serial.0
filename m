Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB2267AE8
	for <linux-serial@vger.kernel.org>; Fri, 14 Feb 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553259; cv=none; b=qfYYF3Suds4myXWCbfQTLDIgfxl0umkcH4dPVpCkXP7HPGBhIdBKyi1UHztaJpEA8qsAWLgtSxeY4nGLWabOIRHdGkh37bPAJMlSMg/Aqi6jCS/2NCq8ffAO2ySyF790G60vSLta3wdBY+vrnTJpzYyp4EIDQ0xTsBHhzaeQNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553259; c=relaxed/simple;
	bh=GCT3tjmLaUYH2vmBJeZHXbttCdIkYNXzAdwNeEZ+HwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/2doAfMltKp4b4yQrUuK4TPdWgGAWsEJt0VXSao4aUj8+wjn5B2WL85lkqC6CACoiAvdWomH8CvVZynwUKeErXnIDSMsuBseNNPGXN4sBfwNAZeB/M8cmqRLMHmtKWf37OY4UWmqBYT0FuAd5MDUWyyi5HaWxvteMkuL9+VRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZKUaBru4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKUaBru4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so4285922a91.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Feb 2025 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739553256; x=1740158056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73h6zgdjYwKV/mV0oFHEsq1W810FrZfJYhYEewVFptA=;
        b=ZKUaBru44S9sCHWC+mMzy7pfykjEvSR1+6AKvetGONum7hQyEdJnbIn0Wy6RUJmc9e
         jZvJh29g0hn2JYku5RS+w3KVwtqQkgoMXYXsMaEmf5g29V/wf481ScU6B99bj2f3sVNW
         XkXo4qtNgPQVQOtfhVf7te/gGbBlFBYJITOM3n/lFkKMs1SY9TT/hjt2yFlfQya8jhg3
         IOzC4YG5f5UGQyEJuQdbE5BM2Jinlpu9GEbjz8A0CrnRx3ez0ogoa5j05tQpi2RhjtlR
         mXqu/ofXiaLoHv+Rn8QGAcOut+lxR53eM00l2JFgk5eezsvbdUTMQLJecvocAkrwBsUD
         EqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553256; x=1740158056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73h6zgdjYwKV/mV0oFHEsq1W810FrZfJYhYEewVFptA=;
        b=r4dwmJ8YiWhgDu1PqXod8xaG4B7T5Tjzmvs+hStKhFzxMJAxAdZ2s3uCVlr7+w53RM
         FEf5QjRvSDHUWIY0tXRGSGx/QsgaLtW32sHVl9QRuutsXjY4jIVOM2d3GZZahHD/cav1
         XM4cpkmvIEJG0dMXq6Zr4O3ue7kvG8VVBvzcKvIJTapBcfr4dT/Cs4rrBxHeNioGyz2U
         Oull7o5u9+BrgtVkBX8fJLlJY5/sav/MUfJensv1meUXyeY0zGZcrw9L0g8D0i4eK9tz
         CjBAtcrdJy5fdGAFZI05v3N3/j9FmNZhQ+bcEwyPqibY8/hnW0pxoLUCg4vvG9qWV+ZW
         q6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrflFNOZSIjgItlHCdTJezx4tLwnz9rrQiooYUCVY+tYzemv6Be4ktQE5YNW3I4rnSPUlNQxLHS3rOoyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XjBa6RDQmEQ8oIPNVd2aIfHpCvmQWMpSuCbcwdxLnzg4zAVb
	i97p8QNoE342WWc80dDFERbRcmouc+jFQgg/hHCFLZuyUjoaFzyUmTGyjpkT0g==
X-Gm-Gg: ASbGncsrzUPdbo9X9Bo+ikY6WBwvQ0TRJLDb/pAgrt4Y9LVKuXojtnA8p3suoeqPxt3
	D0npsTgIIRRuWhSHEm7RmcUWXejuVK+SNKE7L2ULgO+Iug9MWkHgQaGqSFG/YCH+ShSdsR6NzLF
	W2/PqHXAt0gFLxoEsUdGoa4YHP/s4p98XsDoXUNuMZxQZ/WtqwRF7ci9yjVFJEKmpycPASgDX1g
	51zpKL+15D+NG1KjjGb41MIMWcgLKMVYxVMd91cgZXdnudtMesnYagnXWItFRGnsyIKarc82AHr
	mwHgzHmDLFL5T9A5nCeoGFxz7oA=
X-Google-Smtp-Source: AGHT+IGEjW1+nSnm03Sb/7JjOqd2fLGFWNtn2pSYwsh2yOQR3S+BitUF4p8rbuVp0ACw3TNqwyLoRw==
X-Received: by 2002:a05:6a00:4fd2:b0:732:1f45:fcca with SMTP id d2e1a72fcca58-732618fa57dmr185138b3a.21.1739553256278;
        Fri, 14 Feb 2025 09:14:16 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm2520712b3a.75.2025.02.14.09.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:14:15 -0800 (PST)
Date: Fri, 14 Feb 2025 22:44:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Singh Tomar <amittomer25@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: owl-uart: fix call balance of owl_port->clk
 handling routines
Message-ID: <20250214171405.kvyyespxtfqxhapc@thinkpad>
References: <20250213112416.1610678-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213112416.1610678-1-mordan@ispras.ru>

On Thu, Feb 13, 2025 at 02:24:16PM +0300, Vitalii Mordan wrote:
> If owl_port->clk was enabled in owl_uart_probe(), it must be disabled in
> all error paths to ensure proper cleanup. However, if uart_add_one_port()
> returns an error in owl_uart_probe(), the owl_port->clk clock will not be
> disabled.
> 
> Use the devm_clk_get_enabled() helper function to ensure proper call
> balance for owl_port->clk.
> 

Do not use newly introduced APIs to fix old bugs. The bug should be fixed
separately to allow backporting and the conversion should be done on top.

- Mani

> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: abf42d2f333b ("tty: serial: owl: add "much needed" clk_prepare_enable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
>  drivers/tty/serial/owl-uart.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
> index 0542882cfbbe..64446820437c 100644
> --- a/drivers/tty/serial/owl-uart.c
> +++ b/drivers/tty/serial/owl-uart.c
> @@ -680,18 +680,12 @@ static int owl_uart_probe(struct platform_device *pdev)
>  	if (!owl_port)
>  		return -ENOMEM;
>  
> -	owl_port->clk = devm_clk_get(&pdev->dev, NULL);
> +	owl_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(owl_port->clk)) {
> -		dev_err(&pdev->dev, "could not get clk\n");
> +		dev_err(&pdev->dev, "could not get and enable clk\n");
>  		return PTR_ERR(owl_port->clk);
>  	}
>  
> -	ret = clk_prepare_enable(owl_port->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clk\n");
> -		return ret;
> -	}
> -
>  	owl_port->port.dev = &pdev->dev;
>  	owl_port->port.line = pdev->id;
>  	owl_port->port.type = PORT_OWL;
> @@ -701,7 +695,6 @@ static int owl_uart_probe(struct platform_device *pdev)
>  	owl_port->port.uartclk = clk_get_rate(owl_port->clk);
>  	if (owl_port->port.uartclk == 0) {
>  		dev_err(&pdev->dev, "clock rate is zero\n");
> -		clk_disable_unprepare(owl_port->clk);
>  		return -EINVAL;
>  	}
>  	owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
> @@ -725,7 +718,6 @@ static void owl_uart_remove(struct platform_device *pdev)
>  
>  	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
>  	owl_uart_ports[pdev->id] = NULL;
> -	clk_disable_unprepare(owl_port->clk);
>  }
>  
>  static struct platform_driver owl_uart_platform_driver = {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
