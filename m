Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871728F4;
	Sun, 23 Feb 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740287334; cv=none; b=q8cBWWXns5QkG5FTIxSiujv6iPZE4SbdRkpDue5JOyuNphTq45irjtsteZBgOjKv1LDQMJt3O68B8tdXXi9nlq8t/v8Zm0tue8wwTHJSY2JuAL0ZHOMznkGQffjKYbPz2YeD+tstWJXVi2oHoiE/bSrrkp4farcVMVLm5bBYseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740287334; c=relaxed/simple;
	bh=zdbGVk0R4XP2am+HV/vSLFiwL4kfVsz30joW2BNMsVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+ngDYbOhte3HYUPgAuabUC2Qj5ZD/+JM4I+5gmjNpYWF0iSwBMxBTc9YG3DOzVHlS62ata1tDncmcyh8Lhf4S9Cl74DACz5IFE6E99O4r2LHOkKEyYFYB+L16BT49Lnm5vwBX3SYlhPUIxDUqGVS3giFx1QiU7L4qx/sAQXMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAI47qC/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAI47qC/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46fd4bf03cbso55500481cf.0;
        Sat, 22 Feb 2025 21:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740287331; x=1740892131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBH0TwUlKOyjmVBKqs8V0ejTvT1+7RXd2Ev7u2AJBD4=;
        b=AAI47qC/duhVVoMlyv/GviE/UsLUE5K3oW1Fv+YOLMRz5Tkg6P9YBqLsvSfME7AOqP
         TYeZkkllUmoGRZU+tb+hC3fdpv5PPGWcyWh+xq+lEjcVN2EIyepRPShvMPVFaYhWWpml
         XJoa9ncGpdOyZoZGFnSa8Ul68YIkphSpuAw2jQiso87Y2yYzN1Xzks1UkSzVhuCheVuo
         pAtkFioDUkb4BTfBtk+KfppJaPIez8TZWG1mhx3ypX6/0g9wepViYkSXdvHX9NcwrU1+
         e5WFHqmKDRBUPasjyRZLEslU/hWSixCc3NwgN6uf8yYk6TMW4M8syfSiV/qnyznCFdo8
         En4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740287331; x=1740892131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBH0TwUlKOyjmVBKqs8V0ejTvT1+7RXd2Ev7u2AJBD4=;
        b=jv4f4SnYwnr64rR1hF8Cu/CJdesI7Ck0noMLr/7E1jlv78aJqjaHMFOOLWQOEjoO8q
         sxGQBsTZUE8JzJV0yKVn191qCs6me57PZLqbrcQuhPPkezytCWBVK87FtKsN3iM82oFq
         6IJgH4x5DNELU1XbCyN+Ho4neXaT0RwVLE1Xr6SXsjLWPVFHXE/NBpnWM8pW46i3AstN
         4dJ/lTp7fkXXia78uLJdUTLq4qeKdh+rzIBMeLFer0J7ukvsQhszOYrZIGhhhH2NFwml
         kMazVgFdYC6k1bxFNwAEQlrm+ra2O9A6ZqgjHCNHG51qflyXjWAQtIBy8M2Mol5Fk6VW
         hr9A==
X-Forwarded-Encrypted: i=1; AJvYcCXrTXWz8fJREFIR/OELz5jALKdfBDuLMCjlhdaegGks+/ZANr+k+Lp3y9KBV/v7e4hGfWI53knCbA0o0Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsmDHnhgh391CEc+2knAro1GEBLPcVlX5U0RDFfUYWgXzOZzY
	UrFc6Ue71b33Xh00QZtTVoTvHS5JexxM8VAnCnSYXuQyuhZQAj0d
X-Gm-Gg: ASbGncuS3+YNQsPHCSGY47Bnk75KGesn/2UzNdVPosF3ub7J1SVEGcFPBSvHbERmbh+
	wXwEcPqMDwM7Ws/klFZ0J0dgswFDMXfW2YI9Tc3s5JyiPW43NTrQcdhuVyiWiR5ZSsCXCZAoA6B
	NWHckT+a+ZVCsPUL0HWdy51M9FjzeS/BA0tTVxXJFFNDXXVusnSr1b9tFosPOdDbIoM2RVkxAPK
	JEC4E7coLvgW38qVNo7iH5FbnZeekzfGKjOyL32O8vZ61yAUegyuo4Mp3WbyPBpQkhX37w90zRJ
	iAFPAD6YCQTVe3EKhZww6sl1GtWXQiKWl48iCIgUCeYqL8c=
