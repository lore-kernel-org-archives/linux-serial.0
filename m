From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Mon, 4 Jan 2016 17:13:08 -0600
Message-ID: <CAOZdJXUpjWi7Dy=GFi7_58FqD_UZxxrw_QKJ4sdHLKVOLCyNAA@mail.gmail.com>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
	<1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-acpi@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 23, 2015 at 8:19 AM, Aleksey Makarov
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
> index 899a771..974cb9e 100644
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
> +       if (has_acpi_companion(&dev->dev)) {
> +               /*
> +                * According to ARM ARMH0011 is currently the only mapping
> +                * of pl011 in ACPI and it's mapped to SBSA UART mode
> +                */
> +               uap->vendor     = &vendor_sbsa;
> +               uap->fifosize   = 32;
> +               uap->port.ops   = &sbsa_uart_pops;
> +               uap->fixed_baud = 115200;

I'm confused by this patch.  We already have code like this in
tty-next, in the form of sbsa_uart_probe():

https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/+/tty-next/drivers/tty/serial/amba-pl011.c#2553

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
