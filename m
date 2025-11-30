Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA916849C
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764523826; cv=none; b=Vo38m7QCJby4R5s6X0nrbD9+0QAGlYx4oWGd2IadiIKp54p3Gg2ur1Bn+XzGfAFKuokehybdDIm+OX6TpPi/X20a//wnRYsSEWDpR1PVZCHYZNcmCicSjsJBzPhL6l1RS9SS3hwaiExPqCYuvRkg6o4LJG7KPqmk6bh1kD/6qYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764523826; c=relaxed/simple;
	bh=/L0Zgbpwa1yutn4YhEgwsn0UnhyJ7bpcMsO+FWz4bCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWRrQmOdleQse1vtT/KC49Z5sf4TwpF8hPbN5cKqS34Zyq2ih/MKlKqSDJXSmC/sGAJfWBowYay7//0f3/JA4jqUaifKtvx1+5pYkWjmf9tDyhe10o1ua8sfej+DiYymGl+PLCQYbGAzhjET6UWMzmKCeTLU+UWp43nYF1G/mA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgcOeY3Q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgcOeY3Q"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b72bf7e703fso608653666b.2
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764523823; x=1765128623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7NN/qAkmaSpMJXnX+UHH2aVZw8FRCY/ERsj8b6H9iQ=;
        b=UgcOeY3QrU8IibF5IlKV/7vBETEN1XE7I0vCOadQz4ou/advbWcFvA8pekAOQhS1YY
         VU/kxnrbnidUAuHFKE6ja7HR4Nx5/JEIBFVZ7x3gO8BeCeYjHhzT2uu47HMR/UFnukaz
         S50sVGnU2nnap+QJZ4oIRwTh48u55SiH3wPUD7KG5XRUr/8GwfM3xuCCv6NFGkMbYEeB
         qyg5y8+oUoLfINGzYpC7qJJ2JbQ2PRIhG22Rdr0vduDyJahqkmn4vhogRZ/QoqK6K5Iz
         F3PIlc96HivEjdU6iNwI1yqUblCnjBrfkgZ0NwOsYe6J+AcBD+zbJkVCl7ACsydu8i0l
         QP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764523823; x=1765128623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j7NN/qAkmaSpMJXnX+UHH2aVZw8FRCY/ERsj8b6H9iQ=;
        b=eWVdsX7aDFOfC5H9BdCGg26mPGCQkzsMfo9xASduIpd3mSk2r/adwmPYWcZ0o+zZ/Z
         VxYdfcZKJ7qc/+EbRWzgVquKPT5TUWqFod2PJ4k4TcXETpAyn76CtVIZVdZRX06jWAxb
         3eNNxjOJtUujp+wct9lx3XPrqMD9hkbvTeRfp2HoHzlaJ0UiDOtsHTI+abq1wMZSm4K6
         uv86tMk+9EE2NmIa0hRBK2jmcwp+7fEWlp6febrzATeosww+POM4Gbfa09GmRfJfpnk3
         actqiNehTNiMDSlhCzFmn3+UXV7Wrcq0Pm+qf+25N03ZcDneXxni8sljbPbu2DmiOy4P
         lhxA==
X-Forwarded-Encrypted: i=1; AJvYcCUpeZqa3UX7furr+74r/e2HBBTeGQcP6fjF7wIXqOrLV+dEfVs3s0DKK3ECorTZZIah9kqDaq3QeRZInH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwEDFdLIEOOAs/cD5w/T48N9FrJSef4hjvh6nim9L2RrCu9Fx
	WMRMbHilDIFq3jRZighAD58ABzbVwfLwMxZV41p338b0Lo6zG5zRrSLnlq9CJiSWrVkNUwThram
	kilvb3Ym5MhmI47J8t3KNmfkLeV5ErTmBRuIlnIY=
