Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA825B0B3
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071588; cv=pass; b=J0qc75AUZxeMvcDPtbQ1MagBUEqpviPyEoshDqABCicypSpL7A6iqyDRpMcCFfHBLMLsIUw2B6jy4j5AKcOrhvoeBCkHicvNAXgocJAikG5v/mMCNU0RacGEtRD9KtERM3RNGtWbENuIspOioMK9K2e3qvP6fcfYH1IrqKUUpgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071588; c=relaxed/simple;
	bh=w+aCkB7GzTruqjui/BBALB16dGjcRhG19xahcuw2XJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOg3X97m6Unv9z2dJ9/iz00cgVOUccmjwyPoh57qArWi6wv+mI6l7LHcvnj6wdHQWI6XLlYorWFmX4X4NRHiEnrxYRVPmjgK6VRyCuA8RLgc4UWh5QbZ7VWXPLvX036huJXlKzuGu/aFK5MokyXVzOGOamOYOZ52HD3eGWPiIrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2rkbRH/; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2rkbRH/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6919f40a0c8so6687567a12.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jun 2026 23:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781071585; cv=none;
        d=google.com; s=arc-20240605;
        b=WpsjcdGy5bu/cwz2L5cwP6S5ZUTZS0Hn9+HcuB55N6ixrx8jnZ5adS/8b2mzMu0xUK
         AiT08mZnDmGniUVcHoE/s/rWCbB2zzj6wTfSJNMIsiL9PEoTVlyE681kWzoTnFpelxQ+
         UYTOEWZ0ercdKGq5HCgZmlgybRJI4j70pehAXqpEsTbi5/zY6pufif8qRFTEhkj1RTFR
         XngjLKrwcA7JI7kQr+zCr6EIuHhC1/umZ06AWxWoxhPLvAbQqCb5CNrI/GuSPGLgVjDX
         WQtj8Xubeq6aM81nk4L9iYlUZEXpCKsuIXudkyTj2v01xJnNSC91qHH5at4zMMlPZrC6
         qijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sf27jUZrV/4ePYlo+ltQi/cb6ikm1nezgKuVcZuPbNE=;
        fh=v7N8pNLzoX8Q163unyh9NUy0pHaeAFkTEJmlFDXnTxk=;
        b=D8sn3Xf+FCQ4vzM4a9q9IgVV1wgxYYFgOL2hWNEQWVPYEdpwYjoLtoMgSPeU12yyuF
         KGFq1HnD6wVeAgYJtNXkscmUxr04KyDmszri7/6PNwhk8pVUNG1KL1lhsGC3vqHidY+W
         5J/5O4/njB96lH6dUk4FXaQPWUZ73kK39Z9CDtSYT4px7Y/fhXQmta9XuJhIJzviOJ85
         SHJQSWBuOazy+gophUT7aZP6Yc+SQlYaYWbV+u+pnfA9lMrIYl+P0++EVvLpTiMIdjxe
         H1J97QGRhfbX3PMIFmapQ3y2LDubS+Mkb0+KtScuVukALncCM4MK4EO1QQIK5NIL9gH2
         hN2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071585; x=1781676385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf27jUZrV/4ePYlo+ltQi/cb6ikm1nezgKuVcZuPbNE=;
        b=X2rkbRH/ICaBByZmbx5y6LhHvQmJyHgAaU/wXm608TGtGK38IrzWMJ6uT7KOkX+6cv
         FIkbtXdKjxVKITJTGjR64N7/Ix62nRNK/bETpEW4XN/NQeQVWx6PFhWuvoGcfq2YkSwx
         eu5vcB0jrlQiHGhOD10LCZIIMr0/Qr1FHvy5AuR3EOD9E7zqlyk8lo999pbtso0To/yA
         sXk/Bbnuc7gtp0YCA4ogf/DXubI0VWW/DhWhYLAI4gsQ11QSzmn4D9yTaz/MaU07AxTx
         jj2gx9Bgm6G/jQy4SUR5D6KtSxlXROTPzhZ45vgYNviquevMsDcJC2erMPspEAlnNHD5
         sZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071585; x=1781676385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sf27jUZrV/4ePYlo+ltQi/cb6ikm1nezgKuVcZuPbNE=;
        b=UtV0fLX6w0wWp2NIpWYJgxmdUbyIxEGkNfOpQhQO1P/h2e0VI8/5q9wlPQZSWZO7pR
         +PKP1sfsAHlYmTmI2aQxaGa9u7w0PmQ7vx2vhFJd8qoAUYiw2oGqF9mYffGzX1K1x+BZ
         ExSw2XMHa3/YwpNMzzFkXVDtxtLXJuMiWu22iDUwcLrxYVEDvcUrP1VRmLvU2hdxyhwR
         OsCCiGR2P0Uq8huVfOf/hM+7RJVfb4Wbmn0gorD2676ZIsJy0Cld3nwYjwJCQNTTnC3M
         qkpskykdHw1syGbBXqjubf1EOnSmES6T626XuM/hL/KdiKfoSj6Vutq+Jrbw4BZl289Z
         dq2w==
