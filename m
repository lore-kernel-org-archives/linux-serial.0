Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83834136E37;
	Wed,  5 Mar 2025 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140382; cv=none; b=tzi2avzPUZFyLgitg4gf5maIGyBo3MnjWvxB7sc6/PUo8jCSpBA2ua1Cm8ksrtmtN2h98i7FMF7Ivoa9zNgCqYIXJpMs2cOh/Te+rVTUD9dM5KRfQINw8ZCg0SuD8jjO1/q17jpyQKLRD2gz8M/S4pgUiL/KdEfirOEPk42ICeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140382; c=relaxed/simple;
	bh=rXZ2Zr8lM8TrA/9SvxJsslt+rZS4wfnpBpkYvhXBP7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPoDChVnw69oeTHq3uFzbZxletS9enF8z/t+vy6IKzG/6L9yRAi3P/QwDlhQbvJryxCqyfXuSYjprt1e7PzMEcnM/kkQ3S33CVeWyJKxV5pBOSctmBx6yCwOf5knefPUIegTtRUD0bLSxBFDARWYs8HJkKkzYkSqCZDEDrC9vrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6GYxL8C; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6GYxL8C"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e88983cedaso47887126d6.1;
        Tue, 04 Mar 2025 18:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741140379; x=1741745179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1etl3V0lZaRtG6YH6PccrFQl/uVmRYaudXPpsrJaLBY=;
        b=f6GYxL8CvqTnt6iJgufZnnLCxP6F4RRJ1Tdr/ccw3Rs2WnWpY+JPVnTtrFQEijYoCT
         3hOABoUzG4zCSgvQUKs1tsccmYZBIq6oRpSJJhNxhKIfjy0pTJ49y64VAhe822IW5H3r
         /IKQsgddTlj1S6Tc2USq0rO3beljTSYNno2a3hGEqkS01lsZ/QH+A3n7932QNdcX3jWa
         Vl9nYFRQbw9WBY6meEiN0xiMf62DCRXZtjNzQF/4LeRkn3z7egh79nwkyHQMqTrwin6Q
         xyF77v7ZFGV8fAy9A8O0u0IqgGmJVkjkVKPdfKyPEF78G0WYHts6rjMY8yAyp1fdJVAF
         ea6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140379; x=1741745179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1etl3V0lZaRtG6YH6PccrFQl/uVmRYaudXPpsrJaLBY=;
        b=ZjLbWV26PeSXWOlfEkHsPM9s9F93AU1PEzp1j0/FL4HMaA7T+egim1irUGHyYxuA8E
         RRf4Hzn+kaQ1r6VPFBhKYnZRmu/dQdNpPmhLIS9gI/0CBAGunGAMC0ghVNUlPh5PCXFK
         XQotiIBqQ6G/1YQhrIn4s98bQutnZq1C2wton2cmpMSCM2J/Q3/Q8SmrDugI8YIwLf9N
         /xFQwhaaUocoQXGfbM6rRJ2ftA3oWQ7DNcDpytDZ4GxIid+k5gL0+EcIBb+UpYcwjqEx
         j9lme6Y05i5Wp6ozENt+YX3ZRd/chceZWKM1NgRC2wA+NoOYWlT/4ByH5KgJYXm6sxKd
         x45w==
X-Forwarded-Encrypted: i=1; AJvYcCVm+4JYUuJmCA42ityZf8uskv6B8TQatB2qqaT9u3d3ISeYqK9JDtMIibGtlBMN3gqf6tZJC3NPPjomz94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBdIBUxqVydi9kYUGsBLPnk9G/Q3nCLaOpmR9fNEU0nSUE+TH
	Hos5WBg2yff3d9ELYEoLB3M4DT/cd05x8atDlF4LlJHnP4z5h1Rg
X-Gm-Gg: ASbGnctfbQ4IvwT+lIdDnKejZFI2GVSQQFZa+HJgOQaZkPZOOCfSjiegjpnGhSfyztX
	cU4KPoYh0KH1ytGTJac1xybrZKgGwoeOjolkfpz+wMq0mDSdOiy/+PjT3969xilssdABEVg9CDH
	ZaJ9/GcInYbDZsQbkhQxyCJUGnyIaDy2of3bU9MBfaK38Efb6SQNggDIjbQ3XFiDfeaxXut70iA
	4xopfLFA1g6FSOtzHXxaM+2O+AJNltiFnyFnEC8wUOXCe3VU0IjXqhq4CKoKlTtoYzKJHF84KMu
	54h1BvUG6H/yJb7kHdT+KCWo61ChUTTkwz3lghzDZRFbhDEph4U9fCPcvTQZ8cwtVQ==
