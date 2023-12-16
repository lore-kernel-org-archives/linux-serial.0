Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F882E3F8
	for <linux-serial@vger.kernel.org>; Sat, 16 Dec 2023 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cqrAmxKT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a22f2a28c16so206241966b.0
        for <linux-serial@vger.kernel.org>; Sat, 16 Dec 2023 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702743656; x=1703348456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CS7KA2gLSeCNiZW3GKISJfWPIn3uo8dgVC5eGHNM90=;
        b=cqrAmxKT8Ez0Jmbzn+Ah1rnLGzUaIMiTNsbsp9wyZU/lYZ3avuxIu65Pdff03zrlLl
         k7kh2kszUjv6fLutoPeqAxP+BE9ImX5h3MiOBLeDM7ZEeFdp83OnYNu7vpviUdjWxFuT
         Yjk2/IFyjG++aGad6f5AelDP41AYi8SwscRYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743656; x=1703348456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CS7KA2gLSeCNiZW3GKISJfWPIn3uo8dgVC5eGHNM90=;
        b=opOVOXF3/fjyphP/NY/GURDaKlp5rYIeQYZX6Pe5cqq7MFbEGZzy8oY4qAdBMeudXB
         jeimN12uz7A/f+x+4MJtk0pz0Hyw13lKyM9Lx+vBpAOlZyxh1ZEYAPLwA72KJAWuciXL
         kJwTdXEsBtqEwPXeA6r/ldApIEoVAeB4pGglLCneiWsC7JLuDB6KpNvvxC4KtMAmX+7a
         l5Mo+CuW68oORNqyj8vlQn+/GePHkQF1Za6UkJiPM9E6nFkV8TtiwQW/juAmbZlj0YAr
         ro0RuhBK5vlLJBRxbxRowYycZ3inJPWv1i5QiG88aZ4hCsyDT+MjrawXjrvQO4P4EMWu
         OD5w==
X-Gm-Message-State: AOJu0YyA/ockWrVEM3U80845zdktRK3aGyi3rUkFliyTzdAlJ/5r9h4J
	2GXlXZeXdNmCmK67n21u8bCtyjbajzD4ebiXz5Sxzw==
X-Google-Smtp-Source: AGHT+IEIO8Wqo3CheMl1kMfShPLFv9nb1Hcs8aH/BQwHSkOslvvi8KFpgHUPCCNDrrx5DZ7bwH/g7efkia/9pJsM3zY=
X-Received: by 2002:a17:906:590:b0:a23:3829:9e2 with SMTP id
 16-20020a170906059000b00a23382909e2mr56209ejn.141.1702743655722; Sat, 16 Dec
 2023 08:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
 <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
 <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
 <CAOf5uw=6=zNmtVU7cOWv6xTaCghvX9j8pA9ijJxEqYpzikGdcg@mail.gmail.com> <CAOf5uwmTg_T+vHsZwMtkPbxqQdQx4VucMni+f71KtGZY_XdgcA@mail.gmail.com>
In-Reply-To: <CAOf5uwmTg_T+vHsZwMtkPbxqQdQx4VucMni+f71KtGZY_XdgcA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 16 Dec 2023 17:20:44 +0100
Message-ID: <CAOf5uwmvHWCLhh3iAf69D+r_KRZKY6fP0NK5Xtz6tHoAAgYayw@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sat, Dec 16, 2023 at 2:45=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Doug
>
> On Tue, Dec 12, 2023 at 9:54=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Doug
> >
> > On Mon, Dec 11, 2023 at 11:00=E2=80=AFPM Doug Anderson <dianders@chromi=
um.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
> > > <michael@amarulasolutions.com> wrote:
> > > >
> > > > > 1. init_kgdboc() runs and registers the singleton kgdb "platform =
driver".
> > > > >
> > > > > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > > > > checks to see if the console is ready by looking at the return va=
lue
> > > > > of configure_kgdboc(). If it's ready then we're good to go. If it=
's
> > > > > not ready then we defer.
> > > > >
> > > > > So I think the bug here is that somehow the console looks "ready"
> > > > > (because tty_find_polling_driver() can find it) but it isn't actu=
ally
> > > > > ready yet (because it crashes). That's what you need to fix.
> > > > >
> > > >
> > > > The polling driver look for uart and uart8250_core is registered an=
d 4 fake uart
> > > > are there but there are not still replaced by platform driver that =
can
> > > > come later.
> > > > The try_polling find it but it's the isa-8250 driver. It means that
> > > > add_uart 8250 is
> > > > not still happen
> > >
> > > The 8250 driver is always a maze, so you might need to do a bunch of
> > > digging. ...but it sure sounds like the console shouldn't be
> > > registered until the correct ops are in place. That either means
> > > getting the ops put in place earlier or deferring when the console is
> > > registered...
> > >
> >
> > Your point is pretty clear and my initial idea was to find a real fix.
> > This come to avoid
> > breaking existing setup but anyway I will dig in it more
> >
> > Michael
>
> What about this?
>
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -385,6 +385,7 @@ struct tty_driver *tty_find_polling_driver(char
> *name, int *line)
>         int tty_line =3D 0;
>         int len;
>         char *str, *stp;
> +       int index;
>
>         for (str =3D name; *str; str++)
>                 if ((*str >=3D '0' && *str <=3D '9') || *str =3D=3D ',')
> @@ -406,7 +407,7 @@ struct tty_driver *tty_find_polling_driver(char
> *name, int *line)
>                 if (*stp =3D=3D '\0')
>                         stp =3D NULL;
>
> -               if (tty_line >=3D 0 && tty_line < p->num && p->ops &&
> +               if (tty_line >=3D 0 && tty_line < p->num && p->ops &&
> console_device(&index) =3D=3D p &&
>                     p->ops->poll_init && !p->ops->poll_init(p, tty_line, =
stp)) {
>                         res =3D tty_driver_kref_get(p);
>                         *line =3D tty_line;
>
> I will send proper patch
>
> [   18.885348] printk: legacy console [ttyS2] disabled
> [   18.890821] 2800000.serial: ttyS2 at MMIO 0x2800000 (irq =3D 283,
> base_baud =3D 3000000) is a 8250
> [   18.899727] printk: legacy console [ttyS2] enabled
> [   18.909440] printk: legacy bootconsole [ns16550a0] disabled
> [   18.923263] omap8250_probe: register uart 2800000.serial

I read better the documentation is this can not work, because the
requirement can be any uart and not the console one

Micahel
>
> Michael
> >
> > > -Doug
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
