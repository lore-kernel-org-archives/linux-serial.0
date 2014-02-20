From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB to Serial converter code pl2303
Date: Thu, 20 Feb 2014 21:02:50 +0100
Message-ID: <20140220200250.GB16785@localhost>
References: <1392688665.7323.32.camel@mange>
 <20140218090946.GA1954@localhost>
 <1392828260.3113.24.camel@mange>
 <20140219170039.GG24335@localhost>
 <5304E472.2000203@dct.mine.nu>
 <20140219171406.GH24335@localhost>
 <53064721.3080905@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53064721.3080905-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank =?iso-8859-1?Q?Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Malcher <debian-QdlBTFngBEMsCylrc8G9yg@public.gmane.org>, Magnus <magnus-swe-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 20, 2014 at 07:19:13PM +0100, Frank Sch=E4fer wrote:
> Am 19.02.2014 18:14, schrieb Johan Hovold:

> > What driver is that? The latest clone-related patch from Frank that=
 I've
> > seen stated:
> >
> > 	"According to Prolific, several (unauthorized) cheap and less
> > 	 functional clones of the PL2303HX chip are in circulation. [1]
> > 	 I've had the chance to test such a cloned device and it turned
> > 	 out that it doesn't support any baud rates above 115200 baud
> > 	 (original: 6 Mbaud) It also doesn't support the divisior based
> > 	 baud rate encoding method, so no continuous baud rate adjustment
> > 	 is possible."
> This patch is still 100% valid.
> The "good" clones are detected as originals, which is fine.

Good to know. Thanks for clarifying.

Care to respin your refined-device-detection patches against the update=
d
driver in v3.14-rc?

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
