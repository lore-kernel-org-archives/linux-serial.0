From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 4/6] serial: imx: unmap sg buffers when DMA channel is
 released
Date: Thu, 21 Sep 2017 20:25:56 +0200
Message-ID: <20170921182556.n7qael3fyorvkfki@pengutronix.de>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-5-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506010697-22114-5-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 21, 2017 at 05:18:15PM +0100, Martyn Welch wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> This commits unmaps sg buffers when the DMA channel is released. It also
> sets to zero `dma_is_rxing` and `dma_is_txing` to state that the
> corresponding channels cannot transmit/receive data, as these are
> disabled.

That's a fix for a race, right? The functions being fixed were
introduced just in the patch before and I guess the race was there
already before. It is best if you could resort your series to have fixes
first. This way they can easily be applied during the rc phase while the
rest waits for the merge window.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