X-Google-Smtp-Source: AGHT+IFeYhG66XP9kra/BVuJZMG8yqIj6oqdU+8B+nTKQRJtFvYXuuS00o+ECFpnOZZMu6oA70v5aw==
X-Received: by 2002:a0c:e00e:0:b0:6e8:ebc6:fd5f with SMTP id 6a1803df08f44-6e8ebc70244mr290466d6.20.1741140379230;
        Tue, 04 Mar 2025 18:06:19 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8baa851c3sm44981786d6.108.2025.03.04.18.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:06:18 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject:
 Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner if
 enabled as a console.
Date: Tue, 04 Mar 2025 21:06:17 -0500
Message-ID: <7969025.Sb9uPGUboI@nerdopolis2>
In-Reply-To:
 <CAHp75VftQASqajiG_z-==CmVMu5Orv_Q8QMj-7W=sxsJPq6bJw@mail.gmail.com>
References:
 <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <20250304035447.3138221-4-adamsimonelli@gmail.com>
 <CAHp75VftQASqajiG_z-==CmVMu5Orv_Q8QMj-7W=sxsJPq6bJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
> >
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> >
> > If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disable=
d,
> > ttynull will become the default primary console device, based on the li=
nk
> > order.
> >
> > Many distributions ship with CONFIG_VT enabled. On tested desktop hardw=
are
> > if CONFIG_VT is disabled, the default console device falls back to
> > /dev/ttyS0 instead of /dev/tty.
> >
> > This could cause issues in user space, and hardware problems:
> >
> > 1. The user space issues include the case where  /dev/ttyS0 is
> > disconnected, and the TCGETS ioctl, which some user space libraries use
> > as a probe to determine if a file is a tty, is called on /dev/console a=
nd
> > fails. Programs that call isatty() on /dev/console and get an incorrect
> > false value may skip expected logging to /dev/console
>=20
> Missing period at the end.
>=20
> > 2. The hardware issues include the case if a user has a science instrum=
ent
> > or other device connected to the /dev/ttyS0 port, and they were to upgr=
ade
> > to a kernel that is disabling the CONFIG_VT option, kernel logs will th=
en be
> > sent to the device connected to /dev/ttyS0 unless they edit their kernel
> > command line manually.
> >
> > The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
> > maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> > CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
> > is not dependant on hardware configuration by default, and avoid
> > unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > port.
>=20
> ...
>=20
> >  obj-y                          +=3D vt/
>=20
> + blank line.
>=20
> > +# If ttynull is configured to be a console by default, ensure that it =
is linked
> > +# earlier before a real one is selected.
> > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > +                               +=3D ttynull.o
>=20
> Here is the question: are you sure that all console drivers that exist
> in the kernel happen to be here? Have you grepped the source tree for
> checking this?
>=20
Grepping for console_initcall, the only other places I see outside of
drivers/tty/ is=20

arch/mips/fw/arc/arc_con.c
arch/mips/sibyte/common/cfe_console.c
arch/powerpc/kernel/legacy_serial.c
arch/powerpc/kernel/udbg.c
arch/powerpc/platforms/powermac/setup.c
arch/um/drivers/stderr_console.c
arch/xtensa/platforms/iss/console.c
drivers/s390/char/con3215.c
drivers/s390/char/con3270.c
drivers/s390/char/sclp_con.c
drivers/s390/char/sclp_vt220.c

> ...
>=20
> > +# If ttynull is enabled, but not as a boot console, it is linked and u=
sed later
> > +# after the real ones.
> > +ifneq ($(CONFIG_NULL_TTY_DEFAULT_CONSOLE),y)
>=20
> Also can be written as
> ifeq ($(...),)
> but it might be less explicit. Up to you.
>=20
> >  obj-$(CONFIG_NULL_TTY)         +=3D ttynull.o
> > +endif
>=20
>=20




