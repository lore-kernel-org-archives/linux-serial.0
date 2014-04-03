From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb_wwan regression in 3.6 kernel (bisected to bulk-urb
 allocation)
Date: Thu, 3 Apr 2014 12:17:29 +0200
Message-ID: <20140403101729.GG22587@localhost>
References: <CACna6ry7WCou6kacACpQK6qhWffCGNGFyLQU8H9WbrVDLoB7Qg@mail.gmail.com>
 <20140403071819.GE22587@localhost>
 <CACna6rzgnU_=2Gg4v1xk3-KX+zx6G85NksoJiZvbzGyzf+GQ_g@mail.gmail.com>
 <87wqf696wx.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wqf696wx.fsf-lbf33ChDnrE/G1V5fR+Y7Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn-yOkvZcmFvRU@public.gmane.org>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Urlichs <smurf-ci3XGGwdvIcvfNposrsB4g@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 03, 2014 at 10:03:10AM +0200, Bj=C3=B8rn Mork wrote:
> Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>=20
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           0
> >       bInterfaceClass       255 Vendor Specific Class
> >       bInterfaceSubClass    255 Vendor Specific Subclass
> >       bInterfaceProtocol    255 Vendor Specific Protocol
> >       iInterface              0=20
> >       ** UNRECOGNIZED:  05 24 00 10 01
> >       ** UNRECOGNIZED:  05 24 15 00 01
> >       ** UNRECOGNIZED:  05 24 06 00 00
> >       ** UNRECOGNIZED:  15 24 12 20 01 98 b0 6a 49 b0 9e 48 96 94 4=
6 d9 9a 28 ca 4e 5d
> >       ** UNRECOGNIZED:  06 24 13 00 01 10
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       1
> >       bNumEndpoints           2
> >       bInterfaceClass       255 Vendor Specific Class
> >       bInterfaceSubClass    255 Vendor Specific Subclass
> >       bInterfaceProtocol    255 Vendor Specific Protocol
> >       iInterface              0=20
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval              32
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x01  EP 1 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0200  1x 512 bytes
> >         bInterval              32
> >  =20
>=20
>=20
> Hmm, AFAICS we never change altsettings in the option/usb_wwan/
> usb-serial probing, so this function ends up without any endpoints at=
 all.
> As such it should just have failed the probe.  But the option driver =
has
> a static num_ports =3D 1, which looks like it is overriding the endpo=
int
> based calculation in usb_serial_probe() even for the case where
> num_bulk_out =3D=3D 0.  That cannot be right...

You're right. We should probably require both bulk in and out endpoints
in usb_wwan port_probe or return -ENODEV.

The (original option) driver was apparently written under the assumptio=
n
that either endpoint could be missing. It would handle opening a device
without bulk-in (but would blow up during resume which was likely
implemented later), but not a missing bulk-out in write() (although it
is handled in some places).

But since it also got the missing-end-point test wrong, this was never
a (critical) issue...

> I believe we should both change altsettings and fail if there still
> aren't enough endpoints available.

The option driver currently does not implement changing altsettings for
any device as you noted. And in fact, this wouldn't even be necessary
for all 19d2:0031. A quick search for lsusb -v output reveals that not
all devices have these altsettings. As we haven't heard of this issue
before, my guess is that the device in question is the odd one.

Would only using interface 3 be sufficient for now? I'd assume so as
this is reported as a regression (which triggers the oops, but the firs=
t
two interfaces can obviously never have been used for anything).

I'll cook up a patch for the end-point test during port_probe.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