X-Gm-Message-State: AOJu0Ywmi8rjDZaI0NOulR0RG1XIFzPivYz8zHmCu1nGucr219OtBr4G
	DnemVdMPMTCGLWBAeZA0l25ZuACUDk9xt6opa973GcoX4I05Pxcs14D9ydhS1ThZwlZWUgUvyY9
	GlY493EL0tFxKXUepIxuqrIqP9eZCesQ=
X-Gm-Gg: Acq92OFMm817/N8gS0Jmj+aMeh5uOpHbocKKzZB2A+q142g+BlujZ6AxA9lubb3CNBj
	mTBTC1IyE2TZGJU1D+21bNOeX/kTw6lb5ld7/9WpBLcCfoD2Ma6DlI/N3KueQ8KtL4IIg2vodn2
	J3HLqTrigc0CB6dEKuhTXcAgM4WtkD8Kmlu72xUQzJWhw70QDkenNBkEGFMQDh+CFupwmmK/drQ
	Lsn5SlTsx4Jw3nu61leN7FBs77Us/ReCPV8+q9nC1uNQZQi5ubeulx2UwUxr0TkS7/dYtG1z57P
	n2E9np2V39NfVnz1URJPditYMLtNe6a4F6IbLdConhEgKnLDGy469tF986ToXpiVSiFpszJpVKN
	LFaYUip2rBq+yOsXjGcQLdBJ/sXFz4prybTd9G+PttrdBRP+kZJ28N1gal51IngoJ83An6e1Qb2
	f3N6E=
X-Received: by 2002:a05:6402:5216:b0:687:1c98:a19a with SMTP id
 4fb4d7f45d1cf-68fa4f3d294mr12615404a12.13.1781071585304; Tue, 09 Jun 2026
 23:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609223717.41670-1-rosenp@gmail.com> <20260609223717.41670-2-rosenp@gmail.com>
 <aii6RX0321fJV99W@SMW015318>
In-Reply-To: <aii6RX0321fJV99W@SMW015318>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 9 Jun 2026 23:06:13 -0700
X-Gm-Features: AVVi8CdoKJGr2CY6Ts2b1YU7fzVQIRGuXCKSNkOV6YDrgIls9cvowFQd_CqCISg
Message-ID: <CAKxU2N_KcPHAAd=JO6CQuJMqs3PsQd9HBtdW=KbLGOKbfB4H1Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] serial: mxs-auart: fix cast type for of_device_get_match_data
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-serial@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:13=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wrot=
e:
>
> On Tue, Jun 09, 2026 at 03:37:14PM -0700, Rosen Penev wrote:
> > of_device_get_match_data returns const void*. Cast to unsigned long to
> > avoid implicit integer truncation warnings. All the data parameters are
> > correct anyway.
>
> It is not worth to fix it by this ways. cast void * to int/long is not go=
od
> at all.
It's just a compilation fix. The same solution is used in many other places=
.
>
> struct drvdata
> {
>         enum mxs_auart_type type;
> }
>
> static const struct drvata chip_imx28;
>
> &chip_imx28 as drv data.
That's a lot of work just to avoid a cast.
>
> Frank
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/tty/serial/mxs-auart.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
> > index 697318dbb146..de97c0f74e7d 100644
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -1598,7 +1598,7 @@ static int mxs_auart_probe(struct platform_device=
 *pdev)
> >               return -EINVAL;
> >       }
> >
> > -     s->devtype =3D (enum mxs_auart_type)of_device_get_match_data(&pde=
v->dev);
> > +     s->devtype =3D (unsigned long)of_device_get_match_data(&pdev->dev=
);
> >
> >       ret =3D mxs_get_clks(s, pdev);
> >       if (ret)
> > --
> > 2.54.0
> >
> >
