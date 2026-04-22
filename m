Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6363B27F3
	for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848383; cv=none; b=siTs0SLapZfkhezOejbNmr/oXY7eLlzRpnZPGy8XQyutETjixX8o4TeLkNQDkICvJeHyE725TbMTP8W8CDInkzwLdcTCAyxgAAbqF6kaBBz/p4B11k0EmEeYCZd9jdMTEieGXFVQv9LDbV7V+sMtVVzz/nqpm8Jj1fdt3MH0OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848383; c=relaxed/simple;
	bh=cPJJcUlD/nNPMlKn2C5yR8KR/OVhhUUUAuL9RwYBgC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4kGtcJAt3wt8+Tarp77cqhxfnECX0F9rSzlH5k4oStrgkq3YrEBiveIIltgFRI3gEFXazb/4iBazvUOUXJWxjCC45MxJLwKLgojHYPBNL+2Yxnw/BZ/TNjTrSMoFvjjhjBeZvS+0s7cjkwyZl01nWx6i7zrMoBsralp57YN8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so6178596a12.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 01:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848380; x=1777453180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dFcuwDFov74A6VmNy3taBtzKh9fgX5fvgWZ5cbJ/uU=;
        b=mb5L7+OtbI4ldMgC2Mios3B6nhConhlU0yqEdCbnWV87yxn3TJqhOy0PEuUjBA2mei
         uLt/6nveOiHTBhaFBasQGE0il6uRq/EOxRPCrcL/HfyLIbybx3ZlujyaDDEjej18uzWC
         uSzJTnPSFFsMs+LPdgQ20y8Tq+z9pXazWCAc8kK93tihugTgoN7VArEyFCx3Z+lrxn+n
         09fyarmY1VATtUjOlumLZ5K7rr9jS6ICCFM7vCXtSIiOWMrF8fY9/tXLSwLr8fuNvSF+
         CvbzKJawMVV4hcUcgI99qgKyKAHVUqm/HfuKA6epIcBHcsK73GiiyBwRnjlrJvwG/jQp
         bf7w==
X-Forwarded-Encrypted: i=1; AFNElJ/nBcS+WHvt8wyeI2No5UEwygfkY6nCpvXGBMePiRc8qxP1WlC9oA6o7B5w6QXlodeD7GS3AtwLLWlCQCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59xoZkMhni1uhffQlglh5pJjJd/71I4p1FZRxP8j5bk7w92bQ
	QsZA/VJaAqZy4UFScFguyrzWa2RKVKJSV4pmTMz0GT5OGP6JUZ7y/SM8/YZFh8JSOUY=
X-Gm-Gg: AeBDies48WXQQJgBo0SEaONk36Log7nOKU9RqPNZPYLU4bvpyBSt5eHYpsChVZ2vOFH
	TxglCWRO347qfsD6Jzp+VxQJwPuZPmD69ujzO+3ZEe0tONGRdcLPt2hAnkA3BeYfEESDQ8RivA+
	QKcv81IZrfXZiSngHPiRooaLAxuN19PGI3XZnho95oVu4y9U/xdiqKEUkX/PaazWd2rkQDL831j
	LMXKWhNRO5PwKa4INDY/6QwJs2HqQoh4m8XOj3UYVCo7koWjrYqMwynvPj2XwoFtbP6lbuWROYr
	cdbJZ/cY4GqVNWEzTxtwr0gkzRI4basIWAhAgfJLw9TRkGL6wUfPJTtGrJBxHg/eMsL6O+ASD5I
	6obU6mvWscra+NYT9P5P1A96oWxZfLK0E2l3QXlIGuLP2psVIsLxiPQ4Nw8VD8gvOGZjlSKLCWH
	zkB1Tf1dDXcBahL+FW5jrFCP9gufGBgbzYBtyu0Hek87e/y6DUNPWt4I/tG3+JCYvi/se2DYA=
X-Received: by 2002:a17:906:fe04:b0:b97:c719:14d4 with SMTP id a640c23a62f3a-ba41adf9294mr1043298066b.29.1776848379902;
        Wed, 22 Apr 2026 01:59:39 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e1bsm523227266b.3.2026.04.22.01.59.38
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:59:39 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba67b332bbaso515999866b.0
        for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 01:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8N3PS5cSxBGzzYQ4/a+S08qKFXzISiw3AikTh3d0Su5R03d+iSqnn8jhrQKx9EVA5XLZO4aBAs9C0ukS0=@vger.kernel.org
X-Received: by 2002:a17:906:fe4c:b0:ba8:c717:7fdf with SMTP id
 a640c23a62f3a-ba8c7178133mr500668466b.30.1776848378649; Wed, 22 Apr 2026
 01:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
 <20260420140426.237865-3-biju.das.jz@bp.renesas.com> <CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
 <TY3PR01MB113464AE43A23A0B69BCC5675862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113464AE43A23A0B69BCC5675862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 10:59:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfGY6VwW09zQX8T3_JkRHwKGRUyNGRXvQaD4e58OV8qA@mail.gmail.com>
X-Gm-Features: AQROBzC_kTmn8EEDaA2iAwdpFOFCXdz6rO7qv7ivZoZvbZjpD2O1Ich5hX2xBW4
Message-ID: <CAMuHMdUfGY6VwW09zQX8T3_JkRHwKGRUyNGRXvQaD4e58OV8qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate from uart_get_baud_rate()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 22 Apr 2026 at 09:26, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Mon, 20 Apr 2026 at 16:04, Biju <biju.das.au@gmail.com> wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > On DT systems, a zero baud rate from uart_get_baud_rate() is not
> > > possible even earlycon derives its bit rate from chosen/stdout-path.
> > > The zero baud guard and its associated done label are therefore dead code. So remove it.
> > >
> > > Also drop the unused done label from rsci_set_termios().
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > > --- a/drivers/tty/serial/sh-sci.c
> > > +++ b/drivers/tty/serial/sh-sci.c
> > > @@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > >                 max_freq = max(max_freq, s->clk_rates[i]);
> > >
> > >         baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > > -       if (!baud)
> > > -               goto done;
> > >
> > >         /*
> > >          * There can be multiple sources for the sampling clock.  Find
> > > the one
> >
> > I am afraid you are missing that sh-sci is also used on SH, without DT?
>
> Ok, please share your thoughts to handle divide_by_zero fault for
> SH platforms on the code path after done label??

Someone has to check on an SH platform (or qemu rts7751r2d) if
this can happen. It might have been broken along the road, as people
only use earlyprintk when debugging a problem that requires it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
