From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: serial_core: recover uport->cons->cflag on
 uart_close
Date: Tue, 18 Jun 2019 09:51:29 +0200
Message-ID: <20190618075129.GA5758@kroah.com>
References: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kpark3469@gmail.com
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, keun-o.park@darkmatter.ae
List-Id: linux-serial@vger.kernel.org

On Sun, Jun 16, 2019 at 06:57:14PM +0400, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@darkmatter.ae>

I need a "full" name here please, something you use to sign legal
documents.

> Since uart_close was converted to use tty_port_close, uart_shutdown
> also moved to uart_tty_port_shutdown, which means it does not backup
> tty's termios to uart_port.console.cflag when console is closed and
> uart_console is true.
> By losing this value, serial console was not set correctly especially
> after suspend/resume when there is no consumer of console device.
> This problem resets console driver's configuration to an unwanted value
> and may give a performance regression in the system eventually.
> This patch fixes the bug introduced from v4.9 kernel.
> 
> Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
> Reported-by: Jouni Linnamaa <Jouni.Linnamaa@darkmatter.ae>
> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>

Same here as well.

thanks,

greg k-h
