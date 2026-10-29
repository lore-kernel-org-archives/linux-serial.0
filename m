Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294277;
	b=Fz6Q4Be/4PiSmjRzlwICHK2b3AY36y40lTPP+mnuWbSmRQLx1HIur41QRw0MNc/zCMnN
	 x3u81HcGUDI6GNH2hrcO2/dXLBrbaaW90KYkiJbKPbssFwd24eCKy9hXWfzIKN48FWVpi
	 SJln3Km7rSbvt8jxhSrpTqNl5KCi/Zb0ljabQqqssKaGd/9dUYWhmUoMpbUkHENK8m1f/
	 oWfxamztXw6PwZ+hvHcJ5+kIwbpk9YGOktixgx9D+DpT6tV0IuBuDKTsTdOvJSShkqZHb
	 Jllg6EAKX64L+uHprETr3Dti52v/MvvrZlqnx84BBz37PqMyxC4a9f8edbHcqhvlsKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
	b=vUMogBgnKrGIk1kNBgx0Qw2Q8ugSCmYXAVPgoecew2MzNTqM2WQKWWaSj2Oes0AjGUAi
	 rbTMhlvGFBTU02yU6TcUsQu/4B6HTbu1QJ6HvuBJUbEoJYVPbJFG314CiYueEgW2iRcwg
	 jZma/FB6JLVpRC0aFXfUrtPvYRDtwczhWCQNpLtuAQDQuwcP7Bfi7aOyl2p1ivYo5zMwv
	 40qP/Vc1zByETQndksmnkquX6jo7MD8jpupSsfz17Gmk508gHSNIv0R9fAKj4QSF0zSBT
	 xCvLaea9NNs1t4LEYZrgULjBXSSjcXJDPU7+Ibvz/aM4MzITkCXMLgwfqbg9pTvhXyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1lodXTO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE418606A31C
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 17:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE418606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1lodXTO
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so3236813a12.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 10:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294275; cv=none;
        d=google.com; s=arc-20260327;
        b=auaI0rzHN0RF/b4wp2wEqUR+WXsUR/kCULIvVs7Ojk2nVIc8blzDVXmBOas36CVM7s
         0GBm611wXLm8lHUULGlVATGTodnvBO1s1mbn8ZI0yIyHPB9e00DfLiP3+FG90DX+8jz3
         vuLDBOHAXjvuDZvi4fgR5IaPvaNZcFdCtWLeH6161Fjtb1sQywRVsBVmDwaTcJEtRxjE
         H/ktChRNUgNmP3LAlkOrTMM6ytXaka4iKMxQgQiltJh2VEbdtrh/jupPQf/M+IGW6rua
         DcUHyv3i33t3lsHKoCTH6v/5f0oWY78RQ0P1goSejvH8f9GNQ5EZv94JEleV30W5Tw/i
         1/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        fh=yu0okERm4cCMQym5t77L7yjUFWS0lx3UXmvvMtzc+Dk=;
        b=Si0HdwoQw5kNPfmDXyW1VNL5kMaO95fOxu31e5fggXm1J2NksmKmPXcAptZzYrYUrd
         /S1u4IULhZ6y63UthXjsU3oj7jdbHXX3i44Uleyb80rxDFmkMClHeTP3phvO7yw3I21/
         7maAcIgZGxHoTNHih5HxnU6mji7kusI2mu6svoa7d1OlHP9AGT4Nb+b6+4j3g/EVCdO8
         x2NLQgx82rK6+nfRab6ZvEbz4TrS/Epg7QWZ7u5RDER2fYUjMqWf1lKpXOdWzvXW3lSq
         Ev9PKo1Al3BgAVB8o0MRJvwBsZuWlh7inKjTOH791b50CiDxwFKoZXZJpvdhLzxHVTzq
         W1qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294275; x=1793899075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        b=U1lodXTOQgNfGhx5cmSNfFjyd91hY7J581AuMLFuVn7Zoki1q/ZGT3YuSQ/6YVrbCB
         JnBOa9Jf+pHpwzbx1kmYhfjTbyAAWJRl3t7wz8ysZW8Jc++T7GJ5p77Gb0CbZnM8rk/r
         EGCwmAzEW/YCJDg2OzrONhnevtqfHfdQ/uQnM3AH5XEmNBzjux4rjUkRuCUwq0t/ouuH
         Qy5DMr9Wl/UUj13JYEz+33YmIDMsNl/PywPDoM14lVitgSoWEVrxaGrmU+04FlwJtVvg
         ucB/aDfiwCAZRlgzG/Sp0eQhMAvkiRfHfBxvQI6gN/r9BCrTI3DMZrnuwxw1VHMHP/5L
         w61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294275; x=1793899075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVYR1R4XUuM03rk5Iesd5QgqyShDDveAkvO74xuMO/4=;
        b=lV8OWNoDfsaeY8GIcAZC9g9jRSLJOH9ax4K92h4czT7XSEmOtRiGjnnw2FOxv59hxn
         a0NUi6p3ez0FVZZGcJF9DOibgtVlqgbWJ4iBTP5VNwxJqjoktaJ3VvlFP2vySEh4kAZI
         h8J+pcgPNW5HjzwL9FiAb9ceNb6fdVRaCnqpC+E/EFHsRH3MF3zgYfWckmFuT7jphAXI
         1lsOqR3EHrAjCxW3cjgZSoWwsTR1h+vwRBZ7k6brCD/5he66q4Dq0mFJLib65do45eV4
         3PxdT2ghRUo/5vS6RpOzQ+pywYxuBrVM3avDmPzs0rjlc6eQ1WZkNTFbMjkzelWCB+1f
         KqCw==
