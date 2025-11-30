Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B261D47B4
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764523098; cv=none; b=JZL9vtrH1Hjt0e6RppQMX+Gt/KQJM/1cqDfKFTuakcCJtG/H2mwjPZaC5sN6fKbv/W/ijYuVYBT3mcTnwQWDuBE9Kw185WX9HPAELCFJsmLq4q0lcqemjAruUHL2ItiG15dRB8NEv0KOt2zKzRxmNdEYC3OIV+TUeO71iGZ9I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764523098; c=relaxed/simple;
	bh=wLMMz4DUUSdjvsOoSM5t4bXm8k0Iip9Mw718z4y3W2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sX4zBlYdVGDxVEJ7L2KPP6cU1AtZTFZr4GYeHVF23bGdZPLKskMknZsi2MU+Xc3CMzV1JD9wapLMrSZ29MaSI+toQBCfKszcS0DwI6i+GdLpniWgboniOb+N7ZbtUmc/aIHVEhs1pAewdKCiVhFCi6PAuaqHt0X+ehXrst5ZW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9Q8YmU5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Q8YmU5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7373fba6d1so543288066b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764523095; x=1765127895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN4H6f28ilxdDDRCz0iR5oEKy3WeFjraCxWP9yQfwDo=;
        b=L9Q8YmU5fLW2z145vZWaWofRB67vvtG6g0aJpij2o4jkSvTAIWeo54o7pxRNssms7R
         7zMK+G3voqzvdQo/xdE9jastScypD4roUJmmJAyN235CnbudC/f2Mxft6ZGWuf5A2XXu
         EyamCBEpWDSemLktdfpuLhj3IacQEYaUNgxSGeNc0h/CQHW9iDNvP0zRJ4dBFbt0HX/O
         0hbccUTvPvMM39VBCGbO/O851eejrgpuweE+BEHlqfsIaoA8kd9+myzTXbtNojP02Stp
         27r3Rm0jcY5U60K6oJD0wdLDrp5IWrqUAC/4OYeE1fMG8hUPFwDA8goKtfi1FLJZM+2V
         CPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764523095; x=1765127895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zN4H6f28ilxdDDRCz0iR5oEKy3WeFjraCxWP9yQfwDo=;
        b=De4pEjhA/i17megjEctPc7m1ELA4waJUJNBo9Eb5AQBoCHzL5BuoNpjzN92SCmJt3e
         kDVK5dJzF8MufqDvD1xiKWq95iiR3FZ4aac/cERe3kSZ+ddDaVJpyRhJMAQTjSmZGQ2Q
         lO1GKAFGE3lwGGn+1bdYKN7JsqL8KnltdhcyVrTOUfj5bVnn3TC1wSO4GKHr1yq/2yrR
         d70e6vlhWxfhSN5waS1jh0Z7lkWDlp+tsaCF/dV6F3Wga3uzZaft1pHCIuw4TNcym5+S
         VNs4LDKoAxCRFKn7Xxks2VR/43Uonyx0tsK8ezfwpxtXQatJP3+tVNEZksjDJcef/th4
         r9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2tlVXjq5jx/fPXkfs/JCRyO8zcjBGSBGusgcCHMGQhYhlnzSnSIVhPkwGt6L/gZgHWG6/BrMqvfLHKJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1f1zJoBnbNdaMHgKA1MGLntMFjRnGmNiWHqOBht1/TR39llO7
	59HKYGxlMwIHVNNSFHhYcwAsqtBBDyh3oF9VisTlA42tI0O61tigR+l5OY7Pl4woXkXIi5LKD2S
	L/YKg49Y8mc+yO5aHrfBCc/sQ+YVX/IU=
X-Gm-Gg: ASbGncuxq4mEmdg3Ehiblzpr8msEMoDBIdUS2g8abpinJlC9kYaAxqfFj82vqPXWBLg
	ai3yHgYbbPOGSWEL6NfLarr42rFYWHd38mtvXpcPBldqi2+ZqKnMHZYt1L7fGumVG+Mg8+6dZKn
	HhOUTSYE0/dePDTJKp3r1fSntVB5OgJCI1HEZvLvrN7QvfO732mpII4zMGKX90bpne8uMEMLC+9
	wBeAPv+U82ncW0271FnUapsgXWrSoVbDii5+R75oGfs8LIrsB9DYS0gKz+xHpAAn5LRsoMxVIpA
	MP/a/p9ZfxdMlabwb2D11omBfEZ9IO+MAlBxnMnlruXwhx5il7tFe8Q6l4fbQGveiGRZ3WRD9i9
	lTuL2/gA=
X-Google-Smtp-Source: AGHT+IEIIKqPAIlcOSERfxxUcRQekZ9/e9YARPKIcD03fAPo7qqvT9+dwi1SJR5MGQkyc1lgqc4e03FROYScsEKDjf8=
X-Received: by 2002:a17:906:a191:b0:b76:7f64:77a5 with SMTP id
 a640c23a62f3a-b767f64a792mr2936471666b.20.1764523094620; Sun, 30 Nov 2025
 09:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-5-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-5-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:17:38 +0200
X-Gm-Features: AWmQ_bkfQTpVdU8fv3vpuNbVIuXDxB33RJiQhYhVU8fkTI-682CrqaKPH1OWqIo
Message-ID: <CAHp75VfwR+FWGf3e8JJssJ6ori9vZg+Nou5xOk8MpZ2CccKNLQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/31] serial: 8250_mxupci: enable auto RTS/CTS flow control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Implement a custom set_termios() to configure RTS/CTS hardware flow
> control. When CRTSCTS is enabled in termios, the UART_MCR[5] AFE (Auto
> Flow Control Enable) bit is set to allow automatic RTS/CTS signaling.

...

> +static void mxupci8250_set_termios(struct uart_port *port, struct ktermi=
os *new,
> +                                  const struct ktermios *old)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       struct tty_struct *tty =3D port->state->port.tty;
> +       unsigned int cflag =3D tty->termios.c_cflag;
> +
> +       serial8250_do_set_termios(port, new, old);
> +
> +       up->port.status &=3D ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
> +
> +       up->mcr &=3D ~UART_MCR_AFE;
> +
> +       if (cflag & CRTSCTS) {
> +               up->mcr |=3D (UART_MCR_AFE | UART_MCR_RTS);
> +               up->port.status |=3D (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
> +       }
> +       serial_out(up, UART_MCR, up->mcr);
> +}

Here I have a d=C3=A9j=C3=A0 vu feeling, i.e. some other drivers may also d=
o the
same or very similar steps to enable it (8250_dw?). Can we create a
helper for all of them? And if this is the case, perhaps add it to
8250_pcilib.c?

--=20
With Best Regards,
Andy Shevchenko
