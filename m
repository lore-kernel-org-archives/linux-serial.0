From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Thu, 30 Jun 2016 12:38:37 +0300
Message-ID: <1467279517.30123.346.camel@linux.intel.com>
References: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
	 <1467250062-61583-3-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467250062-61583-3-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-06-30 at 09:27 +0800, Kefeng Wang wrote:
> Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
> that it is not 16550 compatibal.
>=20
> Meanwhile, set dw8250_serial_out32 to keep consistent between
> serial_out
> and serial_in in ACPI.
>=20
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> =C2=A0drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++--
> =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index 65f3da7..096431b 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -272,6 +272,12 @@ static bool dw8250_idma_filter(struct dma_chan
> *chan, void *param)
> =C2=A0	return param =3D=3D chan->device->dev->parent;
> =C2=A0}
> =C2=A0
> +/* non 16550 compatible id list*/
> +static const struct acpi_device_id non_16550_id_list[] =3D {
> +	{ "HISI0031", 0 },
> +	{ },
> +};
> +

On first glance it looks redundant, see below.

> =C2=A0static void dw8250_quirks(struct uart_port *p, struct dw8250_da=
ta
> *data)
> =C2=A0{
> =C2=A0	if (p->dev->of_node) {
> @@ -301,8 +307,10 @@ static void dw8250_quirks(struct uart_port *p,
> struct dw8250_data *data)
> =C2=A0		p->iotype =3D UPIO_MEM32;
> =C2=A0		p->regshift =3D 2;
> =C2=A0		p->serial_in =3D dw8250_serial_in32;
> -		/* So far none of there implement the Busy
> Functionality */
> -		data->uart_16550_compatible =3D true;
> +		p->serial_out =3D dw8250_serial_out32;
> +
> +		if (!acpi_match_device(non_16550_id_list, p->dev))
> +			data->uart_16550_compatible =3D true;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Platforms with iDMA */
> @@ -618,6 +626,7 @@ static const struct acpi_device_id
> dw8250_acpi_match[] =3D {
> =C2=A0	{ "APMC0D08", 0},
> =C2=A0	{ "AMD0020", 0 },
> =C2=A0	{ "AMDI0020", 0 },
> +	{ "HISI0031", 0 },

So, we may put something instead of 0 here and consider it as a set of
special quirks / setup instructions / etc.

struct dw8250_dev_info {
=C2=A0 unsigned int =C2=A0uart_16550_compatible:1;
};

static const struct dw8250_dev_info hisi_dev_info =3D {
=C2=A0 .uart_16550_compatible =3D 1,
}

=2E..
=C2=A0{ "HISI0031", (kernel_ulong_t)&hisi_dev_info },
=2E..

And so on.

> =C2=A0	{ },
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
