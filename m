From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/4] hsu: driver for Medfield High Speed UART device
Date: Thu, 17 Jun 2010 10:38:53 -0700
Message-ID: <20100617173853.GE24362@kroah.com>
References: <20100617100012.4379.92949.stgit@localhost.localdomain>
 <20100617100145.4379.60698.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51690 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093Ab0FQRj2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jun 2010 13:39:28 -0400
Content-Disposition: inline
In-Reply-To: <20100617100145.4379.60698.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

On Thu, Jun 17, 2010 at 11:01:47AM +0100, Alan Cox wrote:
> From: Feng Tang <feng.tang@intel.com>
>=20
> This is a PCI & UART driver, which suppors both PIO and DMA mode
> UART operation. It has 3 identical UART ports and one internal
> DMA controller.
>=20
> Current FW will export 4 pci devices for hsu: 3 uart ports and 1
> dma controller, each has one IRQ line. And we need to discuss the
> device model, one PCI device covering whole HSU should be a better
> model, but there is a problem of how to export the 4 IRQs info
>=20
> Current driver set the highest baud rate to 2746800bps, which is
> easy to scale down to 115200/230400.... To suport higher baud rate,
> we need add special process, change DLAB/DLH/PS/DIV/MUL registers
> all together.
>=20
> 921600 is the highest baud rate that has been tested with Bluetooth
> modem connected to HSU port 0. Will test more when there is right
> BT firmware.
>=20
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/serial/Kconfig      |    9=20
>  drivers/serial/Makefile     |    1=20
>  drivers/serial/mfd.c        | 1488 +++++++++++++++++++++++++++++++++=
++++++++++

When building with this patch, I get the following build error:
  CC [M]  drivers/serial/mfd.o
  drivers/serial/mfd.c: In function =E2=80=98serial_hsu_probe=E2=80=99:
  drivers/serial/mfd.c:1338:22: error: =E2=80=98serial_hsu_console=E2=80=
=99 undeclared (first use in this function)

So I can't take this, or the second patch (which doesn't fix this
problem).

Care to redo them so that the build is not broken?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
