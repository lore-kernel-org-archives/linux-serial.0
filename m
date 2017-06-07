From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Fix serial console on SNI RM400 machines
Date: Wed, 7 Jun 2017 16:47:01 +0300
Message-ID: <CAHp75VfCHacEUFKd4j_Cz+ZSh-9QxsLPpGCaNmaPZ2tt139+6A@mail.gmail.com>
References: <20170531203518.76311508766@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531203518.76311508766@solo.franken.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: linux-serial@vger.kernel.org

On Wed, May 31, 2017 at 11:21 PM, Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
> is disabled. Correct usage of clk API to make it work with/without it.

uart -> UART
clk -> CLK

>         clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(clk)) {
> -               if (PTR_ERR(clk) == -EPROBE_DEFER) {
> -                       ret = -EPROBE_DEFER;
> +               ret = PTR_ERR(clk);
> +               if (ret == -EPROBE_DEFER)
>                         goto err_out;
> -               }
> +               uartclk = 0;
> +       } else {

> +               clk_prepare_enable(clk);

This might fail.

> +               uartclk = clk_get_rate(clk);
> +       }

-- 
With Best Regards,
Andy Shevchenko
