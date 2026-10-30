Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380207;
	b=u6f42nRz0H2NxJY++Vzl4EimXwS9dWoF7BElhHpyU8t/ZWRq5sCldifbc5ivdQzARmzB
	 fCYThj/K9wQVq329vcYJbBx7vIhERRZs0Hq4oB0HMwNW3xr0hiwGzk/d3arAgVXeHhaOE
	 9iGM1vrhpFBy7OVFgDpqRR6Kj5VfvU0yIT7529BQZd0uJYmvALHAr1H+1GFU+W8UpOQ+h
	 5zUM1tVbAg1ejQrdWT9UkFb5WOHJXg605iEvsHUAzFHonx00hnHxHMyN1WQ3Jn/MllUp7
	 LbameBA1AzkqnrYvyeING60Q2PJiNYyegaTQYIE3QrTUgZ82WqsslzJXxoCh9DiTTqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
	b=g9D++zeI97OgociM/b6Sx5XSBQgt+RjjAjzWHnLxzoqXvPEQ/2frEUuAn+lV+F/E3KJt
	 sDPRNZ0jh2p25AtHMdo7m/bhYY5Y8hIueMI4Kyu0zTqhc+MXd+dtqLMDM+TBB+3f68J8F
	 l0Htjqf3rbnMh3841EWAhfw/tjDR+Xy5FfsMs+eRyeLSaU1j5cDvaCX2otZceTSxfjvvi
	 jPyWoziXOcqSrGEclEQ0rYqwsCE4Pdb6q70wOOPcm6KObqd8pTzEngVQExQJY5EnMeC91
	 pnQFAq4FDvSDrY+JF/QJ889HmQiX2fZrS9LugvJN2+PSXboC4Q3FMuw56KG5v9l/FOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DemFTicz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F51606A333
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F51606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DemFTicz
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7ccae9f1a9eso512403137.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 10:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380205; cv=none;
        d=google.com; s=arc-20260327;
        b=izSwAZx1UfjlPsJpyWiYoIsRMc1i3uuk9Mwo5UqMFPbxFQmEmejw57FTgQkqHnfQhS
         re8GQQBEPkpW20r7RDTYvZDJiHobqYyHRon2FJWTQ1tyf3Z6Jp9ZNIJFOrdMoWchNzgY
         o0u3FzrhhMU012R9yON34SzWI4tomvSOuLkow/n2okmf3Or6/bgZnDslZB431iIwA3SF
         kkWCFQucF52yS4dSEJfBPc05BMEO++b4KxRGIVtPOF5WgPm1Twno4H4Rf55aVrBnD6lI
         njNI4U3z1jg3M/ALDJaofvid4v7fjXO8OLaNiHTzSOzkoDKWZtMY9wL+oC7kOiokJM4d
         wo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        fh=zdGKu4RqFh0keKARoHQFvnHQHQtvu0BjLno0W3VfjSo=;
        b=Dcmc2EgCRQxrVvLgj00kU4PTGB47YMjmalWw3SqsbX6I5M0pEYs5enIFC/XqiUomQQ
         TdeOFrYnYA8MfIFryW64630k9ribcHJgRqIeCWR2KrG9Izvv1Pr9Xsuwwt8lYGfLqGjz
         IQ7S7HevBChf/3ic53mxbtwlR3e7ejXGNVqwOrnwdK0TtcD4PgOVqXNgpGiTSsKrLO4A
         afFsT1pBHyJer1q0eLo6cGHBg22ETKo2VjU9a9CAD3QbYWKv88IVU1lt/2XsrGBKAdRL
         CTqoFFZheoLZ11EXv8UP10D97Mlos3GPh+oLFT8BLa6BL23Aw6GD1EPnUZfURoq75rKR
         eyBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380205; x=1793985005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        b=DemFTicznQxVZXTaJqrmTwFkB0xJ6lEUFxHpwmNImLDy850dl7+VXftJcJQf7Onq5O
         GroBdy3enaQIkt31MQMYL1qfTE5b23BuM1znvZPmy59K9LdETYiFoN+XCv5PnMN0E7RE
         h9F2ahqPxfFqNHuUNl2NatAYWx+XTWbkiDXNm+BszIp135BOpEflxPMGfNp0sRR24gBb
         EAp0wR1izJev1c5hlE7pFNvxzpWXs3r4oVnrDBjENpjYIskLgv5RoE1dZUDJN+odYOXt
         uNQyqmnDQ9PsTUq5Hky3JNUqmbNzfQuM3gSh6Z6s5YfJesUYUf66PkH66EryscXXrFq9
         tBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380205; x=1793985005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upOYi42AukgDUPkY3CbfHszXdyIJTLIGDSDpKiK4vxs=;
        b=u9fjgAZcJ2TGEeYy0QV3IdkEWqyP8PJKoi2+6cqXaSHyRufpVCofDF00UTStm3Bdmm
         +B88OAaKmE77kbaeaRgcOPJEMiDkeIjY+ZIABY7Rc3j0Qffl0QCAxeUtuOR36ZCLO2wL
         CLr7pFGuymXAOfs3EeCSd8nJZULYsHa99RQ3GA0YxOtKq3f7gPcYDrhNfkymdtsSMl4n
         +lDDdExphqJCSVGSd+lH38kXSqN6/iyMI+Zzt+L/p7R8NT7OLveUj2Pg/eRdKk2QxCnE
         IONgcjeSg+JTkbGLREAlfUCedKg7Yw2rBiS3VIG85uiwldRTjPjEVJDVPoLc7po1PMmV
         LTRw==
