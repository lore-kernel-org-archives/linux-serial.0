From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: imx: adapt rx buffer and dma periods
Date: Thu, 19 Sep 2019 13:22:16 +0200
Message-ID: <20190919112216.qjkx5wvqhsadjxg5@pengutronix.de>
References: <20190919102628.23621-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919102628.23621-1-philipp.puschmann@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Puschmann <philipp.puschmann@emlix.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 19, 2019 at 12:26:28PM +0200, Philipp Puschmann wrote:
> Using only 4 DMA periods for UART RX is very few if we have a high
> frequency of small transfers - like in our case using Bluetooth with
> many small packets via UART - causing many dma transfers but in each
> only filling a fraction of a single buffer. Such a case may lead to
> the situation that DMA RX transfer is triggered but no free buffer is
> available. While we have addressed the dma handling already with
> "dmaengine: imx-sdma: fix dma freezes" we still want to avoid

Is this statement still true now that you split this patch out of your
bigger series?

> UART RX FIFO overrun. So we decrease the size of the buffers and
> increase their number and the total buffer size.

What happens when such an RX FIFO overrun happens? Are characters lost?
Or only time? Does your change have an influence if I do fewer but
bigger transfers?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
