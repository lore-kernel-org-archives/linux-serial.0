Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729819;
	b=ZuKh3q5GXWo59fvlnUjAiR/t3npX5BF6LJso4m2mhc4V8a1bWN1bXOBSnVDBHTcLGOmf
	 mKwxjhpzPeuaNitDxRHN9jB1LmyB4sk4oGlVAPU3lpeyUHr47zRWm5pZhYFCg1YRNE4Zs
	 VDIantl1P1YaOj9grtZOAz1Slx52NQ5aQpP5eeVY2RvnnDCJMRq+5O1JQae3yP2NELqqL
	 Svz+XN8RZkIMchIRm4ogmAwZLIztkgPU6Ci2mpM88W92uZ11ef1X+HohJ2cFnIDhLokXN
	 Id+G87+wZUM3PDW7PTcAl3cwpjHbVA8GGYbUl8lKXeM3qEXFLbxELIhixn6DSPZjaVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
	b=XOsnQw/4cJpTcSWbzr1oD+Q+XKW3Zo8lNlcFZGAqjSqdYT4dI0eSJJDhfGfQq2B1QNiZ
	 Jcm2Gz1BtYFdDMSjuMMx14FzIP/0/VKQ8iCeMtQckRuvpDLEEniVL36K1EeVC039hJ3SV
	 wCbzq3tkMgLZt5QIPqqBzIlFvfhUs9h2p/9a1ODP9USv56jnU8qymWgNISwCdcJkhJQOa
	 2m3VlI3uI54C8mUzwlqxnL+iBgYySptVibMWfty8poeSjHLxGqAToQ+RLNqR0Un/ZLNn8
	 tFGb06YR07Rmlv+lJiYCLCWGLbQMs1IXUz2+ezkoA2Y/s6qhcQ2Qe0bxOIUNR/5TXGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8pJCrwj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4491606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 18:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4491606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8pJCrwj
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so3453642e0c.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 10:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729817; cv=none;
        d=google.com; s=arc-20260327;
        b=kgxuHbIx5AQhEOncMpPAPMTeThtjhNsYZPtynCohqXm3HN0g+Kb4R/+lgx0ShhQ7Rl
         YPPZZFgZhfXnCJ5fOik+J/Kyu0pTpzbErSI49Kkf/F9jfIRp+ym4cb04eNGWW4S6cvKt
         QxAsrYgIP7e8QFucGwuOrVOhFCbVNA6PKDeq8T5mU8RfeZQA7iYsZB+Ys1sITQgKR5Yz
         TMeU6YDVvFpK9kWlsT+hLLzsfEg/RfpnUJkHX9OYaGa81/Tusg9vlgISfTSuJW+NcKsY
         dlA+TIzWg2hseyXI3XLIZXKWZHrH1svC3VxKitt+BHb8G3CexWMelGjdA4pTtH+q+w5G
         aacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        fh=TZnNPlGefEdgNOAvpXtiL6H4UmlsGKBFbFBWgzutXk0=;
        b=jVRUqQjn3W4u8j3m0aEpgYSMSJOaAqJ4gJIjxzzlJvPOWWWSuWu2KvsGxWktmqvJAw
         nioPMhUiCDibWH0tiU8TYfNyGipZVc2T0SohYiNUDNzuWwAkFdxRUDukZEAv5OY05LSq
         W4E30XZgtOGkVF8Gq36vACPnxk9KR3ePWfaNIIYhIXm6fVNMqBRjQzF7cfjDZooXVGjd
         qo40NBVccLMisZ7FHAtv2CzToPjM/XRj4QIHT++QEikUb5vniVVwGxSXu3R4zhnndNjh
         J3b7w31R5EmVm5DrGnvR8hTcl4KWAUP2nUChs9ZyF4kxGZDUO7InrEkGyolWEnsgFpOv
         t1Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729817; x=1794334617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        b=m8pJCrwjuCww3XIDtmtxt9ufTL1HAmYCrSSNHQlC56UWLcRJAB2CRQTqJ5qS5PldZG
         bk1VZ8DrQyVqBSQJny0mF8F2Ml8Zf1pmYk3KRTo6xw5/UglxlTO3HribUzn3B9FwYV1E
         DG8ocnHwXWkQFnH042u0eKpcC6X7wjriMQdEsbF2aO1Q/288IzjBc3Tkktl6e0pwVjbg
         N5C+VzWa8JuAOMV/7tb9MTRHnWUoD2C3HzVC/0jqsUsIJWh5QF4v8jIWRZahjdNeOJit
         L+0zbsrs3OsRX5z3tcZwnHrzoey+wG0o8YCs9GyCXLHd37YEwFhm6P3jE/cc7n+Go45O
         ydKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729817; x=1794334617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbvyH8U6X8W+XhLMtftlLqtY3X/eIGXG9T4SZ8xrjfM=;
        b=voKxZWEFLni0CiINiY8xYUdpab94g6UNapThS3lym81kvo1Ei/9SrwavEFrmjOP3G4
         1DKigfFBEHlOrfOfklEpaDOwvBAZq7Ji0KhMGcIqC1N6kd0oB2f9B9QgMPTJAXsaa+Uz
         OZUDzsQiy4+2nQvA2sE9qpaLMbX0NS6WHlyqI4H4Tn401QFm0QT05sBa4/H//F97Lucg
         RYIJKJUFvVll7PBwyRLtBHuwQPPYm4gbaBoy3PWs/UwpL6HM16Bs1XKd0XN73ha79AT8
         IyBa3QC46CFy4HWRSoJa9OBgR5NkqSS2HZjd897qcYjYG5cc/2tCdNDajgsRAiCj7ZaE
         3hmA==
