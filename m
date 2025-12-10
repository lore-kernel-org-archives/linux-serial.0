Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800582F361C
	for <linux-serial@vger.kernel.org>; Wed, 10 Dec 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350776; cv=none; b=YCd2pfy42PR+kfRBqSlkusq54b+LZpN0PVhYVw5KcNTAUC7dmwVscpPM7sp3MKTLUcCl+z/S2E2c7eBfA4DyxRH69SrlZ/2XQaZZYEgs6reLziGcMHbQrx3eEXkZOosw4RQ4o3S8PNnBI7awKjbhWKCniILFXHM63j/VZs6cncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350776; c=relaxed/simple;
	bh=cKKlf/qi5RVbXpkadjMAjfAtBExXHDozojyEKupWm4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/p4YYRxxaidnr0JfI59Fl7YT2Zu9LWKfqH+Ec2lJXWWOpLyZ9Vb0E4nKgEUyBEwwg20I3SJlg7v9abrNvWGvPd0UKz9RGJrXALzSsCuP2JuRguMewFKHO4dOw10Mxsug7hGLW5O7zEJwwV+XN9iSoxZXQ0kQ+vvgDohgPgEKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsRtftbM; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsRtftbM"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4503ee5c160so3525949b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 09 Dec 2025 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765350773; x=1765955573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFD7UyjsPmpuqFnTTx8vnY6CuwoA2TuWk2b2uY0gKG4=;
        b=BsRtftbMYxO5esVTCk6vHPK+G6PBogO55nuLxYahNAPQ0StGnLQ+mlF6mYmVF7Uwae
         L4XttFL0yYI24nmm2Pt2Dk+/7MBPgDwg8WjRnvz9/DE7++t4QVck0nYRTRbfwmA72miP
         SSbHjnpv7/LOCVdvWzRzIaom0XvRDmUwdtDuQHJRLeuU/Saj1G9D2mvc5avR7frVzJfV
         uHxaR3HwvVQJPTjReKOcddgRUgeqLXQpgg5h9E8Ogyzyq45jMNfflJPFKBCbOOrkEHX0
         yiPPqY/C+CyCC1X5tA+kQ5juD+rsmiZXUB9oKK5BTUadylbrrjcpSYIkOV04AzlxDTq8
         /PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765350773; x=1765955573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFD7UyjsPmpuqFnTTx8vnY6CuwoA2TuWk2b2uY0gKG4=;
        b=RZNZNTC5+1wEf5Ed5TgX6MwAMUZNArhMkV8+WbuUadSJMxlwvvqJ5Kk99I0RLQpCaI
         E1OUxm7zN4AGSxiFlgFie0EPeC08uAhKdvGFp4zTEaSnJDrruA2hwGXCt6AleG8E0dSZ
         GfdBDXOgOQxzAnRH083sb4PTaUUvKmPxjLXgYiRdeC9cIM0mBUlywBuFP9vineRO6v85
         e+TBZsJvj1FcfOuk0jmjLN7eZwQItniyo4kZC5OKtyD3w9XOy+fZRZ+iJ2+9xRkT88cB
         GXCCOmczZm7Yi1mxW7aYX9YDPctR4dhJDUbuKTg/TUIykGIxwHvl4Xdfdxth92VD/iTL
         y7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsMNGLdVGJ2a6yALVRixzdi3j62MrQn4U8leRa8EmH1ErTQDfgpTAppTyjO2g5jyEVx4IBlV79XrBhT0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRVAYKsNAJTrFPB39gX2dEa6AiTgfCZ9Lb0KTLeVcVxCGO8wX
	07a/sul6/ZvNwOnNLZfdo71xQTNXyrFbPpCdJqS1MC2pSA70d9S4oK02CVIr4GFCxoRPbEdahEL
	pe2jvGk7NSDsQthADA2fVFW7eh9371JU=
X-Gm-Gg: ASbGncuIfVsCfDAD4+7tNs72U9/XNeqVdT7ft2k6ujkJXpxPXvmGlT6D2YnUEoO9vpA
	L21fMKVyn1aPgN0SltaT9HcMhjN/GmTHWxGA7x33/+5nDv9wVY63cI8tD0LBtIU529Elz4XfyTs
	2kk2DFX1t4CJc/5sw/e+yHHoxG7crZJlQiPdMtN3pbWa18SLTUkZJC4BwtLTWwnFSe83WpDDjgq
	IHa+jD3oG1XL6GKaA7Y0+NxUO0UYRB4yQNg6tNUp+vB46APPLg+RoqQzL95Z4cvBFE4ZjzGFfrr
	Pq03pkG7etJz7LgOZfQ82jpoXA==
