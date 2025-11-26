Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F87262B
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144026; cv=none; b=O1LpTx4mfzDtvDoOUL/4M3QqmOLmYcZWbg5mvoVi/b4/LrYqwBEDfMaEk3oNvIB5jqTr6BvyQbVc/HIBM+0v6FyPJ6Stsh58cJVZSaGTO6Ow4B5u04tYmDCr5dz98n5Z378rqhvC70nIQxbXzbcmIj2IAcQYwxs6pU62qFRHR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144026; c=relaxed/simple;
	bh=HNi1fv+2fx2B8j+ekndM34eFcpXdrmRxoHpcjsDW2FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Op/yUQGXyJq/7oYfB0czBbjtrhkIpLLnmYOk+WC/1mltDTmNwhNwbLHQ7vHBfRppbE5Dx8IVz4aC5EIcrISISvZ7LtTBhjwRRin+xgM1tfz4rZoAKfrAX7r9MRV47EOTr0suG484sH5wVf3c42Eseuy1N7cCvUpbDesVWT84myE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93a9f6efebbso1809807241.0
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 00:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764144023; x=1764748823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCse7qCPdoJOLa+j8CcQsY7/CoYHUIpR0OYu1ViuPxc=;
        b=VzFoEnDeIzdSn3LOJPoS1eeASkBe2ICuvwIiiAG4ByvymnOr4KMwP78jvApBcsWcNX
         26fx1OIyGJLw3vg6q1M76JZ+1zLwJDvA+X/QpNRrKJhTTTuYAhAQ/LoJXltkx8CyHxSH
         IGx5wQE0x6acBMU2NfjPQPrJEpf7yBYEtZhGNW8RsrPJaCpN25r18ce/1rNk4gCTYGXb
         w4mssoVuwx6EFjTFxVa4qaS9s/sbTmW14Rcs6SRcQV3vLy4J6YmVI2jbMw7OmE4ZA4tR
         Y2XawvwvCg7c+xeaaGQPx1KNUrlj/ialNJO2r9MSrKhPyyp6N2gQ3FRXF/c9zv9Jxsdu
         4Upg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Y7YmkXDopjwA0xCCCsztwFOvfbhhp9eoGCpm6LGHGuA9GwdB1mGO588IH0L6+eXoZjhstqmEKjnJ1Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPf7TSW6ncy12X7J32ZK8rpYovbGjoXz/O9WGYxMQkc8wvHyU7
	MvkEsbWy1bddCMUc/24XCrzwxE8fBufvzaLyBGzEexInXNr7Unbpx/pXlhcZf6T8
X-Gm-Gg: ASbGncvjUr/sgdwhW7CBatSlsfCULYAA/jzabNk4kuqB/aAgx9UXy+AimsASjVlYdeW
	sKaMGXjJyOGC9bo7Cqdr6RhVkUn2iIJ5JQeV7oF0bumD8gD2N/uD/qFk+jes9vkznLm8RcJPauh
	WZ28a9x1hTSfbfEoBBWFhwzhq8ibVLzWiHkTNJ5+wjIQLU0NQ00I39P1C6OzTiOkreB/nwzb6mG
	Wv0N9C7xT25fd0Oc//YTXjBZuvsNcrChynNV7PsAx7nMjXPghTiy5g+n05vcCtN15CqHwMs5Rjc
	DBx8w5CA59qypknu0+mHefNZwG5OYjzljAFGJVBd+HdW/zwTLC/6foFvA/tYzKdGbld7cZktJx5
	0MKp6Kh7Zdxp16CCnzK2gGWh5HgYL1OMIqn5/O8YQbFcbnl2VX+Q4u4E/b+cKk1SRufw0GQ9Vom
	GS8xNLcBMqJip2FIIdRYvpVveyi8XV6c4wq//R6qaejvFUxen8
X-Google-Smtp-Source: AGHT+IGGYNH/mPBUcn85vYw5533QryD3/mcAFnvPgls1INwhiKW/rzUX2YD7e4+BcxK+KHoupv6oYQ==
X-Received: by 2002:a05:6102:3e08:b0:5db:d1b2:c0d4 with SMTP id ada2fe7eead31-5e1de36be99mr6305471137.31.1764144023079;
        Wed, 26 Nov 2025 00:00:23 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e1bda019b5sm7546256137.8.2025.11.26.00.00.21
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 00:00:22 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-93c6628c266so1601918241.1
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 00:00:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVImSan24oYmZT9K4JPRkTbhRyFLba+oMu/W+DftyqrCme3uxLzbFnlrsQMQjOP00Xp1E+qWcY00ajrMPY=@vger.kernel.org
X-Received: by 2002:a05:6102:5107:b0:5db:ef30:b74f with SMTP id
 ada2fe7eead31-5e1de0c07b0mr5210199137.8.1764144021094; Wed, 26 Nov 2025
 00:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com> <20251125150632.299890-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251125150632.299890-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Nov 2025 09:00:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVt6usA9DvzpzKz7OHYppuFH=jWGKRMqEPDzeoUyTXSw@mail.gmail.com>
X-Gm-Features: AWmQ_bnOQjOc7nJK151W-GJheTjV2TvfMTas4-rqaVdq0WY_ea4kfE0DIGYgMyI
Message-ID: <CAMuHMdUVt6usA9DvzpzKz7OHYppuFH=jWGKRMqEPDzeoUyTXSw@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] serial: sh-sci: Add sci_is_fifo_type()
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 25 Nov 2025 at 16:06, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add sci_is_fifo_type() helper for SCI operates in FIFO mode to
> simplify the code in probe() and remove().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3546,6 +3546,12 @@ static struct uart_driver sci_uart_driver = {
>         .cons           = SCI_CONSOLE,
>  };
>
> +static bool sci_is_fifo_type(u8 type)

sci_has_fifo?

> +{
> +       return (type == PORT_SCIFA || type == PORT_SCIFB ||
> +               type == PORT_HSCIF || type == SCI_PORT_RSCI);
> +}
> +
>  static void sci_remove(struct platform_device *dev)
>  {
>         struct sci_port *s = platform_get_drvdata(dev);
> @@ -3556,8 +3562,7 @@ static void sci_remove(struct platform_device *dev)
>
>         if (s->port.fifosize > 1)
>                 device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
> -       if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
> -           type == SCI_PORT_RSCI)
> +       if (sci_is_fifo_type(type))
>                 device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);

I am wondering if we could just check for s->port.fifosize > 1 instead,
and thus combine with the above check?  We do have to fill in .set_rtg =
rsci_scif_set_rtrg first, but are there other hurdles to take?

>  }
>
> @@ -3918,8 +3923,7 @@ static int sci_probe(struct platform_device *dev)
>                 if (ret)
>                         return ret;
>         }
> -       if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
> -           sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
> +       if (sci_is_fifo_type(sp->type)) {

Likewise.

>                 ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
>                 if (ret) {
>                         if (sp->port.fifosize > 1) {

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
