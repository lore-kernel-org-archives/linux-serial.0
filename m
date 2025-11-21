Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159202773C1
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743179; cv=none; b=Nur3hOScXf5OM49WyTnWdMiahPZQyNDggbin+lXV78Hnd40PTsH1aq0pgOW4uSsnnDIM4NP7wUUr+OuXUayY4KTEw+4Hz0tGWzObOyc3lFLQd4cGlhGpX0p0NvpQyF5LxPQppacOd1BRgv0bHEbiomb2bOVr0ETOJdZTNgF3mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743179; c=relaxed/simple;
	bh=Bmgoopsu+0H9XAtez17h1igzsNM8F/VgudfpujlL6Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6dIbBXUQhp8MTo/FOC1cjLCJxGmC+Q89qhziY+1duEHmyHmYg1wMHSmAWslHanM3QipSM/uZ6dASC5T7LZPkiGqI9GjxUqAv+L6E1SIdbl8DGqY2MVx9crQIQuuc0LwoHLzkLI0ANezrNvM73V3fr7zvc/ZcOe4g7JzGg9MHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so770867137.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743177; x=1764347977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ30K5c1Yy25S+FIha2zG0Xwf4NQrvz4vEnETFtA7gE=;
        b=tvaFNmI6HKiCjxJgYtBPi3H16qLLWg09vSnmc5qpIgjeF43cCuiyZO5jTOz+MEAsg8
         bFjQBe0JSICC5FSFNNjvITrLbndLADu9Ek1ByK7AE0OOv/QxxKRAibOyx5blJZ0OTmjt
         NbZEqoe4jzYz+faO5NveKgQmrRX4GQ5cxB3o1upiRxzgbAH4y0p6kyyqTL+8YWhbiO/g
         tfnms3QTi6XNO3NdVRCWTAGmyRdIxIOSZNn6pla/MdJgbEyDLOUPBA6MrhmyRUe1rdcY
         V2NYo5bytnYm2CpkedKy6KIC+fFzR1aybQ4GUbbl1HB6bD9xW6+zacAWqPHxm+jzhc7y
         7JSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ptJn9afbf79j8uTRJiqUScdnA0HLOLjCLH/hbQ9UzI0sd4+iwbksPYzZyX4lDI+/do/3FDnP6g785c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJswf+ulOiaaMTK1fIfqqiZCdUP9tDJ3oCjcU5Wfojwv+f4h5
	xrif/BgfWfXFg6mSh4+EXP7jYOJE3E1mMEDkVi1mO5RPWfz0HmoBvCOeRIq0X5dv
X-Gm-Gg: ASbGncsXE2IYNmcOGXEY1tFJiRHaIwnUJkpdAJrBOInfjps6emvOaihFpEQCzqEdgG+
	cz5cMEJITgXytgbMqDS4xsjAYeqZq+eNC0ydVeQlc5xZMaF9VgpHEuEgw6iqFSCkSNVdYRXRL9c
	K4FZ9L1JRgYq21obaETKFp7VZcITlxJ8fOGc9HrMQ/jNKCLzu3FXaliJeTSxxYPI50ULm2zaeuz
	pQ23ucYRv+T2RQrsctCYNPGOJCReJ6uEINdJkrG6QGNmkTj8MBYriZ/VnTmHsepLLRP5hIPFHs9
	ETRwYkgtHEy0i9wdd7v5TMuGJNH2nnybuG25DBOjOjXu+/2hZmxVY+39UbC8ARx/zpDnNQYenTl
	leINeeBYAlAvwpVeKRUVVghwJCXyIIxVZJaMhM2E5jhzXVqpJcCLw+BUOUHJ3879OAwaYxKKVLV
	eRhHvWGd4zzwmU1XNtXU5XNt699VukCst0GduP+4qY8KH/1CHRXBHkFIE5mh4=
