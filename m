Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294415;
	b=NdnaHx3op16K6kurS67W5Pi+37ubPV0dALaajjyRwQvMGHTiKLnSlzRPyKBHbCBZBJmL
	 DmxZsJtWUAkVT4XG4fiq6/YwaoLc9Mw84V5BSasVxNtNOM1DIEymAN8ItuQ/Drgqjh852
	 Jd/NfhlozRV/25NT7JUxDpRhXdqHWUQjoXcKEt02fEWva2GZliRzFyAsa+UXg90nVKJhp
	 gFpXd+IZD0s1O9tIFaNVSk1DYbNyiiD6JOSO30LLvhtHfSjK1IXcGqEjOkpkzqHpmvTdk
	 SiPFAvvAHbs3jRpgVJ7G2v83YOsu/nULw1z9e/36ILgoB3kyv/ltbmjUlWIgeN6FG1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
	b=Fpr2ezD3aLwn2YfJV/8+GPVOnTlaI3/6u90E++Tgp6INpAu1E0k0y82nhNpfnrgeHxxF
	 QJ9mMAcc5rDmPFGQpjF1vLKpW3fnqM8jjqAQyfXVTHLukNUAJt6SZe92j3rSUkTfcC+fm
	 f9F4fe4WdPdK17de7+AGElG++ebe0FmA70ImBKg3EuWY3msu/e8Zjmaq7zhdM4U0u7z4j
	 z3e3aSHqm9wgxLyJGapBD1m9pVHOSX+uIgGRl3Pksm9M3tAt54tewPZR297A/Vri4U+Al
	 GLeK3hA29bLOdLGsY8VgQrERdK6P+nvVwny4MqjvW6ly8MPi6bHZTde3iewcHxXQBZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iClSgdm3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01A606A323
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 17:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE01A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iClSgdm3
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b4883643ccso2973850a12.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 10:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294413; cv=none;
        d=google.com; s=arc-20260327;
        b=PvXBO5zLuxT/2L5XCFnX74SINy7kmuPYjg4v+wubVu2XpP5nuilwljoaetlqxgvdNb
         4scKHwnNng7INaTnN4TlG0cgFwqypXh9DtNcsVy7UQ4haWGqY1wbaMlkKnwg9eQHa6Ug
         b3bJBMftAovzu1+HfMWZTkqIgVlMTMPJTfAj08NzZEjpbxqdorRUt36sab07ILoYSYc2
         vbshY2RyY2PGvGySzFy8HdzkYjszhCzSOhPP4mKZzP1//DNrdTPbNA+G9ipqCvuYivKt
         BZQbaEihtsx8Ys4TUtM/7yTdQU4EEDgzIr+fNxQYVNV2Wl7nmdaBeusvZuOxmcWTClfH
         BK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        fh=Rp1VSlO32Q4maBwJn54gS7UhCdMDm905UP1X/LhZwAc=;
        b=afUnQHI9FIgVi07tB66yp99OQQeiEqn+LVcxsFl12b9YE6ZlX6+KeMaPVAOkqn01BV
         /0Xr7Zk1YNGvpPwdZbDKkjwjFZiUGTlpf8T27ScptzXxKYVvmkT9VtjYpXoTEu9NlcLk
         +kS7cyKqjEB7vBTVJmBqZX+dO0dcZI5JHELO5zlcOU8jObnRE03bfnKzBBRRrFoVJqlM
         nRXo9RDgerkW1dyxvYhYesrelHzNZKCfcKl4qPvoa4olT19WAD7tz4l6r6a6+OfVuoE/
         Oqr6+gFWHwMBtgrS5scxivQbFDe/RC77WaOCXuwVrbnswxRmMdglk1ib4CE00O4thJs3
         Gsrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294413; x=1793899213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        b=iClSgdm353+66m+jUetFLdNYfYlVqGyk/v1YeLwzDgxxrEWL99dgYjUWx0ioykPrm1
         AyG6Hw/UYVEyJG22bvUNGQ47dclMxQMgHPHQSJcl4uo1xrF+b+TBgYNVRhOjFSyFgLHD
         I+FCG5zu/14izwa4G60MTsaz28yyHB5CCeuaMbMrK3zXPDqDECVloGf8TrhKshdhpWI7
         YRyxKcFoRyDpPW7Ubb+UP76LmjfYRy4aYMurmRMP1L2J56IKeSGHIkMFwpTv0Leewfvf
         agi5Ru84lorLuvqTkiLetnhRwGwUBideyMt3vt7PfN1GUrJ1B/RpcsPYr4IOv3g5AsfQ
         L64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294413; x=1793899213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcHId9d7ZivTlUPflcKuYmygXozfLhAN5Qcceh+SBys=;
        b=TbBVL01k33LXJnimvVrkkXjHfurNv5ClXcmiNraY66QBaGSjDAkZjSEHI+w9zijvf0
         aaUYD9slWZ3yvGLl2fzKhsJi1qRIw8TONzEpHTQ/kygWCHf2cxxzf6u002rIp3oMF+yZ
         9J42PB6Oo/tfLytgdyfzJjAjqh0GQsUdqFRmNZXKp4ijnhzdAoFLatPCy70+ahnsPTfV
         /3zcU/dvTt9crrU+Mr7vDDN1A5vOjiLwHQmTnBBxqZ+MBCgvVmt3JpbZNW5uNwBWOsnV
         Dts1hSey4FFwTMM4/5pqqoVEYOPCSyWRUvuAl+TrFd3N+A8ZMuQyR/Rsk/yfaLy+h14w
         Gp/w==
