From: "Steven J. Ackerman" <steve@acscontrol.com>
Subject: RE: Linux USB Serial
Date: Mon, 17 Sep 2012 17:07:26 -0400
Message-ID: <00b801cd9518$715dd160$54197420$@acscontrol.com>
References: <00a301cd950a$ae9081d0$0bb18570$@acscontrol.com> <87zk4o1kh4.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gwa4.webcontrolcenter.com ([63.134.207.18]:45788 "EHLO
	gwa4.webcontrolcenter.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2IQVIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 17:08:14 -0400
In-Reply-To: <87zk4o1kh4.fsf@nemi.mork.no>
Content-language: en-us
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?'Bj=C3=B8rn_Mork'?= <bjorn@mork.no>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Bjrn-

Thank you for your response.

This change gets me closer. I can now successfully execute the modprobe
without error, but the device still doesn't show up in /dev/ttyUSB? .

sja@UBUNTU-10:~$ sudo modprobe usbserial vendor=3D0x0c6a product=3D0x00=
05
sja@UBUNTU-10:~$ lsusb
Bus 005 Device 004: ID 0c6a:0005 =20
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 003: ID 045e:0048 Microsoft Corp. Office Keyboard 1.0A
Bus 002 Device 002: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

I guess it's still not happy about something...

Steven J. Ackerman, Consultant
ACS, Sarasota, FL
http://www.acscontrol.com
mailto:steve@acscontrol.com


> -----Original Message-----
> From: Bj=C3=B8rn Mork [mailto:bjorn@mork.no]
> Sent: Monday, September 17, 2012 4:08 PM
> To: Steven J. Ackerman
> Cc: linux-usb@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: Linux USB Serial
>=20
> "Steven J. Ackerman" <steve@acscontrol.com> writes:
>=20
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           1
> >       bInterfaceClass         2 Communications
> >       bInterfaceSubClass     32
>=20
> Looks like your bInterfaceSubClass is nibble swapped.  It should be 0=
x02
> for ACM, not 0x20.
>=20
>=20
> Bjrn


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