X-Google-Smtp-Source: AGHT+IFizaua3eIjGJt65BBFtMSxSULFpbYrxq/bHivO1AYmUC8tEM25k2+6Ur4EWCVO80aTPyEm9w==
X-Received: by 2002:a05:6102:2ac9:b0:5dd:89ab:aa08 with SMTP id ada2fe7eead31-5e1de195a0fmr1037682137.19.1763743176853;
        Fri, 21 Nov 2025 08:39:36 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bdd21e37sm2339297137.11.2025.11.21.08.39.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:39:36 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so770859137.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 08:39:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdGaWzlSpPdOKT17N6d+yHcTfxTOA3bAOWClZlsnbcNUZbhv1IBu9H8Qv1CoB38jJY6Bc0YhXz+GBQPhc=@vger.kernel.org
X-Received: by 2002:a05:6102:5805:b0:5db:ca9e:b57e with SMTP id
 ada2fe7eead31-5e1de3d432amr902123137.43.1763743175773; Fri, 21 Nov 2025
 08:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-10-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 17:39:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_fUhM2-gxhYN3jpzj8F5FOHFYjYT+ahrVs=bsLVBZGw@mail.gmail.com>
X-Gm-Features: AWmQ_bme-X7bQANEGBcax-aNmIv7U30_kjwDivwBpQq02aokr8NTPYQMva5IKq4
Message-ID: <CAMuHMdU_fUhM2-gxhYN3jpzj8F5FOHFYjYT+ahrVs=bsLVBZGw@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] serial: sh-sci: Add support for RZ/G3E RSCI clks
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
> RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
> support for the module clocks.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci-common.h
> +++ b/drivers/tty/serial/sh-sci-common.h
> @@ -17,6 +17,9 @@ enum SCI_CLKS {
>         SCI_SCK,                /* Optional External Clock */
>         SCI_BRG_INT,            /* Optional BRG Internal Clock Source */
>         SCI_SCIF_CLK,           /* Optional BRG External Clock Source */
> +       SCI_FCK_DIV64,          /* Optional Functional Clock frequency-divided by 64 */
> +       SCI_FCK_DIV16,          /* Optional Functional Clock frequency-divided by 16 */
> +       SCI_FCK_DIV4,           /* Optional Functional Clock frequency-divided by 4 */

Perhaps reverse the order?

>         SCI_NUM_CLKS
>  };
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2da36e8ce555..3b03d3d3f2c7 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3172,6 +3172,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>                 [SCI_SCK] = "sck",
>                 [SCI_BRG_INT] = "brg_int",
>                 [SCI_SCIF_CLK] = "scif_clk",
> +               [SCI_FCK_DIV64] = "tclk_div64",
> +               [SCI_FCK_DIV16] = "tclk_div16",
> +               [SCI_FCK_DIV4] = "tclk_div4",

Likewise

>         };
>         struct clk *clk;
>         unsigned int i;
> @@ -3181,6 +3184,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>         } else if (sci_port->type == SCI_PORT_RSCI) {
>                 clk_names[SCI_FCK] = "operation";
>                 clk_names[SCI_BRG_INT] = "bus";
> +       } else if (sci_port->type == RSCI_PORT_SCI || sci_port->type == RSCI_PORT_SCIF) {
> +               clk_names[SCI_FCK] = "tclk";
> +               clk_names[SCI_BRG_INT] = "bus";

pclk?

>         }
>
>         for (i = 0; i < SCI_NUM_CLKS; i++) {
> @@ -3194,6 +3200,12 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>                     (i == SCI_FCK || i == SCI_BRG_INT))
>                         return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
>
> +               if (!clk && (sci_port->type == RSCI_PORT_SCI ||
> +                            sci_port->type == RSCI_PORT_SCIF) &&
> +                   (i == SCI_FCK || i == SCI_BRG_INT || i == SCI_FCK_DIV64 ||
> +                    i == SCI_FCK_DIV16 || i == SCI_FCK_DIV4))
> +                       return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
> +
>                 if (!clk && i == SCI_FCK) {
>                         /*
>                          * Not all SH platforms declare a clock lookup entry

This function is becoming a bit cumbersome.
Can it be simplified?
Can we avoid looking up clocks that are not relevant for the port?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
