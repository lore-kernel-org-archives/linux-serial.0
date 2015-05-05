From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] tty: serial: 8250_mtk: Add support for bus clock
Date: Tue, 5 May 2015 17:41:16 +0200
Message-ID: <CABuKBeLwXZPYLka53sDghMyN_dX0wWUh8XV4vMSanWBhXJjFew@mail.gmail.com>
References: <1430117397-13517-1-git-send-email-s.hauer@pengutronix.de>
 <1430117397-13517-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1430117397-13517-5-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

2015-04-27 8:49 GMT+02:00 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> The mtk 8250 needs two clocks, one for providing the baudrate and
> one that needs to be enabled for register accesses. The latter has
> not been supported, this patch adds support for it. It is optional
> for now since not all SoCs provide a bus clock.
>
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  .../devicetree/bindings/serial/mtk-uart.txt        | 12 ++++++++--
>  drivers/tty/serial/8250/8250_mtk.c                 | 28 ++++++++++++++++++----
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 4415226..8d63f1d 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -14,7 +14,14 @@ Required properties:
>
>  - interrupts: A single interrupt specifier.
>
> -- clocks: Clock driving the hardware.
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names:
> +  - "baud": The clock the baudrate is derived from
> +  - "bus": The bus clock for register accesses (optional)
> +
> +For compatibility with older device trees an unnamed clock is used for the
> +baud clock if the baudclk does not exist. Do not use this for new designs.
>
>  Example:
>
> @@ -22,5 +29,6 @@ Example:
>                 compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
>                 reg = <0x11006000 0x400>;
>                 interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
> -               clocks = <&uart_clk>;
> +               clocks = <&uart_clk>, <&bus_clk>;
> +               clock-names = "baud", "bus";
>         };
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 2f28bd0..8eb3876 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -34,6 +34,7 @@
>  struct mtk8250_data {
>         int                     line;
>         struct clk              *uart_clk;
> +       struct clk              *bus_clk;
>  };

Not sure if it would be better to rename the uart_clk to baud_clk
which reflects the new naming scheme.

>
>  static void
> @@ -120,6 +121,7 @@ static int mtk8250_runtime_suspend(struct device *dev)
>         struct mtk8250_data *data = dev_get_drvdata(dev);
>
>         clk_disable_unprepare(data->uart_clk);
> +       clk_disable_unprepare(data->bus_clk);

bus_clk can be NULL.

>
>         return 0;
>  }
> @@ -135,6 +137,12 @@ static int mtk8250_runtime_resume(struct device *dev)
>                 return err;
>         }
>
> +       err = clk_prepare_enable(data->bus_clk);
> +       if (err) {
> +               dev_warn(dev, "Can't enable bus clock\n");
> +               return err;
> +       }
> +

Same here.

-- 
motzblog.wordpress.com