X-Forwarded-Encrypted: i=1; AKwUvByev6fFR26uGpdieO9IbSmofxrhbj4Xn1CiFzAl0Sp9eMHBYhO0LW3QEML656bNpNUlAVAkzkBLbID9KeM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P+TUBtyk3mQd1HwygbwNUOVzIVcWqgnxXg7Inp/HG+rhi6UmL
	nVbKpVrZ/qlhull7qkEDHD1z81JtOLKLfY9EsSqyLzEm0u3lmDvqDZkPzvjZ+wVFmdRg5Rd25rc
	PPHaxienS1ZoYEkscD1SuyKXs4v1VPPg=
X-Gm-Gg: AYBFou3nLdBt/mq9vJ/q6mIYS/Mia+RD7lnDGbNL1o4N81PsG6Cdm+S359wMLoSv9cJ
	/NTMSaCfjNz+ICebtMsC1P0gqIEWWapHhiKdMOgv+LrtdirK+VjDsZvG2Ugcrw72JDDi9pvX3dU
	NodNdW/dQCgyQJGTaf639F9Byy4A58IXFnNvaK+/X1SIqh04IDbshoAiRrDWLv/cUrbZVkXSeDQ
	DY/8/veFqoedUazLpmdbxANnbpTw89Ot9wy6eh2V0CoMu5W5u5P4+8qtXS96r5dytb2y5beueC9
	h7gitvhfmiOhqk4WMYfDT/9aJQ9gzDSolntwG4OJC/2A4SisWT9595Q145cswTg6bV7qFjjVmr1
	YhPciVszt9fPvB+SKu4yssJg9v6xCm6T6/3b56rP7B5RUuFGMCT2wXKc+aXKUB/KWyrsOYII/O9
	IGWD+8gbm4ji0YmtnL+s707KIwzmln6bkwsLxEyZcsbLDEMij6tt6J7cb5ETqeFO1IzoLqz3u6b
	gUG8KL5sBs9dKnWZo02Eoq0Mgl+3aXv8587r3vQ4GxvP8VYu6Y=
X-Received: by 2002:a05:6122:180a:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ec689c4d7fmr6770861e0c.23.1793729817534; Tue, 03 Nov 2026
 10:16:57 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
 <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
 <auoa8OWBxqaQuKRq@ashevche-desk.local> <CADvTj4rL23q6eO8vjVe9vL1g6B8aoZqsbnThi2QJqkj=9e59sw@mail.gmail.com>
 <auoit0AkmVeCvXqk@ashevche-desk.local>
In-Reply-To: <auoit0AkmVeCvXqk@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 3 Nov 2026 11:16:46 -0700
X-Gm-Features: AclHuK8HW-CEs65d3UAbPyCnbzk3fKPiCpsZ9iT1lPWFV_I6MxwKEkb2VsX1bZo
Message-ID: <CADvTj4rwm5BH8veX9i5_4trvzQFRPbDrAby7sXuEth6H6zJH2A@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before
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
	Peter Ujfalusi <peter.ujfalusi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:06=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 03, 2026 at 10:54:38AM -0700, James Hilliard wrote:
