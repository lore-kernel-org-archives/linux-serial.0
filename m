From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 12 May 2016 21:29:43 +0530
Message-ID: <20160512155943.GC2274@localhost>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1463065601.17131.319.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463065601.17131.319.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 12, 2016 at 06:06:41PM +0300, Andy Shevchenko wrote:
> On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
> > This is combined series of two things:
> > - split out the Intel LPSS specific driver from 8250_pci into
> > 8250_lpss
> > - enable DMA support on Intel Quark UART
> >=20
> > The patch has been tested on few Intel SoCs / platforms. In any cas=
e I
> > would
> > like to ask Bryan to do independent test.
> >=20
> > This is targeting serial subsystem, thus it would be nice to get an=
d
> > Ack from
> > Vinod first. Moreover, the series depends on [1] that is now in
> > Vinod's
> > slave-dma tree.
> >=20
> > That's why I asked Vinod to create immutable tag / branch for the [=
1]
> > and the
> > dependants (at least one more, which is sata_dwc_460ex) can use it.
> >=20
> > The series can be reached in the branch located at [2].
> >=20
> > [1] http://www.spinics.net/lists/kernel/msg2244475.html
> > [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
> >=20
>=20
> Do we have a chance to get this? Requirement, i.e. topic/dw branch of
> Vinod's slave-dma tree is available and has all prerequisites.

All dmaengine patches

Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks
--=20
~Vinod

>=20
> > Since v4:
> > - fix an issue what kernel test bot reported (lkp)
> > - add a list of supported SoC to Kconfig (Bryan)
> > - rename polarity -> hs_polarity (Bryan)
> >=20
> > Since v3:
> > - rebase on top of recent tty-next branch
> > - add Reviewed-by tag from Bryan
> >=20
> > Since v2:
> > - add tags
> > - rebase on top of new version of [1]
> >=20
> > Since v1:
> > - address most of Peter's comments (mostly changelog to patch 8)
> > - add tag to patch 5
> > - drop patch 6 from the series to be separately dealt with
> >=20
> > Andy Shevchenko (11):
> > =A0 dmaengine: dw: keep copy of custom slave config in dwc
> > =A0 dmaengine: dw: provide probe(), remove() stubs for users
> > =A0 dmaengine: dw: set polarity of handshake interface
> > =A0 dmaengine: dw: override LLP support if asked in platform data
> > =A0 serial: 8250_dma: switch to new dmaengine_terminate_* API
> > =A0 serial: 8250_dma: adjust DMA address of the UART
> > =A0 serial: 8250: enable AFE on ports where FIFO is 16 bytes
> > =A0 serial: 8250_lpss: split LPSS driver to separate module
> > =A0 serial: 8250_lpss: move Quark code from PCI driver
> > =A0 serial: 8250_lpss: enable MSI for Intel Quark
> > =A0 serial: 8250_lpss: enable DMA on Intel Quark UART
> >=20
> > =A0drivers/dma/dw/core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0|=A0=A043 +++--
> > =A0drivers/dma/dw/regs.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0|=A0=A0=A05 +-
> > =A0drivers/tty/serial/8250/8250.h=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A05 +
> > =A0drivers/tty/serial/8250/8250_dma.c=A0=A0=A0|=A0=A014 +-
> > =A0drivers/tty/serial/8250/8250_lpss.c=A0=A0| 357
> > +++++++++++++++++++++++++++++++++++
> > =A0drivers/tty/serial/8250/8250_pci.c=A0=A0=A0| 257 +--------------=
----------
> > =A0drivers/tty/serial/8250/8250_port.c=A0=A0|=A0=A0=A09 +-
> > =A0drivers/tty/serial/8250/Kconfig=A0=A0=A0=A0=A0=A0|=A0=A016 +-
> > =A0drivers/tty/serial/8250/Makefile=A0=A0=A0=A0=A0|=A0=A0=A01 +
> > =A0include/linux/dma/dw.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0|=A0=A0=A05 +
> > =A0include/linux/platform_data/dma-dw.h |=A0=A0=A04 +
> > =A011 files changed, 430 insertions(+), 286 deletions(-)
> > =A0create mode 100644 drivers/tty/serial/8250/8250_lpss.c
> >=20
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>=20
