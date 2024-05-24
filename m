Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4E33D0;
	Fri, 24 May 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536883; cv=none; b=PNyRRe8POCt1PJQAgng/m94K8mUzU0e6/vpOqexRUPFUgRt4R/+vd+O1nr44ouEoNHbkNTYsyI2l5tzkCLVZU59sDCuNQ2xYDnXlxL64+u1SJuKXoVLS/Nrrc9yS44qE1XJrS0UFV0o5AUK8U9j5Z0OdRO3hbAla3ZnMktDbOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536883; c=relaxed/simple;
	bh=xmLO/x9BvymHv0Wcd7nxb4frCFgzEWm4oGv7O7Uvo/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5Yf7POFbe5Ho4vp2WABfVVxDGzdwj7Igqcgq5lY2lgTprAX6x820Iixw92T+uySgVNJ1ztLyoQMOmJK4zI7WGpkQSlgJSKZGKk1XqDsBdSO2aNcL5zL+1KbsebjJkd5/dQoD5sgBsmfvUIip1Yu5RKAe2KX34VDGQPW+Qsnk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0826ceb0so6356697b3.1;
        Fri, 24 May 2024 00:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536880; x=1717141680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aENHTdUsW8qhM2dHax4VkVpC4dCLHvt2JVCa4jPrTiQ=;
        b=uO3H37cFzyZ4VHLKSqgkRuiXXMGqvsy480WpZwfezQTImN5v5Xf2atv3a02hP82/BM
         tmL+JTI5pDeN1MlUNiV3Oq4ix59+hYSmo95IazM2N6to9yXCPB8l6l76e81CqdhJ95p4
         PrZ1+F1zS28znRvqMv/59wHlHK091TIUS85FDroQ1E4grMrHo4z8zI3UHg3zcnSbUI8t
         /rkXkCrNI8BHmi8nybFCnmtGhrAfLQcOAp3tLoaOA9jnqyYa4bJGtAq6s7Oy4fsAcq3a
         1ayunhnfccjUV42QAW4kKCuW8ZQ10itWZ290q6CN9l7zwNLPEePOZQpYyst+Y+xAWli+
         sklQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsCoC98VZ0d0EHhCMHbqdLz8cyki6SqJzfu/gd3IEfwY8qrgGvfl3VLyPuxC+js4sf7Zz8vJSi7F6KwJL3vLFi2sW38mh4diIC9NjSXZ8UR3YdI2NnAzIgq0DtAidvGHBfbz0R1TmeTt9/
X-Gm-Message-State: AOJu0YwJVcDirUrAYIUz3SzmvYHXoWdxG8/VlVN6lf9tz2rLIGYeE94n
	wNO26D3i9frB3PQLRWMM7Fk3tnnAbiGjUdDBqpMWn7VrJKTkboc+GuAfeZNN
X-Google-Smtp-Source: AGHT+IFRCNHLSupKVi8l2G9kpa5B2pY09m+6yIKphByz9urrhoirFRjVZDcGkz+YWS5stBFf/Pzdgg==
X-Received: by 2002:a81:6d96:0:b0:61b:1718:7302 with SMTP id 00721157ae682-62a08dfd012mr13747547b3.31.1716536879429;
        Fri, 24 May 2024 00:47:59 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a4f34d3sm1676307b3.86.2024.05.24.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 00:47:57 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df771983aedso579007276.1;
        Fri, 24 May 2024 00:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU35eEXuH3fp/yKqjM/2ZFHpwA6uiW6spGNo0XLcQNwxXEAUXkaRJmpR5iKjWFbkvDx/Z7G8RPWoGb1BvLhPl+f7WK0xN/upxhRp6L4F/vHtgVsDbUK7OE2uymfhW9zpReAqs8EyyfnbFiF
X-Received: by 2002:a25:83c4:0:b0:de6:b58:fe72 with SMTP id
 3f1490d57ef6-df772259b37mr1448543276.58.1716536877102; Fri, 24 May 2024
 00:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
 <CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
 <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
 <CAMuHMdX2rrncANhCVf5bo+Md5bpMOeacYAu+Sgiy7noo55PYew@mail.gmail.com> <20240523195625.fa40049802a43a76dbc2a96d@hugovil.com>
In-Reply-To: <20240523195625.fa40049802a43a76dbc2a96d@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 May 2024 09:47:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_yMTyAa0t5=Qm6YNbtOFQTyZZvjYn8Y+6mO3L-GswWQ@mail.gmail.com>
Message-ID: <CAMuHMdV_yMTyAa0t5=Qm6YNbtOFQTyZZvjYn8Y+6mO3L-GswWQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, peterz@infradead.org, mingo@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hugo,

On Fri, May 24, 2024 at 1:56=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Thu, 23 May 2024 09:33:36 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Apr 23, 2024 at 3:11=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Tue, Apr 23, 2024 at 12:37=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Apr 23, 2024 at 1:01=E2=80=AFPM Geert Uytterhoeven <geert@l=
inux-m68k.org> wrote:
> > > > > On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugo=
vil.com> wrote:
> > >
> > > > > > -config SERIAL_SC16IS7XX
> > > > > > -       tristate "SC16IS7xx serial support"
> > > > > > +       tristate "NXP SC16IS7xx UART support"
> > > > >
> > > > > Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> > > > > so arch/mips/configs/cu1??0-neo_defconfig needs to updated.
> > > >
> > > >         select SERIAL_CORE
> > > > -       depends on (SPI_MASTER && !I2C) || I2C
> > > > +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> > > > +       select SERIAL_SC16IS7XX_I2C if I2C
> > > >
> > > > > So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16=
IS7XX_*
> > > > > subdriver can no longer be disabled?  According to
> > > > > https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f63=
5a@hugovil.com/
> > > > > you did want to support that?
> > > >
> > > > I believe it has been taken from one of the IIO drivers as an examp=
le.
> > >
> > > Looks like a bad example to follow:
> > >   1. The driver question now pops up if both I2C and SPI_MASTER
> > >      are disabled,
> > >   2. What if SERIAL_SC16IS7XX_CORE is builtin, but I2C and/or
> > >      SPI_MASTER are modular?
> > >
> > > I believe the only way to fix that is by letting the sub-drivers sele=
ct the
> > > core driver, like before.
> >
> > FTR, this issue is now upstream.

> I replied to you and Andy a few weeks ago about this (multiple emails wit=
h suggestions/explanations), and I even asked if you were satisfied with wh=
at I proposed, but never got anything from you, so I am still waiting on fe=
edback to send a patch to fix this:
>
> https://lore.kernel.org/all/20240430090333.5c5f029553cabcdf699310cb@hugov=
il.com/

Sorry, I indeed forgot to reply there.

Please use two visible symbols (for I2C and SPI), which select
the invisible SERIAL_SC16IS7XX_CORE.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
