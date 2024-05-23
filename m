Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E13B29D;
	Thu, 23 May 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449634; cv=none; b=JC5NogzkPA7Y8XVUne1aJWo38Eu0CYdSz+oSUZkA2nW5lsPHP5Txiiiwa4BJKnfGUX5hhWyubShLdKb5pqIR8c8ez0i2iMGWoz3APmZytJXYQ3GlqO2xOydhbocmzxKn5mYXWSv/W14cd62egweyxuXuXb333aSmNOg9h1PPLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449634; c=relaxed/simple;
	bh=vq/FLuv6VbT6g2NgYDQa9Rizy3VZXftahQHFAk9MtV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryVnZVb6rgszwuqNU0YnJtOBnpdveDRJYIQW+qgGKe8JfpohUuiUh+ePFU3yLhxhcu7KOb7NfkOz+wfdu6OJhlm0edGcqexbae8bKOg9FStTmoFYQPgGtJwrPQ0JPnh68x4LDtrHBwHjJmlU+wAsV8uwHUzmL/UpKY6sIra4ITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627dde150d0so18146707b3.3;
        Thu, 23 May 2024 00:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449630; x=1717054430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9ll3Q17E9S4QIKzi6nGnMviZ6Gac1YwMmcDufGIpEg=;
        b=jSnr9jNwqMwX1OxyZmffd/sL8RD6WywWq7b99EZRMImMGt1IiGts8bOG9VmNTy0I0T
         3fDb9fgTeUiZlLrZT7DUhMbOqZw73JRZs5iQKLLSD00arL16kvOKzKdt/V5jlcWKBJew
         fRPfCW/Ue49c3wCQ89FFx6I/o23MXvtMP46DmPyz5MG1JejTXyK9CW+kozZAOp24Xwr2
         0rzee4XdbWVGjPl8QwNIkfPpIlO2LNdWjOW/CiLzCBgt8bHMvbBYdR5HaPYCgE3MciAp
         aSooMmVHe5eWkiGazlOiQWqzgXEcsVpxKPDNKcRb9gI1Mk2zQ8/XHnk1BYl7T/hvYaEM
         TFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHJOXI3fTaZTpl2gHtHYVjG70UbRbPzITRniiJaGi6Mgai0R9XLJBosccShvD4O0z8kBQhO3O7ycA3CwmPPXjrKEmQc0a+kRNTRzrcLMKQuukScNW+4swMcXZdMmFSlwiZio0mxDX2Qt5
X-Gm-Message-State: AOJu0YxOv0JJT/lcdEd4DwKFZRZSJRqfDdNKGR1U6S66aQvHv+RdX8tj
	E7Tff0zi7xuGTqKEbBOS+4G9NkhzFi7AIVlNNQzJEV+HeADT5x5IuQDxME2A
X-Google-Smtp-Source: AGHT+IHQUH7ltbF4VOcZlPUGa/FDHLFqfEEjELB33iz06dR3b6gGlONl4x6mV5pT36A4waPQRCMWvg==
X-Received: by 2002:a05:690c:fca:b0:61b:3484:316b with SMTP id 00721157ae682-627e46ca8a9mr56024117b3.14.1716449630514;
        Thu, 23 May 2024 00:33:50 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e24680csm60791807b3.6.2024.05.23.00.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 00:33:49 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-df4e0d8fa10so1714806276.1;
        Thu, 23 May 2024 00:33:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRrwQxyj4AzFt8lffLP+CDnSgyxg03BdyrIBDdDAYbSfSzcZtiR8cIrgAbHFyawCGvaxfwIJE5fBOOoj+Ti+eYbF8ckAgHfdLSj/9ANvhjRpltFfTUPT59TuatPfUq/2iiTdF4jZTPPxlv
X-Received: by 2002:a5b:c52:0:b0:deb:cd02:3688 with SMTP id
 3f1490d57ef6-df4e0db8368mr4502046276.48.1716449629677; Thu, 23 May 2024
 00:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
 <CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com> <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
In-Reply-To: <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 May 2024 09:33:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2rrncANhCVf5bo+Md5bpMOeacYAu+Sgiy7noo55PYew@mail.gmail.com>
Message-ID: <CAMuHMdX2rrncANhCVf5bo+Md5bpMOeacYAu+Sgiy7noo55PYew@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:11=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Apr 23, 2024 at 12:37=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Apr 23, 2024 at 1:01=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.=
com> wrote:
>
> > > > -config SERIAL_SC16IS7XX
> > > > -       tristate "SC16IS7xx serial support"
> > > > +       tristate "NXP SC16IS7xx UART support"
> > >
> > > Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> > > so arch/mips/configs/cu1??0-neo_defconfig needs to updated.
> >
> >         select SERIAL_CORE
> > -       depends on (SPI_MASTER && !I2C) || I2C
> > +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> > +       select SERIAL_SC16IS7XX_I2C if I2C
> >
> > > So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7X=
X_*
> > > subdriver can no longer be disabled?  According to
> > > https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@h=
ugovil.com/
> > > you did want to support that?
> >
> > I believe it has been taken from one of the IIO drivers as an example.
>
> Looks like a bad example to follow:
>   1. The driver question now pops up if both I2C and SPI_MASTER
>      are disabled,
>   2. What if SERIAL_SC16IS7XX_CORE is builtin, but I2C and/or
>      SPI_MASTER are modular?
>
> I believe the only way to fix that is by letting the sub-drivers select t=
he
> core driver, like before.

FTR, this issue is now upstream.

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
