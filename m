From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Date: Fri, 20 Jan 2017 18:16:11 +0200
Message-ID: <1484928971.2133.273.camel@linux.intel.com>
References: <20170116225436.17505-1-robh@kernel.org>
         <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
         <20170120142242.GC5241@amd>
         <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-01-20 at 16:26 +0100, Linus Walleij wrote:

> > Now, NMEA knows about some of the complexity (not AGPS), but gets
> > the
> > details wrong. In particular, it would be good to have error
> > estimates
> > and velocities from the same moment you get position estimates.
> 
> NMEA if it is this:
> https://en.wikipedia.org/wiki/NMEA_0183
> 
> Seems to be a high-level format such as XML or CSV or any other
> $FAVOURITE_ASCII_TRANSPORT format.

Not exactly. It depends on device settings.
Old GPS I used to play with have AT command to switch between ASCII and
binary format. Some of the devices might use non-standard binary
protocols (however, representable as NMEA), etc.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
