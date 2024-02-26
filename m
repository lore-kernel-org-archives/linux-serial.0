Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A81BDC3
	for <linux-serial@vger.kernel.org>; Mon, 26 Feb 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928568; cv=none; b=t2Zfl2HWHGHYp1mAzKKlHUsl2lkwppCVF0qPd/tL9r+IaAlxelja3RoovGaJieXd5xIiOr7FgAVkKv7yn7sj/REm8DM/keuapl3WB1TPq8eJ1TmBAfPxP6WikiOViWGLgRJ00ZZR6ZVLPFy9dtivhrahICLR2nZ3TTrA3GAztH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928568; c=relaxed/simple;
	bh=ZZKGU3FffPP3zqC+TnubmjhgC9QH4ptQlNNeiWeNUi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRnKiCcEwcc2uUwsmMQj52moeTDt6eRH7cl8beHLORVy6uJuKMkBhV/98qUH9R1y/2/+MkjDzs5BK7h40oPdjlQU42GzqyHL2KLscna0KLusdMSMT6OhmTnEsSsWb5bfeKrDxpAPX2yqb/b/6VrGCOnQ8tsY3k3KLnb5j1a0Gl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=C3KQ+lwE; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C3KQ+lwE"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso2699733276.3
        for <linux-serial@vger.kernel.org>; Sun, 25 Feb 2024 22:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708928566; x=1709533366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6uQ6p4wrPGEQaea08zy1g4beS3iVKslS9jUud4LuLo=;
        b=C3KQ+lwEaN/eK4elEjfXVIsTWOshR9M0SssWfU8FWyA+DT0HeE74zXdTrI+fImuj4Y
         RoGf4hzn4XS/QBrbIIwmIJyqaaEiKv2b0vJh8soMuX5ZKCrgpe3XRhPThhL+BMbY7sIP
         abHcUK45wAxZ0U5Ih1UZnfmPnrhs72yacrz9h8RKLrPCDhEl1hNlQE5xZr1+bAtInnzH
         sIEIgw90sTFupE7CFgpj6yXHvozqSgUk7TTzRMTVPZOke5krTah2o+9zPHOZluxnXn9A
         fK/QDlI3cWj0mOTcLxwfidmh8f2F+c/xuI7mJckLoWdKAaSAIYgSJsTI8+zkOcU/zAAF
         Ydwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708928566; x=1709533366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6uQ6p4wrPGEQaea08zy1g4beS3iVKslS9jUud4LuLo=;
        b=Ko89G/phUmbJ5Cgw650pMMt/OTRKAv1eqyixb5hdb0Mn5sKU4+ycC0mxv8l8zX0s2h
         CURpBNDK/+8McuCiauPRTQxlrqB1iJNapsQX41nQfS8JH/zt0u5HpAJqesOlgEWis/PT
         U8+RHH+pkhVcHYA1hCNZZOV76Rcq/p9lbXkOKcbM+qSVY9qwMn8y2/kkJQuQ3Jl+yNSA
         Xr95tsInTh+inTNFziVkHn2KYHN5q3paWOJTDVoGH4OBJs8RU5evbFX7jal4hDT3I0vg
         YGDmKWP6KrXDtSLVFYteSu/BYihjCYyYyo6qV95ICcjYMTRwmxt7QlxeaJb5dhafQD14
         ciVQ==
X-Gm-Message-State: AOJu0YzVeboHDGAoTKKHoXj4mFYuW72eMl7xDM9du1TONjgeKaVbFAJ4
	zWIUXK28tn9yb3jYGBW1d6JDaTjQtRswfW2Zih9FHpyZXJG7HRCfLs/sjD3FRr8UMN3wafQzfbu
	1kploDENtBNEW/DYWxgqgSTUzl5U3EAFVPurzOA==
X-Google-Smtp-Source: AGHT+IGuVwNNtNKAUOe7ESvnHt1NkLshjz76YKDlhI9ojfgZqrAObfd1QuyHoNHa5ra3UdBQeDo2NcaGJ6UUutD5RdM=
X-Received: by 2002:a25:3618:0:b0:dc2:45af:aa5b with SMTP id
 d24-20020a253618000000b00dc245afaa5bmr3427311yba.59.1708928565840; Sun, 25
 Feb 2024 22:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201065932.19899-1-andy.chiu@sifive.com> <2f1b1262-8c32-4dd5-8052-d47682c0b1f6@kernel.org>
In-Reply-To: <2f1b1262-8c32-4dd5-8052-d47682c0b1f6@kernel.org>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 26 Feb 2024 14:22:34 +0800
Message-ID: <CABgGipUzTp70j+8UxgURhNU81S_UWNd8dd75pvytzC0GkMCRfA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: manage irq with spin_lock_irqsave in SiFive console
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:21=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> On 01. 02. 24, 7:59, Andy Chiu wrote:
> > It is not safe to call spin_lock() with irq disabled on RT-linux.
> > Instead, transfer the code segment to spin_lock_irqsave to make it work
> > on both RT and non-RT linux.
>
> Hi,
>
> have you investigated what is protected by the local_irq_save() in
> there? The lock is not always taken, OTOH the interrupts are always
> disabled.

I was referencing some serial drivers (omap, pl011) changes on the
linux-rt patch series and provide logically the same change here. For
all oops cases I've found, panic() itself disables irq before calling
`bust_spinlocks(1)`. Architecture dependent `die()` on riscv also
masks off irq with a spin_lock_irq() before calling bust_spinlocks(1).
Should we make SERIAL_SIFIVE depend on RISCV in Kconfig for this?

However, I am not very certain about the sysrq part here. According to
the patch on linux-rt, it says irqs are already disabled if the
console_write comes from sysrq handling. One difference I noticed is
that the sifive console does not support magic sysrq, while the others
do support. And it seems like the condition check `ssp->port.sysrq` in
sifive serial is never true, but maybe I just overlooked something.

+ Thomas
Hi Thomas, do you think the sifive console driver needs the change
here for RT? Do you have any suggestions otherwise?

>
> I believe the fix is not as easy as is presented below.
>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > ---
> >   drivers/tty/serial/sifive.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> > index fa4c9336924f..3f0ddf8bfa7b 100644
> > --- a/drivers/tty/serial/sifive.c
> > +++ b/drivers/tty/serial/sifive.c
> > @@ -788,13 +788,12 @@ static void sifive_serial_console_write(struct co=
nsole *co, const char *s,
> >       if (!ssp)
> >               return;
> >
> > -     local_irq_save(flags);
> >       if (ssp->port.sysrq)
> >               locked =3D 0;
> >       else if (oops_in_progress)
> > -             locked =3D spin_trylock(&ssp->port.lock);
> > +             locked =3D spin_trylock_irqsave(&ssp->port.lock, flags);
> >       else
> > -             spin_lock(&ssp->port.lock);
> > +             spin_lock_irqsave(&ssp->port.lock, flags);
> >
> >       ier =3D __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
> >       __ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
> > @@ -804,8 +803,7 @@ static void sifive_serial_console_write(struct cons=
ole *co, const char *s,
> >       __ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
> >
> >       if (locked)
> > -             spin_unlock(&ssp->port.lock);
> > -     local_irq_restore(flags);
> > +             spin_unlock_irqrestore(&ssp->port.lock, flags);
> >   }
> >
> >   static int __init sifive_serial_console_setup(struct console *co, cha=
r *options)
>
> --
> js
> suse labs
>

Regards,
Andy
