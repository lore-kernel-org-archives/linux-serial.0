From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Fix DNV HSUART RX DMA timeout interrupt issue
Date: Wed, 15 Jun 2016 15:15:40 +0300
Message-ID: <1465992940.30123.116.camel@linux.intel.com>
References: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuah Kim Tatt <kim.tatt.chuah@intel.com>, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: heikki.krogerus@linux.intel.com, mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-06-15 at 13:44 +0800, Chuah Kim Tatt wrote:
> From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>
>=20
> These patches fix a DNV HSUART DMA issue with timeout interrupts,
> where
> RX data is stuck in buffer when RX DMA is used and the number of
> received
> bytes is less than 4096.
> These patches have been tested on Intel Denverton platform.

=46or entire series:
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>=20
> Changes from v1:
> =C2=A0 - Added patch "serial: 8250_dma: Export serial8250_rx_dma_flus=
h()"
> to solve
> =C2=A0=C2=A0=C2=A0=C2=A0build error when CONFIG_SERIAL_8250_MID is se=
t to "m".
>=20
> Chuah, Kim Tatt (3):
> =C2=A0 dmaengine: hsu: Export hsu_dma_get_status()
> =C2=A0 serial: 8250_dma: Export serial8250_rx_dma_flush()
> =C2=A0 serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV
>=20
> =C2=A0drivers/dma/hsu/hsu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 90
> +++++++++++++++++++++++++++++---------
> =C2=A0drivers/dma/hsu/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 11 ++++-
> =C2=A0drivers/tty/serial/8250/8250_dma.c |=C2=A0=C2=A01 +
> =C2=A0drivers/tty/serial/8250/8250_mid.c | 24 +++++++---
> =C2=A0include/linux/dma/hsu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 14 ++++--
> =C2=A05 files changed, 109 insertions(+), 31 deletions(-)
>=20

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
