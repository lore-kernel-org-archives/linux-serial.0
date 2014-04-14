From: =?ISO-8859-1?Q?Kijam_L=F3pez?= <kijamve-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Driver CH341 USB Adapter Serial Port not Works in Linux
Date: Mon, 14 Apr 2014 02:12:40 -0430
Message-ID: <CAMkwOQZAFopifw=rUssXVyk1o1uXfpCmLS1j1pWccbmUkK-YVA@mail.gmail.com>
References: <CAMkwOQZXVQkQsLfbvZFKSLeqbYJZVVdRUDXT+UYe6As4NTtrMA@mail.gmail.com>
 <20140414012013.GA1882@kroah.com> <CAMkwOQa4Wm9vnyDce_tkf3J=h73A3NfX3oAwTaOUeEVduStC4Q@mail.gmail.com>
 <20140414014410.GA5136@kroah.com> <CAMkwOQaqQgDzE430u3TOG85gtqrX-AK0nTWK9dYsJSk-JtK5Mg@mail.gmail.com>
 <20140414052323.GB11480@kroah.com> <CAMkwOQbscK+0qWAPLTJHQQg0H-jaGoSsGznw3Bssi_qAbEBedw@mail.gmail.com>
 <CAMkwOQZe2Gr8YFXGOqdBMiG6nTJj-waJRa9sR2xcnwRuLpRAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMkwOQZe2Gr8YFXGOqdBMiG6nTJj-waJRa9sR2xcnwRuLpRAOA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

As a side note, I mentioned in a previous post, but remember, the
"delta =3D 0x01" I print, not the original driver.

  In https://github.com/torvalds/linux/blob/master/drivers/usb/serial/c=
h341.c
file on line 464 approximately, I wrote:

dev_info(&port->dev, "%s - delta=3D0x%02X\n", __func__, delta);


2014-04-14 2:06 GMT-04:30 Kijam L=F3pez <kijamve-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> By testing, sometimes even when ENQ command, if they leave these four=
 lines:
>
> ch341_update_line_status - multiple status change
> ch341_update_line_status - delta =3D 0x01
> ch341_update_line_status - multiple status change
> ch341_update_line_status - delta =3D 0x01
>
> Always gives Timeout. Apparently there is the problem ... I think XD.
>
> The problem with the driver gives me the kernel 3.12.6 original, a
> despairing attempt to update the two files you mentioned, but still
> always feel the same. Always respond timeout.
>
>
> 2014-04-14 1:02 GMT-04:30 Kijam L=F3pez <kijamve-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> All commands and responses are formatted: STX data ETX LRC (I replac=
e
>> No printable Char for [space]0xXX[space])
>>
>> If I sent a ENQ answers his state, which is 2 bytes, so replies:  0x=
02
>> `@ 0x03 # (`@ is a two-byte mask representing the internal state of
>> the device)
>>
>> If sending the S1 command, which is " 0x02 S1 0x03 a", I should say
>> something like this:
>> " 0x02 S100 0x0A 00000000000000000 0x0A 00000479 0x0A 00000 0x0A
>> 00000330 0x0A 00000 0x0A 0061 0x0A 0000 0x0A X-XXXXXXXX 0x0A XXXXXXX=
XX
>> 0x0A 221715 0x0A 120414 0x0A  0x03  0x1B "
>>
>> In Windows OS, it works perfectly with the same PC and the same USB
>> adapter. But Linux is not responding. Or respond but the driver is n=
ot
>> interpreted correctly.
>>
>> My Kernel is 3.12.6, but i updated from GitHub this file an rebuild
>> this drivers:
>> https://github.com/torvalds/linux/blob/master/drivers/usb/serial/ch3=
41.c
>> https://github.com/torvalds/linux/blob/master/drivers/usb/serial/usb=
-serial.c
>> (commit d9a38a8741fdffabc32e6d0943b1cdcf22712bec)
>>
>>
>> 2014-04-14 0:53 GMT-04:30 Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>:
>>> On Mon, Apr 14, 2014 at 12:16:40AM -0430, Kijam L=F3pez wrote:
>>>> I reported here:
>>>>
>>>>      https://bugreports.qt-project.org/browse/QTBUG-38305
>>>>
>>>> But just migrate my APP to ANSI C and is exactly the same.
>>>>
>>>> My code test in ANSI C:
>>>>
>>>>      <snip>
>>>>      Test command: Fail
>>>
>>> I'm confused, what should it do?
>>>
>>> And what kernel version are you using here?
>>>
>>> thanks,
>>>
>>> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
