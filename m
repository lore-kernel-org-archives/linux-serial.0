From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] serial/8250: remove comment about schedule_timeout
Date: Thu, 5 Jan 2017 15:17:45 -0200
Message-ID: <20170105171744.qgax752sxcwqod2w@calabresa>
References: <20170105154840.24795-1-cascardo@canonical.com>
 <20170105164016.79c6e594@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105164016.79c6e594@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 05, 2017 at 04:40:16PM +0000, One Thousand Gnomes wrote:
> On Thu,  5 Jan 2017 13:48:40 -0200
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> 
> > Ted T'so has added the function size_fifo in 1999 for the 2.3 series
> > [1], a long time ago.
> > 
> > During the 2.5 cycle, Russell King has restructured the serial drivers
> > and, in that process, has suggested using schedule_timeout instead of
> > mdelay in size_fifo. [2]
> > 
> > It was only at 2.6.7 that Greg Kroah-Hartman added the msleep function
> > to the core kernel, as people were starting to duplicate it. [3]
> > 
> > However, as size_fifo is called under a spinlock from the autoconfig
> > function, we might not use msleep here, so removing that comment is the
> > appropriate thing to do.
> 
> No.. it's still a flaw in the driver that we can't use msleep here. It's
> one of those things that people want to know if the probe locking ever
> gets restructured.
> 
> Alan

Okay. At first, I wanted to simply use msleep there, then realized there
was the spinlock. I thought I got a good writeup of the history that was
not in git yet, maybe we should just add a better comment and more
details in the commit log. How about this as the comment?

Cascardo.

---
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1731b98d2471..51efbfcfb922 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -796,7 +796,8 @@ static int size_fifo(struct uart_8250_port *up)
 	serial_out(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
 		serial_out(up, UART_TX, count);
-	mdelay(20);/* FIXME - schedule_timeout */
+	/* FIXME - use msleep when probe locking is restructured */
+	mdelay(20);
 	for (count = 0; (serial_in(up, UART_LSR) & UART_LSR_DR) &&
 	     (count < 256); count++)
 		serial_in(up, UART_RX);
