From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 2 Mar 2010 20:59:26 -0700
Message-ID: <fa686aa41003021959o1ec09100t3a4cffa33f54a13d@mail.gmail.com>
References: <20091229222006.1ddb28a4@feng-desktop> <20100208165946.0e4dde83@feng-i7>
	<20100303105744.1eec10d7@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33229 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0CCD7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2010 22:59:47 -0500
Received: by gwb15 with SMTP id 15so527502gwb.19
        for <linux-serial@vger.kernel.org>; Tue, 02 Mar 2010 19:59:46 -0800 (PST)
In-Reply-To: <20100303105744.1eec10d7@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tue, Mar 2, 2010 at 7:57 PM, Feng Tang <feng.tang@intel.com> wrote:
> Hi All,
>
> Here is a driver for Maxim 3110 SPI-UART device, please help to revie=
w.
>
> It has been validated with Designware SPI controller (drivers/spi: dw=
_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read,=
 and
> provides a console.
>
> change log:
> =A0since v4:
> =A0 =A0 =A0 =A0* Add explanation why not using DMA
> =A0 =A0 =A0 =A0* Fix a bug in max3110_read_multi()
> =A0since v3:
> =A0 =A0 =A0 =A0* Remove the Designware controller related stuff
> =A0 =A0 =A0 =A0* Remove some initialization code which should be done=
 in the platform
> =A0 =A0 =A0 =A0 =A0setup code
> =A0 =A0 =A0 =A0* Add a missing change for drivers/serial/Makefile
> =A0since v2:
> =A0 =A0 =A0 =A0* Address comments from Andrew Morton
> =A0 =A0 =A0 =A0* Use test/set_bit to avoid race condition for SMP/pre=
empt case
> =A0 =A0 =A0 =A0* Fix bug related with endian order
> =A0since v1:
> =A0 =A0 =A0 =A0* Address comments from Alan Cox
> =A0 =A0 =A0 =A0* Use a "use_irq" module parameter to runtime check wh=
ether
> =A0 =A0 =A0 =A0 =A0to use IRQ mode
> =A0 =A0 =A0 =A0* Add the suspend/resume implementation
[...]
> + *
> + * 3. This driver doesn't support work with a spi cotnroller in DMA =
mode, and
> + * =A0 =A0the reason for not using DMA is:
> + * =A0 =A0a) Maxim 3110 is a low speed UART device, whose tx/rx buff=
er are very few,
> + * =A0 =A0and using DMA may be over-killing when working as a system=
 console(imaging
> + * =A0 =A0we edit a text file on it)
> + * =A0 =A0b) Handling only one 16b word transfer will be very common=
, but non-32b
> + * =A0 =A0aligned DMA operation is not supported by all kinds of DMA=
 controllers
> + *
> + * =A0 =A0Some spi controller drivers like Pxa2xx, Designware have o=
ption for device
> + * =A0 =A0driver to chose to work in poll or DMA mode. And platform =
driver which
> + * =A0 =A0enumerates Max3110 device should leverage this option to n=
ot use DMA.

Between this, reading through the other comments, and the existence of
the max3100 driver, I'm less and less comfortable with this driver.
=46irst, if this driver gets merged, then it is quite likely that
neither you or the 3100 author will get around to merging them.
Second, as others have pointed out, this driver is making assumptions
about the SPI bus that it has no business making.  The fact that it
doesn't work with DMA isn't a design choice, it is a bug and whether
or not it is a low speed uart device is completely beside the point.

I'm generally not involved with the serial device drivers, but FWIW,
I'm no longer in favor of this driver getting merged.  If you really
want to get it merged, then I recommend asking Greg to pick it up into
staging so that there is some imperative to fix it up and merge it
with the max3100 driver.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
