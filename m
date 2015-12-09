From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Wed, 9 Dec 2015 15:21:23 +0200
Message-ID: <20151209132123.GB14285@kuha.fi.intel.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1445158908-9610-1-git-send-email-noamc@ezchip.com>
 <20151209131939.GA14285@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151209131939.GA14285@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 09, 2015 at 03:19:39PM +0200, Heikki Krogerus wrote:
> Hi Noam,
> 
> On Sun, Oct 18, 2015 at 12:01:48PM +0300, Noam Camus wrote:
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index a0cdbf3..880f712 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -63,6 +63,9 @@ struct dw8250_data {
> >  	struct clk		*pclk;
> >  	struct reset_control	*rst;
> >  	struct uart_8250_dma	dma;
> > +	unsigned int		(*serial_in)(void __iomem *addr);
> > +	void			(*serial_out)(unsigned int value,
> > +					      void __iomem *addr);
> 
> This is really ideal ..

Meant to say _not_ ideal. Sorry about that.

Cheers,

-- 
heikki
