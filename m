From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v2 0/9] Serial slave device bus
Date: Fri, 20 Jan 2017 15:23:46 +0100
Message-ID: <C18BE7FF-2C6A-4EC3-8FB9-1E69796D1491@goldelico.com>
References: <20170116225436.17505-1-robh@kernel.org> <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com> <41321720-85FD-4CC0-8710-BB044DA37F6F@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <41321720-85FD-4CC0-8710-BB044DA37F6F-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


> Am 20.01.2017 um 15:14 schrieb Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>:
>=20
> Hi Linus,
>=20
>>> There's still some discussion about what to do with devices that =
pass thru
>>> data to userspace unmodified like GPS and could still use tty device =
for
>>> the data path. IMO, we should treat this as a separate problem =
following
>>> this series. Drivers we want to convert to serdev and already in the
>>> kernel don't need this functionality.
>>=20
>> In my simple opinion GPSes shound live in drivers/iio/gps simply by
>> usecase association: streaming out a series of accelerometer readings
>> periodically through IIOs chardevs and other data about the physical
>> world is not any different from the GPS usecase that give you a =
stream
>> of coordinates on where on this planet you are.
>>=20
>> The fact that vendors like to defer GPS processing to userspace =
because
>> it is considered "secret sauce" is not the concern of the kernel =
community,
>> though problems like that in general is the great tragedy of our =
time.
>>=20
>> It would be fun to see a pure, reverse-engineered GPS driver in IIO.
>=20
> except for the pure NMEA devices. Which are pretty much defined as =
terminal devices using RS422 and 4800 baud. For anything non-NMEA, I =
would agree that using IIO might be a good option. So instead of a GPS =
subsystem, might just have a GPS class / type in the IIO subsystem.

Well, we could implement a default NMEA parser in the iio subsystem to
translate satellite time, geolocation, orientation, speed, and satellite
signal strengths to iio channels.

On the other hand we have to wait until all user-space GPS applications
use it and appear in wider use in distribution. Let's say in 3-4 years?

Therefore, I'd like to see NMEA records passed to user space and not
shielded completely.

And some GPS devices send extensions to the core set of NEMA records,
which might give other useful information. Having this needs some
extensibility to the iio translation or side-channels.

BR,
Nikolaus
