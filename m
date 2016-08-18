From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 14:16:27 +0200
Message-ID: <3EC597BE-9348-4D44-B291-A0DB294851BE@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <20160818105521.GB7031@kroah.com> <20160818111046.GE7427@amd> <A8AFECE4-8501-4186-A834-5E08EEE8A0C4@goldelico.com> <951C95FD-35DD-4EC5-A62C-31378B85EF14@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <951C95FD-35DD-4EC5-A62C-31378B85EF14@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, herkne@gmx.de
List-Id: linux-serial@vger.kernel.org


> Am 18.08.2016 um 13:49 schrieb Marcel Holtmann <marcel@holtmann.org>:
>=20
> Hi Nikolaus,
>=20
>>>>> I am actually not convinced that GPS should be represented as
>>>>> /dev/ttyS0 or similar TTY. It think they deserve their own driver
>>>>> exposing them as simple character devices. That way we can have a
>>>>> proper DEVTYPE and userspace can find them correctly. We can also
>>>>> annotate them if needed for special settings.
>>>>=20
>>>> I would _love_ to see that happen, but what about the GPS line
>>>> discipline that we have today?  How would that match up with a char
>>>> device driver?
>>>=20
>>> ./drivers/usb/serial/garmin_gps.c ?
>>>=20
>>> Hmm, some cleanups would be welcome there... plus it would be good =
to
>>> know what is its interface to userland... it is not easily apparent
>>> from the code.
>>>=20
>>> Actually, having some kind of common support for GPSes in the kernel
>>> would be nice. (Chardev that spits NMEA data?
>>=20
>> Yes and no. How do you apply tcsetattr to such a device? More or less
>> by implementing another tty stack?
>>=20
>>> ) For example N900 GPS is
>>> connected over network (phonet) interface, with userland driver
>>> translating custom protocol into NMEA. Not very nice from "kernel
>>> should provide hardware abstraction" point of view.
>>=20
>> Indeed. In such a case the translation should be done in the kernel.
>> But it is not necessary for devices that already provide NEMA over =
UART.
>> Still user-space should be able to tcsetattr how it wants to see the =
records
>> (mainly CR/LF translations).
>=20
> I disagree here. NMEA is a standard and the kernel should just enforce =
framing of NMEA sentences.

AFAIR, NMEA was originally sort of a serial bus going through a ship. =
Where masters (a gps receiver)
can send records with position and speed data and clients (e.g. an =
auto-pilot) can receive them and
process their actions and send control commands to a motor / winding =
engine. But I would have to do
more research about this.

> It makes no difference what the CR/LF is. Userspace gets full =
sentences.

NMEA defines that devices connected to the NMEA source receive =
characters and not sentences.

For example an NMEA record defines a checksum. Should that also be =
exposed to user space or hidden?
How should checksum errors be reported or handled by the kernel?

I would agree if we want to write an abstract "position in geospace" =
driver/subsystem which reports
the position on surface and height and speed and direction. Then we can =
hide everything in the kernel.
But this would no longer send sentences to user space but cooked =
coordinates. More like iio data.

And next issue: how should we handle GPS devices with a bidirectional =
interface where sending
some special command sequence over the UART switches to SIRF or some =
other proprietary
mode? Then, the driver (ans Linux) can't squeeze that into NMEA =
sentences any more. By
doing this in the kernel we make it more inflexible.

Puh, when digging into this topic it becomes more and more complex and =
we are making it more
complex than it is currently working.

BR,
Nikolaus
