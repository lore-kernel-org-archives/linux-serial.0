Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8B1AAA1B;
	Wed,  5 Mar 2025 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148113; cv=none; b=pcHlapM8V9Ng8x1gtZdOi4lMgWtNLyARieCcoKRbUYHiqom1Fr6plsUW4yRpe9t8MH6UUdMWWMKfthypZh9HKqDyww0RXqA8X8M4APteAmSoo9MXT1GtMa19coe0vtAEbcHVXtNoL4lMZhGnDj3MO1mzXM/CnykX8g/1F5eGBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148113; c=relaxed/simple;
	bh=5qlS68p+eVcO0ZnFu3fubELqy8AAf9h4shXD1wXvqvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKv5k793U5tFBh3Isf5PmU8AoZKc8sHb8T7KZo/ygARxmDrmDuo0M7K/ZE0nppAOZ0QcCUMtspn975Q3U8jv37F7Ueq7wEQ5221DLeGOOh/BeAvCbudcYKvK2uFOWrG5R7McsiZ1DO8r5G8BFdzqq4UR3OydzZvzdVxVhYhTjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGpIFlHy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGpIFlHy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3b63dfebfso314062085a.3;
        Tue, 04 Mar 2025 20:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741148110; x=1741752910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtIwc0S596LxrxpBlAZNZRsnhpl8xSZUfbjlJSGuJ78=;
        b=jGpIFlHyCJQ/ePvwl0gZ+nw+fcGK7OWBK3ico8HucL3BkHlFWWyAOVsoLY3ElvHpNk
         d7WHhuNWET4bn+JFNmWa1nOAocy5hW9TB21tYJJWjgEtX9ZgCvEkfsSdGPY9qxrixCDD
         rloXZyPXFnxAwjUfY/qcMFjnAD2mlaE7wu3nTxtRscTqcHIiHeZpSHi9U72JQlpJE+8V
         YmnHIHnlVUeom869ytL/O+D8bfEf17+C787k/AY6H//AmMaR15bbHT8iXYnCG71Y0S1Z
         YZJXbpTDn3ifKoGy8tqP30FOPeQ4MxwXTW+tx9gFy8D+5u+6GBOlryAn/ybsp1RLswm5
         KuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741148110; x=1741752910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtIwc0S596LxrxpBlAZNZRsnhpl8xSZUfbjlJSGuJ78=;
        b=aQEBRORsJJhk9Mp9p2SlqjTJi0nj43xPy0G0Ov9d14C2/QMzwa3nawbbBEGmoYM4SS
         8JDYRi32Y2TO2EoXrnGnC0K+etL2wLCAwc6pdtijC5QVKhuCyyvjRG+dc7yGYEdaEckU
         OgcJip//uFkI/9aI4/D/h7MjgUtqcqiAP8foIkeCOj6Zh3PzHlN46JHY3xv8rQ3WdVGU
         B5q2V8M+Iy9Q3n2o1rOMxcIkhg5UUiTLKrBUadbcyu5fjIgDr9tqyXTeRGG9AwVg/fvF
         gbloyUjzsIDBCwLBJ0VBM1KIi/M4u0h3SLUlToBhT/jTe07FFHbXAgjA505dMM7NB9kG
         3fwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf/EimxGReJCXcf2NfC2g1c2d5MqA7P62rFWrDpw0Mio3SX8Mt2z37I5f+iXg/TOSnaGoTlMiwR6ZeS30=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8E1+U3K9sBR2nYT+w0oRL+AkvmnoI87eutwam2Y437Uv6c7Q
	sZTZnWG2wMYb6EhBIy1sFU2dsQmZ+zR8G5lm6INFuVcF6mzggDpP
X-Gm-Gg: ASbGnctX3VQUN3M/9c8HE9XIGWHPSArApeVK4/5qPPRCFhElq5JiEYsPxVRTnrYZzcv
	ovh2WK+o1JGd511+76khgtoQHOjSOgDHV7/YjNV2JWXcNmnCtwxPkfwz7gEf4UvEg3QKEGeLjpM
	YNJ1cYI2XLchxnU2sQc4iuZILNCNU3sOx0mPzQOvlmh/nDwX8YpGkL/zlzChA+Z+mvgqVd5oOU7
	2YxfYaMcwKmTDI+oBZp12O2sJ7tWd/JVoirCj+z6suy3LQOVs1TbWQ097IEtkVNK8vTVW5icmgL
	3wE3zYVrb//0zDfpwvGD2oSz+J2HvBf041tVLW0Ga417GiFK/Ur+Qm+ZXjvcyLOC0g==
