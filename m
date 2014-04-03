From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb_wwan regression in 3.6 kernel (bisected to bulk-urb
 allocation)
Date: Thu, 3 Apr 2014 09:18:19 +0200
Message-ID: <20140403071819.GE22587@localhost>
References: <CACna6ry7WCou6kacACpQK6qhWffCGNGFyLQU8H9WbrVDLoB7Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6ry7WCou6kacACpQK6qhWffCGNGFyLQU8H9WbrVDLoB7Qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Urlichs <smurf-ci3XGGwdvIcvfNposrsB4g@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 03, 2014 at 08:49:40AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> I recently wanted to use my ZTE MF636 modem 19d2:0031 and got NULL
> pointer dereference in usb_wwan_write few seconds after plugging it.
> This is 100% reproducible.
>=20
> BUG: unable to handle kernel NULL pointer dereference at 000000000000=
0058
> IP: [<ffffffffa07b9570>] usb_wwan_write+0xa0/0x2b0 [usb_wwan]
>=20
> I've bisected between 3.4 and 3.14 kernels and it has appeared to be =
a
> regression caused by:
>=20
> commit 8e493ca1767d4951ed1322abaa74d6edbca29918
> Author: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Fri Oct 26 18:44:20 2012 +0200
>=20
>     USB: usb_wwan: fix bulk-urb allocation
>=20
>     Make sure we do not allocate urbs if we do not have a bulk endpoi=
nt.
>=20
>     Legacy code used incorrect assumption to test for bulk endpoints.
>=20
> Reverting above patch from the 3.14 release fixes the NULL pointer
> dereference for me.
>=20
> Could you look into this, please? I can test any debug/fix patches yo=
u provide.

Thanks for the detailed report. Could you also provide the output of

	lsusb -vd 19d2:0031

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
