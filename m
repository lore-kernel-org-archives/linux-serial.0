Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CF13B584
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554239; cv=none; b=Tw9C/BWvSgJz/hmKwKhTTUE3h0nV+Etf+BUwJ2Anvx53ZHV49MI3t7z9uzM1PDA2wny5VazXaVYBc//qVV3XCp1OV4uj+x6VKTfNPBa7UE0gKmsIRcF0de+lFvBYh77BiHz5F7NCoif9TpQt5LTQsWeSaZd9UrnEtbDT/+s1GPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554239; c=relaxed/simple;
	bh=E+m0smsTeXo5Ymbj7iDGPZz8NZg5yAi3ORqXCtIwJbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnmiz2umsnKxXyAmAmp+sqz1nK8XRcY0PcH1ykGVaZN6aOuH1TadzJ4IOu3oY2CvbloIFDNoerKpEB75OI8NZiq7kWHeNYzKaIziFp95N5BD0CRqZLxiYdfdRCc0fo3TloCb8eamVSeXUNPsNDCnQMLwB3qwoAb6QYfAS89OYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwTLArjz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwTLArjz"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so6052135a12.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554235; x=1765159035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L9M+O3fW7LU5asJjeNmvNzYHFHJicHwvOq46wzWcKI=;
        b=ZwTLArjzNQYHxQW/yyUxhnATBg1VflSVgHJDD/Gjyv/NR53DN6Zyu52ftqygEyS3Sh
         ncZDTEbqZ/hRcLiBv07zGAdowxsgZqNNDlrD9RnF/MJC2Uy7ikVgi+X5bLiF8dRL8NWv
         99Mjv21Y0virtaw5BVj792J4K0E01u/IL2rdP8fJ7RwSiM+pLzfbzPpiqzG/PYWNkvFY
         HDhn4zOjSzz7dVg9z1ABsQ0RnDkFJUr4kUOaXe2MhqvJdtyvLNoaFF9umG/IQ3mPZqa/
         qapu6Tox7TT/ms/TdzR6jWsVG9JH5ty1QpqiXBlKKHYex7uYUDar3cIdhDJUlHJfldWM
         EGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554235; x=1765159035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/L9M+O3fW7LU5asJjeNmvNzYHFHJicHwvOq46wzWcKI=;
        b=CcPm28nDkpVETfWlN8BnHcxNc5S8gYxEl7F7m52Ius5l6rCqI0KP7rEkhNA8AUkwmF
         I2FApACbH+1avi7IO+0NT9QMMUuF/QGQmgyLBqmto2Spjlblgdyhwiv5itmHKVlbZ6fT
         aGRK7X4U3ICPtTbJ1I+6NhwhxVbKAd45SYFpgsHKavxi8MMZMZmTcQVzPs5WensXKTEQ
         NmRuHtYx3WmErk73N+oogfyh+AoxzIzg0na2XS9Ob5xZ+dvsybiLTv0VvbpPoSisLdSu
         ENPCCJjKwf5yAh7TWeKgWkJyRmCtuAMamG5KxpihKIE0Km7wWxfJMaW78jiTXMqa4JQa
         uNsg==
X-Forwarded-Encrypted: i=1; AJvYcCXyP/l5hkfBO3qv+8pBp6WPv6c5DMIEMeQLZBF9PdUbVFfUoaKbZR9CIzrJJhlevHPJLgcwNslouYuqhRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDalh+FoQg6cZQyrzEOGQjvlI4g6/AncTsqSdusIWsIW1WZgAF
	DtFvis92EFhIo6niQJiPfdv0DzvtsCPYp84X0ExGHv8l7bXutZuSzeA7i7TF6laRPERo9wqGEXD
	o3qbbQX7FbWfpcRrVRuII9uwbAHkAYeE=
