Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168881AA8
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553450; cv=none; b=GG3Yamz+wolMY/bIV7sXqxhWX8PKoYu/1iRIg5lin8bTbfxKi7Uv2Op+/AdAR7aaAV2xTOK/WUm1x+HQHf+dIk5E/W5IawS2zjM1KPHDeemYaB+u+88mJfQ4mXvwSNNwrLkkC61aJ8Loe1FnvOmdEA4HAClqEAooKFFCZSALHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553450; c=relaxed/simple;
	bh=13bxe1qiLoK5kHa7Uj/jX29Ax3ynKL+ENMuAuuINPNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj5tLws4lrSd7d6P9KvdUmVTeY6j8MUeaz1sw5fJ14ifeuMiG5GgterL4zViTLAM5LsSvSPsXa7UUzmXCuCmyXlvWdoYgGeQtPnZCf9GqQRa+VfS1CPKpsRLnsbM8hOQ+4jfMMOm99umXDIBNPYHMLDG5tIPV2M2Q6neXxRjKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjYX6Zfg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjYX6Zfg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735ce67d1dso605308266b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764553447; x=1765158247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyCeqeq/yDk+Xy95ao9oYY6IMzbOQuaxl5BkdoDz1MQ=;
        b=CjYX6ZfgvpJddH+B5oUuEIC1dDV+nC4tLew4PG648LPwPhdW/Mh4/lndMfGdrcuQPe
         79nWx9/m7TbusfdtWapTKLToDDygfc6rSz1vAxpadfB9oHQ9QTJzr6fLR70/uYKDcKb9
         snIFUo0IHS0yNtYWiznALTKA04hYTWNQq+wdoV1+Rp179oX/0p/XRHGRrCMzUc2OOIpx
         POD7geKx3qUFUqvvtUnuIxeqS7y+Zque1XjO2+TkWAZz/I3+JKhNs09U6LnCML0nyQan
         9pcIHYy6QtudcH7NNI9IPESGMNFKrwBJWFFAzK6AbMpBvZI3uc77DwTcXbiz1iygRDbX
         XCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764553447; x=1765158247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyCeqeq/yDk+Xy95ao9oYY6IMzbOQuaxl5BkdoDz1MQ=;
        b=q00Duxo3yAcgU9cAPi/p9HsDrN6Cyzt3cOawXPZUY0E9GTmm7bIR0Gu3zkDpTs2GSe
         ndfEmHuPB1N9gkl+tIX/qQ+J53hOAXaxsfihwOV3zVrH42bYekn+gPWNP3LQLi/BrdPL
         rd5yyF4tgpegwii2WQCGqMkVUhs/ScRCEx5JKnuiPkZtyB0s0lEGs4s38Mwsx74VX4OW
         IRWtUxcGJO+1koWCMaVIFHwSn6cOGNpQ8s1cZzFHzKfjSJgkdO3WHPgADlatx5j2QekZ
         P52jQz3UCiZGoUI6FjmJJT3OL6dYMOJCTVmF0i74Dmyq33lt0Vq2V8vSWidGidfDS8Dj
         o+RA==
X-Forwarded-Encrypted: i=1; AJvYcCWm6aCh2jT29lAQ/UC+UCkKLD2PLxi0NIckQabKiXvsPzKgXaURKlq7f5fOEUjrX1xMzJIZcOtTl9J5yiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaukHnHvwJquTRkZlKznLFbp5cNF3oNlpCUUAOwe87Vzl7QkL
	XmS3klNq2/VtCG6CT3vKE53oSPgIwRXU2wyhdJffdlLegMsZKore38xkG552VxyfX9rKCt+chLL
	s/O6ZPt3q6uqpg98WA49yLrSV2H1v3Ww=
X-Gm-Gg: ASbGncukeK/tNK8PsDldl9qXrsxh+P8vTALviYwKmzUqeCB9e4eF5la51ToCofoWvoL
	ZSLylh52bG/vm0fs80bNVFaqlJcUfoPlVglG6sOdsdv0+T54KS/xzoe3cD4F7N/2OEPk/2qmIqo
	LSpIVJCBRzrCYxrO7wywYDT3fGOpW/poVapq8Roq0ON7JRA1wGHOB20VsW/BQQ0ypqvXQQzEqai
	3hf5uBq6KjokNl8ovvc4bu5FRmi8WJ52lpx7niTrzNqo0FqCJmBbpXS2V1Ua8KbWmhTNYD/JUGQ
	DIhBPZzvd5eu3LAMPZdp3vPTME5v4kk7OxtqjSyawZGSpLR4I60iAtKFW12xjYt09eNFjzATiWp
	DnvdhVw==
X-Google-Smtp-Source: AGHT+IEVisNC1M/D0Ps//eZDMYYAbMq+UMKJES6mxIkEqX4Lo/Kqz1+77hMgF9hmYHNMd0bRG1UbvjY2EgqQq/9psaw=
X-Received: by 2002:a17:907:7f8a:b0:b76:f5d0:5df4 with SMTP id
 a640c23a62f3a-b76f5d06ecamr1796837066b.31.1764553447368; Sun, 30 Nov 2025
 17:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-16-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-16-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:43:31 +0200
X-Gm-Features: AWmQ_blvDIzm4J_uuJrG_JE6btohfQXzDodtbkQxVnbuTX-fv3NY8sNkqXw008Y
Message-ID: <CAHp75VdGxSpfiga71UsQip5SGj06v+hxbxayrWYd9eG5QLfSug@mail.gmail.com>
Subject: Re: [PATCH v1 15/31] serial: 8250_mxpcie: optimize Rx using
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
> Add mxpcie8250_rx_chars() to retrieve data from the Rx FIFO via
> memory-mapped FIFO access, using the UART-specific FIFO byte counter
> and FIFO memory region.
>
> This avoids per-byte I/O reads through serial_in(), improving receive
> throughput on Moxa PCIe UART devices. For break and error conditions,
> the handler falls back to serial8250_rx_chars() to retain standard
> error handling logic.

...

> +static void mxpcie8250_rx_chars(struct uart_8250_port *up)
> +{
> +       struct uart_port *port =3D &up->port;
> +       struct tty_port *tport =3D &port->state->port;
> +       int recv_room, gdl, i;
> +       u8 buf[MOXA_PUART_FIFO_SIZE];
> +
> +       recv_room =3D tty_buffer_request_room(tport, port->fifosize);

> +

Unneeded blank line

> +       if (recv_room) {

  if (!recv_room)
    return;

> +               gdl =3D serial_in(up, MOXA_PUART_RX_FIFO_CNT);

> +

Unneeded blank line.

> +               if (gdl > recv_room)
> +                       gdl =3D recv_room;

> +               for (i =3D 0; i < gdl; ++i)
> +                       buf[i] =3D *(port->membase + MOXA_PUART_RX_FIFO_M=
EM + i);
> +
> +               port->icount.rx +=3D gdl;
> +               tty_insert_flip_string(tport, buf, gdl);
> +               tty_flip_buffer_push(tport);
> +       }
> +}

...

> -       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
> -               lsr =3D serial8250_rx_chars(up, lsr);
> +       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
> +               if (lsr & UART_LSR_BRK_ERROR_BITS)
> +                       lsr =3D serial8250_rx_chars(up, lsr);
> +               else
> +                       mxpcie8250_rx_chars(up);
> +       }

And again, please try not to modify the code you just added in the
previous changes.

--=20
With Best Regards,
Andy Shevchenko
