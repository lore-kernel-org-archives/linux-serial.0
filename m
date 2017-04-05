From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Wed, 5 Apr 2017 22:28:56 +0200
Message-ID: <20170405202856.GA4854@amd>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-04-05 13:16:58, Rob Herring wrote:
> On Fri, Mar 31, 2017 at 8:33 AM, Greg Kroah-Hartman
> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > On Wed, Mar 29, 2017 at 11:33:26PM +0200, Marcel Holtmann wrote:
> >> Hi Rob,
> >>
> >> >> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all c=
omments from
> >> >> Rob and Pavel regarding the serdev patches and dropped the *.dts pa=
tches, since
> >> >> they were queued by Tony. I also changed the patch order, so that t=
he serdev
> >> >> patches come first. All of them have Acked-by from Rob, so I think =
it makes
> >> >> sense to merge them to serdev subsystem (now) and provide an immuta=
ble branch
> >> >> for the bluetooth subsystem.
> >> >
> >> > Greg doesn't read cover letters generally and since the serdev patch=
es
> >> > are Cc rather than To him, he's probably not planning to pick them u=
p.
> >>
> >> I wonder actually if we should merge all of these via bluetooth-next
> >> tree with proper Ack from Greg. However it would be good to also get
> >> buy in from Dave for merging this ultimately through net-next.
> >
> > I don't really care where it goes.  I can take the whole thing in my
> > tty/serial tree now if no one objects and I get an ack from the relevant
> > maintainers {hint...}
>=20
> I think it is better if it goes thru BT tree. I have another driver
> converted that is dependent on this series. There's a couple other
> serdev changes on the list too, but this shouldn't depend on them.

I believe BT tree makes sense. Still it would be nice to get Greg's
ACK ...?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljlU4gACgkQMOfwapXb+vKSlgCgwAQ1xUEux3FwJeXT4ckoyptX
dQcAn067vq0A19O5wzzsEfdsYi0a8fQE
=/bfW
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
