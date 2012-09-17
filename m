From: "Steven J. Ackerman" <steve@acscontrol.com>
Subject: RE: Linux USB Serial
Date: Mon, 17 Sep 2012 17:56:46 -0400
Message-ID: <00c101cd951f$55626910$00273b30$@acscontrol.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> <87zk4o1kh4.fsf@nemi.mork.no> <00b801cd9518$715dd160$54197420$@acscontrol.com> <20120917214136.GA20773@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gwa4.webcontrolcenter.com ([63.134.207.18]:54298 "EHLO
	gwa4.webcontrolcenter.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304Ab2IQV5e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 17:57:34 -0400
In-Reply-To: <20120917214136.GA20773@kroah.com>
Content-language: en-us
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg KH' <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?'Bj=F8rn_Mork'?= <bjorn@mork.no>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Greg-

Thanks for your response.

Not sure if I need the cdc-acm functionality or not.

This is a color lcd display that supports a usb serial interface to
interact. I really=20
just need to be able to send and receive characters and NAK the pipe ba=
ck=20
temporarily when my input buffer is full.

The descriptors were supplied by the chip vendor - Renesas - as part of=
 a=20
CDC demo application. The VID/PID is ours. The device works great under=
=20
Windows XP with the descriptors as shown previously - even with the=20
Communications bInterfaceSubClass value wrong.

Doing the modprobe, etc. was based upon some blog posts that purported
to show how to add support for an unknown usb serial device.

Looking at the descriptor for a FTDI USB serial to TTL cable it seems a=
 lot
simpler,
but it does indicate vendor specific class, subclass and protocol - whi=
ch
means=20
that it requires a custom driver - ftdi_sio - right ?  I don't really w=
ant
to have to=20
develop and support that.

I don't think that I have enough Linux experience to be able to test a =
patch

and rebuild of the kernel, and I don't think that I can ask my customer=
s to
do=20
that it order to use our product as a simple serial display. =20

I'm running Ubuntu 10.10.

Any additional pointers and/or ideas would be greatly appreciated.

Thank you again,

Steven J. Ackerman, Consultant
ACS, Sarasota, FL
http://www.acscontrol.com
mailto:steve@acscontrol.com


> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, September 17, 2012 5:42 PM
> To: Steven J. Ackerman
> Cc: 'Bj=F8rn Mork'; linux-usb@vger.kernel.org; linux-serial@vger.kern=
el.org
> Subject: Re: Linux USB Serial
>=20
> On Mon, Sep 17, 2012 at 05:07:26PM -0400, Steven J. Ackerman wrote:
> > Bjrn-
> >
> > Thank you for your response.
> >
> > This change gets me closer. I can now successfully execute the modp=
robe
> > without error, but the device still doesn't show up in /dev/ttyUSB?=
 .
> >
> > sja@UBUNTU-10:~$ sudo modprobe usbserial vendor=3D0x0c6a
> product=3D0x0005
>=20
> Eeek, no, never do that with a device you actually want to use.  This
> should be controlled by the cdc-acm driver, not the usbserial driver.
> That driver should be auto-loaded for this device, but it looks like =
the
> descriptor is wrong, so it's not binding to it.
>=20
> Are you able to test a patch and rebuild the kernel to see if we can =
get
> this to work properly?
>=20
> thanks,
>=20
> greg k-h


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
