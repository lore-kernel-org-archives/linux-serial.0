Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37D276024
	for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621931; cv=none; b=MFyb3TPxx0PwUUGISG8B/izMm4NGsZaacMXq++FdljT2w32wWyucSB1pVsEMuRHO84kpDCkX005NGaqTFKMBWZWQQK64pNHO/fNNwVN8OoJPWP7kgq61ICt+ST6dfbUSKZ2tD27HkeqvRquECj0I5xdpCds6a4aWLrOojYeKyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621931; c=relaxed/simple;
	bh=seZKVt+CB+k7Mas/mFiiVxa4+/v/4YNrXuxIJTyDwm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1oVqV52C+ReXsE+PPy4uHiGj4aQBrsVjhH7fuef2qEZYV0uBiKFB9zqSGoxrLuc1hKEbiiNnBJb68TbjthOM3Kcsvs+CNf1HzY+oCA2kLaD3HfLD2u+JY4pqKQmiOS3bJ0KW6FislsR8uTU819VrDZU6HzaIw7R45BI7w6vRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb098zEg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb098zEg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3019631f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758621928; x=1759226728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Xs+So4MvDnUaVFG+Q6oG/T6yZ5oFXdVTaeJcgoYjs=;
        b=eb098zEg9hMWFVDPenA2juV6hBsABv+UljqGJHn5D9dQNXpGJDor8E4pVnylwrz6At
         r0zCnvALrmTS7gPr7PgoZmtmz2mXawtExEkEGQGMpmdNSfwOdPI5pkLeC5qEoMid6vbg
         B4ljFdejXQVerRouWgydg6Mif9AjijfXpr1G802mfaaBzKq3iSTF0mQ6rNmenqC2R8lr
         bGFqS7NP/OW/4DXR8zMp4WEFDiQWqhIBCUtAZ8V834JrF4325nN4kKzLJIFf8AkCz/WO
         1lZR6clhj7w0Nu0/3DOUsk/TcWgv7ojk0jMbpeWab+cMe27Q42R2Pw9LfBWJodXnHSAb
         pv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621928; x=1759226728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7Xs+So4MvDnUaVFG+Q6oG/T6yZ5oFXdVTaeJcgoYjs=;
        b=DmtvMK2BOFjcHiM0geM6Q6ZudCNwfMKM3tSHRvWQspIdBy5AjAQCmi3B7AkuBjV2Mw
         vVOk0FLSqjRqPD+/3N/4hlx01ZPRHAPwRUdWl9yjZdThhz2nwps1DWWETfRPcCcB+AEP
         SWcC0cSmLMPv5co+03cNLox38+yAXC0TgD1kOgcghdJ2uXYan367ifQCKqjeJMDeGjUm
         duiuGj+wGrByqhDscdzikiJ33DgN/f8xIYiSTQQRybuvJA02cLaAnotYe5lV8jabCV2X
         dPyK35G8xccEBWpbQFOUUMTu+rN5k91Q1OI5yMDEYTmLtB+PL8c7y9FHwtiBUJNBlj26
         3Eyg==
X-Forwarded-Encrypted: i=1; AJvYcCXeAsSibC9dCvrArEElkNr4hmO03lMUXgdRxXBLq8eSutJ7i7gJmKYH1GHl5+qakM3dQyia1KjyELUp6OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKumHeuUAaW7EP+jnyUsdDqRl6GjOWUm5yPa73fGwTplmdOeze
	NbbuWsKhRX2EOi1AntGjKeu0TTCtwP+eVlRqotLcYhRaRXNsz9l/AJcrrT1BxwXgwO4TuL7ga6W
	NZ/k1gZ9CrLHXY5qobBiTc6h4iCv9Gkw=
X-Gm-Gg: ASbGncvHdOeulAR/hE2ZWLM27iWLO10NRgdVBjtHJw/1THaWM1i2/s0AgUi6oL9Pfg0
	Xo46bicETRKJiTHXjc8KB9Dr66p9vwHz3yemPJMa9pnbDvBvK5V293SRHyt2s3Hbby4M5r1vyhA
	qKcpe4xpF9xmNenAj7DdKGt8SGcEgm+893Qdr+6h610InxIzmtAVfyOKqa3R4Hr8TOCWxr9HaNt
	hggLxif
X-Google-Smtp-Source: AGHT+IEmfUOWv3qbc8Ohx4AaGaG7HewCyVbyN4002SXkqm3XHR6/YgMnu50wP/YGQJQxCgT0YYdAXH6LHlAhjgjNMsk=
X-Received: by 2002:a05:6000:1789:b0:3fe:34ec:2fab with SMTP id
 ffacd0b85a97d-405cb3e61a9mr1619335f8f.63.1758621928300; Tue, 23 Sep 2025
 03:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2025092311-espresso-collector-5f4d@gregkh> <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
In-Reply-To: <CAMuHMdU_UXyAaeriz8R0MO5SpWE_z4s8Ci6CEMFgVJr_XxDZzA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Sep 2025 11:05:01 +0100
X-Gm-Features: AS18NWCi66XhZ5MUL-jzRAWBA37LuUHnLVXt5X9xQycFYilsn6M_AddZZJIo5qk
Message-ID: <CA+V-a8uhrOZSXih7ays+0nTJ_gPOAs7sn5=cUkpvwZR3c7EQHA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Add missing header guard
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Sep 23, 2025 at 10:59=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Greg,
>
> On Tue, 23 Sept 2025 at 11:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Sep 23, 2025 at 10:28:46AM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add header guard to sh-sci.h to prevent multiple inclusions of the
> > > header file.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > >  drivers/tty/serial/sh-sci.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.=
h
> > > index 951681aba586..22f877e2a17e 100644
> > > --- a/drivers/tty/serial/sh-sci.h
> >
> > Why is this a .h file at all?  It's so small, why not just put it all i=
n
> > the .c file and then there's no need for it anymore.
>
> Until commit e76fe57447e88916 ("sh: Remove old early serial console code
> V2") in v2.6.33, it was also included by arch/sh/kernel/early_printk.c.
> Those days are long gone, so the time has come for assimilation...
>
You beat me. I was about to ask if you are OK moving this to `sh-sci.c`.

I'll drop this patch and merge the sh-sci.h header into sh-sci.c.

Cheers,
Prabhakar
