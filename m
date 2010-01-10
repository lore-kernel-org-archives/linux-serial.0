From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH 3/3] serial: make PCI device id constant
Date: Sun, 10 Jan 2010 18:51:42 +0100
Message-ID: <e2d7436a1001100951w4dd7139as96e5808872f5c926@mail.gmail.com>
References: <4B4A077C.7020406@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753865Ab0AJRvq@vger.kernel.org>
In-Reply-To: <4B4A077C.7020406@freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, cocci@diku.dk
List-Id: linux-serial@vger.kernel.org

2010/1/10 N=E9meth M=E1rton <nm127@freemail.hu>:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>
> The id_table field of the struct pci_driver is constant in <linux/pci=
=2Eh>
> so it is worth to make initialization data also constant.
[...]
> diff -u -p a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
> --- a/drivers/serial/8250_pci.c 2009-12-03 04:51:21.000000000 +0100
> +++ b/drivers/serial/8250_pci.c 2010-01-08 18:40:05.000000000 +0100
> @@ -2567,7 +2567,7 @@ static int pciserial_resume_one(struct p
> =A0}
> =A0#endif
>
> -static struct pci_device_id serial_pci_tbl[] =3D {
> +static const struct pci_device_id serial_pci_tbl[] =3D {
> =A0 =A0 =A0 =A0/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x36=
20) as 'PCI_SUBVENDOR_ID' */
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_A=
DVANTECH_PCI3620,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x000=
1, 0, 0,
[...]

There was similar patch sent to netdev couple days ago. For PCI
devices it used DEFINE_PCI_DEVICE_TABLE() like this:

static DEFINE_PCI_DEVICE_TABLE(serial_pci_tbl) =3D {

so that the ID data went to the proper .ko section.

Best Regards,
Micha=B3 Miros=B3aw