X-Google-Smtp-Source: AGHT+IFyUwylJsYT2gX4dxbJLOwg/LHqmtz1YQPSMcqi+w4DIwzS+SUSfRN9sXGT2i1e09QdqdNsKA==
X-Received: by 2002:a05:622a:18a1:b0:472:fa0:2b83 with SMTP id d75a77b69052e-472227591c6mr129311731cf.0.1740287331636;
        Sat, 22 Feb 2025 21:08:51 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:104d:377c:5733:f5b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f2b0476dsm75728701cf.28.2025.02.22.21.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:08:50 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject:
 Re: [PATCH v2 1/2] ttynull: Add an option to allow ttynull to be used as a
 console device
Date: Sun, 23 Feb 2025 00:08:49 -0500
Message-ID: <4305907.CQOukoFCf9@nerdopolis2>
In-Reply-To: <2025021920-uproot-antsy-e2c7@gregkh>
References:
 <20250217040748.2017975-1-adamsimonelli@gmail.com>
 <20250217040748.2017975-2-adamsimonelli@gmail.com>
 <2025021920-uproot-antsy-e2c7@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 19, 2025 9:00:07 AM EST Greg Kroah-Hartman wrote:
> On Sun, Feb 16, 2025 at 11:07:47PM -0500, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > initialized by console_initcall() and selected as a possible console
> > device.
> > 
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> > ---
> >  drivers/tty/Kconfig   | 18 +++++++++++++++++-
> >  drivers/tty/ttynull.c | 16 +++++++++++++++-
> >  2 files changed, 32 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index 63a494d36a1f..afe4e7722d4c 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -383,7 +383,23 @@ config NULL_TTY
> >  	  available or desired.
> >  
> >  	  In order to use this driver, you should redirect the console to this
> > -	  TTY, or boot the kernel with console=ttynull.
> > +	  TTY, boot the kernel with console=ttynull, or enable
> > +	  CONFIG_NULL_TTY_CONSOLE.
> > +
> > +	  If unsure, say N.
> > +
> > +config NULL_TTY_CONSOLE
> > +        bool "Supports /dev/ttynull as a console automatically"
> > +        depends on NULL_TTY=y && !VT_CONSOLE
> > +	help
> > +	  Say Y here if you want the NULL TTY to be used as a /dev/console
> > +	  device.
> > +
> > +	  This is useful for userspace applications that expect a working
> > +	  console device, without changing the kernel boot options, such as a
> > +	  distribuition or environment that historically had CONFIG_VT_CONSOLE
> > +	  enabled, and have now disabled it, but still need /dev/console to be
> > +	  working for userspace applications.
> >  
> >  	  If unsure, say N.
> >  
> > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > index 6b2f7208b564..8ba629ae426b 100644
> > --- a/drivers/tty/ttynull.c
> > +++ b/drivers/tty/ttynull.c
> > @@ -57,6 +57,10 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
> >  static struct console ttynull_console = {
> >  	.name = "ttynull",
> >  	.device = ttynull_device,
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +	.index = -1,
> > +	.flags = CON_PRINTBUFFER,
> > +#endif
> 
> There's no way to do this without #ifdef in the .c files?
> 
> >  };
> >  
Maybe IS_ENABLED() is better?  
> >  static int __init ttynull_init(void)
> > @@ -90,10 +94,20 @@ static int __init ttynull_init(void)
> >  	}
> >  
> >  	ttynull_driver = driver;
> > -	register_console(&ttynull_console);
> > +	if (!console_is_registered(&ttynull_console))
> > +		register_console(&ttynull_console);
> > +
> 
> Why do you register this twice?
I thought I had to add that in the console_initcall function because other
drivers seem to have that.
I want it to still work when it is just CONFIG_NULL_TTY without
CONFIG_NULL_TTY_CONSOLE, so I will guard both with console_is_registered
> 
> > +	return 0;
> > +}
> >  
> > +#ifdef CONFIG_NULL_TTY_CONSOLE
> > +static int __init ttynull_register(void)
> > +{
> > +	register_console(&ttynull_console);
> 
> Here, why is this registered again?
> 
> You should only have to do this once, and not need to check before
> trying again, right?
> 
> thanks,
> 
OK, I will guard both. 
> greg k-h
> 




