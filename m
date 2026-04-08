Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2C3B9DBC
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662781; cv=none; b=B7/J2Qigo45OD2jnATHGQ5nbV1E3xda7vv406xrN9chrx2PQ7JTEuLqmvrfbCy/nsK/a7BQ9gw+aXRUFee9DXsWihz3SWIPFwoRQzcllCpopKRVi/QnqIhNKwvCKzwWJIIgOARWn2ooSFGVYXmf0RnnwVAkmjYBiHjYQyeyJ7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662781; c=relaxed/simple;
	bh=y4zf7cW5EbZBC46mnLaONDcohrozG4F73JPhm83PJ3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6HVc2NwRnDq84MfJPrbx8K3CR91A1esnpN1WWaQ+FUx2/o4jT9hjD3eqExVGxiEGSkQl5nOtN6jl53IP4FaEu1jeBii+x0CtPr0yUHbOFIfDrSUNPlBN1U63TTvLGNLmZADLSHDJPVkc0cxNKkfgXOD14PC4cShh9oPUw8XY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso5001151e0c.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662778; x=1776267578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKwJyBa6BNRH4CJj7npuL4jDFCQf7vqexI4deVey9ew=;
        b=kPdesVtvsL+tqYX/jQA4J6H51V8oQ2Q1sRHvLzBUqVqc6l8k/7031/LYXH+UXSvr4Y
         xA/o3ygHjZVZzRG57Cna/4rSWujx4SUVL+Ug37bZRxvormrgaLgBOoOfkLiDtz4deiy/
         Ukmu6fHC2ouYCfirxT+zaZ81i+s5e/vRIT9k9Q01LnXWuhehTKccWPk4NSVEUXoTfkLL
         uz5Tdxv0bHi5OOLPxUWhyeRzxC0VBp6geBeiJH2ZatlOq3XbTUsk/kMT4vAgXW+5Ei4N
         p2HMW9NhsAb95A7wOmgAl9bZDaP4fF8pPo1jgwrZkKqtAT8+RCyyd4Zw6xv+NVr8w6rX
         yLrw==
X-Forwarded-Encrypted: i=1; AJvYcCUdcERf6ZY8e/MvKPkcHVOlCzec0CNBljgwqlVjIX12S7N6xeQ1x8SutqidSP82GtsO9bBbJxduf08o0bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxy9VuuLT7ySsjR2QcYtEA/kQixIJs55EliWJCZNQI8XSmIxM7
	yWkpFE3GeZxKN9JZAlsqxAgjQMkZC5tW2X2abURS99XrFPyA7ebrX/o9jge1FRnl
X-Gm-Gg: AeBDiesZkwEswAdgyHLQzTOxgihxOJsNYVbYgQbwWQbNEOx5XQIB5Z7XAabzWYRBp9k
	Uw9HLOVVXIa73a/RZ82DmCpx2ePtbdNhb+yfFzbzqrSCE654kT0LvLfjgB/NsmptIW9/vuXeezz
	/VARopaxDKVFjSWmrFpx+WfIgR57xDRviK4XV9L3zZG33nKPPy0s+Qg547WHCE5+8qSbluez11g
	ip3aw44klou3m9Qnt3HIThZFSkZUelNhklto+FCmQvzPdUSxiupsUvmNYrKK14vrTYvRybpOZ87
	pyVc0qNAj8hWvoLjczZbsZcRprADfUzWFMOUx4FnYOLETg669WW8NEZ+E0ZKqDErLj3NQLOkrrX
	0pGM1rLJqcxkxDIRwMbraFpw0PPkZ0ZTmUjSvrIiF0Ne9sMiPJGKIvC65VT3+vKWOpwuwcybvA5
	NKF8gUrpWJ3fR5fkyQYct3Y4J0feLUF6+ez3QubErgfblguHNHfMhZLwFvDm1cviKrx/uKgypUS
	uA=
X-Received: by 2002:a05:6122:3117:b0:56c:d862:37dd with SMTP id 71dfb90a1353d-56daba00310mr9280157e0c.14.1775662777968;
        Wed, 08 Apr 2026 08:39:37 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb897b8dsm15960087241.7.2026.04.08.08.39.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:39:36 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so4067222e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSwa03pKZ/mZ7QYNjCBzFCjqlaffczvoOLcXxHkVn83D1xC8tzZmg7E8rGpz785qMiU1AUh+GQ6qqkEqc=@vger.kernel.org
X-Received: by 2002:a05:6122:17a9:b0:56c:d6f1:d742 with SMTP id
 71dfb90a1353d-56dab8f874bmr9660188e0c.8.1775662776150; Wed, 08 Apr 2026
 08:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com> <20260408142105.310210-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260408142105.310210-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 17:39:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5_k+iBekmV47W+Qqt5qDLMrLMRWZnnH5wCNP8E30N3A@mail.gmail.com>
X-Gm-Features: AQROBzB3_pGc4FZfhgLwR-Yt_w0_lTPGNrQbLw_Y5u5jxNU4I7ayBJbLjcoHCC8
Message-ID: <CAMuHMdW5_k+iBekmV47W+Qqt5qDLMrLMRWZnnH5wCNP8E30N3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] serial: sh-sci: Avoid divide-by-zero fault
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, 8 Apr 2026 at 16:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> uart_update_timeout() computes a timeout value by dividing by the baud
> rate. If baud is zero =E2=80=94 which can occur when the hardware returns=
 an
> unsupported or invalid rate =E2=80=94 this results in a divide-by-zero fa=
ult.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -286,7 +286,8 @@ static void rsci_set_termios(struct uart_port *port, =
struct ktermios *termios,
>         sci_port_enable(s);
>         uart_port_lock_irqsave(port, &flags);
>
> -       uart_update_timeout(port, termios->c_cflag, baud);
> +       if (baud)
> +               uart_update_timeout(port, termios->c_cflag, baud);
>
>         rsci_serial_out(port, CCR0, ccr0_val);
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 6c819b6b2425..429e89106ee3 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2805,7 +2805,8 @@ static void sci_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>
>         sci_reset(port);
>
> -       uart_update_timeout(port, termios->c_cflag, baud);
> +       if (baud)
> +               uart_update_timeout(port, termios->c_cflag, baud);

Nice catches!

>
>         /* byte size and parity */
>         bits =3D tty_get_frame_size(termios->c_cflag);

I think there's another one out of context, which can even trigger with
baud =3D=3D 75:

        s->rx_frame =3D (10000 * bits) / (baud / 100);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
