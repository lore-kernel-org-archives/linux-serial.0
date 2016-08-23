From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 01:15:21 +0100
Message-ID: <20160823011521.0ed94283@lxorguk.ukuu.org.uk>
References: <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
        <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
        <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
        <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
        <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
        <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
        <20160822220017.GA10689@amd>
        <20160822235414.4b2f8712@lxorguk.ukuu.org.uk>
        <20160822235758.gh33xupgyroye5wa@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822235758.gh33xupgyroye5wa@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> > That would still be a regression. Not everyone even uses the kernel
> > bluetooth stack. It would only return EBUSY if you had done an "up"
> > on it via the direct bluetooth stack.  
> 
> So it returns EBUSY when uart-bus is used. Since uart-bus is about
> hardwired devices that's basically always.

That would only be when the bluetooth port in question was active via the
hardwired interface - which is not always. You choose to turn on/off
bluetooth interfaces. If you boot with an older user space you'd use
hciattach instead.

In many cases you'll also still need the tty interface to do things like
firmware upgrades.

Alan
