From: chao bi <chao.bi@intel.com>
Subject: Re: [PATCH] serial:ifx6x60:Delete SPI timer when shut down port
Date: Fri, 23 Nov 2012 09:25:09 +0800
Message-ID: <1353633909.22077.12.camel@bichao>
References: <1353573787.22077.8.camel@bichao>
	 <20121122110640.3fd5ef9b@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121122110640.3fd5ef9b@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2012-11-22 at 11:06 +0000, Alan Cox wrote:
> > --- a/drivers/tty/serial/ifx6x60.c
> > +++ b/drivers/tty/serial/ifx6x60.c
> > @@ -552,7 +552,10 @@ static void ifx_port_shutdown(struct tty_port
> > *port) container_of(port, struct ifx_spi_device, tty_port);
> >  
> >  	mrdy_set_low(ifx_dev);
> > -	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
> > +	if (test_and_clear_bit(IFX_SPI_STATE_TIMER_PENDING,
> > +		&ifx_dev->flags)) {
> > +		del_timer(&ifx_dev->spi_timer);
> > +	}
> 
> You don't actually need the test here as far as I can see. Providing a
> timer has been initialised (init_timer) then running del_timer is safe
> even if the timer is not currently queued or has completed.
> 
> Alan

Yes, thanks. I'll update it.
