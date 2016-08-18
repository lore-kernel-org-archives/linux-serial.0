From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:10:46 +0200
Message-ID: <20160818111046.GE7427@amd>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
 <20160818105521.GB7031@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160818105521.GB7031@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, herkne@gmx.de
List-Id: linux-serial@vger.kernel.org

Hi!

> > I am actually not convinced that GPS should be represented as
> > /dev/ttyS0 or similar TTY. It think they deserve their own driver
> > exposing them as simple character devices. That way we can have a
> > proper DEVTYPE and userspace can find them correctly. We can also
> > annotate them if needed for special settings.
> 
> I would _love_ to see that happen, but what about the GPS line
> discipline that we have today?  How would that match up with a char
> device driver?

./drivers/usb/serial/garmin_gps.c ?

Hmm, some cleanups would be welcome there... plus it would be good to
know what is its interface to userland... it is not easily apparent
from the code.

Actually, having some kind of common support for GPSes in the kernel
would be nice. (Chardev that spits NMEA data?) For example N900 GPS is
connected over network (phonet) interface, with userland driver
translating custom protocol into NMEA. Not very nice from "kernel
should provide hardware abstraction" point of view.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
