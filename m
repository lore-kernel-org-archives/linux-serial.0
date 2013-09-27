From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: Improve unwritable LCR workaround
Date: Fri, 27 Sep 2013 10:49:50 +0300
Message-ID: <20130927074950.GA25098@xps8300>
References: <1380069549-9176-1-git-send-email-tim.kryger@linaro.org>
 <20130925114232.GA26259@xps8300>
 <CAAYSxhpXNj4Jo9puhc56EkaXKEg=XjNYG_iwX0FDgpLyySWiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21066 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab3I0Hty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Sep 2013 03:49:54 -0400
Content-Disposition: inline
In-Reply-To: <CAAYSxhpXNj4Jo9puhc56EkaXKEg=XjNYG_iwX0FDgpLyySWiZg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Patch Tracking <patches@linaro.org>

Hi,

On Wed, Sep 25, 2013 at 03:47:14PM -0700, Tim Kryger wrote:
> On Wed, Sep 25, 2013 at 4:42 AM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Tue, Sep 24, 2013 at 05:39:09PM -0700, Tim Kryger wrote:
> >>  static void dw8250_serial_out(struct uart_port *p, int offset, int value)
> >>  {
> >>       struct dw8250_data *d = p->private_data;
> >>
> >> -     if (offset == UART_LCR)
> >> -             d->last_lcr = value;
> >> -
> >> -     if (offset == UART_MCR)
> >> -             d->last_mcr = value;
> >> -
> >> -     writeb(value, p->membase + (offset << p->regshift));
> >> +     if (offset == UART_LCR) {
> >> +             int tries = 1000;
> >> +             while (tries--) {
> >> +                     if (value == p->serial_in(p, UART_LCR))
> >> +                             return;
> >> +                     dw8250_force_idle(p);
> >> +                     writeb(value, p->membase + (UART_LCR << p->regshift));
> >> +             }
> >> +             dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> >
> > Is it not enough to simply poll USR[0] to see when the UART becomes
> > free?
> 
> Unfortunately not.  The LCR is modified while holding the spinlock
> with local interrupts disabled so the ISR is deprived of the
> opportunity to empty the FIFO.
> 
> Given that the hardware will never become idle so long as there are
> characters in the RX FIFO, the only option is to forcibly empty it
> here.

OK. The LCR issue is only a problem when the UART is configured with
the busy functionality (UART_16550_COMPATIBLE == NO). Otherwise LRC is
always accessible and this is not necessary.

We need a flag for the UART_16550_COMPATIBLE configuration, and
use this WA based on that.

Thanks,

-- 
heikki
