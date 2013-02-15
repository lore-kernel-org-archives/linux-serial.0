From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: Fix recursive locking bug
Date: Fri, 15 Feb 2013 09:30:16 -0800
Message-ID: <20130215173016.GA27514@kroah.com>
References: <alpine.LFD.2.02.1302142006050.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1302142006050.22263@ionos>
Sender: stable-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Xinyu Chen <xinyu.chen@freescale.com>, Dirk Behme <dirk.behme@de.bosch.com>, Shawn Guo <shawn.guo@linaro.org>, Tim Sander <tim@krieglstein.org>, Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 14, 2013 at 09:01:06PM +0100, Thomas Gleixner wrote:
> commit 9ec1882df2 (tty: serial: imx: console write routing is unsafe
> on SMP) introduced a recursive locking bug in imx_console_write().
> 
> The callchain is:
> 
> imx_rxint()
>   spin_lock_irqsave(&sport->port.lock,flags);
>   ...
>   uart_handle_sysrq_char();
>     sysrq_function();
>       printk();
>         imx_console_write();
>           spin_lock_irqsave(&sport->port.lock,flags); <--- DEAD
> 
> The bad news is that the kernel debugging facilities can dectect the
> problem, but the printks never surface on the serial console for
> obvious reasons.
> 
> There is a similar issue with oops_in_progress. If the kernel crashes
> we really don't want to be stuck on the lock and unable to tell what
> happened.
> 
> In general most UP originated drivers miss these checks and nobody
> ever notices because CONFIG_PROVE_LOCKING seems to be still ignored by
> a large number of developers.
> 
> The solution is to avoid locking in the sysrq case and trylock in the
> oops_in_progress case.
> 
> This scheme is used in other drivers as well and it would be nice if
> we could move this to a common place, so the usual copy/paste/modify
> bugs can be avoided.

I agree, making this easier to handle would be nice, patches are always
accepted :)

thanks,

greg k-h
