From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 14:20:29 +0200
Message-ID: <1484050829.2133.9.camel@linux.intel.com>
References: <20170106162635.19677-1-robh@kernel.org>
         <8E1651EC-E9E5-4BB5-84CB-8CFEE08009BA@goldelico.com>
         <D24F4B26-1F83-4154-A183-791C5C20DD1F@holtmann.org>
         <6C3E6EA6-5B22-47E8-B2B2-C37D4D080505@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6C3E6EA6-5B22-47E8-B2B2-C37D4D080505@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-01-10 at 13:10 +0100, H. Nikolaus Schaller wrote:

> > So the question is really if a driver only needs to do power
> > management on open() and close() or if it also has to translate or
> > transform the packets. There are devices who speak NMEA and all is
> > good.
> 
> The device I want to upstream the driver speaks NMEA but should be
> powered down unless accessed...

By the way, have you seen the series [1] I'm working on towards bringing
runtime PM for all (current) serial drivers?

[1] https://www.spinics.net/lists/linux-serial/msg24025.html

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
