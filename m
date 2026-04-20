Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE9DDDCD
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669850; cv=none; b=UHnabcoIorfOtG+HypoNfYXI+d7TpqwckjckRQhMngRuV2cTXKwLt6NnEvHl0gQZMrDDkhKTZQOXypF0tVNGZXYKGE5p6Z5z5m2iYKkqRBFfaurInqt+2nKXB91PXDZS/2VzHDZVNnHgk1KF2xBrpRc0npfrkIdzHcNJne1x/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669850; c=relaxed/simple;
	bh=C+c49gAUSQEzaHz4gGjaUXNtx1ZXWqU1p4RFxv3G3Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6Jx+UhYpmUQ3vjbyoeFhUYfI11CpI9N/N/hDFjyuarOyQzhrW+vyr3PYuFVfcy0cMb56UwwbYMLasTJj6Jhaxx9ETdggId3osDVxJ03djO4chVdRXNZMVfdH7h40OJmVVOyVrENacNcY6Ki9dm5hbS6Qh0qifwZYnJk+cAe9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d8d479149so897983e0c.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 00:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669848; x=1777274648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aijd/fi10gj1WzHekfiClO9NcjiOyFGnk8a+H4m1LaM=;
        b=IEKyIcBGB5usFmue46EMR8RzGt/KFETJc19/KDAtVsdgnF3npV0+eqsScC1r71wL73
         WtIH2ZA0jNR2LTCEqpcH7GjHrpSN1nS+VfPehJQ7RkTXiYs5orhT9waSGEYvoTmx6pT3
         oUcQtdAeNnd/xji1M2oAaaUPKjPjh6NfcGZAKqH9bSvHSwZISGLvFFszF1vheZxxu3sM
         pBD3wEBFmDDzM5nEg8Cr6wtkOT9eezeU2JA7jo9qKAW5e8Zaldk0Ys570CK4Aq3D4JqK
         aT0bWXhc0g2mwzibbJXAstGagqwGaNWV+LRa8n11FI+5QkUj9on/AJ043dfgVxmkPxwF
         Mlcw==
X-Forwarded-Encrypted: i=1; AFNElJ8O+9yXSCJoyDcAn9IagEn29Srgghe2Q3zCyQ6yjyhs0dZifhShqTdRIyDBryWVbqiEYNvbRh5kWeCLnU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuB1+2DkHQFKLfPUfpRFD9H0eDJWD7Hl0nqFudmNQGfQhM31/3
	xq3X2Ly5BAXUCzTSBVAs6LMda3CfkO4lu/ttMjQp4a9DKPIm2ovYsYhD8cHdw90W
X-Gm-Gg: AeBDietMAtV5SCcRqFux31I3JcEl8fYjNGpqkfQo7eJ5Wb5WaV9eNjeX8PaQ/7IknZ5
	tNm0MWEUvhwo3ZSmW9gDuMuB9Aye30VvYl1Nfjxt2MyUrjQ4MSXJzptVvpN2ZRxvmdJ0ewzflaV
	9VO/2Z2gSEUBfK3R0i644941iadvXf3FievMvfcn8crK+Wd/I0wfqt+6wPQ2UmY6v4WDnwt0qJr
	Mi3oKkUzWjCbjpRpoF7rOzt30zrSXwiHBHFXH8RJ5XIarZ3SLsuncorDiNKpWkTGp1Jx/lWiqfK
	xVhosJf5/ETAl1yM9WuDKef/28JIUxB5OrtKtKGy2lkDwnwSFPxUROg+GITjnEj0PV+6eL97ASV
	7SoVa2IE0WrIm3HmufhueAXoP3UPHBSX0D1M4TF0jH5iqX+PK7hIwuu34nmuyjChhpaBaqcH815
	JzTdIuM27KNHppjYr1xUKyFYW28j/GU6POaIxRcUa5q5eiQzk8cPr1MoZnhnIkMTgQ56bXmV8=
X-Received: by 2002:a05:6122:f84:b0:56c:db8b:504e with SMTP id 71dfb90a1353d-56fa59fbc9fmr5822675e0c.13.1776669847690;
        Mon, 20 Apr 2026 00:24:07 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9332036sm5359774e0c.15.2026.04.20.00.24.07
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 00:24:07 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-605def5b807so757321137.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 00:24:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9x8sfhdIYnWXbWVdFDLrPmyHfAI2ZakWTjcQpshgoWORJ+LJxUavWiheTHJACq+9BD/rsw6wImkOljITQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3e26:b0:605:ead:8f38 with SMTP id
 ada2fe7eead31-616f7c5da0fmr4402105137.29.1776669847256; Mon, 20 Apr 2026
 00:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417193603.3906568-1-hugo@hugovil.com>
In-Reply-To: <20260417193603.3906568-1-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2026 09:23:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpZjVctirMuH=n_PrK4nnEnWqjuCzRjc4y6kC1--99kQ@mail.gmail.com>
X-Gm-Features: AQROBzBqfBQ40j3hOdAsL_wap8sb15H1YD-i4G3mZoH_zNpEr0_Bx0rfFa1YSvc
Message-ID: <CAMuHMdXpZjVctirMuH=n_PrK4nnEnWqjuCzRjc4y6kC1--99kQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: optimize max_freq determination
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, biju.das.jz@bp.renesas.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

On Sat, 18 Apr 2026 at 07:24, Hugo Villeneuve <hugo@hugovil.com> wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Follow example of rsci driver to avoid code duplication and useless
> max_freq search when port->uartclk is set to zero.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2711,14 +2711,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
>          * setup the baud rate generator hardware for us already.
>          */
>         if (!port->uartclk) {
> -               baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> -               goto done;

There was no "useless max_freq search", due to this goto?

> +               max_freq = 115200;
> +       } else {
> +               for (i = 0; i < SCI_NUM_CLKS; i++)
> +                       max_freq = max(max_freq, s->clk_rates[i]);
> +
> +               max_freq /= min_sr(s);
>         }
>
> -       for (i = 0; i < SCI_NUM_CLKS; i++)
> -               max_freq = max(max_freq, s->clk_rates[i]);
> -
> -       baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> +       baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
>         if (!baud)
>                 goto done;
>

Due to removing the goto above (for the casual reader: this is the
earlyprintk case, when port->uartclk is zero), the code will now
continue here, calculating transmission parameters and setting best_clk,
and overwriting the register configuration done by the bootloader.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