X-Forwarded-Encrypted: i=1; AKwUvBzioRGT248NwN0Ldx1YjLideWq5OEUd+qyOjS6uAeVtyaTFb7BOP673r3OKIxcKbjUXAA2hoAm5G81RaxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfi8eesfGXsY3cargPZznWFbqT5w5rnv1ITMYfUw2wnsQL71Bm
	kO3lDrNrVBGpZGA0RfWUIw1kAHbc9fvUfjMiHhwB0ehlKgXDx7vxu6U1YKYwWmnMcGPWgIrQMhw
	jFT3OA7V3yS7bFDVXh3uTuqZiR7jND5kDtQsEjrk=
X-Gm-Gg: AYBFou1yZkYYzx3k1aeoAGLC0qb+kfIZ/1ikaY3EEov42LuFSKy/HOwHJwohFqlGLS5
	63p213NgIb3zyyiPMfpoIgvGu0dzTrR9S//k409bq1D10kLbpmCHGj+TbkJd6PVP1O/EG9+KbLo
	JkY9ofZIxFr6rsE4YEzPJnsRekB62YzD6FtNuSwLChPWlZVpAvmD5GokRVDxKpyCq7q90gNSBS8
	f/fh+lPQlps/JDTY60NWZqFmkcq0/daI9U6UM2b2qwJqSMWDI0GL1FKRZSsQKSQwBLphPXO37+e
	2jAFKvM+zkZ9kQWS1UHAwLYPd4av0oMNSKmKgMu9V2h3cB+7RNarhs/hxB6au/KrgwZ25jjM7A1
	auR3wrb/H7vYzJ7/o7cHBjxJm5oqF0pI/44xL1uEy6fah8cPzq0uYaBFW1CaBBLdfNXbW6NxqlC
	kMs9AgiIjqtbVZQ0X5rojlg16+gKMFXRciYy4u5usBZ9fB6kDw7Qj1b/LGt4GULLixzuFkZDZrN
	yWn/NnottRxc0SgYgj6S0hGxvmiJGk=
X-Received: by 2002:a67:e10d:0:b0:7cc:1a41:20fe with SMTP id
 ada2fe7eead31-7d072cae2c9mr1521484137.25.1793380205451; Fri, 30 Oct 2026
 10:10:05 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com>
 <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
 <auRl9ztbav4nHi7U@ashevche-desk.local>
