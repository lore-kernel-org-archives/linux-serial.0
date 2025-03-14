Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD51FDA93;
	Fri, 14 Mar 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956739; cv=none; b=DSLV1oFkyJ4ZnmTcOTFMq9Kb/jH/k2UWMCJzILrBlZJ4uI5J10sLRtACL0TyWDTBTNj/SWT3XAlSm/cYq+raoSVGpBfBFqEgG9M9+b0Hu3AD/QPpbmyd7AcAu2oFiQuGopaRoc3NEfQPWjI//U+zaRjl5qd0U6J/0uylQPR7298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956739; c=relaxed/simple;
	bh=YzGjELU6MCw1jIeLACn0hhXeTWO3RUfxHTUsZyvDFSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHlgs8o4G1tvIZOrqRAJKGMQODaEUuQOOpH0CMSAqIKJB0w8l7Z38hKhG4+HMSnzbUlEAD5k3cFKEjDtv6+A5JBKwCwNlF0/FTMIpQWmI05/IMvw4GzAeLf7QjdlIyxBBGPGBtX1d+Kxx1N3+6kPrUqmgZ8vzJl7pTjD5DZdE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOJjH9Kr; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOJjH9Kr"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f94c2698so11485536d6.0;
        Fri, 14 Mar 2025 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741956737; x=1742561537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1/OLI3dAv2lJrBe6X3SCCuDDSuxOfS2a0vFYG5uB8I=;
        b=iOJjH9KrktPi+b1zU5a1Ijm6pcVn/Lsm87Q0uT2NNs3cypRLgKxPEJGpLTUsVmCSA3
         YiPMW1V/6d5FiRAfQ5byLK6fPu1R5Xfyz5oszvDIdi4HTiHPgRYU7hi5HFXKy+JeGVWh
         SL6doAG1patjCIiibp1kX6aXA0YXXirotOHHUuk0EJ8IvVRfOIRLA4Dl9u/IWrSEnc7w
         bKitbvT5YiofknYELPgjCC9sHYIHdKiE/Ecs4bd6lcr0CIkXO32PMAmHfURFqUrUrEuc
         RD9l05J7wiT3HSqp1eQ7c3Sy5RRbPQd4vp09VZ4BHIAxeLhCQDzpGFgzn/JHbd9P9owz
         ldFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741956737; x=1742561537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1/OLI3dAv2lJrBe6X3SCCuDDSuxOfS2a0vFYG5uB8I=;
        b=wIleDJF2oEC3WVrghjNbfDVuhAaQnMbeY9Yk6qjgZsKEOf3D/np+iJK5jlW9KPLySc
         5J6RR4inqUadhOh7jnjyBxAoGzQg4JT2i+LWBbEgugWllCR7cugUBwdRfMVnM/k2lt3B
         jF3uw7WOoUKBk3B64l5Wvm38OVqDeT3kOgacdpYgWlB/Czr4ROUpm+tn3nhz3vKVNhvz
         RgAg295AVQA46YT9hGOPjKSQzr+faztX5aZABYDZaYrhVa4u+Vmb3xPPqy40Nzh3FWfT
         SIj87lEsEO4QRD3fKQLg3O0ARFdxeljobUbKgMjXQIVhbyWp9BAKixSI1ty8351tAX0V
         ntcA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uFSdtirGZJhtqO3n+lcOft6etY7bdS6cztomGUeLiQF8bJqFCjyq9kOfhQJ6ME2fn56xE56DfbMnNKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxevC9mXBDaSEnf8qmM4j6E6bCaDJpNnOzyysSzz/S+wkEI8IGQ
	OPjZV1p/mcjP6/Gx5Ha508ZPx1+X7ML92a7IgFZA198pNjOFpwyQ
X-Gm-Gg: ASbGncuMRGP0vEQwqxEUUZdTpqQZi8B1+Z/uqPvaNJHqZ8yDiMTFctVRy7EuHHvWtg8
	Y6nE0aFIT3cFk7bDODm4whN3LUDiE4hB6TuZjmx3KNFbzhqwGgY2yyOUNSoFzv4MrTUSen/N86L
	k+B+bfigbCUUlTcT6b0dZc9qssxUhsUBr37SE/eFLEhW5AO6crSLFBCuaPErj1eMrXxDPldK/sb
	DgX3uIsZ0v0A71dJbXe4K/oLra7JvWpJxQHYmk1pcTp2ZDEP6zQaFP75zIJhufDg/5crCykJWjq
	M1WhSnfiS4/CQ/5lhDYh9O73QXaq0eztms38bzS9R0FUPsqv3YCe8X7FbyJgsv6SSA==
X-Google-Smtp-Source: AGHT+IFFMalKZ1S85tXeO/MP81G8maqTkHV2ik80vQ11G8F/WvHDr6SFl8ikw98Cts6OTdDN2+WvLA==
X-Received: by 2002:a05:6214:f65:b0:6e8:f4f6:9311 with SMTP id 6a1803df08f44-6eaea995370mr33137536d6.1.1741956736840;
        Fri, 14 Mar 2025 05:52:16 -0700 (PDT)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:1b2c:8d81:f410:30c9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade2342eesm23187276d6.38.2025.03.14.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:52:16 -0700 (PDT)
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
Date: Fri, 14 Mar 2025 08:52:15 -0400
Message-ID: <9563158.18pcnM708K@nerdopolis2>
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
Thanks! I think I will resend though, just so I can get it right



