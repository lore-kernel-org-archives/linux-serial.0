Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E01E4113;
	Mon, 21 Oct 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505361; cv=none; b=YoCss2oFtlnL1oYcxEM8x77hzQ1A2onKWSLtiB1C0idA9U1rDqnDCK5eDV7s+xmW7LB5YnPhcklHgZ5pmmj9QKc870JbYcH1HAj+6Ecqg9G9KcC1jlgivoihXOhC0GN2vTxGnTwEg4aXrZ1PFA+ljbyiKj96A2LLCW8TtNfqdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505361; c=relaxed/simple;
	bh=2XWylLirGe485hFoO5ABdA5oJnm8V+XCxwoKVzuF+gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usl4v0BmSOgbYXmUeb2Syw8zQqXaXCIQ7G7bFYark7PkndFWzB+pHO+b7Y7cV88eRvw0Y8TjB+O3skQCEOkpt0vmYr1jsWOlJt4D54a1AnRY0rqBbd+PgkV0sG9a10m5GK8lNNq7BlsZOxvcyzDVPU+97kze0hVkznPJkkH7RX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9d3x7O9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9d3x7O9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b5affde14so29088865ad.3;
        Mon, 21 Oct 2024 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729505359; x=1730110159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yeq8CDDkDOrSnhrxHij8VmLVC6Z1DWY5RzKY0fBvsb4=;
        b=m9d3x7O9GYbzld+8ZtHzUGSO5USfu9EZDhAoPK541lhWjrQV0tUlgnfJcGS5Cj+2dB
         pzm1zlVunTv7EfAwKCsMUdPWr0fXs6lXDaEi5dgGf6aLL6NmKBLzT6EPZtToiksFaiq6
         OfrUiDDJ1Ha1fTBab8RY3EvW8ovD9Zi3EpB5CAACMCdQtS7YgY+ECh+w/bqr0QNXzP5b
         7VXmqiVzNL1RW0xdqaueCQ4xAliotogxdH5MweuS9EJC++YobyKRT5OYhI8gpoi7bewQ
         d68/DqvAvUZJzJr/Rz/XPEfJYOYII7LtfP+b+NhyDop9WmSvocrX5E2Odi8vSk1SwX4g
         HGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505359; x=1730110159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yeq8CDDkDOrSnhrxHij8VmLVC6Z1DWY5RzKY0fBvsb4=;
        b=H00ViAWP286YGPWfrP1Vt7IH27k8Z45Y03Y8U36s8x/iJBnOXtztTwY3axts9Jv5c9
         IUBogigjDVb23UBueW8awewZhRqcLgUAjwxDGhEX0XljGUx+ylJ/GP9kmcBHJT2rdFvw
         6JFONuVLCcW1pYKp2uhcRK3jx5G2u1xQynUd+qFnyE465wgZc5+PytIqRUl6UkDiT6rQ
         e37Hy89LOzL0hr+M35WW0elMWeuCA4ztLXOpMTcEljJk0+Qy2T8C7ICrV/e7vPH4LLPz
         ge25U/T/mhBahAyVc9lZ0Wd/luewGy+iTbqwGlupUH2iKIJQNyfNIM5+T26bjTJvmf/L
         zrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW24rCU7nXuXigYuUuvq/xuPA0QldNqcKF6npbM6eIvDRs6Ra0AQ6zQ0Hv+ME/yzshSxblbEpbO/v3y3IU4@vger.kernel.org, AJvYcCX1VoeNL1gVGYHE7z8WqBmg1BRVWaT8Y6Tolz4cXbJTWK9qtHk+bDk6UnY+wnFIm+0oopufR6L4EzsV23gY@vger.kernel.org, AJvYcCXl+FkT4Eag1j0M8W1EG7aJvQgeI9agjmyRyKBSYr65pEkV9Ck+MRzfBddX9ZL6DNQ8f58+7cE3PvUb@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHrTiSCbTTYcaaU6PM54pwBQyAkdmW3JJag40VAX9GoRxAYMU
	PzWOLyH96+vom+OSIbiS8qdJ5WVXq7ScTkmGzXGhwqb6dDzqAWtH
X-Google-Smtp-Source: AGHT+IGBVSe3fGC8jwkNg83HVZynlz+8eS6hkHiMJMQb3ltPpok70fN7+VYi13IU+PQuxS5Q2gB9RQ==
X-Received: by 2002:a17:903:2342:b0:20c:7a0b:74a5 with SMTP id d9443c01a7336-20e5a9055e3mr143289685ad.39.1729505358749;
        Mon, 21 Oct 2024 03:09:18 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e0ecsm22543135ad.109.2024.10.21.03.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:09:18 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:08:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: Add Sophgo SG2044 quirk
Message-ID: <tm7jtf3swggiilznwo3xcqjlhd2a7cguwk3nay3bhmaxo23mf5@qw2fyjwapoxe>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-3-inochiama@gmail.com>
 <29d8e2a6-d0e7-0f74-1f5c-4f285ec1e9ee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d8e2a6-d0e7-0f74-1f5c-4f285ec1e9ee@linux.intel.com>

On Mon, Oct 21, 2024 at 11:52:38AM +0300, Ilpo Järvinen wrote:
> On Mon, 21 Oct 2024, Inochi Amaoto wrote:
> 
> > SG2044 relys on an internal divisor when calculating bitrate, which
> > means a wrong clock for the most common bitrates. So add a quirk for
> > this uart device to skip the set rate call and only relys on the
> > internal UART divisor.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I wonder though does this mean the numbers userspace can read from kernel 
> are bogus and if something can be done about that?
> 

I am not sure whether the clock rate can be read by the userspace.
At least it report the right baud speed by using stty.

Regards,
Inochi

> 
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index ab9e7f204260..51894c93c8a3 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -750,7 +750,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
> >  	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
> >  };
> >  
> > -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> > +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
> >  	.usr_reg = DW_UART_USR,
> >  	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
> >  };
> > @@ -760,7 +760,8 @@ static const struct of_device_id dw8250_of_match[] = {
> >  	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
> >  	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
> >  	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> > -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> > +	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
> > +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
> >  	{ /* Sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> > 

