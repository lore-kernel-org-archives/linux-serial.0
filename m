Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D8264A6D
	for <linux-serial@vger.kernel.org>; Tue,  6 May 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527934; cv=none; b=HqwxLPn1JWdOgNxc0JRyVC4NhpThPkVAxDNEjaZTt4uB5gc1kpd1NVk+nYtDUiOUOekKZctTuMeTgRMnQN/qiXdOYd9/sXz9uTVA3Aztb/r38+Lg/8HcO7lK/Plne1MU7owSMmiarnPTHbTefO3/sieSuMBu3b1Wbxn7gaMg8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527934; c=relaxed/simple;
	bh=Wk/Bq9mVdtHfUb6e5vphF8QQcUvgAWhLMCFOzh4ICmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM4nJyXcuZtTyWq3yZS8+Atv4RhBty9w+GzHq57GU+mALMz6PuTE2i+/uI8ksKxzCkxjnprejMmWTKM6BGyKKlTz/Ebt36pAhAV/fNq/wayL0ZzO90T1LyW60dC9WFwQwHoSeqSixzgs7BZ0KPL70KOKTDLZPsGDkQfzQaFVCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RyMjEk7o; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RyMjEk7o"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60219a77334so2884441eaf.1
        for <linux-serial@vger.kernel.org>; Tue, 06 May 2025 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746527931; x=1747132731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdS0iTK9Vcceq32q3AIoLs3BITEBAqCSw/rcfLl4/ig=;
        b=RyMjEk7oolkhjx8uTiFzxtamcTFDt2I+ObhwQbgPleAuHrDuqxkyz4H3GocEaUkryr
         JIST5CGKJqyJV96AwG0wWrQrC6U9CahjR7jN46ldFKtS96+y9DXMK0eKK+SBtgK0CaAQ
         64qesqqAuFaTLWr662vY7crf8haa5ZJkN7bz0FeEyoNFkHdVbtAnSyNnJckMrpmwmiYG
         w9NhM1rIsB9oRLgDv1SvdR/gJU/cJ2vxiWm0qzB7yZj8LlHaoVdO2KKoZR7Ms0X12U5c
         nlSDQWN+1StqeBrJXXUx7IxjlNzT/xWRYVnXcwVxJceZ8X2ySFVBwq/fN5GsuPgaz1YY
         RieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746527931; x=1747132731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdS0iTK9Vcceq32q3AIoLs3BITEBAqCSw/rcfLl4/ig=;
        b=R1iVSHyrDz3sMvg10Wu99QzyMM7kTuIQmL7GS7sHBbDdUTLgCJpQ7t8tBCuqbf8Pg/
         mdMlj6Kv5/2Mpt2dihDj/P+ov4WJWzaV/r9qVv1tJ7qms7IFAlAcD4Dn4vu54p0HhuId
         FZURfUhcexWv2Ch92thJfA9UG5IqHsRcPL75jyCP1uhYeDiB4v4nbMl0HQk6fTpbCLG8
         RAIcpFbobwmgoh3P8GrUPgywf/s6sz3SI+5t+UIJZZAOQKRR4ZJjD/WJVgMFsNscgL1K
         LPgSrZw2AQ42X58V4c99GuIgGtZrFrqWqolSqFV6PZ3xubBEMZ3f6lISFqVVHNrAsi8B
         8KfA==
X-Forwarded-Encrypted: i=1; AJvYcCXghzzTMaQ+V7o9xH3oncRIo940UQPg8StIEhlL/nbelgm8mojXXd6iuZrJZECi8ULhSYiQAq5AG8EE27w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3eolYs61aNTQ8+9r4EXBkM6rTrKVrEShtech6Dyd1HSvMtTL
	5thF1iQ9n6vRwnqE9CDpkp6z6lpUEzHOo0YGUleQ+5fKileErpyFdmwbXEqXWG7nQt+WPgRTizS
	1VmApB3I42DhvOk893JU5ejxtnDZG6XX1glwFPg==
X-Gm-Gg: ASbGncuTj2Z300ii/2ob7+cOu3Vi5dl6MD02+GDsxJUhaMgjgdQi1EBDPsGRvWFzX8T
	J868O2svyum/mzAKaLtmMKG09rGlXQzpLsQs4kChSoR9y4JFvlbUdxzRogazIb/KOm/U1/TaYwC
	hoT2om+bUUmXymepnNBzLb8nF0FpvpRMntzayb8II=
