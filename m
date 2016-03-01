From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH v7] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 1 Mar 2016 19:53:22 +0000
Message-ID: <20160301195322.3eefcad8@lxorguk.ukuu.org.uk>
References: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	<1456781209-11390-1-git-send-email-ynvich@gmail.com>
	<1456830401.13244.189.camel@linux.intel.com>
	<1456849504.23036.108.camel@gmail.com>
	<1456850782.13244.208.camel@linux.intel.com>
	<1456852472.23036.124.camel@gmail.com>
	<1456854532.13244.215.camel@linux.intel.com>
	<1456860493.23036.133.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456860493.23036.133.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"open list:SERIAL DRIVERS" <lin>
List-Id: linux-serial@vger.kernel.org

> > Maybe this flow will work for you
> >=20
> > if (BOTHER)
> > =C2=A0clear BOTHER
> > =C2=A0call=C2=A0uart_get_baud_rate()
> >=20
> > ? =20
>=20
> It works well for standard rates, let it be so. If there ever is a
> problem, we can fix it.

I'm NAKking the v7 PATCH because we spent ages getting all the drivers =
to
use tty_termios_get_baud_rate() cleanly.

Get rid of everything in the ifdef BOTHER
Remove the if baud > 115200 stuff

=46or the default: entry in the case add

             tty_termios_encode_baud_rate(termios, 2400, 2400);

and all will be good. Anything not a standard rate will get 2400 baud a=
nd
reported back to the user properly as that rate.

You could do matches for "within 10%" but really I don't think it matte=
rs
and other drivers don't bother either when they have such fixed clocks.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
