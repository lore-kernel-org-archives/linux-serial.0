Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3A27055F
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764523242; cv=none; b=tAEgxDRh5XqrPZt0WOHA7cDCTxNj9CEfLJQm5okqEjkih3ERBCoB2Dqs8nWFieLleMepDu76cQ9f0kOxhCZkV7RNxjyRPciVS0BMorEsFzYCLOC7NEKI6UYaE599+jNoJQesCnQo01ntXCfKhBOjD9JSTRv/UOnu5SMC4fAqy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764523242; c=relaxed/simple;
	bh=6AZD8s/6Fj3/LjrlyUwKGQ443+wkPOIH6tsrFzYjJA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYC840+WmPIc2SXiB5DwTeEnx21KMOnRYUTnqZ+N2T4WiMUUVof1y2KKjTlPQa49TYI6HB1hikpgXkhUL1fCUoaVJlNzsHG8JOeDoJN1koZ5fFpkOG+P0wZ8qVMS6jHW9m6pgk1WIOKCBkjLtCg0WcrwlTHeizUs058MkfM2xII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azZ/VFwX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azZ/VFwX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso6375481a12.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764523239; x=1765128039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XGg/9mUmxbfEVhBy4JapAmnsmDTfCKnkBEAyKCNSl4=;
        b=azZ/VFwXhGJci7TQEVi43sekYeZTfAZJ3MqfM8WdE+oWCxl+C+6PRQr078da6objgW
         f15DuhCHwDCDTomk6+fZEATSjm0F1UoHO1GL3nHZ0YAbXptYCLfIJl2s89WASMz+O+l1
         kYpmaRjbm255d7tmWP/8o0GBPDwNSDPbjVR4sggLYJ/oKfX3qSm7Wb4gtR4tkUFGKDO9
         Ad1PsFpmTdk9LtmdX9Gsj4lISxEJDenlZvYpXQGSIyzoHOgV/6zsPyMuwZpLES6QbQJW
         paHukVfwoOn9CIgY77llnjGhPg/2UhCn45DyokaKY8fA07PHAwF31FS1CF4m9hqV/Wrp
         RZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764523239; x=1765128039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XGg/9mUmxbfEVhBy4JapAmnsmDTfCKnkBEAyKCNSl4=;
        b=DKJQJdCZKEXpeaWTxSrcTT+fXGCV7pEHL9sQEQkgznGF05FJPFkrLLZiiKDz7W/ajW
         CE9/Hx2+lG9JJybNEjgzveDDkPPkevztjRuRt855g3208uXTI7SpBVY2bmjFAVDRXg8C
         ivbysQZXwwIJDJksBdGx2HWcJwI48jcyJ2BVQG18BZ1JzUihwowK9MOVNk6d1lqCk2+f
         V6NyTMbUDwRE5A+AMeHRpPAa5RUjdvauPc4GHXNGksW46iRPH2/1qsGvCUzUyXFP6WvW
         OMM5qzX2aaARFyyy9KoK9oFkFzM7gRKb+eAUR3kUYHNm9y0Zm0gjG5ZckZD89LPyp5cU
         YIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQO/vYD09be00MFjSlWv/d1YEaSygRhqmeMdbwUlJyJuMBTSqQ35DZxfMbaK8mEqdPSxEC+HVEsSJCIEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNB2gzthSaPeJnaIWMe8TW3YJky2GyAHyQnUGOw0LRi364j4DC
	Dno6T73PZvN3znYynE44v+ZR4MBSS7hBqv33RzMZJNbZVrxGyUuxKvsIa59YoIOsxFN8sapJz49
	vU0tfWKV4Iiz59nc4L7nBsndEo0WPxNM=
X-Gm-Gg: ASbGnctzaAloHowptbQBdOgMsODT3Wfs6kd177J7J8uqyowiCy6E4/AVxQmMwFGjJ9y
	dMcGvZMCfbwE6DipCZiS4cCZUAuo1D5s7bp6TBygCgXnvjqqzZ+JZujvvFjQuMUc05UU7tk/rJE
	mkHo10ogTlcra2cUZi9nrwt0jVOIhCGvqZIt/x67AhzXiM2jpgOkQiCPhWQCd36dHVvvXgpYGzr
	pb/XmkvZ6zl1wwtq6UIyN4ZIlgTv5p4Jt/aa3IEE+6JjIJjihdion1v+A5craaxq7Mo+Dd8FEeB
	vTCLJH7QWwcI3NUuCqPkSnUpSUF65v+4NrZJDJtRvcrVAgIiOB6ER/17L4kr2zltYFQMxXof7h1
	HuaaHDLc=
X-Google-Smtp-Source: AGHT+IF9MvoHBGQX3A9adyedYLz4m5BVsNEYr5I0yeXSWJb+jDe4+8pO9rAQ0WnejQXucl0su6LnwoXagDD5ULWHtC0=
X-Received: by 2002:a17:907:7f09:b0:b76:4a7c:27a5 with SMTP id
 a640c23a62f3a-b766ef47be6mr3614724466b.23.1764523239291; Sun, 30 Nov 2025
 09:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-7-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-7-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:20:03 +0200
X-Gm-Features: AWmQ_blFFV2D-2mIqGg-EfXqwWNJsj4eZaaf_gtwp3bJPdQZKtFnkEsUJUHLWMA
Message-ID: <CAHp75VcSLY_L6Xp9LrY_qOBCUrmaEMtPTFpUPK9bJNs6L8FgiA@mail.gmail.com>
Subject: Re: [PATCH v1 06/31] serial: 8250_mxupci: add custom handle_irq()
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Add a custom handle_irq() for 8250_mxupci based on serial8250_handle_irq(=
),
> removing PM wakeup and DMA handling that are not needed.
>
> This prepares for future adjustments to RX and TX behavior specific to
> Moxa MU860 UART.

...

> +static int mxupci8250_handle_irq(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       bool skip_rx =3D false;
> +       unsigned long flags;
> +       u16 lsr;
> +       u8 iir;
> +
> +       iir =3D serial_in(up, UART_IIR);

> +

Stray blank line addition.

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
> +
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