X-Google-Smtp-Source: AGHT+IFe5sX85wLXHZU0uwT1FUfZjV33xZUKAlCSBaeAyBkJU0LzTwgNcod4sedmUZ83ZjcgMlPRAfBw4RfJmfMXvO0=
X-Received: by 2002:a05:6820:1a05:b0:602:5856:255c with SMTP id
 006d021491bc7-6080033603fmr6521304eaf.8.1746527931552; Tue, 06 May 2025
 03:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425062425.68761-1-cuiyunhui@bytedance.com>
 <20250425062425.68761-2-cuiyunhui@bytedance.com> <3a24d3ab-9567-4a0c-b904-4225ab4c489b@kernel.org>
In-Reply-To: <3a24d3ab-9567-4a0c-b904-4225ab4c489b@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 6 May 2025 18:38:40 +0800
X-Gm-Features: ATxdqUGpvfTUYGLZj5z6Xj8_RiBVFq2tQ6MuRyPbmhHPgeqmnqc00YWhK_0Qlzw
Message-ID: <CAEEQ3wnizUrMctT17krZNYUszT0n7mgW5cBHkMzOUF+j+ecMJA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/4] serial: 8250: introduce serial8250_discard_data()
To: Jiri Slaby <jirislaby@kernel.org>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi js,

On Fri, Apr 25, 2025 at 2:49=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 25. 04. 25, 8:24, Yunhui Cui wrote:
> > To prevent triggering PSLVERR, it is necessary to check whether the
> > UART_LSR_DR bit of UART_LSR is set before reading UART_RX.
> > Ensure atomicity of UART_LSR and UART_RX, put serial8250_discard_data()
> > under port->lock.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >   drivers/tty/serial/8250/8250.h      | 15 +++++++++++
> >   drivers/tty/serial/8250/8250_port.c | 42 ++++++++++++++--------------=
-
> >   2 files changed, 36 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8=
250.h
> > index b861585ca02a..5a106cf88207 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -162,6 +162,21 @@ static inline u16 serial_lsr_in(struct uart_8250_p=
ort *up)
> >       return lsr;
> >   }
> >
> > +/*
> > + * To avoid PSLVERR, check UART_LSR_DR in UART_LSR before
> > + * reading UART_RX.
> > + */
> > +static inline unsigned int serial8250_discard_data(struct uart_8250_po=
rt *up)
> > +{
> > +     u16 lsr;
>
> Is lsr really 16-bit?

The data book I have shows a 32 - bit width, but actually only the
lower 8 bits are valid. Using u16 is fine, and the current code all
uses u16 lsr.

>
> > +
> > +     lsr =3D serial_in(up, UART_LSR);
> > +     if (lsr & UART_LSR_DR)
> > +             return serial_in(up, UART_RX);
>
> Why does a discard function return a value at all?

Update in next version.

>
> > +
> > +     return 0;
> > +}
> > +
> >   /*
> >    * For the 16C950
> >    */
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index a913135d5217..802ac50357c0 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> ...
> > @@ -2137,25 +2136,21 @@ static void wait_for_xmitr(struct uart_8250_por=
t *up, int bits)
> >   static int serial8250_get_poll_char(struct uart_port *port)
> >   {
> >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > -     int status;
> > +     int status =3D NO_POLL_CHAR;
> >       u16 lsr;
> >
> >       serial8250_rpm_get(up);
> >
> > +     uart_port_lock_irqsave(port, &flags);
> >       lsr =3D serial_port_in(port, UART_LSR);
> > -
> > -     if (!(lsr & UART_LSR_DR)) {
> > -             status =3D NO_POLL_CHAR;
> > -             goto out;
> > -     }
> > -
> > -     status =3D serial_port_in(port, UART_RX);
> > +     if ((lsr & UART_LSR_DR))
>
> Too many parentheses.

Okay.

>
> > +             status =3D serial_port_in(port, UART_RX);
> > +     uart_port_unlock_irqrestore(port, flags);
>
> thanks,
> --
> js
> suse labs

Thanks,
Yunhui
