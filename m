Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294055;
	b=ohOP0Sz9BFfIX/lNWK7JH1z6dDO4FgRRKgWzUNTeWffMgIVcM3hWNA/c5dabnYE8JOsA
	 ksUVqvPWc7TuI1k+YxYwlv9HuaD0gfnYoAsugV9qK2lfvGxE2uFsWf+VUIsgli+h6+JXB
	 iQcvFpI0Z6esjKnmXt0TZmmqZqx/kXy+bVVsdkG/ScgB7ZElUAfng1CdeQ7Df7aqPJpJd
	 WE2pnmr2rRN7ZthiHXeAo4kv2/CrxhybRK6VvsFWTRRF2uI7VEPxnR3769jhB6jtIJQxA
	 SQHlNk3Ss8dbm/ByPuJOlQq2l64RVEnddnfGMEY1ESxBzaID+WkAPNVIYwcYgt7ok4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
	b=qxPurGhDA1m8XkrN2glSd1LTKv9G6hQYa/EMgxmn4hUo/cqhwbRyG27MIdsfjypQl4e2
	 yCycEF6vTiyXMnAsxqSyzmE732gMlW3XGNViJvBphNp4jE6gFjlHXFh5p0I3tpDL0JD+y
	 u+RKTvXPujBaaFcUBeqSmeoXV9mdYTb0oVHHCd85gw/6ND7ray5nMn1ntJuFDstQ+W2XQ
	 K/MAhgHtXHZUDKUk567HfkYSf7i6jz6bS++3HdAWIO1EAqS2HH9XOzGUlO3z8CtWdVRdh
	 IurG6MJn0+u3aoDT/nQ1Zd0LlSmSYfXdIBZZk824YFKAB3lg/S9R6pnYWfNICGCYZRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zni3Q5Gx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFB606A321
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 17:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DBFB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zni3Q5Gx
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b413b0a974so3605333a12.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 10:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294049; cv=none;
        d=google.com; s=arc-20260327;
        b=nyCUDwnNF/QZRC7PNSZ6JdBbz6krqJJaj91so9LSh15QaRdSoTEBscNaNdyNzNtHzr
         KviJvkjnGRkdd5lbLV8KiKpOLkslY3N1p8uLOq2YbdG/INS+nKZEHz2jvTJOqQzdnw/C
         kw7dYBPCJ0FltFiBk91OGunpgJ7VxvQKFXIqQ1mkQXIxkfKj0DqEIuomZiAh4oqOh4GK
         oQ8Ty4yNENpe1B2dE3gThJowEnk6DKQx12FGg2pl4QIZPV6HP8kgZEp/SZre5mYYoDV3
         LpbNKHxZ9IvU1PY/+Tmb2WzEDXY5FdcML0xRIVVA2hrsfYfYP6fJ5MQGxt80EpQaQhF3
         SJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        fh=HfJNoVkno/WPTRdIr8yKfDUqOH8+O/2iakyGsv4xjQM=;
        b=cT/HUUW6luHeAENaPrM9M6kbQQ2splimgXiUs2gacT2daB6o0c1kIeqQ1/zkxd4dJH
         uIpgkURVQfn5F3qsnVvKlW8Lm8QjCWTDp7EwAYdnqwiYuL9Yrpp1PMME1WOg7FJaZtq0
         B/T8FShpGmoe7Nez7BzUEIgg33HwIfT9mKuDqmzPn0qkaeJBAi+BAT3l1IHJ9JMiyVAf
         5B17n5IzwFwX0pHuQ+TRk3TZsRb2VeFwDbMmb/S+rodEiLZy27VSOq5x+H0aqRWikFeX
         dVuW1aEnupsTypRwbFexSNKgN0wiaHu75gItMRxVWe3awyNdiZbqv/OtlYNpI6fezHG1
         y+/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294049; x=1793898849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        b=zni3Q5Gx4fdEB/c6OKot7rINlo1KgjEo+W++gLI3PzRc0rbIrQGeeyVoXJAnM2Qe/z
         fSNdXdDZ3TeF4/w08c4oWi0H1g/qsXCYW2lK0c6Fw8x6Bb8+fa9aI8wlPj2dQ3GtZRL9
         s8lBD4bBX9SkQnzvVpmpaSuZONmPNQcxLTTwhSFacM6nFomIUUFK9xBhJsP1TX7v5dyf
         TQRgiNBTg0A8tA5chpFawj6byoRME/usf0sAbINbkgegmRLFOu4GAlXJs4yWPVX4mVoP
         K3WxPN+v3jQQ086W9iMGjpiuxoiuOGVYjCxMlEyeEXek7dJc8vbSTG8lfWYzDYMKktr2
         SPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294049; x=1793898849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTbT3tgSxeUnwmRhmxtw1LLZfXKECJjTK/sp07zcT8c=;
        b=AJF4INKDR4piy8L5jNpbXaRceP2FseIJG8k0iLVyLk8dDSzt5FgB1QafXgy5G/+9pS
         tyrcjdFBy6D+OcPqsGjTnk3RqeV5515DY1GnFSaIZLTekbY8Wds7F/uUn85H3LoYDxJD
         Uw0eCPlVLdVHVMhk+mMqV9+d8sfgf284Bik9IKj8nhDqUMlkTNwlQ6c+Pq2SZB8PCUSh
         LCgHOG0tW5BSIHDqa6xwYuWuQpyr6zovrBQJVwcik9GmKUYeSBY6NU8owjE2QMH89+Cw
         FonlY1W6OgiTB11Ft/oEV3oFW1QsvzlgIXplXTxsDXARc9ib+RehXQMDL11xb6jmA9mG
         hnCQ==
