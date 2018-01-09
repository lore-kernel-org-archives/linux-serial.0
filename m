From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gpio: serial: max310x: Support open-drain configuration
 for GPIOs
Date: Tue, 9 Jan 2018 16:37:21 +0100
Message-ID: <20180109153721.GA17957@kroah.com>
References: <18c9e927d2b75b3325ee3eae7e78319129faa779.1513983040.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <18c9e927d2b75b3325ee3eae7e78319129faa779.1513983040.git.jan.kundrat@cesnet.cz>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc: linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 22, 2017 at 09:29:44PM +0100, Jan Kundrát wrote:
> The push-pull vs. open-drain are the only supported output modes. The
> inputs are always unconditionally equipped with weak pull-downs. That's
> the only mode, so there's probably no point in exporting that. I wonder
> if it's worthwhile to provide a custom dbg_show method to indicate the
> current status of the outputs, though.
> 
> This patch and [1] for i2c-gpio together make it possible to bit-bang an
> I2C bus over GPIOs of an UART which is connected via SPI :). Yes, this
> is crazy, but it's fast enough (while on a 26Mhz SPI HW bus with a
> dual-core 1.6GHz CPU) to drive an I2C bus at 200kHz, according to my
> scope.
> 
> [1] https://patchwork.ozlabs.org/patch/852591/
> 
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> My suggestion is for this patch to go in via the tty/serial tree; I plan
> to send more patches to this driver (and some of them are alreay in
> tty-next). --jkt

Doesn't apply to my tty-next branch, so I can't apply it, please rebase
and resend.

thanks,

greg k-h