X-Forwarded-Encrypted: i=1; AKwUvBzh+F+wSKC0/JvLYRl/AnGPrV+0hEl6u0kmSMxTW/t6aXs0FoW1ljiGdLQgoep0Psj1Bzc3x0+/BSjNy3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYImZtRbcaGMbWBwC9zlwMXvQ++uab8veTHjwT3WKuHcHmaTOksZ
	7JB3qhAuXhhv9L0zMy+OxArScSm78Rh8xWzSLTDMi5C9gsOMUHWP0N0GEQjpGYeMacNH5gDE0A2
	jBbB7G0aU0Rdm1D0+uCwBMSBcr7hv6Bo=
X-Gm-Gg: AYBFou1v+ZsGs5l/TMC8suTyiEeXrdX3HYK1RIXmleneBOE2t+3klmnSlZf5pZVdW0w
	WV+JJf9jDMxc0bcKbfkIDZyixUjHsjFWH1AyNo9LI2NCOgP6pIASn7QLgZCHOuwNm3X0T1X3rA+
	M0PsLP0VxWLXeio7Fo2P34DXUg91RoWd77XiK3aC6t/i1bvd6/0DeK3eoKQDj+erdkYzkR5MX9N
	lXMFrI56e6oDTuS0fx0qdQfhfPIq0VfV/JcH1a98IqIAOdJRiaRgVUr+rU+rWAjD+mbzhH5yw7t
	Y77hK0NCrThx/BmNiDI8L9ROpipXDo/D0AOf27BXB9ZcJnnIo9JzccSrobH5vXZT5z8G6cuucX3
	2nWY3RMHWS/UQuvWXGW5zt8Rdd8p77A9GFAUq/37WLrHhLOD9v2ghK2FsNivwuCHO67mM13788d
	u5GCvTq6Svr/NzK0KqxWv6lXXacog8e3XqpOvigp+3UpTF8JbDcdPd84iWntN58XEiN2yLpme6G
	l4T73qZssDb2E7tsuhStmS+KWB27A==
X-Received: by 2002:aa7:c1d1:0:b0:6b4:201f:17db with SMTP id
 4fb4d7f45d1cf-6b49cbdfd84mr3081067a12.18.1793294412721; Thu, 29 Oct 2026
 10:20:12 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
In-Reply-To: <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:19:59 -0600
X-Gm-Features: AclHuK-0pW6JI4DxQzs96I_p0R94o9xpuy7K0elsSNWPWKpDy78P7tTWYrgR_Gg
Message-ID: <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when
 termination fails
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
> > serial8250_release_dma() ignores the return from dmaengine_terminate_sy=
nc()
> > before freeing the coherent RX buffer, unmapping the TX FIFO and releas=
ing
> > the channels. If the provider fails to stop a channel, the DMAengine
> > wrapper returns the error without synchronizing its callbacks. Hardware
> > or a detached callback can then access the released storage and state.
> >
> > Checking the error and returning early would not preserve their lifetim=
e:
> > serial core frees the TX FIFO after the driver's shutdown callback retu=
rns,
> > and port removal can then release the callback context as well.
> >
> > Require successful synchronous termination of both channels before
> > releasing any DMA resources. Retry failed channels after a sleep outsid=
e
> > the port lock, leaving channels that have already stopped and drained
> > alone. Keep the shutdown gate and storage reservation in place througho=
ut
> > the retries.
> >
> > A permanently failed DMA engine blocks close or removal. This deliberat=
ely
> > retains the buffers, mappings, channels and callback context until the
> > provider can establish that they are no longer in use.
>
> ...
>
> > +     while (rx_ret || tx_ret) {
> > +             dev_err_ratelimited(p->port.dev,
> > +                                 "DMA termination failed: RX %d, TX %d=
; retrying\n",
> > +                                 rx_ret, tx_ret);
>
> > +             msleep(100);
>
> Huh?!
>
> > +             if (rx_ret)
> > +                     rx_ret =3D dmaengine_terminate_sync(dma->rxchan);
> > +             if (tx_ret)
> > +                     tx_ret =3D dmaengine_terminate_sync(dma->txchan);
> > +     }
>
> This is unacceptable. Sleeping is okay, but value should really match the
> baudspeed and other parameters of the transfer.

This sleep is backoff after dmaengine_terminate_sync() has returned
an error, rather than an estimate of UART transmission time. Each
retry asks the provider to stop the channel again; elapsed time is
never treated as evidence that the resources are safe to free.

The particular 100 ms interval has no hardware-derived justification.
However, I don't yet see a sound way to derive the retry cadence from
baud rate either. RX can be waiting for input, TX can be held by flow
control, and callback retirement is a separate requirement from
moving bytes through the UART.

Do you have a particular provider failure mode in mind where retrying
termination should follow the serial transfer timing? I'd like to
base the interval on the condition that can make termination succeed,
rather than substitute a wire-time estimate for an arbitrary delay.

Regardless of the retry interval, shutdown cannot release the buffers
until the provider establishes that DMA and its callbacks have stopped.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
