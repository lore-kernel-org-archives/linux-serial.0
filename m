From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
 dma in use
Date: Fri, 20 Oct 2017 13:56:36 +0200
Message-ID: <20171020115636.GB2073@kroah.com>
References: <20171007014648.6989-1-troy.kisky@boundarydevices.com>
 <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AM3P101MB01800FAA2029393C5A859629E64A0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Han, Nandor (GE Healthcare)" <nandor.han@ge.com>
Cc: Troy Kisky <troy.kisky@boundarydevices.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 06:22:53AM +0000, Han, Nandor (GE Healthcare) wrote:
> 
> 
> > -----Original Message-----
> > From: linux-serial-owner@vger.kernel.org [mailto:linux-serial-
> > owner@vger.kernel.org] On Behalf Of Troy Kisky
> > Sent: 07 October 2017 04:47
> > To: gregkh@linuxfoundation.org
> > Cc: fabio.estevam@nxp.com; l.stach@pengutronix.de; u.kleine-
> > koenig@pengutronix.de; linux-serial@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Troy Kisky <troy.kisky@boundarydevices.com>
> > Subject: EXT: [PATCH 1/1] tty: serial: imx: disable ageing timer interrupt if
> > dma in use
> > 
> > Since commit 4dec2f119e86 ("imx-serial: RX DMA startup latency")
> > 
> > the interrupt routine no longer will start rx dma.
> 
> I think you have 2 commits here: 
> - one that disables ageing timer when DMA is in use
> - one that cleans the leftovers after 4dec2f119e86.

I agree, Troy, please make a patch series here.

thanks,

greg k-h
