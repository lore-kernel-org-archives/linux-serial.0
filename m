From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Thu, 24 Nov 2016 09:26:26 +0100
Message-ID: <20161124082626.ge7t64fwrtx3slvo@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <20161123100819.GA20137@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123100819.GA20137@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 23, 2016 at 11:08:19AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2016 at 11:01:03AM +0100, Sascha Hauer wrote:
> > With this patch the serial core provides LED triggers for RX and TX.
> > 
> > As the serial core layer does not know when the hardware actually sends
> > or receives characters, this needs help from the UART drivers. The
> > LED triggers are registered in uart_add_led_triggers() called from
> > the UART drivers which want to support LED triggers. All the driver
> > has to do then is to call uart_led_trigger_[tx|rx] to indicate
> > activity.

BTW last time LED triggers were discussed
(https://patchwork.kernel.org/patch/9212885/) You and Arnd mandated the
triggers should be implemented in the tty layer. By tty layer did you
really mean the tty layer or did you mean serial_core?

We could implement it in the tty layer, but tty doesn't know when the
characters are actually sent. There could be arbitrary time passing
between a tty_operations->put_char and the character being on the wire.

Also I am not sure if we want to have LED triggers for each and every
tty in the system

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
