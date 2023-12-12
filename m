Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KR6xLpGi"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7DFD
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 00:54:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1f8f470903so294913166b.1
        for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 00:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702371276; x=1702976076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A//H89nLIqMq0iuRQhq0YsqOdT5hbunDdga9/SvX8lk=;
        b=KR6xLpGiMBAHNx2YT+hWUDR5kzvZa66xnIA/YkYly0O+6Di6pCvPrWIjRPrd4s9H6E
         dho6rTDCf6RBE3co8arbv+Etu10tfKzWx0mluZlLx+yNO5HuboS+Ou8RcBeewUA8fCcb
         BPXRm2kT+jReuBNP8dfhjK+c5h3/k46lIog58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702371276; x=1702976076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A//H89nLIqMq0iuRQhq0YsqOdT5hbunDdga9/SvX8lk=;
        b=I7vTZ8ANkR9IvFgqNHDlrXycv5CJJEpFP/boChR4qx6JSXMtZCI8+ExrFBgfFP5ktk
         x6PQZbKYn9SFA5droS7AO7b3fgOGTUtNeWyilAyjEgniK4jJnY7Ohd3fONpUbYgA75AC
         8RG2LBgTP+ojMjBoUycB/SVjh0tCwdhvrbIRcBEGRg1DApRP5EczzztBoJrBlOZUFdfu
         4AXeDm4csqr0e7EfLSaw6OWWhNPNcEe6S4Ug029WrGvYwF6mB1VkzwtwWuK74UAs3yyJ
         4tJ3aiNZ0Wo9b9jNrkMLstueFx/L75Rt9SKh2BSyr1ck7aKj4I54GZHFCDXMpxN3gVXu
         KGTA==
X-Gm-Message-State: AOJu0YxBfh1+tK1XJ5iGNvkubfXeh4nNBU2C2DqMyxb3oufQZ5D3n94e
	Y3WzBOG5jF8cmVjmqy+DzwUYHmZFoOcrdMu2jhxS3A==
X-Google-Smtp-Source: AGHT+IFSJFHOOrQE3V04Fmu3oWSVJD1UkVU09R2ZY1uW85Gte5y23c9QiKs51LSszOA/s908I2zrbL+Lc7tT6S/fyMg=
X-Received: by 2002:a17:907:7d8c:b0:a1d:932f:9096 with SMTP id
 oz12-20020a1709077d8c00b00a1d932f9096mr3903932ejc.37.1702371276353; Tue, 12
 Dec 2023 00:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
 <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com> <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
In-Reply-To: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 12 Dec 2023 09:54:24 +0100
Message-ID: <CAOf5uw=6=zNmtVU7cOWv6xTaCghvX9j8pA9ijJxEqYpzikGdcg@mail.gmail.com>
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

On Mon, Dec 11, 2023 at 11:00=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > > 1. init_kgdboc() runs and registers the singleton kgdb "platform driv=
er".
> > >
> > > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > > checks to see if the console is ready by looking at the return value
> > > of configure_kgdboc(). If it's ready then we're good to go. If it's
> > > not ready then we defer.
> > >
> > > So I think the bug here is that somehow the console looks "ready"
> > > (because tty_find_polling_driver() can find it) but it isn't actually
> > > ready yet (because it crashes). That's what you need to fix.
> > >
> >
> > The polling driver look for uart and uart8250_core is registered and 4 =
fake uart
> > are there but there are not still replaced by platform driver that can
> > come later.
> > The try_polling find it but it's the isa-8250 driver. It means that
> > add_uart 8250 is
> > not still happen
>
> The 8250 driver is always a maze, so you might need to do a bunch of
> digging. ...but it sure sounds like the console shouldn't be
> registered until the correct ops are in place. That either means
> getting the ops put in place earlier or deferring when the console is
> registered...
>

Your point is pretty clear and my initial idea was to find a real fix.
This come to avoid
breaking existing setup but anyway I will dig in it more

Michael

> -Doug



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
