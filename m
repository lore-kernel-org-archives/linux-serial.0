Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73815176AC5
	for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226151; cv=none; b=GR576zXT8ipXI1u6FnWpZt1cb8Wykbkl9xMioXpmXl7Taw6ggo3CJcqvCIdcjy5S+NuR/i4eyRXQ6jCau5mMcs+zfFcENeq1sWNKlpUp3dBN++22mryx6hE8mW1pQvjgvv1c3qUCRRx0TxMarUODPv9cB1YmRmXD5IHNUgRHnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226151; c=relaxed/simple;
	bh=95C0iFKPFCJdqxunet5Y22/0vzP095YVnCIPv+/g1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCGWUzrn+kmCqnH0TN85XNzvr2xX2zE9/JvPwgtxJ4T0vgFA2CaRRKnODmN1AOcO3GnZ6+ghSfi7oXAVVtreg2mUeU7ep5CKvxodT2Su95isEsFuCCtnsNhjiBYNQVMPFGaA94ZLCCmJqHiSyOCqaNFUJFfeKgElm9LAHRIEvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D9CivxON; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D9CivxON"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39133f709f5so2784663f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742226148; x=1742830948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Sl6TiBLO8N25M9MJl5F5cWXO3GkD985i4DUNgdnIpM=;
        b=D9CivxONF6M+3Nw3yUJKy0MVXwRHhUPDywMHgNFXXumfc10MGj+IUlaQg6vD8lAv+2
         PZBhyeBUQr7oGXHSCA1r1sX8lPHP8cU5tx/w+90RK3vvw/4Vp5nw3yDwmo9z7INSF+4X
         4w1OAUsoO3XWF6L7NL2DMU2NxDxj1EtVmMjwhdrGMF7pAS7Fj+GQ/9NbTlHuSL1shojp
         Zvh72QUj+mzs7BM+0FFFGuN6w9zA1nCu2N8/X0IxfkpmTpr//y71FHgIiN+D8Nz8+gqO
         O1yxojFfqyhyfcgidRBvYo5LMoNEle2L/8BcH+8S5SwqqUaGFyN5e2tQpFok+Kh10tTS
         vY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226148; x=1742830948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sl6TiBLO8N25M9MJl5F5cWXO3GkD985i4DUNgdnIpM=;
        b=edFMKP4CnqJpApCX0H3ggFFD9kpaWUxVBTPwOk5OG9MbcEBB1nGDJ8MvIa0ehwdnZH
         4QiJHfJJWzWTLH9oaAHjf16pPyVxEtqv/SEVm/eONABebw9xr0R+Lm7OSGUIGFi5l6l9
         UGVhRtqO2UT6Y1hxM6fGH+x+YJ2dfX2DB3511B+b0OxyEjBL7KnaFJsckrdF8UX7UjEg
         N3juEwgCx0j9CiXODjsPPmns1418ZAmgmKc0tsindJdtTBoW0iuqQ2L3myo4Ty16N2BF
         TdHntouH7eETB7sUOe6Mz7NlWJzHfcfwmC42t0rzuTiN+38E7zgYPGYZdOguwOxB/VWC
         3GDQ==
X-Gm-Message-State: AOJu0Yywg60OlsIw12S7Nz606QLdzc47OBI+DckhoeVYHE5vi6fwvBRe
	5n5VyCIOPN1VvWnPZ5pL42PbMPQWBwy5XNhtaT+lSj/eZhefQ48Wqqb4mGN+9cc=
X-Gm-Gg: ASbGncuKb3qhEomEN/nJHZhWjhC9CLQDu1RW8NNw/qfk+Qqg10q4ilJZPwhfx0hzPaJ
	iBHxInRf0GsEW5SFuimhbNIckeg1cdfAioDioX4DyEeOfqJNYn3YgHicKXc1Atdz6vp+r1VTzf9
	t5fuH2PupeM3/UBLVExROeg52OglT0Ny+8lyKJNN5T50oukxd1pVL6ECqgLMPl1sxc6KpHJ8Snr
	ePMV+x8YvpFIrXSMwFlM3HhtTaDINXyPOVqaCnPqgKUQqDHPIC5/PIIw/PDWnRAtlfHWvHETlbL
	d+MSF0ZV8lgKoWtd5U2vrLV0/BD5Q2xqrP+NwaVpyW9qi5AIPRPyK95igQ==
X-Google-Smtp-Source: AGHT+IGFI7QGKei4yncWB619h0fAg9aDp6rT7ZSJlbo42qbdkjEdJIdxaXEtj/PmkeZ0XXSLhW6X3A==
X-Received: by 2002:a05:6000:470a:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-3971e686fdcmr15861208f8f.33.1742226147727;
        Mon, 17 Mar 2025 08:42:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm15623852f8f.53.2025.03.17.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:42:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:42:25 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 1/1] printk: Add an option to allow ttynull to be a
 default console device
Message-ID: <Z9hC4Ri39FsyOF0T@pathway.suse.cz>
References: <20250314160749.3286153-1-adamsimonelli@gmail.com>
 <20250314160749.3286153-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160749.3286153-2-adamsimonelli@gmail.com>

On Fri 2025-03-14 12:07:49, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> 
> if enabled, and CONFIG_VT is disabled, ttynull will become the default
> primary console device.
> 
> ttynull will be the only console device usually with this option enabled.
> Some architectures do call add_preferred_console() which may add another
> console though.
> 
> Motivation:
> 
> Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
> if CONFIG_VT is disabled, the default console device falls back to
> /dev/ttyS0 instead of /dev/tty.
> 
> This could cause issues in user space, and hardware problems:
> 
> 1. The user space issues include the case where  /dev/ttyS0 is
> disconnected, and the TCGETS ioctl, which some user space libraries use
> as a probe to determine if a file is a tty, is called on /dev/console and
> fails. Programs that call isatty() on /dev/console and get an incorrect
> false value may skip expected logging to /dev/console.
> 
> 2. The hardware issues include the case if a user has a science instrument
> or other device connected to the /dev/ttyS0 port, and they were to upgrade
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
> 
> The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
> distribution maintainers an option to avoid this. Disabling CONFIG_VT and
> enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
> console behavior is not dependent on hardware configuration by default, and
> avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
> port.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>

JFYI, the patch have been comitted into printk/linux.git,
branch for-6.15.

Best Regards,
Petr
