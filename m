From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: How to move serial8250_init out of the critical path to decrease
 boot time?
Date: Sun, 1 Apr 2018 10:05:46 +0200
Message-ID: <20180401080546.GA31356@kroah.com>
References: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Apr 01, 2018 at 09:11:15AM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> The goal is to boot a *distribution* Linux kernel as fast as possible. (The
> goal is currently 500 ms.)

What distro?

> With Linux 4.16-rc7, `serial8250_init()` takes almost 34 ms according to
> `initcall_debug` on the laptop TUXEDO Book BU1406 with an Intel Kaby Lake
> processor.
> 
> ```
> [    2.657950] calling  serial8250_init+0x0/0x168 @ 1
> [    2.657963] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    2.692598] initcall serial8250_init+0x0/0x168 returned 0 after 33820
> usecs
> ```
> 
> One problem is, that the distributions do not build this as a module,
> despite more and more devices do not actually have serial connectors, but
> the chipset still exposes them.

Then fix that in the distro kernel build.

> What options are there?

File a bug with the distro.

> 1.  Try to probe it asynchronously as in the attached patch, which is not
> tested yet.

Please test it and watch to see what breaks :)

good luck!

greg k-h
