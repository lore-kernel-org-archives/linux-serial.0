From: "Vitaly V. Ch" <vitaly.v.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Review and minor fixes for ftdi_sio.c
Date: Sat, 6 Feb 2010 12:18:04 +0200
Message-ID: <6efe08af1002060218i614eebe8w860ec063878e0564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuba-6OO/Rnbgvk2D7HvB/+pQRQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 5, 2010 at 6:38 PM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Feb 05, 2010 at 11:54:56AM +0200, Vitaly V. Ch wrote:
>> Hi all!
>>
>> I'm find then ftdi_sio.c in 2.4.37.8 kernel have next bug: if I have
>> three ftdi-232 simultaneously connected to middle-loaded host,
>> application which use one of them will hung in driver, usually durin=
g
>> few hour.
>
> Can you look at the version in 2.6.33-rc6, and also in the linux-next
> tree? =A0Both of those have changes to this driver already done, and
> hopefully this fixes your problem.

1)
Yes, I will see in that files but I can't use 2.6.xx kernel. I will
backport fixes to 2.4.37.8.


2)
> I don't know, what is the problem you are seeing here?

In kernel sources we have:

=A0 =A0 else if (divisor =3D=3D 1)
=A0 =A0 =A0 =A0 divisor =3D 0; =A0 =A0/* special case for maximum baud =
rate */

But there are reason to wait at this place:

=A0=A0 =A0 if (divisor =3D=3D 1)
=A0=A0 =A0 =A0 =A0 divisor =3D 0; =A0 =A0/* special case for maximum ba=
ud rate */

last version of code I found in driver downloaded from ftdichip.com.
and i'm not sure which of them is right. if anyone know - it will be
interested.


> If not, can you send a patch that I can apply (read
> Documentation/SubmittingPatches for how to do it)?

Ok, I will do it

>
> thanks,
>
> greg k-h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
