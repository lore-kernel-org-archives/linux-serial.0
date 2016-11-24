From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Thu, 24 Nov 2016 10:59:32 +0100
Message-ID: <20161124095932.GA14605@kroah.com>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <20161123100819.GA20137@kroah.com>
 <20161124082626.ge7t64fwrtx3slvo@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124082626.ge7t64fwrtx3slvo@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 24, 2016 at 09:26:26AM +0100, Sascha Hauer wrote:
> On Wed, Nov 23, 2016 at 11:08:19AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 23, 2016 at 11:01:03AM +0100, Sascha Hauer wrote:
> > > With this patch the serial core provides LED triggers for RX and TX.
> > > 
> > > As the serial core layer does not know when the hardware actually sends
> > > or receives characters, this needs help from the UART drivers. The
> > > LED triggers are registered in uart_add_led_triggers() called from
> > > the UART drivers which want to support LED triggers. All the driver
> > > has to do then is to call uart_led_trigger_[tx|rx] to indicate
> > > activity.
> 
> BTW last time LED triggers were discussed
> (https://patchwork.kernel.org/patch/9212885/) You and Arnd mandated the
> triggers should be implemented in the tty layer. By tty layer did you
> really mean the tty layer or did you mean serial_core?
> 
> We could implement it in the tty layer, but tty doesn't know when the
> characters are actually sent. There could be arbitrary time passing
> between a tty_operations->put_char and the character being on the wire.

With USB serial devices and even basic UARTs, you never really know when
"the character is on the wire", you can only guess.  And really, just
guessing is good enough given that no one is using this type of
interface to actually count when exactly the bits hit the wire.  This is
just for those that like blinky-lights :)

> Also I am not sure if we want to have LED triggers for each and every
> tty in the system

Why not?  It's opt-in by the user, so might as well let them do it for
whatever tty they want to.

thanks,

greg k-h
