From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 4 Jul 2017 10:36:08 +0200
Message-ID: <20170704083608.y3wra6afs6dm7pum@pengutronix.de>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <20170703181738.xyxtwe246cfrkyd7@pengutronix.de>
 <e1601aa2-6eaf-7212-369f-9c67a3159f64@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e1601aa2-6eaf-7212-369f-9c67a3159f64-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 04, 2017 at 09:01:24AM +0200, Romain Perier wrote:
> Le 03/07/2017 à 20:17, Uwe Kleine-König a écrit :
> > On Thu, Jun 29, 2017 at 08:26:18PM +0200, Uwe Kleine-König wrote:
> >> On Wed, Jun 28, 2017 at 12:15:14PM +0200, Romain Perier wrote:
> >>> From: Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>
> >>>
> >>> The size of the DMA buffer can affect the delta time between data being
> >>> produced and data being consumed. Basically the DMA system will move
> >>> data to tty buffer when a) DMA buffer is full b) serial line is idle.
> >>> The situation is visible when producer generates data continuously and
> >>> there is no possibility for idle line. At this point the DMA buffer is
> >>> directly affecting the delta time.
> >> This doesn't look like a hw property but a configuration item. Also I
> >> don't understand the problematic case. The i.MX is sending continuously
> >> and then doesn't receive bytes until the DMA buffer is full? What is the
> >> DMA buffer? You don't mean the FIFO here, do you?
> 
> by DMA buffer, I mean the size of the RX FIFO. Data will be moved to tty
> when the FIFO
> is full or the serial line is idle. Now suppose you have an important
> work load and the serial line is never idle,

That means you're waiting for urgent data that already sits in the
hardware's RX fifo but as you send in parallel the hardware is busy and
doesn't process the RX fifo?

Would it help to decrease UFCR.RXTL? Or is this a HW bug that the RX
fifo isn't considered idle when you send much?

Or is this a software problem and the urgent data sits somewhere in the
tty or dma layer already?

> with the current size of the DMA buffer (PAGE_SIZE) you might introduce
> latencies between data being produced and data being consumed.

Making DMA buffers smaller doesn't sound like the right approach to
minimize delays. If you choose to do so you increase the number of irqs
and so this is a user policy what you want and shouldn't fixed in the
oftree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