X-Forwarded-Encrypted: i=1; AKwUvByaBO9YIvPN+XVLD0IbVUJBUJp7gsdMHUs+wXi9rvLExB48gYp3L1u58yqIRL5qNE1/YUgForNBiDmp/Vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqcX9HiWZZoXeja/PJj2LLbJ0qYA8W554h89LS9J/WNbuPMwSD
	hRqOobvvtYAJKy7TvIlmO4subtZkBEQT2cck0g1DomC1ZPqjSRUiE3KiWE9kzhEdDReZThMFKhv
	IIKmBMkFfpz6GZSrk8/vq21KcH2I7E8k=
X-Gm-Gg: AYBFou3ZS68BoNYQ/2E8Yw6wYnOUvovCxi4wHif4r7OHRir8a6E4XRv1oeLeYRpunqZ
	Wf4UiWraC51h71plbmQ4NHWTRl7rbgULEWGjr2w64zGhH9vblVI0Zb3iGh0+YrkWyT8nDm12eac
	/ZaXORATD3YRO0oHemazOtfFreo5NybPPj4o03rWpsYLDCnclRZ+we9iNLY7EYqatOwDXfSi4cl
	M36b1rr3gLw5oz6DU5YwltCqepVGpiAp8a/jzEW8Ov4S5Lvw7hRu1WDZQQNYIIl7yM+HDkfcouG
	9UfUB8YovuXTko4VsNImuDYSudLHdD3Fbw0IlRW/XIeAS2q74BxQ7/K6JNS6kXOrNxo4xyw8JK1
	Xlee/HSpJy/vrhVfSAhbL14ENqJXSgnzaFue+ScspbWwt4Ohr0jeVKxOXK3AjpPgdB00tctli2L
	kY07YprmNE3mHDmR1uaFdXZlOmkV5WE3t1bRZ7y22FCcCNk8kjA/+idwbz62pePoLXBShkf2lNy
	2/3aCpHTseIXf5GlRzGkjUx4JzNbw==
X-Received: by 2002:a05:6402:1cc4:b0:6aa:9830:aa21 with SMTP id
 4fb4d7f45d1cf-6b49cb8eabemr4436038a12.39.1793294048534; Thu, 29 Oct 2026
 10:14:08 -0700 (PDT)
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
 <20261029-submit-serial-8250-dma-cancel-v1-v8-2-3fd56ba352ed@gmail.com> <auNVk_Y8iiAXyFa3@ashevche-desk.local>
