Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDF17C21C;
	Mon, 27 Jan 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966572; cv=none; b=Xds2BSuQ3GWbsMslTdmwD+32+fteAKkOkRjXa9kE2pY599YHRGRNvEiAJl5PSRiFtVxtiyRh9zGBGEKlyNYVqS78gYf3kDWHPHmaranLu6ZJw4HTKw6H+iXhK/VJnqTOLarI7gQX3oPN1hYQirbfQoT/PAND3Q3/qfD6pJ7+G/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966572; c=relaxed/simple;
	bh=Y8tJhNg9KDJCEjz8VtvJzFvJeQBPTUTW5IOYy3pmZFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldg5iEl14fuB878hOdLZ2fOdxwWuqIJfXGn2NUfmum2FmkSUGljms4cK3Apz30d2gt9ucUDANEnkjBtnL1yAEvn9C+wg3wPFHH1HemukdY7DvhWabGC/mf7g+J23RH7U39txaI/YRR/gRSVvBpAaGERXufGJFwc2D4CtCf3K+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToH71ipn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToH71ipn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso68429325ad.3;
        Mon, 27 Jan 2025 00:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737966570; x=1738571370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3Fuocx71vo7O/6VQuM1gRBQ0HXaeffMzka2qn5jJO4=;
        b=ToH71ipngOiFEwXHBNm2ezaSxTxdhAznamyvKS70EkXMNtoYuvCnjrjr3Paek0FrEl
         sv8BoZqFVvkneRmL0AjqOLZBE8UEhOBzeVaNPvOFQNM7AkTaxKgzlv38Chwsf34szAea
         CeWVQ3KoU9zlGZvIvOeyElkMcMWxawBePyK+QyoMc7PREy141ZM6HXs7ix6O3cwXsPre
         DE85jGbfy7X4UeRKibwxToF8inxcpTsEOfK5AjmP6Oym3V9KF1Oz9boPNhbVHaUfzCtD
         G7sUpdZXoNfAUXiVqJ2GPgv5QxUXMfrHGAMWbBzck/+zst20/OtsbTAQ7U89tIV3P8w9
         kx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737966570; x=1738571370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Fuocx71vo7O/6VQuM1gRBQ0HXaeffMzka2qn5jJO4=;
        b=EE7vLC1bDlKjzE4zqeNXcFqQox9szA8WEKLMTtKeIodzil983eG+SJZ0kij5ZGlxT5
         VnXvWVCysEI/xjxldHE+0BkhAmxhvFfUw0LYoz6v6tdUGOmcvNRWz1HyCYWmEUn70eED
         /k3b7VZNHa9sghxX44vQ8ph5CCn7MegoDcKnty/x60B83ml8L/IN6fFXqmNaoi2Zapwe
         28Q0hKesk6bIuW6fOODABJY6OIdQ3FYXtKsDIu7hhhwE7szRZ3o46PSvuhcDxu/arRH4
         upQ3MnjIm/hGFSrcaA7tquayaldaLlCwLQzk3YPuKSru/Ru4yZwWSrylqvY/qtcRALLC
         9FSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs7ofsPT2NIO9SHzqUsV1HRo+4rPerkygPatnIlD5FFDYhNCUfX4wXqVH4MTSkgeULyjW7Uh6iq8EuGyRO@vger.kernel.org, AJvYcCWkn236x24+5euvrfvy69Z8Yu5Ow/YtOyV8fWTP1bBXO3Eh29/IuFI9VqcuZwdGWWmpH/TOSvPnLuSdkY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweicERLBIy/gyETw/s+FrGZN8Zv5FH6lYWekoK8Sjbv7f2M3/b
	U93Vc1HX3KtrOaTYB/nCan2nmV6Yiz6BNpS42N+rCeOxY6F/hHVY
X-Gm-Gg: ASbGncvQ2GZH3t74SyvWY3i4NC25Nqu4QisEqFkIJr2V4QS5wGylT5cKOHWwM54TZqI
	YP9gB0gadk6z9FJZKrdjE9l/S+seG/8lUS8/0ZEWzo+ODa69YzcnubYbEx/Ox1BzxXIh2OvrmhC
	BHEzHNHHOOlHM88GL9dsOZl6GOTZ8rkpJpr/ZaxD39noshuAzMVpoN2C6tI/TFR69FIjuuwFo8q
	AwUlDMVZuSGr9af1Pe0/YGFGJ7SC0/Ymq/HJohSM8bgSQcJO9B0k1eRpkPdYeZ+5ozGD3ZyHbLB
	CIh7vCg=
X-Google-Smtp-Source: AGHT+IHv1vtc32wnEWTe6p2W7In8Wx5hlJNvdrRdOpCVQL3f+gNRkY1wMBn7lKVL0JYtbiRuDTMFhw==
X-Received: by 2002:a05:6a20:4309:b0:1e1:a693:d623 with SMTP id adf61e73a8af0-1eb214ea886mr63892729637.25.1737966569733;
        Mon, 27 Jan 2025 00:29:29 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac490cba124sm5850684a12.41.2025.01.27.00.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 00:29:29 -0800 (PST)
Date: Mon, 27 Jan 2025 16:29:24 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: pic32: Fix build warning when CONFIG_OF is
 disabled
Message-ID: <Z5dD5Fz2vf-nnjvg@eleanor-wkdl>
References: <20250126163115.3200308-1-eleanor15x@gmail.com>
 <2025012604-undamaged-earring-d16c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025012604-undamaged-earring-d16c@gregkh>

On Sun, Jan 26, 2025 at 08:30:33PM +0100, Greg KH wrote:
> On Mon, Jan 27, 2025 at 12:31:15AM +0800, Yu-Chun Lin wrote:
> > As reported by the kernel test robot, the following warning occurs:
> > 
> > >> drivers/tty/serial/pic32_uart.c:904:34: warning: 'pic32_serial_dt_ids' defined but not used [-Wunused-const-variable=]
> >      904 | static const struct of_device_id pic32_serial_dt_ids[] = {
> >          |                                  ^~~~~~~~~~~~~~~~~~~
> > 
> > The 'pic32_serial_dt_ids' array is only used when CONFIG_OF is enabled.
> > Wrapping its definition and 'MODULE_DEVICE_TABLE' in '#ifdef CONFIG_OF'
> > prevents a compiler warning when OF is disabled.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501260006.ecUsBidz-lkp@intel.com/
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > ---
> >  drivers/tty/serial/pic32_uart.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
> > index 14d50bd7f1bd..a228a55102c6 100644
> > --- a/drivers/tty/serial/pic32_uart.c
> > +++ b/drivers/tty/serial/pic32_uart.c
> > @@ -948,11 +948,13 @@ static void pic32_uart_remove(struct platform_device *pdev)
> >  	pic32_sports[sport->idx] = NULL;
> >  }
> >  
> > +#ifdef CONFIG_OF
> >  static const struct of_device_id pic32_serial_dt_ids[] = {
> >  	{ .compatible = "microchip,pic32mzda-uart" },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
> > +#endif
> 
> That should not be needed, no other bus requires this, please fix up the
> use of the OF macros instead.

So I should remove of_match_ptr and add the CONFIG_OF as a dependency
for the configuration. Correct?

Yu-Chun Lin
