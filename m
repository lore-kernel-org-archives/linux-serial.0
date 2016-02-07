From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] serial: 8250: add gpio support to exar
Date: Sat, 6 Feb 2016 22:44:07 -0800
Message-ID: <20160207064407.GA24131@kroah.com>
References: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, andy.shevchenko@gmail.com, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 11:36:35AM +0530, Sudip Mukherjee wrote:
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
> Add support to use these pins.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---

I need an ack from the gpio maintainer before I can take this.

Or was it going to be reworked again?

thanks,

greg k-h
