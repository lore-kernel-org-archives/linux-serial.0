From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: USB Smart Card reader
Date: Mon, 27 Feb 2012 12:36:20 -0800
Message-ID: <20120227203620.GA11896@kroah.com>
References: <CAAMvbhFzJv4EpQt4LavFeFusJsCDrFQ1EGhCdvgPG9q63s2AyA@mail.gmail.com>
 <20120225164118.GA21495@kroah.com>
 <CAAMvbhH5wyiWf+1i4FWkAwGRtAK=xdZejbrtThzEdgTURo+uqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44958 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2B0Ug2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Feb 2012 15:36:28 -0500
Received: by pbcup15 with SMTP id up15so2451014pbc.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2012 12:36:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAMvbhH5wyiWf+1i4FWkAwGRtAK=xdZejbrtThzEdgTURo+uqg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: linux-serial@vger.kernel.org

On Mon, Feb 27, 2012 at 08:17:50PM +0000, James Courtier-Dutton wrote:
> On 25 February 2012 16:41, Greg KH <greg@kroah.com> wrote:
> > On Sat, Feb 25, 2012 at 10:01:17AM +0000, James Courtier-Dutton wro=
te:
> >> Hi,
> >>
> >> I have done some development work on the iuu_phoenix.c driver in t=
he
> >> Linux kernel.
> >> The iuu_phoenix is a smart card reader.
> >> The smart card reader can be given a unique identification string =
of
> >> 16 characters/hex bytes. This ID can be read when the card reader =
is
> >> inserted into the USB port.
> >> I would like to be able to set up device names in /dev so that whe=
n
> >> inserting a card reader into the USB port, it always will appear w=
ithudev
> >> the same unique name in /dev.
> >> Similar to the by-uuid used for hard disk drives.
> >
> > Your distro should already have /dev/serial/ which provides this fo=
r you
> > automatically. =A0Have you used that and found it somehow lacking?
> >
>=20
> My question is how to I get the card reader ID, that is going to be
> read by a special usb request, to influence the name of the
> /dev/serial device name.
> If the first card reader has ID: 0001, and the second has the ID:
> 0002. The IDs are programmed into the EEPROM of the card reader. I
> would like the IDs to be passed to udev so that even if only one card
> reader with ID:0002 is plugged in, it always gets the same name in
> /dev/serial
> The reason for this, is so that someone can look at the device name i=
n
> /dev/serial and then know exactly which physical device it applies to=
=2E

If the card reader's "id" shows up in the serial number of the USB
device, /dev/serial/ will reflect this in the naming of the symlinks it
generates for the device.

Try it and see :)

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
