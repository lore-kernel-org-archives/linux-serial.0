Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792954037;
	b=MgKoEmSEtY+v/b1oVTMbKQDz9olAEKNV6KK98Tc9IKlGkK0voi3/GcbaqHG2um8QA3Su
	 Iz9um3am5ayT6kX3v30/iRy8BK1p54BHKbTlEAc/j1En/1jZPU7yn6Jas3qGG3zKEE4xp
	 qAa6t9tuBXemmiorBApXGl0Vn9LFxOPUQ6ovsuflBkSuDeE7M0vDHu30U464hQxIt8ecC
	 PF657eSK8hnSeigWcPL+XU+UE0lE7EOY/0WbQ4HH3GP7YruQtZuKVR8OdU5WGo7PJx6MB
	 qSoRPvnkk+IXC/kpjiUBh75fn3iH33B3gmSksfrlLXI5QREL7E8h6k5bP1v3DRk0YHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
	b=dcbGmEsjKk+LUDNbonC0CH/UAIQrRbkjzJYD7yLq3rHqMcSwmSlwGMEmVLuWEQJYBk/u
	 qAEbNkSBRrrWQezYDprpj+SUUyDdsVXmcrGpXWttU08qIy5crfdImFGqX6dxRHivg0j96
	 vfw/6lZPFA1Zng/NPjdPepUJQDhZDBRXRp4L2NrswQ2ld0pTdftlZqgYz5KvM6EW+Sov0
	 HKoaAQmCID3GZD2EJlFscRJfrli5U76Kz2VEI2VYp1VYj13xHlQpevGGKWc6JORZSF5vD
	 BrKdtKBhAAX1YkO+scG6aP5wD5G2t3TMg00bNkx9jyy373LNUewDD/4cprg0s8847Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pFZ5a2iX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2808606A31D
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2808606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pFZ5a2iX
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so2961988e0c.1
        for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 11:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792954036; cv=none;
        d=google.com; s=arc-20260327;
        b=KGRLRbeHOrvuR4evg2v+GNiOxHY4yAEGrV7vprzqcmDfweo3e6o6+1JnZdWL1dKrLZ
         i13Cci9bi+lw5ti1uKHQemmrAIVkjZYJwmbxeTwdVM2BwvUwTuCZ6SnBEh0z+dWMkjZA
         qCWEgmNsJyKBjGT5FkOjl+8bFasqGcLwro5iGD2bayNdBSmaBJkJ3LMKhPjswIfdNf5j
         WKPiBa9fUTHjSaZ+5ZZb73NupGYOpFJMpdzAWugELXuVt6uNnuFubIlUD8cVn3oL1E5y
         rhUa3G5C4kIc54BV2ngyJ+btK6DyXuH5ngkO1d+ACXmPOFvsBvtI3kSF8I9gb/vO+FTP
         ugvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        fh=zLDLAJrUUHRM0idfmpN1Dko36Un6KY8pkvflpnHQiPE=;
        b=b0105rwKKoGpdzf0P3L1eHYG5eHoW1gzY5d70KhPahopR80ZvXcA39IvzmsgFEQahc
         736O6AyllB/ilwliAF2TqEhChCvPL4J3iVtMNuYM9ceM6Qk51qB3CYe2JsbFjU3OF14T
         Z2NlbtKg0YFa/FXHtwfud9zV0pEKwQtUQayL97xBb3W8NvYCCt98C2Yilbehl9gCOuAJ
         oUnVqSzMvz8BfLzVD9SroCepm4dlJmhcgkf/X+kcQ4RZtbq9XWwhI06ziBSQNk/mk1FN
         FFgubL2m7cFNrywo1z9Cpd3ihZyEvH1/6xrxQ6EmRgVxeJj/MxQIZq8ZmiESmXw8NF0Z
         jykA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792954036; x=1793558836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        b=pFZ5a2iX/z+pKe+hYLL1GQnSOuYDBsz3Ynetp+1FWxgyGkX28iH2CSl267qWQgDyM+
         RGRJPcOXNuTcRjE8ZLrMLmU7T+dN7BWz82eGoPJdVXP2Mvp9vwELoUeGlVLP1nOK9Xcf
         7i722QRvAnnSymbAbqjIULgrN8IXRBrkDHcsBVG8B/xiMPMkam2S62O+X8e0DtCoP6Th
         nl3gIW+nmYYec9t9wbAvuRGY6nPN108gaPfaCKBhFCew4Dad7WB+wwngNqiwEKYtP4uS
         aH6gkvQr1EnE0CNMNrA2l5zFCFFOXGACQi4eaWzXmMZC3vm/YEiF0haCDgZ+hu/V61Cy
         VLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792954036; x=1793558836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cd/Rf0PmOsf9SbzCT228kopwmzuVCMtn/HtZcsjTHHw=;
        b=vPPdCTfBm5HvumpDRHmtxyePXqGLyviyzqAdj7jmgWEnJozsStlDwyyskrW9BQ4JLc
         FIKnUsqni6yXsXTgeVtV0fRM1M4y7ci3Nl53mDTu1dW0jOkDr0x1mrvbCrWtiLgLEQy4
         F5aYUgOls9OKqRUwVqhOkSukvnLk9/9Re5lzNgMh6J0qXLVoU3UfqRjCcqaEyCXFryYR
         xvLBnGNB9lmHxz6SzIswmDsP9E/WsnzULXy/ug2VvvMjqmYTq4yV0zhQQgFi3EaKmIfz
         zCoCP4pWkfzt5yrKiC4WdPRMPmNCkJ3klaMsif4qRYJ5yVqhhnupNkZ/MMIL8wH/TMOK
         ETAA==
