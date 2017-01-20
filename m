From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Date: Fri, 20 Jan 2017 16:26:20 +0100
Message-ID: <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
References: <20170116225436.17505-1-robh@kernel.org> <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
 <20170120142242.GC5241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170120142242.GC5241@amd>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

oOn Fri, Jan 20, 2017 at 3:22 PM, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:

> Switched subject: Rob's work is great for GPS and bluetooth, but this
> goes beyond it.

Sure why not talk around a bit.

>> In my simple opinion GPSes shound live in drivers/iio/gps simply by
>> usecase association: streaming out a series of accelerometer readings
>> periodically through IIOs chardevs and other data about the physical
>> world is not any different from the GPS usecase that give you a stream
>> of coordinates on where on this planet you are.
>
> That is... not quite how GPSes work. What interface would you propose?
> It would be good to support error estimates in position/velocities and
> AGPS data upload.

Sorry for my ignorance. I have not had the opportunity to work
directly with a GPS hardware.

> Now, NMEA knows about some of the complexity (not AGPS), but gets the
> details wrong. In particular, it would be good to have error estimates
> and velocities from the same moment you get position estimates.

NMEA if it is this:
https://en.wikipedia.org/wiki/NMEA_0183

Seems to be a high-level format such as XML or CSV or any other
$FAVOURITE_ASCII_TRANSPORT format.

What we want to push into the ring buffer is of course the raw data
that is produced by the GPS hardware, whatever that may be.
If what we have is this text format we should not reverse-translate
it back any more than modem AT commands, it doesn't make sense
I guess.

So NMEA processing would be in userspace. And if the GPS is just
streaming this text data over to the client, like Marcel says, it is
more reasonable to just feed that up to userspace (no policy in the
kernel).

I am however aware of certain hardware such as the ST
Microelectronis STA2062 produced for Garmin, which is *not*
connected to any external chip, and is not talking over serial
to any RSx port, and does not have an embedded firmware running
on another SoC in any special GPS chip. And it is unassisted.

Maybe that is an oddity. In the mobile phone business I guess it
could be more common to have a separate SoC that by way
of standards just stream NMEA data.

Fusing that with other sensor data (accelerometer, compass, etc)
is again indeed a userspace task. I hope NMEA includes very good
timestamps.

Thanks,
Linus Walleij
