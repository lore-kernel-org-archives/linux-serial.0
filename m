From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] earlycon: 8250: Fix command line regression
Date: Sat, 4 Apr 2015 18:09:31 +0200
Message-ID: <20150404160931.GC19278@kroah.com>
References: <1428105875-4038-1-git-send-email-peter@hurleysoftware.com>
 <1428157650-16418-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428157650-16418-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 04, 2015 at 10:27:30AM -0400, Peter Hurley wrote:
> Restore undocumented behavior of kernel command line parameters of
> the forms:
>     console=uart[8250],io|mmio|mmio32,<addr>[,options]
>     console=uart[8250],<addr>[,options]
> where 'options' have not been specified; in this case, the hardware
> is assumed to be initialized.
> 
> Document the required behavior of the original implementation.
> 
> Fixes: c7cef0a84912cab3c9df8 ("console: Add extensible console matching")
> Reported-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
> 
> v3: Fixed automatic console to port line settings initialization;
>     open-coded serial8250_console_setup() so the baud can be probed;
>     added sha reference in commit log
> 
> v2: Fixed regression which allowed "console=uart1337,..." to start a
>     console (but not an earlycon)
>   + fixed earlycon= documentation related required behavior fixed by
>     this patch
> 
>  Documentation/kernel-parameters.txt  | 18 ++++++++++++++---
>  drivers/tty/serial/8250/8250_core.c  | 38 +++++++++++++++++++++++++++++++++---
>  drivers/tty/serial/8250/8250_early.c | 19 ------------------
>  3 files changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index bfcb1a6..1facf0b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -713,10 +713,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  
>  		uart[8250],io,<addr>[,options]
>  		uart[8250],mmio,<addr>[,options]
> +		uart[8250],mmio32,<addr>[,options]
> +		uart[8250],0x<addr>[,options]
>  			Start an early, polled-mode console on the 8250/16550
>  			UART at the specified I/O port or MMIO address,
> -			switching to the matching ttyS device later.  The
> -			options are the same as for ttyS, above.
> +			switching to the matching ttyS device later.
> +			MMIO inter-register address stride is either 8-bit
> +			(mmio) or 32-bit (mmio32).
> +			If none of [io|mmio|mmio32], <addr> is assumed to be
> +			equivalent to 'mmio'. 'options' are specified in the
> +			same format described for ttyS above; if unspecified,
> +			the h/w is not re-initialized.
> +
>  		hvc<n>	Use the hypervisor console device <n>. This is for
>  			both Xen and PowerPC hypervisors.
>  
> @@ -944,11 +952,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		uart[8250],io,<addr>[,options]
>  		uart[8250],mmio,<addr>[,options]
>  		uart[8250],mmio32,<addr>[,options]
> +		uart[8250],0x<addr>[,options]
>  			Start an early, polled-mode console on the 8250/16550
>  			UART at the specified I/O port or MMIO address.
>  			MMIO inter-register address stride is either 8-bit
>  			(mmio) or 32-bit (mmio32).
> -			The options are the same as for ttyS, above.
> +			If none of [io|mmio|mmio32], <addr> is assumed to be
> +			equivalent to 'mmio'. 'options' are specified in the
> +			same format described for "console=ttyS<n>"; if
> +			unspecified, the h/w is not initialized.
>  
>  		pl011,<addr>
>  			Start an early, polled-mode console on a pl011 serial
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e0fb5f0..f59c7a0 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -3447,6 +3447,22 @@ static int univ8250_console_setup(struct console *co, char *options)
>  	return serial8250_console_setup(up, options);
>  }
>  
> +/* FIXME: this is broken on most other 8250 h/w */

What do you mean by "most other"?  What hardware does this work for?
What is it broken for?  What is someone supposed to think/do with this
comment?

thanks,

greg k-h
