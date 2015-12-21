From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Mon, 21 Dec 2015 20:11:32 +0200
Message-ID: <CAHp75VcLGTMemaDyezgtxjtPa+tEUGm8ULJE8feY8FX4FEqU6g@mail.gmail.com>
References: <1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org>
	<1450709399-7246-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1450709399-7246-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 21, 2015 at 4:49 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> In ACPI this device is only defined in SBSA mode so
> if we are coming from ACPI use this mode.
>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/tty/serial/amba-pl011.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 899a771..766ce4f 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2368,18 +2368,33 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>         if (!uap)
>                 return -ENOMEM;
>
> -       uap->clk = devm_clk_get(&dev->dev, NULL);
> -       if (IS_ERR(uap->clk))
> -               return PTR_ERR(uap->clk);
> -
> -       uap->vendor = vendor;
> -       uap->lcrh_rx = vendor->lcrh_rx;
> -       uap->lcrh_tx = vendor->lcrh_tx;
> -       uap->fifosize = vendor->get_fifosize(dev);
> -       uap->port.irq = dev->irq[0];
> -       uap->port.ops = &amba_pl011_pops;
> +       /* ACPI only defines SBSA variant */
> +       if (ACPI_COMPANION(&dev->dev)) {

has_acpi_companion()

> +               /*
> +                * According to ARM ARMH0011 is currently the only mapping
> +                * of pl011 in ACPI and it's mapped to SBSA UART mode
> +                */
> +               uap->vendor     = &vendor_sbsa;
> +               uap->fifosize   = 32;
> +               uap->port.ops   = &sbsa_uart_pops;
> +               uap->fixed_baud = 115200;

Shouldn't you match by ID and provide the custom values if any?
On the other hand have you checked if it's possible to use _DSD in this case?

>
> -       snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
> +               snprintf(uap->type, sizeof(uap->type), "SBSA");
> +       } else {
> +               uap->clk = devm_clk_get(&dev->dev, NULL);
> +               if (IS_ERR(uap->clk))
> +                       return PTR_ERR(uap->clk);
> +
> +               uap->vendor = vendor;
> +               uap->lcrh_rx = vendor->lcrh_rx;
> +               uap->lcrh_tx = vendor->lcrh_tx;
> +               uap->fifosize = vendor->get_fifosize(dev);
> +               uap->port.ops = &amba_pl011_pops;
> +
> +               snprintf(uap->type, sizeof(uap->type), "PL011 rev%u",
> +                               amba_rev(dev));
> +       }
> +       uap->port.irq = dev->irq[0];
>
>         ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
>         if (ret)
> --
> 2.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
