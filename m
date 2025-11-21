Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5432BEFFB
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736773; cv=none; b=YpD8AG2qPA4TIZ9lXHSKEd74EqbnWQFKVv+Ve3Iy1aqzXssBKFxqZKlK7+kJP3cCl0wFMdUkWQ+3BJIhu9110qn8y1+iOs6E01HOo7oL6Kqi3UNEfN4i5jL9VLfqjTiKMwwnZc3Zb94OgBaVyvhq+ft9c+6uvaZNvzQKhclFoEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736773; c=relaxed/simple;
	bh=skql/n5RcA7jyeBbQIxGJIucWjPzv4AFxG9+SxoeQo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiE+WzoCL3jnv8fDIhwaZ2sVhqz6m1Fg4/n8HZpgu7c+XJ4nLi6mo+pd1VP9TiMlrjbK+6y7/GVXW2t19U+N+qWdFd9ei57J6lHs/IbfiLLmE6Lop4WYEmq850MHT/RTX6ct9RqLN7XaW2XIu16xBM+JTSqLcL1BbTza5r7PwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso1688379137.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736769; x=1764341569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lC5TXmbx1EgLF/GuqliUSxYBVJgyAz3ZPwC7d7k9sA=;
        b=kgj6Y1oQFCAmc0shYNA+vsBR8beplHr9D29o3PrLmG5nkrxFe/8QtUua6US9Q7yM6J
         +llLcmwtO5cBObZPM4juD/jh/ksOJQ3cqYDy08RyUcL1Q2eys8QsIFZbtSJd/34b3wD5
         aNLnXKcxPCg6pcRNqL0wiySC+BkftfJCbnJr+HnapE30+ZX8Vjwsx/zABzddMQ52CODX
         IxAIW2B/7ywQ94qDmcwjv5sX4KgM2QAaj3PvIR0xtIGgkXe1C6XXsJayORK/b+urPo8a
         zl047igVrQd3vo1oHgLbPm3GT/b/XX7dapAj4ErMqnGFCNC6B8uJMUMuGFCMALjwfWz9
         Hrkw==
X-Forwarded-Encrypted: i=1; AJvYcCUlc5YGaFq0NtGeJYcRjx74k00L59Z1KFEmfN82xYtwZNj0mHGgJLt/Luo4wquljxIMCMeHE5mIOhitvTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbnzWXTMBATkjK34FRQUfZm+Cag2ciFV0+FlYPfLRlJwXNY2x
	cCBaMpSzq727WMZF2PCCbrz4xvbF+KoNXNAMOoXJ3dM7bp4xLqQOVkBT7S7zP4dV
X-Gm-Gg: ASbGncuXEuBecgJ3fDB5d8EB9UMgjVxuhoOmghzVZfD8rUWA9bSYahVElgl976EGW3F
	sLPmJrql22rP8S4/XhcE9841w410Fnk3iNnGLnLhpW0tcpymLLEOvcgWM3UKr0+xfWyhJn/yCH7
	iKh5sDuAuFoOufoCg18SonK0KdIPOWSBjcOZ16EOzsGSRB8Qju/OzK5DqmFACr9oQdQeFB0YK5b
	q2OMam3DIpC3khU+zWNqkdfCXPpoEc47JE5gob7x2qI6DU1SpBYwUHZGow8/R3ETCdFoLmsHywN
	5jsGyrZVUzYgViRrZRwV+R/c/u616+LDrykdRHtVdi6uAAi0AJJOnWBkIyUbiUEeFu/Eu1/53zu
	Vfl5kqNq6Unes+mJTpXKEqRV6UMsVRMUxKwmiUcGXTEjHjWHVWNFerrdjFRFfYS6mWQNldY7zYY
	Ooa0g4tFVhVt3n5a+ynMM0oxE7RmPPiJeWlMC5upYVcIttN0b6
X-Google-Smtp-Source: AGHT+IEqHJSb02QoxYTmB3KxgWvkpTEBX/s3i4pNp9z3QKINQZufbyE+6SfvjrZQa8vSqMQlAomrQw==
X-Received: by 2002:a05:6102:3f4d:b0:5db:25b5:9b4f with SMTP id ada2fe7eead31-5e1de396e6amr809404137.26.1763736769364;
        Fri, 21 Nov 2025 06:52:49 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bdd27f22sm2206155137.9.2025.11.21.06.52.48
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:52:48 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so1328159137.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 06:52:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXhWZ6uTrFKsB0R3xdNGuYPtAwJ/v5UnX0ISjCJluPw+EK1FxndGft615KVnWy1Brq3S8Ea37sGc+Zv84=@vger.kernel.org
X-Received: by 2002:a05:6102:1609:b0:5d6:254f:4e24 with SMTP id
 ada2fe7eead31-5e1de402656mr820827137.32.1763736768085; Fri, 21 Nov 2025
 06:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 15:52:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_zCYLTM9gwJJE9nErumC32=2qkfPQDhpDVwKHCsVpYw@mail.gmail.com>
X-Gm-Features: AWmQ_bmzBcQpoZhI5Cv11aAtmYB1BIc8afiHapCc3vy2neqnnDocHJX2ZHzmfR0
Message-ID: <CAMuHMdV_zCYLTM9gwJJE9nErumC32=2qkfPQDhpDVwKHCsVpYw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] serial: rsci: Drop rsci_clear_CFC()
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Drop rsci_clear_CFC() by reusing rsci_clear_SCxSR() as the contents of
> both functions are the same.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -199,11 +199,6 @@ static unsigned int rsci_get_mctrl(struct uart_port *port)
>         return 0;
>  }
>
> -static void rsci_clear_CFC(struct uart_port *port, unsigned int mask)
> -{
> -       rsci_serial_out(port, CFCLR, mask);
> -}
> -

This function is indeed identical to rsci_clear_SCxSR(), so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, while the sci_port_ops method is indeed called .clear_SCxSR(),
I think it makes more sense to drop rsci_clear_SCxSR() instead, as this
function touches the CFC register...

>  static void rsci_start_tx(struct uart_port *port)
>  {
>         struct sci_port *sp = to_sci_port(port);
> @@ -275,7 +270,7 @@ static void rsci_transmit_chars(struct uart_port *port)
>                         break;
>                 }
>
> -               rsci_clear_CFC(port, CFCLR_TDREC);
> +               rsci_clear_SCxSR(port, CFCLR_TDREC);

... and it is called directly.

>                 rsci_serial_out(port, TDR, c);
>
>                 port->icount.tx++;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
