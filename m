From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: USB Smart Card reader
Date: Mon, 27 Feb 2012 20:17:50 +0000
Message-ID: <CAAMvbhH5wyiWf+1i4FWkAwGRtAK=xdZejbrtThzEdgTURo+uqg@mail.gmail.com>
References: <CAAMvbhFzJv4EpQt4LavFeFusJsCDrFQ1EGhCdvgPG9q63s2AyA@mail.gmail.com>
	<20120225164118.GA21495@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54968 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab2B0URv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Feb 2012 15:17:51 -0500
Received: by qcqw6 with SMTP id w6so1180889qcq.19
        for <linux-serial@vger.kernel.org>; Mon, 27 Feb 2012 12:17:50 -0800 (PST)
In-Reply-To: <20120225164118.GA21495@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On 25 February 2012 16:41, Greg KH <greg@kroah.com> wrote:
> On Sat, Feb 25, 2012 at 10:01:17AM +0000, James Courtier-Dutton wrote=
:
>> Hi,
>>
>> I have done some development work on the iuu_phoenix.c driver in the
>> Linux kernel.
>> The iuu_phoenix is a smart card reader.
>> The smart card reader can be given a unique identification string of
>> 16 characters/hex bytes. This ID can be read when the card reader is
>> inserted into the USB port.
>> I would like to be able to set up device names in /dev so that when
>> inserting a card reader into the USB port, it always will appear wit=
hudev
>> the same unique name in /dev.
>> Similar to the by-uuid used for hard disk drives.
>
> Your distro should already have /dev/serial/ which provides this for =
you
> automatically. =C2=A0Have you used that and found it somehow lacking?
>

My question is how to I get the card reader ID, that is going to be
read by a special usb request, to influence the name of the
/dev/serial device name.
If the first card reader has ID: 0001, and the second has the ID:
0002. The IDs are programmed into the EEPROM of the card reader. I
would like the IDs to be passed to udev so that even if only one card
reader with ID:0002 is plugged in, it always gets the same name in
/dev/serial
The reason for this, is so that someone can look at the device name in
/dev/serial and then know exactly which physical device it applies to.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
