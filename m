Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF91EE03D;
	Fri, 14 Mar 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968351; cv=none; b=rTmGt4W/q8GbJPcnx99ZNqO8ro1ElwTMUDKe/Tny9lNtZIbWVOCySxOdT1mtuuCTUgzkNDvzFFFDu/WsBgioyLXgqcYSH724ApoNIdanSbU+LP+lM+0bdQ/jcMv0nWsZVvA/GlLfTp+ACMT2I7h2zKPYE1C5KPKVa+p4QkpFj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968351; c=relaxed/simple;
	bh=y5iLS0qAR/Fw4lPHpyN8WwukffN+ADvp20CdBHRHImg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw8RnpKFfMSQHjIwdPPT5xX6lEA1Yy7x11s45X6wCSAaMRtPUtYIDUUZ6MglojKLVIuRIycVNY6tDkOFsPllq4re75C08kDqgbv1hxkVBY+3ndZoMdB/ZsLYGw8pi84XHI4tEWRrnB0q3NIEPUQ9xxp2dXyhd88yU/Xbm1j3Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDXRQqit; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDXRQqit"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso4214296d6.2;
        Fri, 14 Mar 2025 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741968348; x=1742573148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGmHPsluvU5tP9Cbeh0pEBn1lLXR4ROUfQFDzD/Nc2w=;
        b=iDXRQqitqg4PARHCs0U4snXTmmFW5WP9jg9iDmkzah4NsZhzLBcCJI+TY2o90vvytb
         SNNFvQFKPmE32QP3yKrAluJFQcI5cd7CNEilGy314QQZVTB8SbP5RvSewdT2F4tWUq89
         m+TR0rDMlCbMTLCosn6ICjmBJvZGCp2tiDJLD6R9VC5Ts9IXlNFhvLrkSoqb++Mfwtz8
         m0xzrA/hGsmsmJOvvuq2OEn1Jq75b4SFSC5MhYHtdeWj4ev/2ZtKfE5K+F+jc/jS64cl
         1lIa0M9JHd63IZj4KYuMA5Q6EwcdDxp1xyxkRuwX4B13smGMHxeed/FbsrvyhoSpBS4d
         DuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968348; x=1742573148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGmHPsluvU5tP9Cbeh0pEBn1lLXR4ROUfQFDzD/Nc2w=;
        b=nOhH9DNws9VVrnHoAPLRnU8esIbFyuGDuq4W7eTgR/cvVdUSX9vXYkgWs+FTb6sRv0
         p1H2g7Hdy680XYEiLQrLNRU5ujmjmJn1t4WX+Kj5Zb2Ml+CalX8NWuvOkKC3AwohK2XR
         IJ1WBmZWSEgHrwlmcwPchshkd083uiAAedc9LlxozoBgnwe5OW2P/PZK9I0PYPUjlqop
         5w1K9/587wMKB9CN1DaLp1U+LlwHCPXEBdAAM+xrCfF0jg/NkUGOvg/yQ98/PJ/60+36
         1KoGwjHE+xZKEP1ZMsLj0zBn6ox+45o2HcqTduoWW4WxMdvsPq/7cAKuip2phJJ6/TtG
         Fa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnMKAwI21sZW2jkiQ1p/NvHLO3DsuaUqy6cv8fr4eP753YuWYlq4gBeGUtCr2puSqFqzUoU0nIhh7Mqc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSU9dTilCP1DaS5OOzvasBvvEhz+ivvfXT0IAuxtebkj+5j0Zq
	DtRR/lxo1O4PDGwLIezTJGnzgog5Qe1vsUasDHp4DEDvzg5HOc8R
X-Gm-Gg: ASbGncuHrFckyCCu25wiDqz5RI8/eIVLUSQa39n+jyu3XHFK3IfhGUzvBfyA44GT187
	9qM6LXq7QRBGTswl8D+iZHmuOSFvqnBjKV/AKk0F8HBJCi931wNcWpCzs1uw3Sy3L7F+OGtanMU
	Ty5B1f9VJRI/9PFuk9mzBEw87u/U8ZRrwFvu7SkVW+Uw+xTObSHv1Oj3N0Aeb8imJiqObijvFrP
	BcfDWSL3cIT3BW86nJ5a/7ftu4yDsYVv+/D8xI51DP6cmC9+iuxcuXokGiAciWgN9WKoQJu6blA
	KC9T7ZdTGig0JO6gtZq1OP+Exe8Pqit63xuiTV6W5lXxGa/1bDQ1s3xB1BmpTYNopg==
X-Google-Smtp-Source: AGHT+IHcB+IAzxI0mIV6Mj5N9hZoIKvZ4KpP2wVXOdNcCWpePYZlGUTQYghkqGrd5jjjr9WvpCN2CA==
X-Received: by 2002:ad4:5cca:0:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eaeaa1c6e7mr41295056d6.11.1741968348166;
        Fri, 14 Mar 2025 09:05:48 -0700 (PDT)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:d731:b11a:3691:3fd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3501ebsm25528146d6.116.2025.03.14.09.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:05:47 -0700 (PDT)
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
 Re: [PATCH v10 1/1] printk: Add an option to allow ttynull to be a default
 console device
Date: Fri, 14 Mar 2025 12:05:46 -0400
Message-ID: <5391570.SvYEEZNnvj@nerdopolis2>
In-Reply-To: <Z9P6i1Caw9SWEO6t@pathway.suse.cz>
References:
 <20250314004104.3103656-1-adamsimonelli@gmail.com>
 <20250314004104.3103656-2-adamsimonelli@gmail.com>
 <Z9P6i1Caw9SWEO6t@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 14, 2025 5:44:43 AM EDT Petr Mladek wrote:
> On Thu 2025-03-13 20:41:04, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> > 
> > if enabled, and CONFIG_VT is disabled, ttynull will become the default
> > primary console device, based on the link order.
> 
> The result is not longer based on the link order.
> 
> The linking order affected the ordering the console initcalls.
> But this patch calls add_preferred_console() directly in console_init()
> before processing the init calls...
> 
> I would just remove the ", based on the link order".
> 
> > ttynull will be the only console device usually with this option enabled.
> > Some architectures do call add_preferred_console() which may add another
> > console though.
> 
> I would add here the following line:
> 
> Motivation:
> 
> to clearly separate the description of the new behavior from the motivation.
> 
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
> > console behavior is not dependant on hardware configuration by default, and
> 
> s/dependant/dependent/
> 
> > avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > port.
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 07668433644b..9dd807717cd4 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -4277,6 +4277,11 @@ void __init console_init(void)
> >  	initcall_t call;
> >  	initcall_entry_t *ce;
> >  
> > +#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > +       if (!console_set_on_cmdline)
> > +               add_preferred_console("ttynull", 0, NULL);
> 
> checkpatch.pl reports that there are used spaces instead of
> tabs in the two lines above. I suggest to use some editor which takes
> care of proper indentation, e.g. emacs or vim and run
> ./scripts/checkpatch.pl before sending pathes ;-)
> 
> > +#endif
> > +
> >  	/* Setup the default TTY line discipline. */
> >  	n_tty_init();
> 
> With the above changes:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> There is no need to resend this patch unless there are other comments.
> I could make the changes when committing the patch.
> 
> Best Regards,
> Petr
> 
Ah, I didn't know if I was allowed to include that myself in the commit message.
Thanks



