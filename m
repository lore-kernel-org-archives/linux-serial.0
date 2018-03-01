From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] earlycon: Allow specifying a uartclk in options
Date: Thu, 1 Mar 2018 19:42:52 +0100
Message-ID: <20180301184252.GA29304@kroah.com>
References: <20180301182028.237856-1-djkurtz@chromium.org>
 <57fb4f35-fd75-b2cc-75f7-8157ab1081d5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57fb4f35-fd75-b2cc-75f7-8157ab1081d5@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>, adurbin@chromium.org, briannorris@chromium.org, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 01, 2018 at 10:30:45AM -0800, Randy Dunlap wrote:
> On 03/01/2018 10:20 AM, Daniel Kurtz wrote:
> > Currently when an earlycon is registered, the uartclk is assumed to be
> > BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> > options, then 8250_early's init_port will program the UART clock divider
> > registers based on this assumed uartclk.
> > 
> > However, not all uarts have a UART clock of 1843200.  For example, the
> > 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> > cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> > on such a device will result in incorrect divider values and a wrong UART
> > clock.
> > 
> > Fix this by extending the earlycon options parameter to allow specification
> > of a uartclk, like so:
> > 
> >  earlycon=uart,mmio32,0xfedc6000,115200,48000000
> > 
> > If none is specified, fall-back to prior behavior - 1843200.
> > 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Hi,
> 
> Hopefully there will also be an update to one of
> Documentation/admin-guide/kernel-parameters.txt or
> Documentation/admin-guide/serial-console.rst.

Well, considering I'm not taking this patch unless it comes with such an
update, I'm hoping as well :)

greg k-h
