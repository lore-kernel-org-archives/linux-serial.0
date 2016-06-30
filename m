From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] serial: 8250_dw: add ACPI support for uart on
 Hisilicon Hip05 soc
Date: Thu, 30 Jun 2016 17:39:46 +0300
Message-ID: <1467297586.30123.358.camel@linux.intel.com>
References: <1467250062-61583-1-git-send-email-wangkefeng.wang@huawei.com>
 <1467250062-61583-3-git-send-email-wangkefeng.wang@huawei.com>
 <1467279517.30123.346.camel@linux.intel.com>
 <1467280468.30123.350.camel@linux.intel.com>
	 <4ba5d9fb-580d-0e32-0ae7-85ab3b68742e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4ba5d9fb-580d-0e32-0ae7-85ab3b68742e@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, z.liuxinliang@hisilicon.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-06-30 at 22:26 +0800, Kefeng Wang wrote:
>=20
> On 2016/6/30 17:54, Andy Shevchenko wrote:
> > On Thu, 2016-06-30 at 12:38 +0300, Andy Shevchenko wrote:
> > > On Thu, 2016-06-30 at 09:27 +0800, Kefeng Wang wrote:
> > > > Add ACPI identifier for UART on Hisilicon Hip05 soc, be careful
> > > > that it is not 16550 compatibal.
> > > >=20
> > > > Meanwhile, set dw8250_serial_out32 to keep consistent between
> > > > serial_out
> > > > and serial_in in ACPI.
> > > >=20
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > ---
> > > > =C2=A0drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++--
> > > > =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > > > b/drivers/tty/serial/8250/8250_dw.c
> > > > index 65f3da7..096431b 100644
> > > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > > @@ -272,6 +272,12 @@ static bool dw8250_idma_filter(struct
> > > > dma_chan
> > > > *chan, void *param)
> > > > =C2=A0	return param =3D=3D chan->device->dev->parent;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +/* non 16550 compatible id list*/
> > > > +static const struct acpi_device_id non_16550_id_list[] =3D {
> > > > +	{ "HISI0031", 0 },
> > > > +	{ },
> > > > +};
> > > > +
> > >=20
> > > On first glance it looks redundant, see below.
> >=20
> > Oh, wait, this is still valid, but the better solution is to use
> > device
> > properties for the rest except yours!
>=20
> Do you mean using something like
>=20
> static struct property_entry dw8250_properties[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PROPERTY_ENTRY_U32("r=
eg-io-width", 4),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PROPERTY_ENTRY_U32("r=
eg-shift", 2),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PROPERTY_ENTRY_BOOL("=
snps,uart-16550-compatible"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ },
> };
>=20
> then use platform_device_add_properties to add it to the device(16500
> compatible),

Correct for the existing devices.

>=20
> but for hisi, use another property_entry without
> PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible")?

=46or HISI in case of alternate configuration you have to tweak _DSD in
ACPI.

>=20
> Not clear about using device properties.

Built-in device properties only for non-DT, non-ACPI devices. You may
consider it as a successor of platform data.

>=20
> >=20
> > I will prepare patch later this week or at the beginning of next
> > week if
> > you are in hurry, otherwise I would postpone this a bit (anyway it
> > will
> > not make v4.8 cycle).
> >=20
>=20
> Thanks, hope that it will come out soon.
>=C2=A0

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