X-Google-Smtp-Source: AGHT+IGwoyI1zd6iMavV7DAu5r2HkD4sNpKolWIfTMdjBX1p9J8Tp0jGWgvyvkf8sO9ftOT91HEBlw==
X-Received: by 2002:a05:620a:6509:b0:7c0:7833:cbb7 with SMTP id af79cd13be357-7c3d8ef2d7fmr264229885a.47.1741148110393;
        Tue, 04 Mar 2025 20:15:10 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:a5b9:4b66:4113:9357])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bc75fb32sm362136085a.52.2025.03.04.20.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:15:09 -0800 (PST)
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
Date: Tue, 04 Mar 2025 23:15:07 -0500
Message-ID: <4600427.OBFZWjSADL@nerdopolis2>
In-Reply-To: <7969025.Sb9uPGUboI@nerdopolis2>
References:
 <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <CAHp75VftQASqajiG_z-==CmVMu5Orv_Q8QMj-7W=sxsJPq6bJw@mail.gmail.com>
 <7969025.Sb9uPGUboI@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, March 4, 2025 9:06:17 PM EST Adam Simonelli wrote:
> On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> > On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
> > >
> > > From: Adam Simonelli <adamsimonelli@gmail.com>
> > >
> > > If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disab=
led,
> > > ttynull will become the default primary console device, based on the =
link
> > > order.
> > >
> > > Many distributions ship with CONFIG_VT enabled. On tested desktop har=
dware
> > > if CONFIG_VT is disabled, the default console device falls back to
> > > /dev/ttyS0 instead of /dev/tty.
> > >
> > > This could cause issues in user space, and hardware problems:
> > >
> > > 1. The user space issues include the case where  /dev/ttyS0 is
> > > disconnected, and the TCGETS ioctl, which some user space libraries u=
se
> > > as a probe to determine if a file is a tty, is called on /dev/console=
 and
> > > fails. Programs that call isatty() on /dev/console and get an incorre=
ct
> > > false value may skip expected logging to /dev/console
> >=20
> > Missing period at the end.
> >=20
> > > 2. The hardware issues include the case if a user has a science instr=
ument
> > > or other device connected to the /dev/ttyS0 port, and they were to up=
grade
> > > to a kernel that is disabling the CONFIG_VT option, kernel logs will =
then be
> > > sent to the device connected to /dev/ttyS0 unless they edit their ker=
nel
> > > command line manually.
> > >
> > > The new CONFIG_NULL_TTY_CONSOLE option will give users and distributi=
on
> > > maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> > > CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavi=
or
> > > is not dependant on hardware configuration by default, and avoid
> > > unexpected new behavior on devices connected to the /dev/ttyS0 serial
> > > port.
> >=20
> > ...
> >=20
> > >  obj-y                          +=3D vt/
> >=20
> > + blank line.
> >=20
> > > +# If ttynull is configured to be a console by default, ensure that i=
t is linked
> > > +# earlier before a real one is selected.
> > > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > > +                               +=3D ttynull.o
> >=20
> > Here is the question: are you sure that all console drivers that exist
> > in the kernel happen to be here? Have you grepped the source tree for
> > checking this?
> >=20
> Grepping for console_initcall, the only other places I see outside of
> drivers/tty/ is=20
>=20
and if I, as a wacky test try=20

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 05c5aa951da7..bcd248c44fc8 100644
=2D-- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1159,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
=20
        e820__setup_pci_gap();
=20
+       add_preferred_console("ttyS", 0, NULL);
+
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
        if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) !=3D EFI_CONVE=
NTIONAL_MEMORY))


just as a test, and do
cat /proc/consoles=20
I see
ttynull0             --- (EC    )  242:0
ttyS0                -W- (E  p a)    4:64
where ttynull0 is at the top of the list

> arch/mips/fw/arc/arc_con.c
> arch/mips/sibyte/common/cfe_console.c
> arch/powerpc/kernel/legacy_serial.c
> arch/powerpc/kernel/udbg.c
> arch/powerpc/platforms/powermac/setup.c
> arch/um/drivers/stderr_console.c
> arch/xtensa/platforms/iss/console.c
> drivers/s390/char/con3215.c
> drivers/s390/char/con3270.c
> drivers/s390/char/sclp_con.c
> drivers/s390/char/sclp_vt220.c
>=20
> > ...
> >=20
> > > +# If ttynull is enabled, but not as a boot console, it is linked and=
 used later
> > > +# after the real ones.
> > > +ifneq ($(CONFIG_NULL_TTY_DEFAULT_CONSOLE),y)
> >=20
> > Also can be written as
> > ifeq ($(...),)
> > but it might be less explicit. Up to you.
> >=20
> > >  obj-$(CONFIG_NULL_TTY)         +=3D ttynull.o
> > > +endif
> >=20
> >=20
>=20
>=20




