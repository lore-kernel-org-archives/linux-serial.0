From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] tty: serial_core: Fix the incorrect configuration of
 baud rate and data length at the console serial port resume
Date: Tue, 14 May 2019 09:34:57 +0200
Message-ID: <20190514073457.GI9651@localhost>
References: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lanqing Liu <liuhhome@gmail.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: baolin.wang@unisoc.com, baolin.wang@linaro.org, jslaby@suse.com, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com, orson.zhai@unisoc.com, zhang.lyra@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thu, May 09, 2019 at 01:42:39PM +0800, Lanqing Liu wrote:
> When userspace opens a serial port for console, uart_port_startup()
> is called. This function assigns the uport->cons->cflag value to
> TTY->termios.c_cflag, then it is cleared to 0. When the user space
> closes this serial port, the TTY structure will be released, and at
> this time uport->cons->cflag has also been cleared.
> 
> On the Spreadtrum platform, in some special scenarios, like charging mode,
> userspace needs to close the console, which means the uport->cons->cflag
> has also been cleared. But printing logs is still needed in the kernel. So
> when system enters suspend and resume, the console needs to be configure
> the baud rate and data length of the serial port according to its own cflag
> when resuming the console port. At this time, the cflag is 0, which will
> cause serial port to produce configuration errors that do not meet user
> expectations.

This is actually yet another regression due to 761ed4a94582 ("tty:
serial_core: convert uart_close to use tty_port_close") which
incidentally removed the call to uart_shutdown() where the cflag was
being saved precisely to avoid the problem you're describing:

	ae84db9661ca ("serial: core: Preserve termios c_cflag for console resume")

Judging from a quick look it seems the xmit buf, which is released in
that function may now be leaking too.

> To fix this, assigning the TTY->termios.c_cflag value to uport->cons->cflag
> before the userspace closes this console serial port. It will ensure that
> the correct cflag value can be gotten when the console serial port was
> resumed.

Not sure this is the right fix, but I don't have time to look at this
right now.

Johan
