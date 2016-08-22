From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 23:54:14 +0100
Message-ID: <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
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
        <20160822220017.GA10689@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822220017.GA10689@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 23 Aug 2016 00:00:17 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2016-08-22 22:32:23, One Thousand Gnomes wrote:
> > > why would we even have it create a /dev/ttyX for these devices in the first place. Lets just not create an uevent for it and lets not create a dev_t for it.  
> > 
> > Because if you don't it's a regression. It's not permissible to break
> > existing userspace.  
> 
> Well... it would be good to do the right thing, at least in the places
> where we can.
> 
> Yes, renumbering people's serials is bad, OTOH for new platforms it
> would be nice not to expose ttyS15 which can only return -EBUSY.

That would still be a regression. Not everyone even uses the kernel
bluetooth stack. It would only return EBUSY if you had done an "up" on it
via the direct bluetooth stack.

Alan
