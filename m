From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch] tty/serial/8250: unlock on error in
 serial8250_register_8250_port()
Date: Wed, 31 Aug 2016 15:57:58 +0200
Message-ID: <20160831135758.GA13298@kroah.com>
References: <20160628091522.GA7720@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160628091522.GA7720@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anton Wuerfel <anton.wuerfel@fau.de>, Phillip Raffeck <phillip.raffeck@fau.de>, Peter Hurley <peter@hurleysoftware.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 28, 2016 at 12:15:22PM +0300, Dan Carpenter wrote:
> We need to unlock before returning here.
> 
> Fixes: 4ef03d328769 ('tty/serial/8250: use mctrl_gpio helpers')

I ended up reverting this patch, perhaps this is the problem that people
were having with this patch?

thanks,

greg k-h