In-Reply-To: <auNVk_Y8iiAXyFa3@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:13:56 -0600
X-Gm-Features: AclHuK8vSM1CWTDsGeWZ16QtCofwiUc2xcHxHUC_tVZ5DI3qrKZF21jWZD2zp04
Message-ID: <CADvTj4pwVF7u-6z3RUiHWGyG3MZGFU2WkytMRh0G16pdFwaotQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] serial: serialize asynchronous write wakeups with
 the port lock
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

On Thu, Oct 29, 2026 at 8:18=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:36:58AM -0600, James Hilliard wrote:
> > uart_write_wakeup() expects the UART port lock to be held. Several work=
er,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
> >
> > Take the port lock around these notifications or their transmit helper.
> > Keep sleeping SPI and regmap accesses outside the locked region, and ke=
ep
> > the FSL LPUART completion lock held through its wakeup. Acquire the por=
t
> > lock after releasing private channel locks to preserve the ordering use=
d
> > by UART callbacks. In the MUX timer, publish available FIFO space under
> > the port lock and keep the hardware FIFO-drain wait outside it.
> >
> > Use IRQ-safe locking in the Atmel RX and TX tasklets and SB1250 termios
> > path, since their interrupt handlers now acquire the same port lock.
> > Preserve the caller's interrupt state when releasing those locks.
> >
> > On SB1250, lock modem-state updates after reading and filtering the cha=
nge
> > status, and wake modem-status waiters after unlocking. Take the TX lock
> > inside its service routine so RX-only interrupts need no acquisition.
> > Keep that lock across x_char handling, FIFO consumption and the decisio=
n
> > to mask TX interrupts: a writer must not enqueue data and enable TX bet=
ween
> > the empty-FIFO check and the interrupt-mask write. Each TX invocation s=
ends
> > at most one character.
> >
> > Serialize CLPS711x TX servicing and its interrupt-enable state with the
> > port lock. Disable TX interrupts without waiting in stop_tx(), since a
> > threaded handler may need that same lock. Have an already queued handle=
r
> > leave stopped output untouched, and drain it outside the lock during
> > shutdown before the transmit FIFO can be released.
> >
> > SCCNXP handles interrupts under a controller lock which its UART callba=
cks
> > acquire with the port lock already held. Collect the ports needing wake=
ups
> > in an unsigned long bitmap while servicing the controller, then release
> > that lock before visiting the set bits, taking each port lock and
> > rechecking the wakeup threshold. Removal drains the IRQ or timer before
> > unregistering the ports.
> >
> > This serializes write notifications with port-locked serial-core state
> > changes, allowing readiness and transmit-storage reservations to gate t=
he
> > notification without a check-versus-shutdown race.
> >
> > Cover DZ TX servicing and JSM Classic modem notifications as well. On
> > DECstation ZS, acquire the port lock before the SCC lock and notify wri=
ters
> > after releasing the SCC lock. Defer normal TX restart after console out=
put
> > to a worker, since console output can already run under the port lock.
> > Check transmitter readiness before consuming another character and drai=
n
> > the restart worker during shutdown and removal. Release Lantiq's hardwa=
re
> > lock through the transmit helper's completion hook before notifying the
> > line discipline.
>
> ...
>
> > static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
>
> >       struct uart_port *port =3D dev_id;
> >       u8 ch;
> >
> > +     guard(uart_port_lock_irqsave)(port);
>
> Why _irqsave?

For serial21285_tx_chars(), a plain uart_port_lock guard is sufficient.
It is only registered as an IRQ handler; saving and restoring the IRQ
state adds no protection on the hard-IRQ path. The necessary change
here is acquiring the port lock.

>
> >       uart_port_tx_limited(port, ch, 256,
> >               !(*CSR_UARTFLG & 0x20),
> >               *CSR_UARTDR =3D ch,
>
> ...
>
> Same Q everywhere (it might be legit in some cases,
> it might be too strong in others).

The other sites have different calling contexts. Workers and tasklets
can share the lock with a hard IRQ, and some helpers have callers with
different incoming IRQ states. Those need different treatment from
hard-IRQ-only handlers.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
