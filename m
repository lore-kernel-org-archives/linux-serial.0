From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 2/3] tty/serial: at91: fix hardware handshake with GPIOs
Date: Thu, 22 Sep 2016 11:47:49 +0200
Message-ID: <20160922094749.GA31898@kroah.com>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-3-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160912094733.21501-3-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 12, 2016 at 11:47:32AM +0200, Richard Genoud wrote:
> Commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
> hardware handshake is enabled") broke the hardware handshake when GPIOs
> where used.
> 
> Hardware handshake with GPIOs used to work before this commit because
> the CRTSCTS flag (termios->c_cflag) was set, but not the
> ATMEL_US_USMODE_HWHS flag (controller register) ; so hardware handshake
> enabled, but not handled by the controller.
> 
> This commit restores this behaviour.
> 
> NB: -stable is not Cced because it doesn't cleanly apply on 4.1+
> and it will also need previous commit:
> "serial: mctrl_gpio: implement mctrl_gpio_use_rtscts"
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Fixes: 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when hardware handshake is enabled")
> ---
>  drivers/tty/serial/atmel_serial.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

This patch doesn't apply to my tree, are you sure it's up to date?

Can you please refresh this whole series against linux-next and resend?

thanks,

greg k-h