X-Forwarded-Encrypted: i=1; AKwUvBw/GjBndtNVZLZaQ1ReXKg/6qmCDA0TT3wcf20mFNB2QqD1vP2vVwy04bHR8b8zwmB0T+lY1x37qlfCgF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK3gvdqU/Fn+g1o7nI7tmI0BKA/Lxg7uth/eFm3d+gFlUsqg2X
	J6V8n8uvpNkRrNnIxSFtjU38WTjxeS+c3B/vvSY3ErKh0rqO9bcIs/WBlGrG9uyzy5hEtw4ojTJ
	l5ZHB0qMW1au1x0jZEiAchryQ8KTXGIo=
X-Gm-Gg: AYBFou1khSm3PgUNeRkb21M/9tOpUzet01/b537G62zs2Av8IwIFM58vrJ7x2gCampr
	wqFyl0znqU4pygfzD4wHY+k3XJdpm8ucJmQ4xjmX7sHszKlPbg7TlIxwrfYxnkufsyI3daSNO6+
	YTDiR5WOIIkAVlZI9aCt6xK+gpzOA6zUkts1vxbvItJ6JeF9iM67yeVi+qkaSySnRvld1K5QtPb
	ag0fVkdkx1p6xn1CEU2GBUycyiIXIDTkrC9Bwby1pGk0priijOMwtqbl1x7btOj0JEPrDs5QdgV
	yGqe0J8+VMWg0M+S2SlNA1at1xdZQrfJ1IbHsk862MZ2Es8nShXy0YaX8zdj6vjaij8BckacKvO
	rR9/fZJIQAXGLXvxWKBteiFQDDabWt/NaFdyys7iqoks2rbBPDZVRwjkIeXkifxYM1XEr0hOPNv
	+FleP4eTQdNXXTLliRdAPW/EZjMyD08abreDSdV/wtLRvBVonCd52CwiD7/1Q52MoZDmYdDto5a
	zA8QJjbkLZAwxmsnq9CvhNNv/ipWA==
X-Received: by 2002:a05:6102:b04:b0:7b5:8fd9:27e9 with SMTP id
 ada2fe7eead31-7ce5d005cd0mr1043722137.2.1792954035832; Sun, 25 Oct 2026
 11:47:15 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com> <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 12:47:05 -0600
X-Gm-Features: AclHuK8RfnuoMKUL7_ChiQcwJjtxWWikUNjoVOQNx_xye2F4G1UoFeQQYjFC0tc
Message-ID: <CADvTj4ryYd91LYMCktJ6a8=ygm0BG6dd4ZyK6XByaVcWvFTvkw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 11:10=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.=
uk> wrote:
>
> On Sat, 24 Oct 2026, James Hilliard wrote:
>
> > uart_write_wakeup() expects the UART port lock to be held. Several work=
er,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
>
>  Fair enough, and thank you for the cleanup and spotting the issue in the
> first place, however...
>
> > diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1=
250-duart.c
> > index b4e1b90e5960..b15f76acd06b 100644
> > --- a/drivers/tty/serial/sb1250-duart.c
> > +++ b/drivers/tty/serial/sb1250-duart.c
> > @@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *d=
ev_id)
> >
> >               if (intstat & M_DUART_ISR_RX)
> >                       sbd_receive_chars(sport);
> > -             if (intstat & M_DUART_ISR_IN)
> > -                     sbd_status_handle(sport);
> > -             if (intstat & M_DUART_ISR_TX)
> > -                     sbd_transmit_chars(sport);
> > +             scoped_guard(uart_port_lock_irqsave, uport) {
> > +                     if (intstat & M_DUART_ISR_IN)
> > +                             sbd_status_handle(sport);
> > +                     if (intstat & M_DUART_ISR_TX)
> > +                             sbd_transmit_chars(sport);
> > +             }
>
> ... why do you think the whole functions need to be called with the lock
> held while they may or may not call the handlers in question even?

For sbd_transmit_chars(), locking only uart_write_wakeup() would leave the
empty-FIFO decision and TX interrupt masking racing with start_tx(). A
writer could queue data and enable TX after the empty check, then the
interrupt handler disables TX interrupts and leaves that output stalled.

The same lock protects x_char handling and FIFO consumption against
concurrent updates and flushing. These races predate this series, but
wakeup-only locking would leave them unresolved. I'd keep the complete TX
operation locked; each invocation sends at most one character without a
FIFO-drain wait.

> I
> think we should avoid excessive locking where possible to avoid holding
> execution elsewhere unnecessarily, shouldn't we?

For sbd_status_handle(), I'd read and filter the change status first, take
the lock around the CTS/DSR updates, and release it before waking
modem-status waiters.

I'd also move the TX lock into sbd_transmit_chars(), so RX-only interrupts
don't acquire it. That means two acquisitions when both status and TX need
servicing, in exchange for narrower critical sections.

>
>   Maciej
>
