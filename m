From: =?ISO-8859-1?Q?Kijam_L=F3pez?= <kijamve@gmail.com>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Mon, 14 Apr 2014 01:02:12 -0430
Message-ID: <CAMkwOQbscK+0qWAPLTJHQQg0H-jaGoSsGznw3Bssi_qAbEBedw@mail.gmail.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com> <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
 <20140414014410.GA5136@kroah.com> <CAMkwOQaqQgDzE430u3TOG85gtqrX-AK0nTWK9dYsJSk-JtK5Mg@mail.gmail.com>
 <20140414052323.GB11480@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39719 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaDNFcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2014 01:32:32 -0400
In-Reply-To: <20140414052323.GB11480@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

All commands and responses are formatted: STX data ETX LRC (I replace
No printable Char for [space]0xXX[space])

If I sent a ENQ answers his state, which is 2 bytes, so replies:  0x02
`@ 0x03 # (`@ is a two-byte mask representing the internal state of
the device)

If sending the S1 command, which is " 0x02 S1 0x03 a", I should say
something like this:
" 0x02 S100 0x0A 00000000000000000 0x0A 00000479 0x0A 00000 0x0A
00000330 0x0A 00000 0x0A 0061 0x0A 0000 0x0A X-XXXXXXXX 0x0A XXXXXXXXX
0x0A 221715 0x0A 120414 0x0A  0x03  0x1B "

In Windows OS, it works perfectly with the same PC and the same USB
adapter. But Linux is not responding. Or respond but the driver is not
interpreted correctly.

My Kernel is 3.12.6, but i updated from GitHub this file an rebuild
this drivers:
https://github.com/torvalds/linux/blob/master/drivers/usb/serial/ch341.=
c
https://github.com/torvalds/linux/blob/master/drivers/usb/serial/usb-se=
rial.c
(commit d9a38a8741fdffabc32e6d0943b1cdcf22712bec)


2014-04-14 0:53 GMT-04:30 Greg KH <gregkh@linuxfoundation.org>:
> On Mon, Apr 14, 2014 at 12:16:40AM -0430, Kijam L=F3pez wrote:
>> I reported here:
>>
>>      https://bugreports.qt-project.org/browse/QTBUG-38305
>>
>> But just migrate my APP to ANSI C and is exactly the same.
>>
>> My code test in ANSI C:
>>
>>      <snip>
>>      Test command: Fail
>
> I'm confused, what should it do?
>
> And what kernel version are you using here?
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