In-Reply-To: <auRl9ztbav4nHi7U@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 30 Oct 2026 11:09:53 -0600
X-Gm-Features: AclHuK8FtznzJujmH4YHgrWNDCpi98ee8eK0vX_qbau-y3ULhcsZAztidkT31Us
Message-ID: <CADvTj4p8tjwdftg+H11ob0iaBZKxXrTdkSmhfZHjOYunm5tr9w@mail.gmail.com>
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

On Fri, Oct 30, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 11:19:59AM -0600, James Hilliard wrote:
> > On Thu, Oct 29, 2026 at 8:24=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 29, 2026 at 01:37:02AM -0600, James Hilliard wrote:
>
> ...
>
> > > > +     while (rx_ret || tx_ret) {
> > > > +             dev_err_ratelimited(p->port.dev,
> > > > +                                 "DMA termination failed: RX %d, T=
X %d; retrying\n",
> > > > +                                 rx_ret, tx_ret);
> > >
> > > > +             msleep(100);
> > >
> > > Huh?!
> > >
> > > > +             if (rx_ret)
> > > > +                     rx_ret =3D dmaengine_terminate_sync(dma->rxch=
an);
> > > > +             if (tx_ret)
> > > > +                     tx_ret =3D dmaengine_terminate_sync(dma->txch=
an);
> > > > +     }
> > >
> > > This is unacceptable. Sleeping is okay, but value should really match=
 the
> > > baudspeed and other parameters of the transfer.
> >
> > This sleep is backoff after dmaengine_terminate_sync() has returned
> > an error, rather than an estimate of UART transmission time. Each
> > retry asks the provider to stop the channel again; elapsed time is
> > never treated as evidence that the resources are safe to free.
> >
> > The particular 100 ms interval has no hardware-derived justification.
> > However, I don't yet see a sound way to derive the retry cadence from
> > baud rate either. RX can be waiting for input, TX can be held by flow
> > control, and callback retirement is a separate requirement from
> > moving bytes through the UART.
> >
> > Do you have a particular provider failure mode in mind where retrying
> > termination should follow the serial transfer timing? I'd like to
> > base the interval on the condition that can make termination succeed,
> > rather than substitute a wire-time estimate for an arbitrary delay.
>
> Termination of DMA sometimes require to clean up internal FIFOs and other=
 state
> machines. That's what happens on HW side. In the software waiting for too=
 much
> may lead to the very big undesired latencies. The value of 100ms sounds i=
nsane
> to me for the HSUART cases (megabaud range of speed). Also note, not ever=
y PCB
> design uses HW flow control, so this may be even worse for them.

The 100 ms interval can add unnecessary teardown latency if a failed
termination becomes retryable much sooner. There is no hardware-derived
justification for that particular value.

The FIFO/state-machine draining is part of the provider's stop sequence.
For example, DW performs its FIFO-empty polling inside
dwc_terminate_all(). If termination succeeds, this patch proceeds without
the retry sleep, regardless of baud rate. The sleep is only reached
after an error during DMA release, not during normal RX delivery.

Baud rate can influence how quickly a transmit FIFO drains, even without
flow control. However, the termination error does not tell 8250 whether
that drain is still progressing, how much remains, or whether the
controller needs a different recovery operation. That distinction matters
when choosing a retry interval: a shorter interval reduces the added
latency, but does not establish that retrying can recover the channel.

There is also a specific API detail here: dmaengine_terminate_sync()
returns immediately if device_terminate_all() fails, without reaching
dmaengine_synchronize(). Consequently, an error leaves callback draining
unconfirmed as well. The retry cadence can change, but resource release
still requires successful termination and synchronization.

>
> > Regardless of the retry interval, shutdown cannot release the buffers
> > until the provider establishes that DMA and its callbacks have stopped.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