X-Gm-Gg: ASbGncu8f7TSXzSN08h7tdAcUoQGeInb2npqSJ3JYOXWhcTVP1XxPet7LAsCZAdTNiC
	K3rCcQoE4985UgOX+SlBuJ7brtnKj4JcSErhr9d5aEb87PylN7x2FpE9hcKxTfbwQGWbhtH3hl9
	IKLIWvLNcF/If7ELjb9swXrEFkIv6kMZyVhsgd+DvE/TGb3NFsnIiclG2Aha1ArDntcXRaqBLr3
	ewp9WFQv393OZd/NOV/Msbj9be1NFsH+aqHLYK9cKp/h+b4AKj9t4XzZqZSZxu/ormYGxJCk/JG
	WfKycql/qqPG4HMciAHUMFYSep1VpOtEh2qTfihCVzO3g9feuGUdKDlVQstu/hfjyZwnhLYtUbA
	bdBueGjVVsfhtIzyGFQ==
X-Google-Smtp-Source: AGHT+IEn1AZiELO4z+ivxRZImZYR2RgyVb+uOPO1tI9y6vLLcbDVIaxhwOSvMx+3/3vz9hWXBwmRUqEOOJVEL355vQQ=
X-Received: by 2002:a17:907:3d05:b0:b70:aa96:6023 with SMTP id
 a640c23a62f3a-b7671707672mr3286784366b.24.1764523823075; Sun, 30 Nov 2025
 09:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-8-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-8-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:29:47 +0200
X-Gm-Features: AWmQ_blpadYM_HYS480huNFflpsK5NhuweSBm6Et7gIRbLwqr4Q5VcglbsvM52g
Message-ID: <CAHp75Vex-YzE-0PydYcSZGd24hkmbBanVHRTSsWQ_X-bc8kW9Q@mail.gmail.com>
Subject: Re: [PATCH v1 07/31] serial: 8250_mxupci: add GDL-based Rx routine
 for 8250_mxupci
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Introduce a custom Rx routine using the GDL (Good Data Length) register t=
o
> read multiple bytes from the Rx FIFO on Moxa UPCI serial boards.
>
> When no LSR error bits are present, the handler reads GDL bytes from
> UART_RX and inserts them into the TTY flip buffer. If error bits are
> detected, it falls back to the default serial8250_rx_chars() handler.

...

> +static void mxupci8250_rx_chars(struct uart_8250_port *up)
> +{
> +       struct uart_port *port =3D &up->port;
> +       struct tty_port *tport =3D &port->state->port;
> +       int recv_room, gdl, i;
> +       u8 buf[MOXA_UART_FIFO_SIZE];
> +
> +       recv_room =3D tty_buffer_request_room(tport, port->fifosize);

> +

Stray blank line addition.

> +       if (recv_room) {

Can't it be

  if (!recv_room)
    return;

?

> +               gdl =3D serial_in(up, MOXA_UART_GDL);

> +

Stray blank line addition.

> +               if (gdl > recv_room)
> +                       gdl =3D recv_room;
> +
> +               for (i =3D 0; i < gdl; ++i)
> +                       buf[i] =3D serial_in(up, UART_RX);
> +
> +               port->icount.rx +=3D gdl;
> +               tty_insert_flip_string(tport, buf, gdl);
> +               tty_flip_buffer_push(tport);
> +       }
> +}

...

> -       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
> -               lsr =3D serial8250_rx_chars(up, lsr);
> -
> +       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
> +               if (lsr & UART_LSR_BRK_ERROR_BITS)
> +                       lsr =3D serial8250_rx_chars(up, lsr);
> +               else
> +                       mxupci8250_rx_chars(up);
> +       }

Oh, can we reduce ping-pong a bit (the modification of the lines just
being added earlier in the same patch series)?

I think you can create a helper to wrap 8250_rx_chars() with split
version of the almost unreadable conditionals, this will also remove
the skip_rx variable

static ... _rx_chars()
{
  /* split version of skip_rx monstrous if */
  if ...
    return ...;
  if ...
   return ...;

  if ...
   return ...;

  return 8250_rx_chars(...);
}

Then in this patch only a couple of lines will be added to the end of
the function.

  if (...)
   return ...

--=20
With Best Regards,
Andy Shevchenko