X-Forwarded-Encrypted: i=1; AKwUvBzM/7kRYBVbgxMgxyNPD6GHaalAjWY9IUmqTSWZVMBnOnWlBmD8N6GXstz53z/wLljpGdkMXHZCnuchC/4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx8OlW1WryYEIHcAXymoUuRKl2WtWJG/sZSZOGkuNVYGOTRccr
	BE5ZmO1XdhUkg/woCfI3lLg8of/iMm2li5cVqn5NnZ48lFf4Lresk20uu3Ee8INq3TrQZXBoSzN
	CKSOmSEZTYbf7HtMSG9+CjI8//pa/YeA=
X-Gm-Gg: AYBFou2m5O382uyH6IhvN9p9e/W3/S9cmmMesPvQdrDnJfZlJRsbBVlJRVTibY5yNtD
	i2sjNTt9YJpVjNlz6sDdEfeUYh/V+YrvDa2gCddYA7l1EN1DY8Llb98gbsHuHXs2hLSEaP7LWQR
	upYpndSrLfA4U8Nuf/fnTVXA5gSoekQDuk4qnOKCSaK850+ErR0FDlJorvsEibj1Yl/B+O4urzJ
	tjh3jvrLwxGsc3SAJnL+6UzaXXuky9GFcbHNPJBQ0h4xtXIFdwqi3TcpUiCyQdb3sUGMILwt1BO
	4/GbK5tqu+b25ZF0CFYTc5OaVzTIACrKTszE9V9v5B8rt4l6UO2g+yR45ih+LtevBxiuHF6MxoH
	RNjboKKp+rvnk2cCMt8NUF4V1toRWyueu8FGTGvNfEiWJDR/VMZO404Re903mPyuEuqnMBv8veh
	4ljUL6BPMOCViaa7YwHbjWEUjv8iPK8KPE702onrsr3qFQgLr5npkQC8fho0C0XCxa+GDcPyD2I
	6903CnTY0SKHHx4YeEDMSh5tZmqnQ==
X-Received: by 2002:a05:6402:158f:b0:6b1:ba86:5f48 with SMTP id
 4fb4d7f45d1cf-6b49cb8e221mr4598429a12.36.1793294275082; Thu, 29 Oct 2026
 10:17:55 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-5-3fd56ba352ed@gmail.com> <auNWl_thBnE8JqBE@ashevche-desk.local>
In-Reply-To: <auNWl_thBnE8JqBE@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:17:42 -0600
X-Gm-Features: AclHuK9p5HgzHs6EyjP74wtBvDwmav_JmQ_V3uuDUu-UaTGXVkbTzXu0Rboi3LQ
Message-ID: <CADvTj4qR0j7f-79wTUb9LmwWdGKYz32vB3Bgfr9AnEfXMnMBdw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] serial: 8250: retire canceled RX DMA before
 reusing the receive buffer
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

