From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH v6] serial: support for 16550A serial ports on LP-8x4x
Date: Mon, 29 Feb 2016 14:45:28 +0000
Message-ID: <20160229144528.0c0b8371@lxorguk.ukuu.org.uk>
References: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
	<1456589675-25377-1-git-send-email-ynvich@gmail.com>
	<1456741786.13244.167.camel@linux.intel.com>
	<1456750995.23036.87.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456750995.23036.87.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"open list:SERIAL DRIVERS" <lin>
List-Id: linux-serial@vger.kernel.org

> I haven't tested this mode. I am pretty sure it will fail. There is
> also no support for speeds higher than 115200.
>=20
> CS7 and CS8 at speeds up to 115200 work well.
>=20
> However, there is no way to report errors from=C2=A0set_termios(). Sh=
ould
> anything be done about those limitations?

You report back by setting the termios fields to the values actually
selected. Eg if you can't do CS5/CS6 you'd pick CS7 or CS8 and write th=
at
back into tty->termios so the caller knows what they actually got. Ditt=
o
for speed (see the 16550A core driver for the speed write backs).

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
