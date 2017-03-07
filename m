From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/10] serdev: add serdev_device_get_cts
Date: Tue, 7 Mar 2017 22:12:43 +0100
Message-ID: <20170307211243.zecbitmkbozd3s2j@earth>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-9-sre@kernel.org>
 <CAL_Jsq+6NCC35zBMhvNhXug2sYmBqBoJ20pgdREhvRPGzePNkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgxp6za64zl6ol6z"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+6NCC35zBMhvNhXug2sYmBqBoJ20pgdREhvRPGzePNkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--xgxp6za64zl6ol6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Mar 07, 2017 at 10:03:37AM -0600, Rob Herring wrote:
> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > Add method to get current CTS line state.
> >
> > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/tty/serdev/core.c           | 11 +++++++++++
> >  drivers/tty/serdev/serdev-ttyport.c | 15 +++++++++++++++
> >  include/linux/serdev.h              |  6 ++++++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index a63b74031e22..36eb3dfb1477 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -184,6 +184,17 @@ void serdev_device_wait_until_sent(struct serdev_d=
evice *serdev, long timeout)
> >  }
> >  EXPORT_SYMBOL_GPL(serdev_device_wait_until_sent);
> >
> > +bool serdev_device_get_cts(struct serdev_device *serdev)
>=20
> I wonder if this should just be the wait for cts in the core. I think
> that would be the common use for reading the CTS state. IIRC, I saw
> some other device needing the same thing.

mh. I think it fits nicely to serdev_device_set_rts(). But I guess
it makes sense to have the wait feature directly in serdev. So I
suggest to add the function in addition to the simple get_cts
function. Does that make sense to you?

-- Sebastian

--xgxp6za64zl6ol6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAli/IksACgkQ2O7X88g7
+pqtkxAAl6AhKIaDXJkM/F0M6njSh9jVXfoqiVYKveFVaAFqQHOL0AdrLg9NAGec
twzIhdzvFOU7bkvky0pU+amhHeQmqjvmjVA1F2XpHlQedO2UhseFeBE9OAnhvqIO
04vckI3NVa/Zi30J7WylLOiRyBIW5tGjs5OOPdfbxeScSIoeeBFOBFNwpIYngy4i
yCpbl5AVrVw/YDJ5rEU4x/dqco7vvaBorypO+nRFpC7krsHBEDeq2w5WEM64BaP1
UvorgbcTaW3LnZjqAcYAVhOJZ+y3Gwqc6hNQNbI4dEmhi8SGAjnCNczchDcbDN4N
b+IDOB9uSbsvznghWW1AkDUJ7wmG5CKiqyFV0+KAko3Po0F6a1R7ZjDGcGYRJpa+
1yI5jqx4ACCF7NxeVkAmI+5+RmHCmcVZUiwPauq6k6+PE0rWpxeALw7Z50pyYO8t
iUnhnp4Bc2tTPgDF1WCumCCnj3jqQSnkH2HxkJYckYpPilqjBCmo0sC8mEUKx1G5
yEYgoo1UL/iKTau3HqLVNxa1RV3/yitfoIFR57iyx6lGeoymFX5PNxg3+gdE0t5a
m2CivqtZky6NJZXN9rU9C9fBRQGTtD0GN8RhKIsUTMlWjbEoib/F6RZ/kcHX/YqW
mruMSF4Mi5U7OmRO5UUfpu+J8zjDcj2mqrTRT43SXg41ZZ3Zqes=
=jydG
-----END PGP SIGNATURE-----

--xgxp6za64zl6ol6z--
