From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Tue, 11 Apr 2017 01:10:42 +0200
Message-ID: <20170410231041.vz35anezpzhscu4t@earth>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dipfilb2pjqlqp5r"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--dipfilb2pjqlqp5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 05, 2017 at 01:16:58PM -0500, Rob Herring wrote:
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

Is this waiting for something, or could it be queued to
bluetooth-next then? It would be nice to finally have
this in 4.12 :)

-- Sebastian

--dipfilb2pjqlqp5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljsEO4ACgkQ2O7X88g7
+prlVw/8D5yHLn3bud/tGu5Vxk2egECRmepJuyttsUYiZJZnL23cxCcD5jIiFV69
FnrDbIUqhOCrDRHGI4Iz1nzYSBQj+XhN/TTY9ZrfPEqZ5vicKpLFjqPZ0U/Oksfw
Ok2uGpFzneXo9LJp7nMBK2+d8hxDR1bYb/x0bmwDbRJGfWzkhf55aJHXijU21pa8
2hguISP3yavnNCHv/mymGms+rRBjW23FF6fOEDwpexC3zO4HDy39Dw6Age0qzjWl
kHOFbTeG1Hw2ZD3w9OW7ROBIIEhG8zKSC/XseMFI8af5LR/7paL9BmLITug8qkh9
lbzlulq/t3cxAxX7RQeSait1bUjyOQmbHn9KWLYvL1Z05R3YlzHE3Io9Dz7HBoml
hI6/IgvTI7mafzKgnL48cvJPv7Tkpk0l5g72Iw7/MGPnVGAuvhAxlWuD6GzfFYrt
IHdso9aWvybdwfHQifu4j+nZxrE26lBok0B3fTAM8nQrl1EUHVDK428f3vR4Rp9n
RUbr9Ms+yPBWFEUN5VABVPqlKAcVDLPdB3ACm2YPEOF0FUJvc3n8k6AtYbKb9csA
QE17f+iEyhEhH2mOb7clb4+1At97fKu3WpsKF8FWpgNQXfu8RB3XNzpg+7ZdUHaw
4sfu+LmCPmRvLn0cLVwFaA5MXs0UvwH2Sm+2F6VE5qKBEydIJYU=
=S+Rs
-----END PGP SIGNATURE-----

--dipfilb2pjqlqp5r--
