From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Subject: Re: usb_wwan regression in 3.6 kernel (bisected to bulk-urb allocation)
Date: Thu, 03 Apr 2014 10:03:10 +0200
Message-ID: <87wqf696wx.fsf@nemi.mork.no>
References: <CACna6ry7WCou6kacACpQK6qhWffCGNGFyLQU8H9WbrVDLoB7Qg@mail.gmail.com>
	<20140403071819.GE22587@localhost>
	<CACna6rzgnU_=2Gg4v1xk3-KX+zx6G85NksoJiZvbzGyzf+GQ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACna6rzgnU_=2Gg4v1xk3-KX+zx6G85NksoJiZvbzGyzf+GQ_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Thu, 3 Apr 2014
 09:23:40 +0200")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Urlichs <smurf-ci3XGGwdvIcvfNposrsB4g@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           0
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0=20
>       ** UNRECOGNIZED:  05 24 00 10 01
>       ** UNRECOGNIZED:  05 24 15 00 01
>       ** UNRECOGNIZED:  05 24 06 00 00
>       ** UNRECOGNIZED:  15 24 12 20 01 98 b0 6a 49 b0 9e 48 96 94 46 =
d9 9a 28 ca 4e 5d
>       ** UNRECOGNIZED:  06 24 13 00 01 10
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       1
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0=20
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>  =20


Hmm, AFAICS we never change altsettings in the option/usb_wwan/
usb-serial probing, so this function ends up without any endpoints at a=
ll.
As such it should just have failed the probe.  But the option driver ha=
s
a static num_ports =3D 1, which looks like it is overriding the endpoin=
t
based calculation in usb_serial_probe() even for the case where
num_bulk_out =3D=3D 0.  That cannot be right...

I believe we should both change altsettings and fail if there still
aren't enough endpoints available.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
