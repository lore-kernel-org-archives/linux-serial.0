Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDA204C31;
	Mon, 17 Mar 2025 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253974; cv=none; b=gvpzBSLUfqbBMy9QlbIJ+LXtXnIS6/SSWo6GMqtLcGqIyn8ciOoK93Q8DSxqOzgUxugtK1csHjjHfI8L6KshVTZLoMLmGyJ0+ZcJprufgdyMuNywaHnD7RrmTtq/MhQZWTUDu1Mg7miAzfvpeDn6RcyrV64Rr9eMzwYb0UEkAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253974; c=relaxed/simple;
	bh=RWEsdX6wdBbxQwhqTn65Mu4phSo3+GqqCZj8NtfaC2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO1KDFJ34p7GCl6uPPk/KxT0lFwguEq6WniJsKSO94ea5FFwkd/T/iIO47FFx37ou2PMWZqu+tjkPWcgaf/InmkH+7qufdp3axQw+QWTFg858W7wliT8BTvspyzx3mmO0W+2HNMXRpZ2QsjfmI2yjuphwkYcDJpyi5mRKpfQFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffOzYxEz; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffOzYxEz"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c2303a56d6so574116085a.3;
        Mon, 17 Mar 2025 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742253971; x=1742858771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnM9OF/UJ3vtp/v3zGtmLtQKA8pRcDzu+K7ktZwRW8k=;
        b=ffOzYxEzWVFMF1kq3n27N3r+PNlNRetguEACqfChxEVma7rGOBhBmREpbf206Faary
         KtAkaKpoz/NEG67fPJFQoJJW810MEFl4Lzozg/6w452ws1QjN+g82T0KOGiMaCPOaGzr
         2g1PAbauM3L+7tbtiaJf7rChfkajydhSgTY76EoPHT/lgqIaEt5XUZZns3xJvnNDYwPf
         Ho3ZLYJcgbEc4ccPXUEthv+BWR4KBGjEY+T+G+oNs7iuvns2O3VsUq1muADzh+TXBMCD
         QaWKi7Ksg2OPBSiIhZ3mHfqU8vMWR31UOCm9qqVSQoqo1LmtY9PK7MQBpCyV1fs+pJYF
         CINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742253971; x=1742858771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnM9OF/UJ3vtp/v3zGtmLtQKA8pRcDzu+K7ktZwRW8k=;
        b=P40tB/zP8aTO+kdLgXEQuMZ9sqQbpI2OTfvPaVLzsG+TgzgVDckd/c9FQLTo4kUBLA
         huYBj5ktMLG2bY/a/UlijKsO4bkAAvMUXbGXM/UuijSFbWynR+6cdhm2ID+ImLzpRA75
         U/0sfcuIZAOP3uY4/a5c5rya1qNg/JiDTZ8r4YhVfv2/FfmGoQlenAME1XTEcsN3xAyC
         drnqjHy7uubzup6TkD376LfX6uQYYpvmdIUE5F3ZrJwDgzweet/N2SBdJ7MhMbzeOZS7
         IIkL1h3gWSK+ZVQ6xiZ+1cCBhfHvWurAtJqQtekEyikc+aY4ghzy2ft9kBN9dZS7rBmt
         abhw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZnoa93FjbiiCdLKQwi7Wi7waY+IXhyyKcOr03D4DUWyURQfWDEHTmJELG1DZHLVZuP2naigzKm0Jo7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxSRsUNUpD4Xm6usxZN6irintUueZpLM5RQSTD3Q1txeSqswZ
	4Y9mwVkXck8Eih06T6NPh8cs9Wv3XPnMRxqOoxG3Csde3woVGGDB
X-Gm-Gg: ASbGnctEtvNd9TlyWAiJYiZNNiwgeSjDXbUIL6439HxJccxCoVtDWnqc4wWb7me4vam
	cPOD2IXdPjEadZCzkr4qbde6mH+zeUvS/ksIFqPPTuKdFFrAJKYigR5Gipf+EGsGys5wPka9XcQ
	u0RnSHL7yRDA2Pkxj+oHsZ3JnDgSTylxKkIBFfXIL5Y82qoF4qiTx0MqCb3AH41WeNstmunco9w
	Fw3QDN6BfZrgmjOwLxMBMkKffiGxLts8DdqYJIOzAh4/p5yI3hFbCMYIr3fqpzJdE1a4SNNqVpT
	NnaKCYkqFfbR6evbC/i2fm1dZyuSGCns+ZhfQSV9kaniy2w5pGRYbrM2LW38BnbCepi1H2x2X+4
	K
X-Google-Smtp-Source: AGHT+IHQVBU2VBGGZNQYT49PslVSslozZ7Jcc4/v398qPS5vnwAtP0kkN3aEaVBONGvFvZcboF3L9g==
X-Received: by 2002:a05:620a:8389:b0:7c5:4d22:2147 with SMTP id af79cd13be357-7c59b2c496amr255523385a.55.1742253971205;
        Mon, 17 Mar 2025 16:26:11 -0700 (PDT)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:2c79:27d5:fd48:ab84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f53csm643095685a.22.2025.03.17.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:26:10 -0700 (PDT)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject:
 Re: [PATCH v12 1/1] printk: Add an option to allow ttynull to be a default
 console device
Date: Mon, 17 Mar 2025 19:26:08 -0400
Message-ID: <5112655.tIAgqjz4sF@nerdopolis2>
In-Reply-To: <Z9hC4Ri39FsyOF0T@pathway.suse.cz>
References:
 <20250314160749.3286153-1-adamsimonelli@gmail.com>
 <20250314160749.3286153-2-adamsimonelli@gmail.com>
 <Z9hC4Ri39FsyOF0T@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, March 17, 2025 11:42:25 AM EDT Petr Mladek wrote:
> On Fri 2025-03-14 12:07:49, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> > 
> > if enabled, and CONFIG_VT is disabled, ttynull will become the default
> > primary console device.
> > 
> > ttynull will be the only console device usually with this option enabled.
> > Some architectures do call add_preferred_console() which may add another
> > console though.
> > 
> > Motivation:
> > 
> > Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
> > if CONFIG_VT is disabled, the default console device falls back to
> > /dev/ttyS0 instead of /dev/tty.
> > 
> > This could cause issues in user space, and hardware problems:
> > 
> > 1. The user space issues include the case where  /dev/ttyS0 is
> > disconnected, and the TCGETS ioctl, which some user space libraries use
> > as a probe to determine if a file is a tty, is called on /dev/console and
> > fails. Programs that call isatty() on /dev/console and get an incorrect
> > false value may skip expected logging to /dev/console.
> > 
> > 2. The hardware issues include the case if a user has a science instrument
> > or other device connected to the /dev/ttyS0 port, and they were to upgrade
> > to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> > sent to the device connected to /dev/ttyS0 unless they edit their kernel
> > command line manually.
> > 
> > The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
> > distribution maintainers an option to avoid this. Disabling CONFIG_VT and
> > enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
> > console behavior is not dependent on hardware configuration by default, and
> > avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > port.
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> 
> JFYI, the patch have been comitted into printk/linux.git,
> branch for-6.15.
> 
> Best Regards,
> Petr
> 
Oh wow! Thank you so much!



