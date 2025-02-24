Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC1233734;
	Mon, 24 Feb 2025 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400734; cv=none; b=ozEovMNW2TpcwRpIJrfv1z0zqGDN/49DJ5stHlVsL8zCerLrlMNC97bRn6b0lCauRreXV3zUfehkuDM9/pEjGRjiDtgbS/3F6ibzlf8QXsEaN30AdXHgh8amz/6ZwQEQ5FaHMNX41XZJ2hl8GX1DDjZj0uYe6UJEAewdaM5bfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400734; c=relaxed/simple;
	bh=C/HIYLJMes5/JokQAfCciquYE960i/AJXIf+VAKHVZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFPyo6Vlv/P8wQ+kA2uJ/3q38z3ySkDpiBcm4vU8lztvTh07p0nhzo0/MIBlsgvyabdD9KDXyQoE9Lpd+5HdHbC7AJIQl64HCW9fh9Ggj6lx/oNaV+I0sWmdDgu9PpLRNxJyFOTUZvrGsaC03xGfK/Aws52PhntDLTbdv9nxyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnBBKK8/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnBBKK8/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c08f9d0ef3so265951485a.2;
        Mon, 24 Feb 2025 04:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740400732; x=1741005532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kmTM3n4yBBMdKxDX6gBx7ZoYT1kT7Ntk+s/Q8yOWMw=;
        b=TnBBKK8/606x0W8NOgmSffZshFeOMysUEXbgcXNmDrGZ7FaNHZlozE3ZREtaROsNJ+
         eSe4pNJPgPskWe8mxceVcagQ3Mp7gBg1y1+v7QGbl9nuIUKFDhxXx6Q9usDZDH5WLCuA
         kXqVAKu+6zX12lo29DQ7moD0XwiczMyfO0htllprK0VMpPUXf69aHiTSjUyJNc5cWdkw
         6xhdKd4wHRl/gbAsY39Bz2y2b9LYTFJXSqmBB6b+IO/eNKopjONqaC6QsD2lrLgaY0Vw
         gaPe20suDYNYUlRkreuDBNgTnJtFJrxbMhNNFzhYvqY5ll51DIiQz5/25h+b4Qao7ham
         jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400732; x=1741005532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kmTM3n4yBBMdKxDX6gBx7ZoYT1kT7Ntk+s/Q8yOWMw=;
        b=MJRJpZPIeNY5EBJsLy71Aunr09jXoFYM1Ju8s+VMZLB0ZkB0FsMlue/Io0EVSsHBaN
         eacIv7quU8zUOmb0Wo0sbJvW38HWVWY9S5D/pHC5DSjK4rik5YDpVhRz/zuYhN9vdT7x
         7JgGPNcrrrWyv6sz71edGzoTdLneFsrJoLkhfmvqlwiqM9SnnZ4wTEPpde4VYTLxWzSA
         56dtMfqsr+QESUBrv3omxwgoy0LJolfPPnTW5SEJw4TcVdmswg4Vgh6SxD7kwveonzNB
         zB4HZ888RmmqdsCXOm660yxPgs819HexyAWG4u4Gvj0DdDltZZignyNnU5iepbJDnrr8
         +jSw==
X-Forwarded-Encrypted: i=1; AJvYcCWlNBZm0CtE4alh53s6Oa+VR9nF3ckJchMz0qXxvNYJqa0ZIIPtmc5XeG7dxiwJ6t9JB8Xm33ptyNE+7WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaZHV4vwUYGd95LCZbnmXKQeZxmAOIBNuTf9wUeuOiXpWl6Kp
	zkNtomjE8xKv1LJ1GF+lpM7Y7RBvngRMqU8IBs0yFtQ7+awqPjyl
