From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [patch] tty/serial/8250: unlock on error in
 serial8250_register_8250_port()
Date: Wed, 31 Aug 2016 19:11:01 +0300
Message-ID: <1472659861.4887.413.camel@linux.intel.com>
References: <20160628091522.GA7720@mwanda>
         <20160831135758.GA13298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160831135758.GA13298@kroah.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, Jiri Slaby <jslaby@suse.com>, Anton Wuerfel <anton.wuerfel@fau.de>, Phillip Raffeck <phillip.raffeck@fau.de>, Peter Hurley <peter@hurleysoftware.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-08-31 at 15:57 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 28, 2016 at 12:15:22PM +0300, Dan Carpenter wrote:
> > 
> > We need to unlock before returning here.
> > 
> > Fixes: 4ef03d328769 ('tty/serial/8250: use mctrl_gpio helpers')
> 
> I ended up reverting this patch, perhaps this is the problem that
> people
> were having with this patch?

Nope, I tried this fix, didn't help.
Mika put the details in his message I mentioned in the patch:

Link: https://lkml.kernel.org/r/20160809130229.GN1729@lahna.fi.intel.com

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
