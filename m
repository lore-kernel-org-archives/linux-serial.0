From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 01 Mar 2016 22:28:13 +0300
Message-ID: <1456860493.23036.133.camel@gmail.com>
References: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	 <1456781209-11390-1-git-send-email-ynvich@gmail.com>
	 <1456830401.13244.189.camel@linux.intel.com>
	 <1456849504.23036.108.camel@gmail.com>
	 <1456850782.13244.208.camel@linux.intel.com>
	 <1456852472.23036.124.camel@gmail.com>
	 <1456854532.13244.215.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456854532.13244.215.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:SERIAL DRIVERS" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-03-01 at 19:48 +0200, Andy Shevchenko wrote:
> On Tue, 2016-03-01 at 20:14 +0300, Sergei Ianovich wrote:
> > On Tue, 2016-03-01 at 18:46 +0200, Andy Shevchenko wrote:
> > > On Tue, 2016-03-01 at 19:25 +0300, Sergei Ianovich wrote:
> > > > On Tue, 2016-03-01 at 13:06 +0200, Andy Shevchenko wrote:
> > > > > On Tue, 2016-03-01 at 00:26 +0300, Sergei Ianovich wrote:
>=20
> > > So, but if you support only fixed rates, why do you care about
> > > BOTHER
> > > at all?
> >=20
> > If BOTHER is defined,=C2=A0tty_termios_baud_rate()
> > and=C2=A0tty_termios_encode_baud_rate() allow non-standard baud rat=
es. I
> > should clear it from=C2=A0c_cflag to indicate I don't support it.
> >=20
> > > > > > =C2=A0
> > > > > I think you can call this unconditionally together with case
> > > > > >
> > > > > 115200.
> > > >=20
> > > > The calls are orthogonal. This one deals with the case when
> > > > BOTHER
> > > > is
> > > > defined and set, and we have non-zero rate with BOTHER, but we
> > > > have
> > > > zero rate after BOTHER is cleared. So we set 9600 as a sane
> > > > default
> > > > speed.
>=20
> Maybe you just set a baud rate nearest to the one from the table in
> case of BOTHER?
>=20
> In that case perhaps you have to supply +-1 to the range. That's why
> I
> asked about=C2=A0uart_get_baud_rate().=C2=A0
>=20
> Maybe this flow will work for you
>=20
> if (BOTHER)
> =C2=A0clear BOTHER
> =C2=A0call=C2=A0uart_get_baud_rate()
>=20
> ?

It works well for standard rates, let it be so. If there ever is a
problem, we can fix it.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
