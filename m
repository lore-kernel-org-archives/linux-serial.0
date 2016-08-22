From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Mon, 22 Aug 2016 14:24:14 +0300
Message-ID: <1471865054.4887.206.camel@linux.intel.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
         <1468580485-28567-4-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1468580485-28567-4-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-07-15 at 19:01 +0800, Kefeng Wang wrote:
> Use built-in device properties to set device parameters for the
> existing device probed by acpi.

acpi -> ACPI

> 
> Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful

soc -> SoC

> that it is not 16550 compatibal, so we need set "reg-io-width"

compatibal -> compatible

> and "reg-shift" by _DSD method in DSDT.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index d6934310..5ab9cfe 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -297,12 +297,6 @@ static void dw8250_quirks(struct uart_port *p,
> struct dw8250_data *data)
>  			p->serial_in = dw8250_serial_in32be;
>  			p->serial_out = dw8250_serial_out32be;
>  		}
> -	} else if (has_acpi_companion(p->dev)) {
> -		p->iotype = UPIO_MEM32;
> -		p->regshift = 2;
> -		p->serial_in = dw8250_serial_in32;
> -		/* So far none of there implement the Busy
> Functionality */
> -		data->uart_16550_compatible = true;
>  	}
>  
>  	/* Platforms with iDMA */
> @@ -352,6 +346,19 @@ static void dw8250_setup_port(struct uart_port
> *p)
>  		up->capabilities |= UART_CAP_AFE;
>  }
>  
> +static struct property_entry dw8250_properties[] = {
> +	PROPERTY_ENTRY_U32("reg-io-width", 4),
> +	PROPERTY_ENTRY_U32("reg-shift", 2),
> +	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
> +	{ },
> +};
> +
> +/* non 16550 compatible id list*/

non 16550 -> Non-16550
Space before */

> +static const struct acpi_device_id non_16550_ids[] = {
> +	{ "HISI0031", 0 },
> +	{ },
> +};
> +
>  static int dw8250_probe(struct platform_device *pdev)
>  {
>  	struct uart_8250_port uart = {};
> @@ -395,6 +402,9 @@ static int dw8250_probe(struct platform_device
> *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	if (has_acpi_companion(dev) &&
> !acpi_match_device(non_16550_ids, dev))


> +		platform_device_add_properties(pdev,
> dw8250_properties);

What if we probe device which has already properties assigned?

Heikki, are you good with such trick?


> +
>  	data->dma.fn = dw8250_fallback_dma_filter;
>  	data->usr_reg = DW_UART_USR;
>  	p->private_data = data;
> @@ -619,6 +629,7 @@ static const struct acpi_device_id
> dw8250_acpi_match[] = {
>  	{ "APMC0D08", 0},
>  	{ "AMD0020", 0 },
>  	{ "AMDI0020", 0 },
> +	{ "HISI0031", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
