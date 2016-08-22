From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 22:32:23 +0100
Message-ID: <20160822223223.398ee72d@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
        <20160822180254.5c95af7c@lxorguk.ukuu.org.uk>
        <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
        <20160822183849.6dfdb9d2@lxorguk.ukuu.org.uk>
        <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2D07EA08-1055-4292-96B3-32913EC9BBE1@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> why would we even have it create a /dev/ttyX for these devices in the first place. Lets just not create an uevent for it and lets not create a dev_t for it.

Because if you don't it's a regression. It's not permissible to break
existing userspace.

> Internally the setup stage does a hciconfig hci0 up and it is already abstracted out that way. So there has been a lot of work in the Bluetooth subsystem to allow for this. That part is really solved.

So you'd create a kernel side tty struct and bind it to the tty_port on
hci0 up and drop it on hci0 down ?

Alan