> > On Tue, Nov 3, 2026 at 10:34=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Nov 02, 2026 at 04:14:34PM -0700, James Hilliard wrote:
>
> ...
>
> > > > +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> > > > +{
> > > > +     struct uart_8250_dma *dma =3D container_of(work, struct uart_=
8250_dma, rx_flush_work);
> > > > +     struct uart_8250_port *p =3D dma->port;
> > > > +     unsigned int delay_us =3D USEC_PER_MSEC;
> > > > +     ktime_t start =3D ktime_get();
> > > > +     bool recover, retry, restore_rx;
> > > > +     bool warned =3D false;
> > > > +     int ret;
> > > > +
> > > > +     guard(serial8250_rpm)(p);
> > > > +
> > > > +     for (;;) {
> > > > +             scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > > +                     /* Shutdown cancels this work and drains both=
 DMA channels. */
> > > > +                     if (dma->shutting_down)
> > > > +                             return;
> > > > +                     /* Serialize reset with completion and shutdo=
wn notifications. */
> > > > +                     WRITE_ONCE(dma->rx_pause_wakeup, false);
> > > > +                     retry =3D dma->rx_pause_pending && !dma->rx_t=
erminating;
> > > > +                     if (retry) {
> > > > +                             ret =3D serial8250_rx_dma_try_flush(p=
);
> > > > +                             retry =3D dma->rx_pause_pending && !d=
ma->rx_terminating;
> > > > +                     }
> > > > +                     recover =3D dma->rx_err;
> > > > +             }
> > > > +             if (!retry)
> > > > +                     break;
> > > > +             if (!warned && ktime_ms_delta(ktime_get(), start) >=
=3D MSEC_PER_SEC) {
> > > > +                     dev_warn_ratelimited(p->port.dev,
> > > > +                                          "RX DMA pause stalled: %=
d; retaining transfer and retrying\n",
> > > > +                                          ret);
> > >
> > > _ratelimited() is a slop of AI without understanding the code. It mak=
es nonsense
> > > in combination with warned.
> >
> > The two controls have different scopes. warned is local to one invocati=
on
> > of the flush worker and prevents repeated warning attempts while that
> > flush remains stalled. A later flush starts with warned cleared again.
> >
> > The rate limit applies across worker invocations and UART ports. It lim=
its
> > messages from separate stalls, rather than repeated retries of the same
> > stall.
>
> How? The whole _ratelimited() is nonsense here.

dev_warn_ratelimited() uses a static ratelimit_state at the call site,
shared by all ports. The intent was to limit warning bursts across ports
and separate flushes, while warned only covers one flush.

>
> > > > +                     warned =3D true;
> > >
> > > Altogether NIH _once().
> >
> > dev_warn_once() uses a static flag at the call site, shared by all port=
s.
> > After the first warning, subsequent stalls would remain silent even aft=
er
> > recovery or reopening the port, including stalls on another UART.
> >
> > The intended behavior here is at most one warning attempt per prolonged
> > stall, while keeping later incidents diagnosable and limiting their
> > aggregate logging rate.
>
> Yes, so what the point to use _ratelimited()?

It was intended to limit warning bursts across multiple ports and
separate stalls, while warned prevented repeated messages for one
stalled flush.

I'll use dev_warn() with the per-flush warned flag and one-second
threshold instead. That keeps one warning per prolonged stall and lets
each port report its own failure independently.

>
> > > > +             }
> > > > +             /* Notifications also cover completion or shutdown be=
fore sleeping. */
> > > > +             wait_event_hrtimeout(dma->rx_pause_wait, READ_ONCE(dm=
a->rx_pause_wakeup),
> > > > +                                  ns_to_ktime(delay_us * NSEC_PER_=
USEC));
> > > > +             delay_us =3D min(delay_us * 2, USEC_PER_SEC);
> > > > +     }
> > > > +
> > > > +     if (recover) {
> > > > +             ret =3D dmaengine_terminate_sync(dma->rxchan);
> > > > +             if (ret) {
> > > > +                     /* Retain ownership and keep RX masked if DMA=
 cannot be stopped. */
> > > > +                     dev_err(p->port.dev, "failed to stop RX DMA: =
%d\n", ret);
> > > > +                     return;
> > > > +             }
> > > > +     } else {
> > > > +             dmaengine_synchronize(dma->rxchan);
> > > > +     }
> > > > +
> > > > +     scoped_guard(uart_port_lock_irqsave, &p->port) {
> > > > +             restore_rx =3D recover || dma->rx_pause_pending;
> > > > +             dma->rx_pause_pending =3D false;
> > > > +             dma->rx_terminating =3D false;
> > > > +             dma->rx_running =3D 0;
> > > > +             if (dma->shutting_down)
> > > > +                     return;
> > > > +
> > > > +             if (!restore_rx)
> > > > +                     return;
> > > > +
> > > > +             /* Apply the current enables, including any interveni=
ng stop_rx(). */
> > > > +             serial8250_out_IER(p, p->ier);
> > > > +     }
> > > > +     if (recover)
> > > > +             dev_warn(p->port.dev, "RX DMA failed, using PIO\n");
> > > >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
