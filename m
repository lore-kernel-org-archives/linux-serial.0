From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: move Non-standard serial drivers menu to the
 Serial drivers menu
Date: Fri, 4 Oct 2019 14:54:46 +0200
Message-ID: <20191004125446.GB583048@kroah.com>
References: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 25, 2019 at 06:16:28PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Since Non-standard serial port drivers are also Serial drivers,
> move the "Non-standard serial port support" menu to be under/in
> the "Serial drivers" menu. With this move, the "Serial drivers"
> menu contains (a) 8250/16550 support, (b) non-8250 support, and
> (c) non-standard serial port support.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/tty/Kconfig        |  119 -----------------------------------
>  drivers/tty/serial/Kconfig |  119 +++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+), 119 deletions(-)
> 
> --- lnx-53.orig/drivers/tty/Kconfig
> +++ lnx-53/drivers/tty/Kconfig
> @@ -151,125 +151,6 @@ config LEGACY_PTY_COUNT
>  	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
>  	  architectures and 24 bytes on 64-bit architectures.
>  
> -config SERIAL_NONSTANDARD
> -	bool "Non-standard serial port support"
> -	depends on HAS_IOMEM
> -	---help---
> -	  Say Y here if you have any non-standard serial boards -- boards
> -	  which aren't supported using the standard "dumb" serial driver.
> -	  This includes intelligent serial boards such as Cyclades,
> -	  Digiboards, etc. These are usually used for systems that need many
> -	  serial ports because they serve many terminals or dial-in
> -	  connections.
> -
> -	  Note that the answer to this question won't directly affect the
> -	  kernel: saying N will just cause the configurator to skip all
> -	  the questions about non-standard serial boards.
> -
> -	  Most people can say N here.
> -
> -config ROCKETPORT
> -	tristate "Comtrol RocketPort support"
> -	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)

I would agree with the move, but the files are not in
drivers/tty/serial/ for the drivers you are asking to configure in that
directory.

So unless we want to move these drivers (and it's not really worth it,
unless we want to create drivers/tty/serial/obsolete/ or something like
that), I would just leave this alone.

thanks,

greg k-h
