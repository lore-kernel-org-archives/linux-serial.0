From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] parport/serial: add support for Timedia/SUNIX cards to
 parport_serial
Date: Thu, 8 Jul 2010 12:11:22 +0100
Message-ID: <20100708121122.17d3e823@lxorguk.ukuu.org.uk>
References: <1277511823-6973-1-git-send-email-fbriere@fbriere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37956 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754081Ab0GHLDd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Jul 2010 07:03:33 -0400
In-Reply-To: <1277511823-6973-1-git-send-email-fbriere@fbriere.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-14?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-parport@lists.infradead.org

On Fri, 25 Jun 2010 20:23:43 -0400
=46r=E9d=E9ric Bri=E8re <fbriere@fbriere.net> wrote:

> Timedia/SUNIX PCI cards with both serial and parallel ports are
> currently supported by 8250_pci and parport_pc individually.  Moving
> that support into parport_serial allows using both types of ports at =
the
> same time.

This seems to have fallen on silence so I'm getting around to looking a=
t
it.  I'm not sure the sunix hack to avoid lots of entries is a good ide=
a
- it'll eventually break horribly somewhere.


> + * Devices with a parallel port can be identified by their subdevice=
 ID
> + * matching xx[7-9]x.  We thus mark them as class OTHER, so that the=
y will be
> + * ignored by 8250_pci, and claimed by parport_serial instead.
> + */
> +static void __devinit quirk_timedia(struct pci_dev *dev)
> +{
> +	/* 0,2,3,5,6: serial only -- 7,8,9: serial + parallel */
> +	if ((dev->subsystem_device & 0x00f0) >=3D 0x70) {
> +		dev_info(&dev->dev, "Timedia %04x; "
> +			"changing class SERIAL to OTHER (use parport_serial)\n",
> +			dev->subsystem_device);
> +		dev->class =3D (PCI_CLASS_COMMUNICATION_OTHER << 8) |
> +		    (dev->class & 0xff);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDI=
A_1889,
> +		quirk_timedia);

And this check probably should be done in the serial driver so that it
doesn't bind, rather than changing the class, which then lies to other
bits of the kernel so can have funny side effects.

If you did that check in the serial driver and returned -ENODEV to the
probe the id will be handed on to the next driver that matches (ie
parport_serial)

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
