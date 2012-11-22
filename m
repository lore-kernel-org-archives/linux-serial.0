From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial:ifx6x60:Delete SPI timer when shut down port
Date: Thu, 22 Nov 2012 11:06:40 +0000
Message-ID: <20121122110640.3fd5ef9b@bob.linux.org.uk>
References: <1353573787.22077.8.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353573787.22077.8.camel@bichao>
Sender: linux-kernel-owner@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 22 Nov 2012 16:43:07 +0800
chao bi <chao.bi@intel.com> wrote:

> 
> When shut down SPI port, it's possible that MRDY has been asserted
> and a SPI timer was activated waiting for SRDY assert, in the case,
> it needs to delete this timer.
> 
> Signed-off-by: Chen Jun <jun.d.chen@intel.com>
> Signed-off-by: channing <chao.bi@intel.com>
> ---
>  drivers/tty/serial/ifx6x60.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/ifx6x60.c
> b/drivers/tty/serial/ifx6x60.c index 5b9bc19..467020b 100644
> --- a/drivers/tty/serial/ifx6x60.c
> +++ b/drivers/tty/serial/ifx6x60.c
> @@ -552,7 +552,10 @@ static void ifx_port_shutdown(struct tty_port
> *port) container_of(port, struct ifx_spi_device, tty_port);
>  
>  	mrdy_set_low(ifx_dev);
> -	clear_bit(IFX_SPI_STATE_TIMER_PENDING, &ifx_dev->flags);
> +	if (test_and_clear_bit(IFX_SPI_STATE_TIMER_PENDING,
> +		&ifx_dev->flags)) {
> +		del_timer(&ifx_dev->spi_timer);
> +	}

You don't actually need the test here as far as I can see. Providing a
timer has been initialised (init_timer) then running del_timer is safe
even if the timer is not currently queued or has completed.

Alan
