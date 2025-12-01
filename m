Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73126AC3
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553242; cv=none; b=I0IC5qlOBeHa72ZGqC5p5JtR07Co66Yf6KxWTEpqLZAQA0rgffDtbjYj7MKk8iQXUe/Iw23lmeX1fkC4fKjmPJ7rK7Bh4kiagNVJynkPdL+Co/0cb7MDrlOt4ZDzxCKdrB8c2nvGnZUgOJfO67cQ7wtSMNoyTk9kXAWx/079OFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553242; c=relaxed/simple;
	bh=5OkSm7FvrabtJy0gPysxYioIQTxWgkbYPVY4OzUXgNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/YWMTXLMZ0a/X5q9qCSq5jZIAByrVmbfajCOlXruW6f3KmW72aLdclWQN1/lycTes7r/IIhYLmBIW2ec7l0vrmFu5dVVqOUL8nP8a8xKxCnByJlWbPIcIp5R1cl2+dkESruXWiI293TB11xyL04XOPHzHDWp1nCPaLrFtKGlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un7Ee4ad; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un7Ee4ad"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso7086231a12.2
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764553239; x=1765158039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rAgLNYZiqU1X8w6VqWDQHjCVNL6UXHV/oi+vqyEtxg=;
        b=Un7Ee4adKtxjoAg3glJeoU6BC2UfK4OzoIW97zBmT0MqE3OmBfXQ6BaqQ4aqBfwS0Q
         1ETi/kymN4Py+ACQELcTMfhasOg32UuUcc+ISbXWTQ2+RQMJTPx+EvS8hKGtEvcfi/cN
         ANp5HrlhZFXsiuYKdTjPr6AxCZamHq2RDJZXoW1lhiVQMlwzv69yMvHFnNJXLAHRrIaU
         QUSxL17E12gCYVj4R3MX9iIFssjLkKhAu2+SplhmYXFM8vxkfHuRhCWIwv6TBn0iCm4k
         chmSCbgf6bOK5ZXU9UANYLqQvFFxMxlioC76E2BeRGV0WUIN4ud5cz1qijm1XibXk4Ar
         arkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764553239; x=1765158039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rAgLNYZiqU1X8w6VqWDQHjCVNL6UXHV/oi+vqyEtxg=;
        b=ek8NbzWOjJrbY9Fvnyap9Ug045+yp9/LfNFUeLzZagNptnAehNCl3ouGUh2nXLCFzw
         c0BKc5n1Rg+XXzF5E5yHKf5vdflnhbnEDNowPNUBiiogDbGxWrJd2UbrE9PBwBXVIEBi
         CKS61E7Jm4vsOLAJwOIiM3giVd4WQpoHTY0l/ja+J1eXvtr74v7LWsOaITt3390F1CWl
         1plkKyWZBVUR7Eov1v9NY6xTDdYsqIWlWiQEarYAkp7l3p+1r3FqI8bhFoTSGWwyMd6p
         U6ip8UFdsxVwscpyJSXelP0I3MHhaTFVBy+raYcZEYdvw5xUExXUxjmkizVvnuolcVxH
         LPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUiKtD1xxDPc1W69/F/2UJ8jBueEuy+iuw48RTwu6UUlklz2grvOhfftu12ckRbcny2+HP8M3S8ql4huP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0EyLzCWqfNDorHxdJ/z6+iU0Ol6aDXuGNLOG4L8GN8NDea/Y
	uZ2ap1l89DTtzetTfu/zUE7n5NebQGGRxbgDr7xg6Z+ciQvkUXobfdU4BbybE8ICMnD7TXXAeNv
	1QMffqvhLynOliTq5Z0E4x1YIOq8a2AM=
X-Gm-Gg: ASbGncu9LAVGSKGfw6tYmXg6IUBBlIrffvQHHLjWCADLXNWbvXEUi4LSHv0KDmiGpsk
	AxFSWRShlvrJVw2c36LWp2Lf68q3hH1cciUv6nkPhePZPr69CVAdWqvUbLR/psFnL7gA/Y4/oCH
	KcXLLmJFIJxnNKG/rGUwQH0r2+bwr8YbmyykGoe5F8YmEQjmDIRieZI/X4seMfWGdJTejSO/7qa
	ml8MbBj7LGYs/6dXrvpjWUH8FJWFaTCc7l0OeRRSjDX9w9ysryG9e5TvKJ/6UF0DE0qhClD6i3u
	FdwrsCOHB+cPds4npSsvDnqj+T6UW1eKgI2KD4F8rl5mGgUeyVFsvJb0DuQDdO6/xPWA3dojK7I
	tL5tfYw==
X-Google-Smtp-Source: AGHT+IGaPCcubI6rIg30FDEMfpG8+BxTSxLJtNKatKdPwcG+2xw+C6PXPm8iCEot+99wl9EkBHIpgnEp+V7x93xh6/k=
X-Received: by 2002:a17:907:1c28:b0:b73:3ced:2f59 with SMTP id
 a640c23a62f3a-b76715dcc1bmr4214399466b.27.1764553238853; Sun, 30 Nov 2025
 17:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-15-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-15-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:40:02 +0200
X-Gm-Features: AWmQ_blP9WS0pwpu_TnxB3AZsVmL7HcqwBuCvD1AzgAUFJuz0bcHTP1462fPegY
Message-ID: <CAHp75Ve7XuqvmCK0EpKqFptLNTVH5x0=inwkO6BNVx9hsaHYYw@mail.gmail.com>
Subject: Re: [PATCH v1 14/31] serial: 8250_mxpcie: add custom handle_irq()
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:44=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Add a custom handle_irq() for 8250_mxpcie based on serial8250_handle_irq(=
),
> removing PM wakeup and DMA handling that are not needed.
>
> This prepares for future adjustments to RX and TX behavior specific to
> Moxa MUEx50 UART.

...

> +static int mxpcie8250_handle_irq(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       bool skip_rx =3D false;
> +       unsigned long flags;
> +       u16 lsr;
> +       u8 iir;
> +
> +       iir =3D serial_in(up, UART_IIR);

> +

Unneeded blank line.

> +       if (iir & UART_IIR_NO_INT)
> +               return 0;
> +
> +       uart_port_lock_irqsave(port, &flags);
> +
> +       lsr =3D serial_lsr_in(up);

> +

Ditto.

> +       if (!(lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS)) &&
> +           (port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)) &&
> +           !(port->read_status_mask & UART_LSR_DR))
> +               skip_rx =3D true;
> +
> +       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
> +               lsr =3D serial8250_rx_chars(up, lsr);

Again, perhaps it's better to split the above to a few if-return
conditionals in a local helper.

> +       serial8250_modem_status(up);
> +
> +       if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
> +               serial8250_tx_chars(up);
> +
> +       uart_unlock_and_check_sysrq_irqrestore(port, flags);
> +
> +       return 1;
> +}


--=20
With Best Regards,
Andy Shevchenko