On Thu, Oct 29, 2026 at 8:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:01AM -0600, James Hilliard wrote:
> > The generic RX timeout path pauses a transfer, copies its data and
> > terminates it asynchronously. Clearing rx_running at that point lets a
> > new receive reuse the buffer and cookie while the old callback has not
> > yet run. Inspecting the new cookie cannot distinguish that callback fro=
m
> > the completion of a new transfer.
> >
> > Reserve the receive buffer until a worker has drained the canceled
> > callbacks. Keep FIFO access separate from callback retirement: after a
> > successful pause and termination, clear rx_running while rx_terminating
> > prevents another descriptor from reusing the buffer. Deliver the paused
> > data before allowing the interrupt handler to drain the FIFO through PI=
O.
> > Normal retirement only releases ownership and leaves subsequent receive
> > handling to the UART interrupt.
> >
> > Preserve the normal completion-path LSR read and gate DMA resubmission =
on
> > the receive interrupt enable, so stop_rx() prevents another transfer wh=
ile
> > the status read retains its existing side effects.
> >
> > Reject new flush work and PIO receive handling during shutdown, includi=
ng
> > late Intel MID DMA timeouts. Stop and drain retirement work before free=
ing
> > the channels and buffer. Once RX has stopped, allow the idle flush used=
 by
> > DesignWare LCR recovery during shutdown. Clear the shutdown guard befor=
e
> > startup configures the UART and tests its interrupts.
> >
> > Check pause failures before accessing the buffer. A successful pause is
> > the quiescence guarantee, even when a provider still reports IN_PROGRES=
S.
> > Also accept DMA_COMPLETE after a failed pause: completion can stop the
> > channel before its callback acquires the port lock, leaving nothing for
> > the provider to pause. Retire that completed transfer normally.
> >
> > A failed pause with an incomplete cookie is ambiguous: hardware may hav=
e
> > finished while its completion interrupt is still pending. Canceling tha=
t
> > descriptor can discard the entire completed receive buffer and switch
> > permanently to PIO. Retain the transfer and retry pause and status in t=
he
> > worker, with receive interrupts masked to prevent a timeout interrupt
> > storm. The worker copies only after a successful pause or reported
> > completion, then terminates and drains the old callback before reuse.
> > The pending-pause guard keeps callbacks from copying or resubmitting th=
e
> > transfer concurrently. Retries sleep outside the port lock and stop whe=
n
> > shutdown takes over. A provider which never pauses or completes retains
> > RX ownership until an error or shutdown; a timeout alone cannot establi=
sh
> > that discarding the buffer is safe.
> >
> > On DMA_ERROR or termination failure, let the worker stop DMA before
> > handing the FIFO to PIO. Keep the requested enables in the existing IER
> > shadow and filter hardware writes during pause retries and recovery,
> > including termios, RS485 and overrun-backoff changes. Apply the current
> > enables after retirement so stop_rx() and shutdown remain effective.
> > Hold a runtime PM reference around worker register accesses and keep RX
> > on PIO until reopen after a confirmed error.
> >
> > Abort the DesignWare idle sequence when RX cannot be stopped. Allow
> > the empty-FIFO timeout workaround once DMA has released the FIFO, inclu=
ding
> > while callbacks retire. Exclude FIFO resets during RX DMA recovery. If =
the
> > provider still cannot terminate the channel in process context, retain
> > its buffer and leave receive interrupts masked.
> >
> > For OMAP, publish the shutdown gate under the port lock before the fina=
l
> > RX flush and interrupt masking. Take the RX DMA lock inside the port lo=
ck
> > in the completion callback, and serialize the runtime-suspend flush wit=
h
> > the same order. Drain the UART IRQ before releasing DMA state so an
> > in-flight handler cannot retain up->dma across its release.
>
> Can this patch be split to smaller logically isolated (to some extent) pi=
eces?

The OMAP shutdown and locking changes look like they can be split
out.

The generic RX changes are more tightly coupled: the retirement
state, worker, IER filtering and FIFO-access guards must agree about
whether DMA still owns the receive path. Splitting those mechanically
could leave intermediate commits allowing PIO or another descriptor
to access a buffer that has not been retired.

>
> ...
>
> > +++ b/drivers/tty/serial/8250/8250_dma.c
>
> >  #include <linux/tty_flip.h>
> >  #include <linux/serial_reg.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/delay.h>
>
> When adding a new header to an unsorted block, try to squeeze it the way =
that
> you get the longest ordered chain (yes, interleaved with some unsorted
> elements, but still).
>
> >  #include "8250.h"
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
