From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 09:44:37 +0200
Message-ID: <20170403074437.GA20683@kroah.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170401222119.25106-1-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 01, 2017 at 06:21:14PM -0400, Nicolas Pitre wrote:
> Many embedded systems don't need the full TTY layer support. Most of the
> time, the TTY layer is only a conduit for outputting debugging messages
> over a serial port. The TTY layer also implements many features that are
> very unlikely to ever be used in such a setup. There is great potential
> for both code and dynamic memory size reduction on small systems. This is
> what this patch series is achieving.
> 
> The existing TTY code is quite large and complex. Trying to shrink it
> is risky as the potential for breakage is non negligeable, and its
> interchangeable layers impose a lower limit on the code to implement it.
> Therefore, the approach used here consists in the creation of a parallel
> implementation with the very minimal amount of code collapsed together
> that interfaces with existing UART drivers directly and provides TTY-like
> character devices to user space. When the regular TTY layer is disabled,
> then this minitty alternative layer is proposed by Kconfig.
> 
> For more details on the rationale and motivations driving this approach
> please see: https://lkml.org/lkml/2017/3/24/634
> 
> Of course, making it "mini" means there are limitations to what it does:
> 
> - This supports serial ports only. No VT's, no PTY's.
> 
> - The default n_tty line discipline is hardcoded and no other line
>   discipline are supported.
> 
> - The line discipline features are not all implemented. Notably, XON/XOFF
>   is currently not implemented (although this might not require a lot of
>   code to do it if someone were to need it).
> 
> - Hung-up state is not implemented.
> 
> - No error handling on RX bytes other than counting them.
> 
> - Job control is currently not supported (this may change in the future and 
>   be configurable).
> 
> But again, most small embedded systems simply don't need those things.
> 
> This can be used on any architecture of course, but here's some numbers
> using a minimal ARM config.
> 
> When CONFIG_TTY=y, the following files are linked into the kernel:
> 
>    text	   data	    bss	    dec	    hex	filename
>    8796	    128	      0	   8924	   22dc	drivers/tty/n_tty.o
>   11809	    276	      0	  12085	   2f35	drivers/tty/serial/fulltty_serial.o
>    1376	      0	      0	   1376	    560	drivers/tty/tty_buffer.o
>   13571	    172	    132	  13875	   3633	drivers/tty/tty_io.o
>    3072	      0	      0	   3072	    c00	drivers/tty/tty_ioctl.o
>    2457	      2	    120	   2579	    a13	drivers/tty/tty_ldisc.o
>    1328	      0	      0	   1328	    530	drivers/tty/tty_ldsem.o
>     316	      0	      0	    316	    13c	drivers/tty/tty_mutex.o
>    2516	      0	      0	   2516	    9d4	drivers/tty/tty_port.o
>   45241	    578	    252	  46071	   b3f7	(TOTALS)
> 
> When CONFIG_TTY=n and CONFIG_MINITTY_SERIAL=y, the above files are replaced
> by the following:
> 
>    text	   data	    bss	    dec	    hex	filename
>    8063	      8	     64	   8135	   1fc7	drivers/tty/serial/minitty_serial.o
> 
> That's it!  And the runtime buffer usage is much less as well. Future plans
> such as removing runtime baudrate handling for those targets with a known
> fixed baudrate will shrink the code even more.

Thanks for the resend.  I agree with your goal of getting Linux running
on these very tiny chips, I want that to happen too.  I'm traveling at
the moment for the next 2 weeks, but will review it in detail when I get
back.  It's in my queue, don't worry, it's not lost.

Ideally others would review it as well...

thanks,

greg k-h
