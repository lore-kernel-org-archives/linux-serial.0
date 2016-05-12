From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 12 May 2016 18:06:41 +0300
Message-ID: <1463065601.17131.319.camel@linux.intel.com>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
> This is combined series of two things:
> - split out the Intel LPSS specific driver from 8250_pci into
> 8250_lpss
> - enable DMA support on Intel Quark UART
>=20
> The patch has been tested on few Intel SoCs / platforms. In any case =
I
> would
> like to ask Bryan to do independent test.
>=20
> This is targeting serial subsystem, thus it would be nice to get and
> Ack from
> Vinod first. Moreover, the series depends on [1] that is now in
> Vinod's
> slave-dma tree.
>=20
> That's why I asked Vinod to create immutable tag / branch for the [1]
> and the
> dependants (at least one more, which is sata_dwc_460ex) can use it.
>=20
> The series can be reached in the branch located at [2].
>=20
> [1] http://www.spinics.net/lists/kernel/msg2244475.html
> [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
>=20

Do we have a chance to get this? Requirement, i.e. topic/dw branch of
Vinod's slave-dma tree is available and has all prerequisites.

> Since v4:
> - fix an issue what kernel test bot reported (lkp)
> - add a list of supported SoC to Kconfig (Bryan)
> - rename polarity -> hs_polarity (Bryan)
>=20
> Since v3:
> - rebase on top of recent tty-next branch
> - add Reviewed-by tag from Bryan
>=20
> Since v2:
> - add tags
> - rebase on top of new version of [1]
>=20
> Since v1:
> - address most of Peter's comments (mostly changelog to patch 8)
> - add tag to patch 5
> - drop patch 6 from the series to be separately dealt with
>=20
> Andy Shevchenko (11):
> =C2=A0 dmaengine: dw: keep copy of custom slave config in dwc
> =C2=A0 dmaengine: dw: provide probe(), remove() stubs for users
> =C2=A0 dmaengine: dw: set polarity of handshake interface
> =C2=A0 dmaengine: dw: override LLP support if asked in platform data
> =C2=A0 serial: 8250_dma: switch to new dmaengine_terminate_* API
> =C2=A0 serial: 8250_dma: adjust DMA address of the UART
> =C2=A0 serial: 8250: enable AFE on ports where FIFO is 16 bytes
> =C2=A0 serial: 8250_lpss: split LPSS driver to separate module
> =C2=A0 serial: 8250_lpss: move Quark code from PCI driver
> =C2=A0 serial: 8250_lpss: enable MSI for Intel Quark
> =C2=A0 serial: 8250_lpss: enable DMA on Intel Quark UART
>=20
> =C2=A0drivers/dma/dw/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A043 +=
++--
> =C2=A0drivers/dma/dw/regs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=
5 +-
> =C2=A0drivers/tty/serial/8250/8250.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +
> =C2=A0drivers/tty/serial/8250/8250_dma.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
14 +-
> =C2=A0drivers/tty/serial/8250/8250_lpss.c=C2=A0=C2=A0| 357
> +++++++++++++++++++++++++++++++++++
> =C2=A0drivers/tty/serial/8250/8250_pci.c=C2=A0=C2=A0=C2=A0| 257 +----=
--------------------
> =C2=A0drivers/tty/serial/8250/8250_port.c=C2=A0=C2=A0|=C2=A0=C2=A0=C2=
=A09 +-
> =C2=A0drivers/tty/serial/8250/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A016 +-
> =C2=A0drivers/tty/serial/8250/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0=C2=A01 +
> =C2=A0include/linux/dma/dw.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +
> =C2=A0include/linux/platform_data/dma-dw.h |=C2=A0=C2=A0=C2=A04 +
> =C2=A011 files changed, 430 insertions(+), 286 deletions(-)
> =C2=A0create mode 100644 drivers/tty/serial/8250/8250_lpss.c
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