X-Gm-Gg: ASbGncsAylEL+txE2Y3rjBWxXfHlZR83Vj6DWaLKH9XwOoa/YG/NIdiQFQfJvzODnlc
	2pz53xB3RQBHstPXlzXw4lnwYVjRmOOLIytvt26j4IeAHhaOhqczadNvbnRczDDjsFDrmdnnqO/
	W4fhOfh7cioT7WNmFCeR/R3u8mAjO80YWJ3PVmwedXmQA0g5MWp9Umtwo3SQCaQFpn9cUcHjLXY
	eszym9Zarij0cseEVnKlT4gkDGYHJ+Htjng7eqxkXW7AqktKDSDrxIIU7uNNMYfqaL5I4RDmAdK
	ajzgnggSbXk0cNgz+Pdds0b6KX0QEhJxeyAHKU4dN+7OIi8=
X-Google-Smtp-Source: AGHT+IGGhugltGFxjou3YcFhCjOAHq8GvR/ZZ0GJd0SlybKi/gPBxkYd8FyR81teGJvDQXjVckXrqQ==
X-Received: by 2002:a05:620a:170f:b0:7c0:a5f4:4df with SMTP id af79cd13be357-7c0cef12528mr1659614285a.34.1740400732051;
        Mon, 24 Feb 2025 04:38:52 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:3cb7:1064:72b6:f891])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad774f81sm831880285a.37.2025.02.24.04.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 04:38:50 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>
Subject:
 Re: [PATCH v4 2/2] tty: Change order of ttynull to be linked sooner if
 enabled as a console.
Date: Mon, 24 Feb 2025 07:38:46 -0500
Message-ID: <5764492.44csPzL39Z@nerdopolis2>
In-Reply-To: <2025022421-refract-defame-94db@gregkh>
References:
 <20250223204456.1913392-1-adamsimonelli@gmail.com>
 <20250223204456.1913392-3-adamsimonelli@gmail.com>
 <2025022421-refract-defame-94db@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 24, 2025 2:23:09 AM EST Greg Kroah-Hartman wrote:
> On Sun, Feb 23, 2025 at 03:44:56PM -0500, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > If CONFIG_NULL_TTY_CONSOLE is enabled, and CONFIG_VT is disabled, ttynull
> > will become the default primary console device, based on the link order.
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
> > false value may skip expected logging to /dev/console
> > 
> > 2. The hardware issues include the case if a user has a science instrument
> > or other device connected to the /dev/ttyS0 port, and they were to upgrade
> > to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> > sent to the device connected to /dev/ttyS0 unless they edit their kernel
> > command line manually.
> > 
> > The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
> > maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> > CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
> > is not dependant on hardware configuration by default, and avoid
> > unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > port.
> > 
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> > ---
> >  drivers/tty/Makefile | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> > index 07aca5184a55..1a1051ecb1af 100644
> > --- a/drivers/tty/Makefile
> > +++ b/drivers/tty/Makefile
> > @@ -11,6 +11,10 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
> >  obj-$(CONFIG_N_GSM)		+= n_gsm.o
> >  
> >  obj-y				+= vt/
> > +#If ttynull is configured to be a console by default, ensure that it is linked
> > +#earlier before a real one is selected.
> > +obj-$(CONFIG_NULL_TTY_CONSOLE)	+= ttynull.o
> > +
> >  obj-$(CONFIG_HVC_DRIVER)	+= hvc/
> >  obj-y				+= serial/
> >  obj-$(CONFIG_SERIAL_DEV_BUS)	+= serdev/
> > @@ -20,7 +24,13 @@ obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
> >  obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
> >  obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
> >  obj-$(CONFIG_NOZOMI)		+= nozomi.o
> > +
> > +#If ttynull is enabled, but not as a boot console, it is linked and used later
> > +#after the real ones.
> > +ifneq ($(CONFIG_NULL_TTY_CONSOLE),y)
> >  obj-$(CONFIG_NULL_TTY)	        += ttynull.o
> > +endif
> 
> Nit, a " " needs to be after the "#" character, right?
> 
> And ick, this is going to be tricky, changing the link order depending
> on the configuration option setting?  This feels wrong, and messy, and
> very fragile.
> 
Yeah, it did feel kind of odd I will admit, but I was worried if there are any
ramifications that I don't know about if I move it up early for all cases now
or if I should just put it back to how it was in v1...
> thanks,
> 
> greg k-h
> 




