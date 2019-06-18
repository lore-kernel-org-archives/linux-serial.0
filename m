From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sh-sci: fix uninitialized variable warning
Date: Tue, 18 Jun 2019 09:38:53 +0200
Message-ID: <20190618073853.GA25598@kroah.com>
References: <20190613180824.6ajwjelzr5fmjnie@debie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190613180824.6ajwjelzr5fmjnie@debie>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles <18oliveira.charles@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 13, 2019 at 03:08:24PM -0300, Charles wrote:
> Avoid following compiler warning on uninitialized variable
> 
> In file included from ./include/linux/rwsem.h:16:0,
>                  from ./include/linux/notifier.h:15,
>                  from ./include/linux/clk.h:17,
>                  from drivers/tty/serial/sh-sci.c:24:
> drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
> ./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~

What version of gcc is doing this?  It should be smarter than that,
perhaps you should just upgrade.

thanks,

greg k-h
