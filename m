From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 14:07:16 +0200
Message-ID: <9209AB2B-925D-4990-86A0-75DE8BFC721C@goldelico.com>
References: <20160818011445.22726-1-robh@kernel.org> <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com> <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org> <EE9DA3F6-382C-4930-8511-8D1C9A7D1E77@goldelico.com> <07FF6D1B-7B9B-441C-AFB9-E06AC5F469E2@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <07FF6D1B-7B9B-441C-AFB9-E06AC5F469E2-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

> Am 18.08.2016 um 13:41 schrieb Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>:
>=20
> Hi Nikolaus,
>=20
>>>>> Currently, devices attached via a UART are not well supported in =
the
>>>>> kernel. The problem is the device support is done in tty line =
disciplines,
>>>>> various platform drivers to handle some sideband, and in userspace =
with
>>>>> utilities such as hciattach.
>>>>>=20
>>>>> There have been several attempts to improve support, but they =
suffer from
>>>>> still being tied into the tty layer and/or abusing the platform =
bus. This
>>>>> is a prototype to show creating a proper UART bus for UART =
devices. It is
>>>>> tied into the serial core (really struct uart_port) below the tty =
layer
>>>>> in order to use existing serial drivers.
>>>>>=20
>>>>> This is functional with minimal testing using the loopback driver =
and
>>>>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the =
slave
>>>>> device). It still needs lots of work and polish.
>>>>>=20
>>>>> TODOs:
>>>>> - Figure out the port locking. mutex plus spinlock plus =
refcounting? I'm
>>>>> hoping all that complexity is from the tty layer and not needed =
here.
>>>>> - Split out the controller for uart_ports into separate driver. Do =
we see
>>>>> a need for controller drivers that are not standard serial =
drivers?
>>>>> - Implement/test the removal paths
>>>>> - Fix the receive callbacks for more than character at a time =
(i.e. DMA)
>>>>> - Need better receive buffering than just a simple circular buffer =
or
>>>>> perhaps a different receive interface (e.g. direct to client =
buffer)?
>>>>> - Test with other UART drivers
>>>>> - Convert a real driver/line discipline over to UART bus.
>>>>>=20
>>>>> Before I spend more time on this, I'm looking mainly for feedback =
on the
>>>>> general direction and structure (the interface with the existing =
serial
>>>>> drivers in particular).
>>>>=20
>>>> Some quick comments (can't do any real life tests in the next =
weeks) from my (biased) view:
>>>>=20
>>>> * tieing the solution into uart_port is the same as we had done. =
The difference seems to
>>>> me that you completely bypass serial_core (and tty) while we want =
to integrate it with standard tty operation.
>>>>=20
>>>> We have tapped the tty layer only because it can not be 100% =
avoided if we use serial_core.
>>>>=20
>>>> * one feedback I had received was that there may be uart device =
drivers not using serial_core. I am not sure if your approach addresses =
that.
>>>>=20
>>>> * what I don't see is how we can implement our GPS device power =
control driver:
>>>> - the device should still present itself as a tty device (so that =
cat /dev/ttyO1 reports NMEA records) and should
>>>> not be completely hidden from user space or represented by a new =
interface type invented just for this device
>>>> (while the majority of other GPS receivers are still simple tty =
devices).
>>>> - how we can detect that the device is sending data to the UART =
while no user space process has the uart port open
>>>> i.e. when does the driver know when to start/stop the UART.
>>>=20
>>> I am actually not convinced that GPS should be represented as =
/dev/ttyS0 or similar TTY. It think they deserve their own driver =
exposing them as simple character devices. That way we can have a proper =
DEVTYPE and userspace can find them correctly. We can also annotate them =
if needed for special settings.
>>=20
>> Yes, we can. But AFAIK no user space GPS client is expecting to have =
a new DEVTYPE.
>=20
> but we can fix userspace clients to deal with DEVTYPE.
>=20
>> I have several different GPS devices. One is by bluetooth. So I get a =
/dev/tty through hci. Another one has an USB cable. I get a /dev/tty =
through some USB serial converter. A third one is integrated in a 4G =
modem which provides a /dev/ttyACM port. So I always get something which =
looks like a /dev/tty... Seems to be pretty standard.
>=20
> Actually for Bluetooth RFCOMM it would be a lot better to use the =
RFCOMM socket instead of the TTY emulation. However that said, Bluetooth =
RFCOMM is already split in a way that you can have either a socket or a =
TTY emulation. There is nothing stopping us from adding a GPS emulation =
and with that natively hooking it up to a future GPS driver. I mean why =
not have a GPS subsystem that allows for that. I know this is future =
talk, but it can be done.
>=20
> Same goes for the USB GPS devices that use a serial converter. If they =
use proper VID:PID or some sort of identification, we can have a =
dedicated USB driver that matches it to a GPS device. At the end of the =
day, the only difference for the usb-serial driver is if it registers a =
TTY or a future GPS device.
>=20
> The 4G modem ones are a bit funky. Not all of them expose a ttyACM =
port btw. Some of them have the NMEA via Qualcomm QMI or some other =
channel. So inside oFono we have abstracted that into a file descriptor =
so that power control etc. is handled by oFono. Since you need to use =
the telephony stack to control the GPS state. But again here, there is =
nothing stopping us from moving parts of QMI into the kernel. We have =
done that for the Nokia ISI and the ST-Ericsson CAIF already.

Yes, agreed. But here we try to optimize the kernel and a specific =
variant of user space code. I am not sure if we should do that.

> However honestly, my main focus would be to get Bluetooth UARTs =
integrated natively without line discipline before I would worry about =
GPS.

Well, for me it is the opposite. I have no problem with running existing =
user space code like hciattach on a hci tty port. Even with older OS =
versions.
But I can't control the power of this GPS device with a standard user =
space mechanism. So for my GPS it either needs new kernel support to =
work with old and existing user space code or needs new user space code =
in projects I don't even know the name...

>=20
>> Yes it would be nice to have a /dev/gps2 device.
>>=20
>> And how do you want to control if the gps device should send records =
with cr / lf (INLCR, IGNCR)? Can you use tcsetattr?
>=20
> That needs to be seen. In general NMEA does not need it. However there =
is more than NMEA out there. Maybe it would need to focus on NMEA GPS =
anyway. As said above, oFono just hands out the NMEA sentences for QMI =
devices via file descriptor. So I am not sure we need to control that =
much.

Well, you must have some agreement between the device internals and the =
user space read() processor if CR LF are to be treated as a single line =
or two lines (one empty) or whatever. It can be controlled either by =
user space (ignore the empty line) or by tcsetattr. Is that something =
the kernel should enforce in this case? Or should the user space tell =
the kernel by tcsetattr? I really don't know..

>=20
> I mean with Bluetooth we have done a bunch of extra framing =
enforcement so that a read() only returns a full frame. So that =
userspace applications have it a lot easier and don't have to worry =
about byte-byte reading.

Indeed for Bluetooth it is sort of a low level network stack driver.

> Something similar could be done for GPS NMEA.

Yes it could, but I am not sure if Linux should solve this at all.

> Anyway, I am just pointing out ideas here. We do not have the UART bus =
upstream yet.

Indeed, we need an agreeable solution for that first.

Maybe the main problem is that too many unsolved ideas are tried to be =
squeezed into a single solution fits everyone.

BR,
Nikolaus
