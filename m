Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4E3BBF2
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553999; cv=none; b=ndq69mW3a0fNc6VmO2bZOh+j+tXaoKARokRkSknIhQjFAJGylXGmZYufrRMLjs69TzADY1dKADY92Jkzh6L1ro81gpAdaG5elR5VSZY2JGKkekX+3q23E7z05XqsCJm539NTFnY8I7B1aRIRTB3Fs9aQ4cQ59IJdyMgWJvXRnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553999; c=relaxed/simple;
	bh=aJelZ/+u3R8rF6TfJomJMXB8RkkOMPOljbfl6Mzgdpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e86JsbPBxnsBSEK4yYzgoNq0KXzzCPhYzmmmgLjHdWILc9q0MAnCFZy/P9oVuyilPdDjMyvlFsc2VDSAk17YeFIxt30i4fu+a81mFsHwLdeXhCM1jRd1RcQINVdJs9oUEOGlnIzR/VrtnFwyviE0lFTLvyUD9ZoPg7DWgk6byYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpgunRF3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpgunRF3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso6971507a12.0
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764553996; x=1765158796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq9qrrpWNvlwRhmzPTpRqKkWZziuvHfMMFLfzK7AvtM=;
        b=XpgunRF3bYXCqo8+hFU4zmYOM3nOUMV+Z3pbMMCH6P8Ag9rXHK7VlHSLfY8bq2kJYt
         Omsn+7RGetme8ausm18utosRklAe6kjI6MBtPvTjM5K0NUL5k3s6SP+OIoWKNZStLxcM
         wa9r4Ns/6MEOiOUFx7JE6PTVEa/yYlkmz0wEeU4P1vsQqgaAsvsjk4O0LuzTeBFmd9mq
         BrFhqYKrIm/S0sD5tlk+c7BhjBwLOk+cfH6t03Rn3/zsiDcAWBLecj3TUt5qqmZmOQe4
         q5zPg9UoaLn85iOfqBT7wRWWhLWDG4PRY/rLrnA+9V2Mm2iGZ1YYsSoRVPo2kUyiy0U6
         4/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764553996; x=1765158796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uq9qrrpWNvlwRhmzPTpRqKkWZziuvHfMMFLfzK7AvtM=;
        b=SQfrQ9Y5qWiE3PFwWrG3FB2HOj6hVCfen5ulsVYcdlHCv3elaGgfSe5LfztHx3nkVz
         sZdexhn3spXIfILRLbvsIBHhb3zjdgtYZZ6wgCklptQqrvNPYKMsdZ8t/hAYuU8reL5j
         z7X4iDpZoBaX5++W4+25MHDUW+ofmYLWyLt0F7S+2qvCbmmRHxpJcwBfNXBS2jPQR7V3
         A9f9vEHZlMEIxELl39Ljq8KxgRLiP1/yrYYzSclhAQUa/wVwLzKUrwYi5gfQvObeXHFW
         4puxx1qdSzSmZBF1HfkQmmPh+szwAsZvDMNtz0MldpG/lA8U0rdLTYRC0X1izV4lIHZM
         GIlg==
X-Forwarded-Encrypted: i=1; AJvYcCWD3X1pZV2fDbeQb0NtPxCqz6FxWLZHOe04c9AEeBwcNlLpGk8ijiO+dnBEaHxlTztZ93tlg7ghkXlll8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9ivROMddw3ep3tXPRpC4pZyLgHRQ+TINaBg27MAZjYkdYQIN
	YYVPS3pM4EEWeWymUTWj2t0VNADlNmbp+U6qh5iYQEZWBXFyVpY403D7zvcnfH+2YE/SjPb5bX9
	ZG3G6tw57KlrShBxonebAbsWNA8ceUvATj2PRB4BhhQ==
X-Gm-Gg: ASbGncvE301/4Wcv0NwDKtXTU+jpEOYRUOWHWMoZJZGBXnPI7p5xiQSwdX4OwvWD8fP
	zXeEMCmMd34Z2JUPYyWa8UMzlEGbuVdkLDH+zKeGkv3TCPo+mNCfaK46j0xZeUKInVT7LakEH8s
	nnL+9gsVuHwpXitKXC33yDqNC+9HF1yOsgu9u5kJlSpPhgxzXh/NS6+t41S1t0jT61jtb/XtMOr
	kzu3WUAgrMeAnGPWpVO5x508sbPgfbAKUBKV/sqszX5MesLW7tdWTtLTCSADb67AQf/CSiWDpFU
	yVsiwhwHJiv4kKwF+jR+bJOY1+KtlswCBvpUv+jFbzLbimo7dPvF1NgjHxMHKdWiRRdOphA=
X-Google-Smtp-Source: AGHT+IGillXULq8zm4QMTZn7Zxy0qmkgBF356UlXWsZ12nlTABIBJfevjfxGWjX7NP2HhOjMBrSCAuO8UyshnF6hKII=
X-Received: by 2002:a17:907:a05:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b76d8ccf5e3mr2378755366b.18.1764553996242; Sun, 30 Nov 2025
 17:53:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-17-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-17-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:52:39 +0200
X-Gm-Features: AWmQ_bndolT0QIQ-oeZ_XLFeXoXO8SHZVuIGZubUyrpTLHx9rXWPyvT6tqUs440
Message-ID: <CAHp75VfW0DJMw+7Fh5ty_uy9=c50-Cb7maRcFYuA7S8JT3=nLw@mail.gmail.com>
Subject: Re: [PATCH v1 16/31] serial: 8250_mxpcie: optimize Tx using
 memory-mapped FIFO access
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Add mxpcie8250_tx_chars() to transmit data via memory-mapped FIFO
> access, using the UART-specific Tx FIFO counter and buffer region.
>
> This replaces serial8250_tx_chars() to reduce per-byte I/O operations
> and improve transmit throughput on Moxa PCIe UART devices.

...

> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
> +{
> +       struct uart_port *port =3D &up->port;
> +       struct tty_port *tport =3D &port->state->port;
> +       unsigned int count, i;
> +       unsigned char c;
> +
> +       if (port->x_char) {
> +               uart_xchar_out(port, UART_TX);
> +               return;
> +       }
> +       if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
> +               port->ops->stop_tx(port);
> +               return;
> +       }

> +       count =3D kfifo_len(&tport->xmit_fifo);
> +       count =3D min(count, port->fifosize - serial_in(up, MOXA_PUART_TX=
_FIFO_CNT));

Perhaps

  unsigned int i, count, txsize;
  ...
  txsize =3D serial_in(up, MOXA_PUART_TX_FIFO_CNT);
  count =3D min(kfifo_len(...), fifosize - txsize);

?

> +       for (i =3D 0; i < count; ++i) {
> +               if (!uart_fifo_get(port, &c))
> +                       break;

> +               *(port->membase + MOXA_PUART_TX_FIFO_MEM + i) =3D c;

This is interesting... Why can't the proper IO accessors be used?

> +       }
> +       if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
> +               uart_write_wakeup(port);
> +
> +       if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UAR=
T_CAP_RPM))
> +               port->ops->stop_tx(port);
> +}

--=20
With Best Regards,
Andy Shevchenko
