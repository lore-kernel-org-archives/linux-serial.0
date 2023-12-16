Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7E2E3F7
	for <linux-serial@vger.kernel.org>; Sat, 16 Dec 2023 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zqrsm8+H"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso183605966b.0
        for <linux-serial@vger.kernel.org>; Sat, 16 Dec 2023 05:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702734367; x=1703339167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8xT25O20RU+TsLhM6aVYkQaH5ZlroXWhbUjiAE2DMs=;
        b=Zqrsm8+H4W5J9fHiS696MyqgqwHs0+9bKK7RByDZbgF/XGEL0OuYe/4WbmzMGHLaaf
         8dW9hN1HuIIs6NzuP2T9KlGdB52MvNHUUEp6xgfp4pHwe60It/welbLRD03K18H80ISj
         2OX1ycesbAfaKQlYxQPwKQNXlgumRPQOqIyDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702734367; x=1703339167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8xT25O20RU+TsLhM6aVYkQaH5ZlroXWhbUjiAE2DMs=;
        b=IG5/aZHGYxieh8l/X1xGz0NYkwTI/rxH+Tuaxh0SNb/Ry6BRuCpkIjiuwIklnn6rak
         Lt/HxarTBU9uOT5FDXz7qEy8Ouaaxs6iS4KQ8TjtyWWBXRthI8a/zPtliTV5AfdI/G0m
         nHI6VdycM4pXfA/RFBhFDIOL6PbB0DDtUfwfdNrNnSyBQPSC9SAi5W4o57PuWOkcDbyd
         CejkCEOlHeicwBZfZPF8RLHxRXfhEBGFgWQdO9sxIIa8DAEi4CqnFeQAefuNzDi5ySbS
         FGY4JSoVEurnHPzqSnvmphe3O+y/fScAWglM1bh/dRKCbnBsxeI28YwVJ2HXubT26UE2
         5mag==
X-Gm-Message-State: AOJu0YxTH4KQLCgWOzE10gu/vtsAZtS44A9B3n5Ebh2nTmOkSJsWv0zl
	rSTRi5pTuG0AQsrS+kuAcbUvpupnrUmvkGx7PYuZoQ==
X-Google-Smtp-Source: AGHT+IEGVShzeDISEpnOUlXp42zimt0iY+0zTMh1tw4G8p95d4s+OpBxkDGkAsrjOVGesf/2pqiTkO/QZvE6MGAMtPg=
X-Received: by 2002:a17:906:142:b0:a22:faf0:3bbc with SMTP id
 2-20020a170906014200b00a22faf03bbcmr3599797ejh.139.1702734367105; Sat, 16 Dec
 2023 05:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
 <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
 <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com> <CAOf5uw=6=zNmtVU7cOWv6xTaCghvX9j8pA9ijJxEqYpzikGdcg@mail.gmail.com>
In-Reply-To: <CAOf5uw=6=zNmtVU7cOWv6xTaCghvX9j8pA9ijJxEqYpzikGdcg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 16 Dec 2023 14:45:55 +0100
Message-ID: <CAOf5uwmTg_T+vHsZwMtkPbxqQdQx4VucMni+f71KtGZY_XdgcA@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug

On Tue, Dec 12, 2023 at 9:54=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Doug
>
> On Mon, Dec 11, 2023 at 11:00=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> >
> > Hi,
> >
> > On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > > 1. init_kgdboc() runs and registers the singleton kgdb "platform dr=
iver".
> > > >
> > > > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > > > checks to see if the console is ready by looking at the return valu=
e
> > > > of configure_kgdboc(). If it's ready then we're good to go. If it's
> > > > not ready then we defer.
> > > >
> > > > So I think the bug here is that somehow the console looks "ready"
> > > > (because tty_find_polling_driver() can find it) but it isn't actual=
ly
> > > > ready yet (because it crashes). That's what you need to fix.
> > > >
> > >
> > > The polling driver look for uart and uart8250_core is registered and =
4 fake uart
> > > are there but there are not still replaced by platform driver that ca=
n
> > > come later.
> > > The try_polling find it but it's the isa-8250 driver. It means that
> > > add_uart 8250 is
> > > not still happen
> >
> > The 8250 driver is always a maze, so you might need to do a bunch of
> > digging. ...but it sure sounds like the console shouldn't be
> > registered until the correct ops are in place. That either means
> > getting the ops put in place earlier or deferring when the console is
> > registered...
> >
>
> Your point is pretty clear and my initial idea was to find a real fix.
> This come to avoid
> breaking existing setup but anyway I will dig in it more
>
> Michael

What about this?

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -385,6 +385,7 @@ struct tty_driver *tty_find_polling_driver(char
*name, int *line)
        int tty_line =3D 0;
        int len;
        char *str, *stp;
+       int index;

        for (str =3D name; *str; str++)
                if ((*str >=3D '0' && *str <=3D '9') || *str =3D=3D ',')
@@ -406,7 +407,7 @@ struct tty_driver *tty_find_polling_driver(char
*name, int *line)
                if (*stp =3D=3D '\0')
                        stp =3D NULL;

-               if (tty_line >=3D 0 && tty_line < p->num && p->ops &&
+               if (tty_line >=3D 0 && tty_line < p->num && p->ops &&
console_device(&index) =3D=3D p &&
                    p->ops->poll_init && !p->ops->poll_init(p, tty_line, st=
p)) {
                        res =3D tty_driver_kref_get(p);
                        *line =3D tty_line;

I will send proper patch

[   18.885348] printk: legacy console [ttyS2] disabled
[   18.890821] 2800000.serial: ttyS2 at MMIO 0x2800000 (irq =3D 283,
base_baud =3D 3000000) is a 8250
[   18.899727] printk: legacy console [ttyS2] enabled
[   18.909440] printk: legacy bootconsole [ns16550a0] disabled
[   18.923263] omap8250_probe: register uart 2800000.serial

Michael
>
> > -Doug
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
