From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/2] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Wed, 29 Jun 2016 16:51:22 +0800
Message-ID: <0e7153a4-9743-5a26-3212-42004fbf6930@huawei.com>
References: <1467083835-37750-1-git-send-email-wangkefeng.wang@huawei.com>
 <1467083835-37750-3-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1467083835-37750-3-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

+cc linux-acpi@vger.kernel.org

On 2016/6/28 11:17, Kefeng Wang wrote:
> Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
> that it is not 16550 compatibal.
> 
> Meanwhile, set dw8250_serial_out32 to keep consistent between serial_out
> and serial_in in ACPI.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 65f3da7..7571b0f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -301,8 +301,11 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  		p->iotype = UPIO_MEM32;
>  		p->regshift = 2;
>  		p->serial_in = dw8250_serial_in32;
> -		/* So far none of there implement the Busy Functionality */
> -		data->uart_16550_compatible = true;
> +		p->serial_out = dw8250_serial_out32;
> +
> +		/* Hisilicon 8250 dw uart is not 16550 compatible */
> +		if (!acpi_dev_found("HISI0031"))
> +			data->uart_16550_compatible = true;
>  	}
>  
>  	/* Platforms with iDMA */
> @@ -618,6 +621,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
>  	{ "APMC0D08", 0},
>  	{ "AMD0020", 0 },
>  	{ "AMDI0020", 0 },
> +	{ "HISI0031", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
> 

