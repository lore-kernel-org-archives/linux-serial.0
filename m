From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: count tty buffer overruns
Date: Sat, 20 Jun 2015 09:57:18 -0700
Message-ID: <20150620165718.GA31390@kroah.com>
References: <558597B0.80104@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558597B0.80104@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: "manfred.schlaegl@gmx.at" <manfred.schlaegl@gmx.at>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Jun 20, 2015 at 06:41:20PM +0200, manfred.schlaegl@gmx.at wrote:
> As can be seen in function uart_insert_char (serial_core) the element
> buf_overrun of struct uart_icount is used to count overruns of
> tty-buffer.
> Added support for counting of overruns in imx driver analogue to
> serial_core.
> 
> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>

Your From: line in your email doesn't match this, please fix up and
resend.

Same goes for your other serial patch.

thanks,

greg k-h
