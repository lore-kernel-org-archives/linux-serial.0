From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Thu, 13 Apr 2017 02:26:41 +0200
Message-ID: <20170413002641.ypeofsh57fdiis5g@earth>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
 <20170410231041.vz35anezpzhscu4t@earth>
 <4FEFA1D8-BE23-40FB-BAA3-3EC910FE9F96@holtmann.org>
 <20170411140637.GA4388@kroah.com>
 <C16140C4-0264-411B-9058-0B9013AAC82F@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyphekhu7hwajixy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C16140C4-0264-411B-9058-0B9013AAC82F-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--zyphekhu7hwajixy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Wed, Apr 12, 2017 at 10:19:21PM +0200, Marcel Holtmann wrote:
> Hi Sebastian,
>=20
> >>>>>>>> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed al=
l comments from
> >>>>>>>> Rob and Pavel regarding the serdev patches and dropped the *.dts=
 patches, since
> >>>>>>>> they were queued by Tony. I also changed the patch order, so tha=
t the serdev
> >>>>>>>> patches come first. All of them have Acked-by from Rob, so I thi=
nk it makes
> >>>>>>>> sense to merge them to serdev subsystem (now) and provide an imm=
utable branch
> >>>>>>>> for the bluetooth subsystem.
> >>>>>>>=20
> >>>>>>> Greg doesn't read cover letters generally and since the serdev pa=
tches
> >>>>>>> are Cc rather than To him, he's probably not planning to pick the=
m up.
> >>>>>>=20
> >>>>>> I wonder actually if we should merge all of these via bluetooth-ne=
xt
> >>>>>> tree with proper Ack from Greg. However it would be good to also g=
et
> >>>>>> buy in from Dave for merging this ultimately through net-next.
> >>>>>=20
> >>>>> I don't really care where it goes.  I can take the whole thing in my
> >>>>> tty/serial tree now if no one objects and I get an ack from the rel=
evant
> >>>>> maintainers {hint...}
> >>>>=20
> >>>> I think it is better if it goes thru BT tree. I have another driver
> >>>> converted that is dependent on this series. There's a couple other
> >>>> serdev changes on the list too, but this shouldn't depend on them.
> >>>=20
> >>> Is this waiting for something, or could it be queued to
> >>> bluetooth-next then? It would be nice to finally have
> >>> this in 4.12 :)
> >>=20
> >> I would prefer if we can get an ACK from Greg. Then I merge it through=
 the bluetooth-next tree.
> >=20
> > Sorry thought this was coming through mine:
> > 	Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> >=20
> > Merge away!
>=20
> so I have applied patches 1-8 to bluetooth-next tree.
>=20
> The last 2 I left out since they do cause build issues on non-DT
> platforms. We need to be able to build the driver on all platforms
> so that sanity compile checks happen all the time.
>=20
>   CC      drivers/bluetooth/hci_nokia.o
> drivers/bluetooth/hci_nokia.c:802:34: error: array type has incomplete el=
ement type =E2=80=98struct of_device_id=E2=80=99
>  static const struct of_device_id nokia_bluetooth_of_match[] =3D {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/hci_nokia.c:803:4: error: field name not in record or u=
nion initializer
>   { .compatible =3D "nokia,h4p-bluetooth", },
>     ^
> drivers/bluetooth/hci_nokia.c:803:4: note: (near initialization for =E2=
=80=98nokia_bluetooth_of_match=E2=80=99)
> drivers/bluetooth/hci_nokia.c:815:21: error: implicit declaration of func=
tion =E2=80=98of_match_ptr=E2=80=99 [-Werror=3Dimplicit-function-declaratio=
n]
>    .of_match_table =3D of_match_ptr(nokia_bluetooth_of_match),
>                      ^~~~~~~~~~~~
> drivers/bluetooth/hci_nokia.c:802:34: warning: =E2=80=98nokia_bluetooth_o=
f_match=E2=80=99 defined but not used [-Wunused-variable]
>  static const struct of_device_id nokia_bluetooth_of_match[] =3D {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~

Building without CONFIG_OF should work already. Note, that its
actually enabled in your build, since nokia_bluetooth_of_match
is guarded by "#ifdef CONFIG_OF". The actual problem is, that
<linux/of.h> is not included in your build. Looks like it was
implicitly included in my configurations, so I didn't notice.
I will send PATCHv4 with the added include and includes sorted
alphabetically.

-- Sebastian

--zyphekhu7hwajixy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuxb8ACgkQ2O7X88g7
+ppH8g//Wv9ukhxEOa2T0ZCLhhWnIL0i7k80USILvnJpP3pwBSQt2uHxOQ+ILlYe
h7Z6jN2uoGOaB4KYz2satUTdNZJHZyZ2ikWyczlMUmEjuvBWfvVPJdygowbar8zM
N/4O1BO+tLPYg90GslwodNIip67cJPk7tsUcfsz5Hnwh5FvFrt47x24ejBcXhjN3
WjUEyLMzZxLktdSMGO64Az3udsdgcfbcQTHmzSAeQVKzDpz5k52p+zOwdbTkPvFA
fUW1my2deNXOopn9mTeLRg1qVVAimq3V01JEoQcozKEXFCRsnx0DRQzDi4ShMoP2
jkrqwbfxGLoqLFr80AZAMrQbXYPyHawGmtu1xufvLqvWViwUvcn/vT07oPgGQSvr
5UUeLCXOxPgDM1l2BtWNr1Ddn3hNF4zSns7xJHDyHwOSmGWqXX89Gqw1/H7gTBz+
O2v+T0mFf88QRVLLsHrPV+DUEknQO+US0sjFQuwxhyFN0++a/BDE6u9ggWGCBSMY
4cO+r863UcXVsPipx2g1ixuWEpVscuFVybu63nobfHX92FQTI8QNrRFcHZKgBuY9
HpRtk21Q7S/7vxBPm+jKtbbJXwJ3lGOBSX7uPLOTK1fZpOmk4YEPWMe1vQa6uM4R
zkt6B3SeqVpZttERT1TKA1lulCWaegF99faFh80DfJenMqKMkgI=
=LMr4
-----END PGP SIGNATURE-----

--zyphekhu7hwajixy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
