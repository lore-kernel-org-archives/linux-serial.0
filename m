From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 00:00:17 +0200
Message-ID: <20160822220017.GA10689@amd>
References: <20160818011445.22726-1-robh@kernel.org>
 <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel>
 <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
 <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
 <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
 <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon 2016-08-22 22:32:23, One Thousand Gnomes wrote:
> > why would we even have it create a /dev/ttyX for these devices in the first place. Lets just not create an uevent for it and lets not create a dev_t for it.
> 
> Because if you don't it's a regression. It's not permissible to break
> existing userspace.

Well... it would be good to do the right thing, at least in the places
where we can.

Yes, renumbering people's serials is bad, OTOH for new platforms it
would be nice not to expose ttyS15 which can only return -EBUSY.

And we may want to do incompatible change at some point. People should
not have to use hciattach on n900 from now on until end of time, just
because we exposed USB port as ttyO1 in past.

...actually. I guess we should disable that ttyO1 in the device tree
for now, so nobody can start using it. As we currently have 2-3 people
in world who got that bluetooth to work with out-of-tree patches,
breakage should be quite acceptable :-).

Best regards,
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
