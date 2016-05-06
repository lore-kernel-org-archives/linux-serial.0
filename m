From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] dmaengine: urgent fix to prevent regression in
 UART
Date: Fri, 06 May 2016 16:38:46 +0300
Message-ID: <1462541926.17131.285.camel@linux.intel.com>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

+Cc: Heikki

On Wed, 2016-05-04 at 22:29 +0300, Andy Shevchenko wrote:
> There are two patches, first of which is an urgent fix to prevent a
> regression
> when UART driver can't acquire DMA channel due to DMA engine which
> doesn't
> support DMA_CYCLIC.

Have to add the following.

The commit ec5a11a91eec ("serial: 8250: Validate dmaengine rx chan meet=
s
requirements") brought a check for DMA capabilities and UART will not
acquire a DMA channel if DMA engine doesn't support both DMA_CYCLIC
_and_ DMA_SLAVE. The first patch in the series changes the logic from
_and_ to _or_.

>=20
> Andy Shevchenko (2):
> =C2=A0 dmaengine: slave means at least one of DMA_SLAVE, DMA_CYCLIC
> =C2=A0 dmaengine: rename cmd_pause to cmd_suspend
>=20
> =C2=A0drivers/dma/dmaengine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 8 ++++----
> =C2=A0drivers/tty/serial/8250/8250_dma.c=C2=A0=C2=A0=C2=A0=C2=A0| 2 +=
-
> =C2=A0include/linux/dmaengine.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 4 ++--
> =C2=A0sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
> =C2=A04 files changed, 8 insertions(+), 8 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