X-Gm-Gg: ASbGncvTJ3PnXxoTl5vinBhD7A4vqGIpCQhTV+sdHFO5uxhwZZpQJwIEZQvUGWu9rvK
	7Azmbuon+10wwtl/Udq/yi8/BH3wEQRUDgmgy9LB+M4EMRjjQE0tpHGiucvcewYG8UcWrjyoggw
	4xnJSbIFTZdMvCiXioCHHEpKoBltqCaJD+l3YcELhwdRypKEZX5ry+Is8+onfzC37QVcGPd0iq+
	uaQsYP21AFYEOCYzbNfgu++Poh7rXlU1YvuaTZ0S9Qc0tJjfN9Ej5tXssqLfBHW/jFleC8bj5CD
	g1RyTNwYt345zxLAjUBIR4QQXIvi2iUc2M/b0J1+mJgCir/n0virw0e4iDYuwcngXSSXjE4=
X-Google-Smtp-Source: AGHT+IFDXsQ3QsXZNHlf7wD5cPh5TmPc4qeY3suwnF1r3715JQtQc1Lfv6mNKBYXEVkOBA78Io9RSjKasJrDo6pQByI=
X-Received: by 2002:a05:6402:50c8:b0:640:c460:8a90 with SMTP id
 4fb4d7f45d1cf-64555b986a7mr33158792a12.12.1764554234869; Sun, 30 Nov 2025
 17:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-20-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-20-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:56:38 +0200
X-Gm-Features: AWmQ_bmAvvpNaVujwr_0LbqhU2FWO0L0dtDobncMuUTZV7mwF5D3wo-x9souiPw
Message-ID: <CAHp75Veb_iu+WiUdJ6anqu3TbkjgwAU2deo8=b8TmcC7COS03A@mail.gmail.com>
Subject: Re: [PATCH v1 19/31] serial: 8250_mxpcie: add break signal support
 under RS485
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Moxa PCIe boards require a specific sequence to send break signals in
> RS485 mode. This patch implements the required behavior, while falling
> back to the default break mechanism in RS232 and RS422 modes.

...

> +static void mxpcie8250_software_break_ctl(struct uart_port *port, int br=
eak_state)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       struct tty_struct *tty =3D port->state->port.tty;
> +       unsigned char tx_byte =3D 0x01;
> +       unsigned int baud, quot;
> +       unsigned long flags;
> +       u8 sfr;
> +
> +       uart_port_lock_irqsave(port, &flags);
> +
> +       if (break_state =3D=3D -1) {
> +               serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
> +               serial_out(up, UART_DLL, 0);
> +               serial_out(up, UART_DLM, 0);
> +               serial_out(up, UART_LCR, up->lcr);

> +               memcpy(port->membase + MOXA_PUART_TX_FIFO_MEM, &tx_byte, =
1);

My gosh, why?
It's even different to the way you used in the previous change.

> +               sfr =3D serial_in(up, MOXA_PUART_SFR);
> +               serial_out(up, MOXA_PUART_SFR, sfr | MOXA_PUART_SFR_FORCE=
_TX);
> +
> +               up->lcr |=3D UART_LCR_SBC;
> +               serial_out(up, UART_LCR, up->lcr);
> +       } else {
> +               up->lcr &=3D ~UART_LCR_SBC;
> +               serial_out(up, UART_LCR, up->lcr);
> +
> +               sfr =3D serial_in(up, MOXA_PUART_SFR);
> +               serial_out(up, MOXA_PUART_SFR, sfr &=3D ~MOXA_PUART_SFR_F=
ORCE_TX);
> +
> +               serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
> +
> +               baud =3D tty_get_baud_rate(tty);
> +               quot =3D uart_get_divisor(port, baud);
> +               serial8250_do_set_divisor(port, baud, quot);
> +               serial_out(up, UART_LCR, up->lcr);
> +       }
> +       uart_port_unlock_irqrestore(port, flags);
> +}

--=20
With Best Regards,
Andy Shevchenko
