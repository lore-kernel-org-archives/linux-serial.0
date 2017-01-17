From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Date: Tue, 17 Jan 2017 12:07:22 +0100
Message-ID: <20170117110722.GB26116@xo-6d-61-c0.localdomain>
References: <20170116225436.17505-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi!

> Here's a new version of the serdev bus support with all the review
> feedback so far incorporated. I've left it named serdev for now pending
> any further votes one way or the other, but I did rename the sysfs visible
> portions to "serial".
> 
> There's still some discussion about what to do with devices that pass thru
> data to userspace unmodified like GPS and could still use tty device for
> the data path. IMO, we should treat this as a separate problem following
> this series. Drivers we want to convert to serdev and already in the
> kernel don't need this functionality.
> 
> I need a SoB from Alan on his patch 2 and would like review from Alan and/or
> Peter on the locking in patch 5.
> 
> I have hacked up versions of the BT ldisc and TI ST drivers moved over to
> use the serdev bus. I have BT working on the HiKey board which has TI BT.
> With the serdev bus support, it eliminates the need for the TI userspace
> UIM daemon. I've made some progress cleaning up the TI-ST into proper
> patches and also got it working at 3Mbps.
> 
> Changelog is in individual patches. Previous version is here[1]. This
> series and the mentioned drivers can be found here[2].

Series looks good to me. Thanks for doing the work.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
