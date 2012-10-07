From: Greg KH <greg@kroah.com>
Subject: Re: PL2303 Driver Issue
Date: Sun, 7 Oct 2012 07:47:00 -0700
Message-ID: <20121007144700.GA18178@kroah.com>
References: <523E9909A6DFCF469669581BEB8DA7AA56928B25@G2W2441.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54315 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129Ab2JGOrD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Oct 2012 10:47:03 -0400
Content-Disposition: inline
In-Reply-To: <523E9909A6DFCF469669581BEB8DA7AA56928B25@G2W2441.americas.hpqcorp.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Reddy Kaveri, Praveen Kumar" <praveen-kumar.reddy-kaveri@hp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Sat, Oct 06, 2012 at 06:33:19PM +0000, Reddy Kaveri, Praveen Kumar w=
rote:
> Hi,
>=20
> I am using Telxon PTC-710 device in linux environment and I am using
> RS232 Serial to USB converter. When I connect the device to USB port
> it is detecting and showing in the system log as "attached to
> ttyUSB0".=A0 I have written a java program to display all the availab=
le
> ports. But this program is displaying only ttyS0 &ttyS1. I have tried
> to set all permissions to the user as well as to port. Please help me
> if I am missing any configuration related to this driver.

You are going to have to modify your userspace program to know to look
for the ttyUSBX devices as well.  There's nothing the kernel can do
about this.

As you wrote the program, how are you getting the list of serial device=
s
in the system?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
