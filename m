From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB to Serial converter code pl2303
Date: Wed, 19 Feb 2014 18:14:06 +0100
Message-ID: <20140219171406.GH24335@localhost>
References: <1392688665.7323.32.camel@mange>
 <20140218090946.GA1954@localhost>
 <1392828260.3113.24.camel@mange>
 <20140219170039.GG24335@localhost>
 <5304E472.2000203@dct.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5304E472.2000203-QdlBTFngBEMsCylrc8G9yg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karsten Malcher <debian-QdlBTFngBEMsCylrc8G9yg@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Magnus <magnus-swe-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 19, 2014 at 06:05:54PM +0100, Karsten Malcher wrote:
> Am 19.02.2014 18:00, schrieb Johan Hovold:
> > I need an adapter that can handle 2400 Baud to talk to the
> > ft639/ede639 servo controller chip or possibly a pl2303 driver
> > that is improved.
> > The pl2303-driver can handle 2400 baud, but not sure exactly what b=
aud
> > rates are available for a cloned/pirated pl2303 chip (if that is wh=
at
> > you've got). 115200 baud should be supported, though.
>=20
> We have tested different baud rates with the PL2303HX china clones.
> All are working including non standard baud rates.

Ok, good, so 2400 baud should work.

> But the non standard baud rates are only available with the modified
> driver from Frank Sch=E4fer.

What driver is that? The latest clone-related patch from Frank that I'v=
e
seen stated:

	"According to Prolific, several (unauthorized) cheap and less
	 functional clones of the PL2303HX chip are in circulation. [1]
	 I've had the chance to test such a cloned device and it turned
	 out that it doesn't support any baud rates above 115200 baud
	 (original: 6 Mbaud) It also doesn't support the divisior based
	 baud rate encoding method, so no continuous baud rate adjustment
	 is possible."

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
