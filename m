From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [EXT] [PATCH v3] serial: imx: adapt rx buffer and dma periods
Date: Thu, 26 Sep 2019 06:37:24 +0000
Message-ID: <15be848facd5e80222e5db30c61fe72f82a85713.camel@analog.com>
References: <20190919145114.13006-1-philipp.puschmann@emlix.com>
 <VI1PR0402MB3600CA068AEBAC63D3CE6A4CFF880@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <ac67f010-1b2c-6996-f542-ab955ca86489@emlix.com>
 <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xL0BKmt8xrhuB4rrvOqkCM5AUJ6YAzbcU8eNDXbzj4fZg@mail.gmail.com>
Content-Language: en-US
Content-ID: <2B1FC44150C12F4780866DD289A67B7E@namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "aford173@gmail.com" <aford173@gmail.com>, "philipp.puschmann@emlix.com" <philipp.puschmann@emlix.com>
Cc: "fugang.duan@nxp.com" <fugang.duan@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jslaby@suse.com" <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "yibin.gong@nxp.com" <yibin.gong@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-09-25 at 10:14 -0500, Adam Ford wrote:
> [External]
> 
> On Fri, Sep 20, 2019 at 2:06 AM Philipp Puschmann
> <philipp.puschmann@emlix.com> wrote:
> > Hi Andy,
> > 
> > Am 20.09.19 um 05:42 schrieb Andy Duan:
> > > From: Philipp Puschmann <philipp.puschmann@emlix.com> Sent: Thursday,
> > > September 19, 2019 10:51 PM
> > > > Using only 4 DMA periods for UART RX is very few if we have a high
> > > > frequency
> > > > of small transfers - like in our case using Bluetooth with many
> > > > small packets
> > > > via UART - causing many dma transfers but in each only filling a
> > > > fraction of a
> > > > single buffer. Such a case may lead to the situation that DMA RX
> > > > transfer is
> > > > triggered but no free buffer is available. When this happens dma
> > > > channel ist
> > > > stopped - with the patch
> > > > "dmaengine: imx-sdma: fix dma freezes" temporarily only - with the
> > > > possible
> > > > consequences that:
> 
> I have an i.MX6Q with Wl1837MOD on UART 2 with flow control, and I am
> getting Bluetooth transfer timeouts.
> (see imx6-logicpd-som.dtsi)
> 
> On top of 5.3.1, I have installed:
> 
> dmaengine: imx-sdma: fix buffer ownership
> dmaengine: imx-sdma: fix dma freezes
> dmaengine: imx-sdma: drop redundant variable
> dmaengine: imx-sdma: fix kernel hangs with SLUB slab allocator
> serial: imx: adapt rx buffer and dma periods
> 
> and I still get timeouts:
> 
> [   66.632006] Bluetooth: hci0: command 0xff36 tx timeout
> [   76.790499] Bluetooth: hci0: command 0x1001 tx timeout
> [   87.110488] Bluetooth: hci0: command 0xff36 tx timeout
> [   97.270507] Bluetooth: hci0: command 0x1001 tx timeout
> [  107.590457] Bluetooth: hci0: command 0xff36 tx timeout
> [  117.750477] Bluetooth: hci0: command 0x1001 tx timeout
> [  226.390499] Bluetooth: hci0: command 0xfe38 tx timeout
> [  231.590735] Bluetooth: hci0: command tx timeout
> 
> I did a bisect and found the start of my problems came from
> 
> 361deb7243d2 ("dmaengine: dmatest: wrap src & dst data into a struct")

That commit only touches `drivers/dma/dmatest.c` 
Are you using that module?

It's a "unit-test" module for testing DMAengine drivers.
The only way that can break anything [from what I can tell], is if it is
being run. It will probably put the DMA into a weird state (it is a test-
module after-all), and it may require some DMAs to be reset.
I admit it would be nice that the test-module would put the DMA back into a
normal-working state, but that effort could be big for some cases.


> 
> This happened sometime between v5.0 and v5.1
> 
> Is there a patch I missed somewhere?  Do I need to change my device
> tree configuration somehow to allocate the proper DMA memory?
> 
> 
> 
> > > > with disabled hw flow control:
> > > >   If enough data is incoming on UART port the RX FIFO runs over and
> > > >   characters will be lost. What then happens depends on upper
> > > > layer.
> > > > 
> > > > with enabled hw flow control:
> > > >   If enough data is incoming on UART port the RX FIFO reaches a
> > > > level
> > > >   where CTS is deasserted and remote device sending the data stops.
> > > >   If it fails to stop timely the i.MX' RX FIFO may run over and
> > > > data
> > > >   get lost. Otherwise it's internal TX buffer may getting filled to
> > > >   a point where it runs over and data is again lost. It depends on
> > > >   the remote device how this case is handled and if it is
> > > > recoverable.
> > > > 
> > > > Obviously we want to avoid having no free buffers available. So we
> > > > decrease
> > > > the size of the buffers and increase their number and the total
> > > > buffer size.
> > > > 
> > > > Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> > > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > > ---
> > > > 
> > > > Changelog v3:
> > > >  - enhance description
> > > > 
> > > > Changelog v2:
> > > >  - split this patch from series "Fix UART DMA freezes for iMX6"
> > > >  - add Reviewed-by tag
> > > > 
> > > >  drivers/tty/serial/imx.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index
> > > > 87c58f9f6390..51dc19833eab 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -1034,8 +1034,6 @@ static void imx_uart_timeout(struct
> > > > timer_list *t)
> > > >         }
> > > >  }
> > > > 
> > > > -#define RX_BUF_SIZE    (PAGE_SIZE)
> > > > -
> > > >  /*
> > > >   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
> > > >   *   [1] the RX DMA buffer is full.
> > > > @@ -1118,7 +1116,8 @@ static void imx_uart_dma_rx_callback(void
> > > > *data)  }
> > > > 
> > > >  /* RX DMA buffer periods */
> > > > -#define RX_DMA_PERIODS 4
> > > > +#define RX_DMA_PERIODS 16
> > > > +#define RX_BUF_SIZE    (PAGE_SIZE / 4)
> > > > 
> > > Why to decrease the DMA RX buffer size here ?
> > > 
> > > The current DMA implementation support DMA cyclic mode, one SDMA BD
> > > receive one Bluetooth frame can
> > > bring better performance.
> > > As you know, for L2CAP, a maximum transmission unit (MTU) associated
> > > with the largest Baseband payload
> > > is 341 bytes for DH5 packets.
> > > 
> > > So I suggest to increase RX_BUF_SIZE along with RX_DMA_PERIODS to
> > > feasible value.
> > 
> > I debugged and developed this patches on a system with a 4.15 kernel.
> > When prepared for upstream i have adapted
> > some details and missed a important thing here. It should say:
> > 
> > +#define RX_BUF_SIZE    (RX_DMA_PERIODS * PAGE_SIZE / 4)
> > 
> > Yes, i wanted to increase the total buffer size too, even wrote it in
> > the description.
> > I will prepare a version 4, thanks for the hint.
> > 
> > Just for info: A single RX DMA period aka buffer can be filled with
> > mutliple packets in regard of the upper layer, here BT.
> > 
> > 
> > Regards,
> > Philipp
> > > Andy
> > > 
> > > >  static int imx_uart_start_rx_dma(struct imx_port *sport)  {
> > > > --
> > > > 2.23.0
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