X-Google-Smtp-Source: AGHT+IG5sh9jcbMTkcsetA5uVfX+x//n3POrnzOjy1f3lBH8sxIIeBBEy5wJ5q1vvCD2ydT7tmHEpVTiJoTOC8ihjrs=
X-Received: by 2002:a05:6808:318e:b0:43f:5c19:cabe with SMTP id
 5614622812f47-455865dbc5dmr897931b6e.24.1765350773345; Tue, 09 Dec 2025
 23:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210063543.2185727-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20251210063543.2185727-1-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 10 Dec 2025 15:12:17 +0800
X-Gm-Features: AQt7F2rDJFcScLWb7SZd1mjCQ5DE5qCRxZI0dKJfTaIBp8LmQgLQ0OWIfG0fDZ8
Message-ID: <CAAfSe-vXq6Q6bzSbkWYaB656NqD64+9XdVkKdKVid6sZo3fu0Q@mail.gmail.com>
Subject: Re: [PATCH V2] serial: sprd: Use devm_clk_get_optional() to get the
 input clock
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 14:36, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> Simplify the code which fetches the input clock by using
> devm_clk_get_optional(). If no input clock is present
> devm_clk_get_optional() will return NULL instead of an error
> which matches the behavior of the old code.

This commit message is not describing the key point of its changes.

>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
> Change in V2:
> -Change title.
> -Change commit message.
> -Replace devm_clk_get() by devm_clk_get_optional() and drop NULL assignment.
> -Delete the sprd_uart_is_console function, after using the devm_clk_get_optional()
>  interface, this conditional check is redundant.
> ---
>  drivers/tty/serial/sprd_serial.c | 40 +++++++-------------------------
>  1 file changed, 9 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 8c9366321f8e..83ce77b435ee 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1115,34 +1115,21 @@ static void sprd_remove(struct platform_device *dev)
>                 uart_unregister_driver(&sprd_uart_driver);
>  }
>
> -static bool sprd_uart_is_console(struct uart_port *uport)
> -{
> -       struct console *cons = sprd_uart_driver.cons;
> -
> -       if ((cons && cons->index >= 0 && cons->index == uport->line) ||
> -           of_console_check(uport->dev->of_node, SPRD_TTY_NAME, uport->line))
> -               return true;
> -
> -       return false;
> -}
> -
>  static int sprd_clk_init(struct uart_port *uport)
>  {
>         struct clk *clk_uart, *clk_parent;
>         struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
>
> -       clk_uart = devm_clk_get(uport->dev, "uart");
> +       clk_uart = devm_clk_get_optional(uport->dev, "uart");
>         if (IS_ERR(clk_uart)) {
> -               dev_warn(uport->dev, "uart%d can't get uart clock\n",
> -                        uport->line);
> -               clk_uart = NULL;
> +               return dev_err_probe(uport->dev, PTR_ERR(clk_uart),
> +                       "uart%d can't get uart clock\n", uport->line);

No, as I said before, you cannot do like this, this patch is making
the clocks mandatory, sprd_serial driver could work as serial ports
for logs output without this "uart" clock.

It is very useful for early debugging when the clock driver is not even ready.

If other SPRD serials' default clock is 24M rather than 26M, like I
said in the last version patch, you can set default clock according to
the compatible string, that's saying make SPRD_DEFAULT_SOURCE_CLK to
be an element of "of_device_id.data".

So NAK for this change, sorry!

Thanks,
Chunyan

>         }
>
> -       clk_parent = devm_clk_get(uport->dev, "source");
> +       clk_parent = devm_clk_get_optional(uport->dev, "source");
>         if (IS_ERR(clk_parent)) {
> -               dev_warn(uport->dev, "uart%d can't get source clock\n",
> -                        uport->line);
> -               clk_parent = NULL;
> +               return dev_err_probe(uport->dev, PTR_ERR(clk_parent),
> +                       "uart%d can't get source clock\n", uport->line);
>         }
>
>         if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
> @@ -1150,19 +1137,10 @@ static int sprd_clk_init(struct uart_port *uport)
>         else
>                 uport->uartclk = clk_get_rate(clk_uart);
>
> -       u->clk = devm_clk_get(uport->dev, "enable");
> +       u->clk = devm_clk_get_optional(uport->dev, "enable");
>         if (IS_ERR(u->clk)) {
> -               if (PTR_ERR(u->clk) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_warn(uport->dev, "uart%d can't get enable clock\n",
> -                       uport->line);
> -
> -               /* To keep console alive even if the error occurred */
> -               if (!sprd_uart_is_console(uport))
> -                       return PTR_ERR(u->clk);
> -
> -               u->clk = NULL;
> +               return dev_err_probe(uport->dev, PTR_ERR(u->clk),
> +                       "uart%d can't get enable clock\n", uport->line);
>         }
>
>         return 0;
> --
> 2.34.1
>
