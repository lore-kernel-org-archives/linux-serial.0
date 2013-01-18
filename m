From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: Switch to using struct tty_port
Date: Fri, 18 Jan 2013 09:37:56 +0100
Message-ID: <20130118083756.GA3303@avionic-0098.adnet.avionic-design.de>
References: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de>
 <50F82FE7.9090403@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50F82FE7.9090403-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2013 at 10:07:51AM -0700, Stephen Warren wrote:
> On 01/17/2013 06:31 AM, Thierry Reding wrote:
> > Many of the tty functions were converted to use a struct tty_port
> > instead of a struct tty_struct. Update the Tegra driver accordingly to
> > avoid build breakage.
>=20
> I tested that this does indeed fix the build warnings. I didn't test the
> resultant driver.

I wonder if this would have been caught earlier if it had errored out
instead of outputting lots of warnings. Looking at the gcc documentation
there doesn't seem to be a way to turn this kind of warning into an
error. That would leave -Werror as the only option to have the compiler
abort on this kind of warning.

Globally enabling -Werror might not be a good idea and I'm sure it must
have been discussed in the past (even though Google doesn't show any
references). In this particular case the warnings are actually severe
errors and are very likely to cause buggy behaviour so it would be good
to catch them at compile time. Warnings are unfortunately quite easy to
ignore.

I know I can always use EXTRA_CFLAGS to change this for local builds,
but maybe getting more people to do this would be worthwhile.

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ+QnkAAoJEN0jrNd/PrOhHY4QALU+sRVVUzalMJ/fULEV+qor
Y6fDFwcgfRReLoUs5mM5SNgFApJc3rS39O9gtZRYuJLeUmmT7VmPw4QZpeB4UNqM
9wLtWzKUOZydDYy/pbg3FNBFCLMvBP3QeX9SrqnsUKtSfjaQk+GlOFWXU2hKZVxt
iG3QgJYciKfHV/c6XWGe8d+VJID7aZdie60TDfm+VkfPkfipMtJYRLt3cx/nbMHX
22cvToW50dgJ8QCR/a3R4um8asTTyN1jOrwTB08OQ2tB1VI+EGZwgenZewVkm/cf
EyJnilA7y3F27W1jiZ6LGbtJxaQA3cPi9oqJqLGM5KwcKmjfumXIVDya5sJ19cX8
B8toKCHVpEDls/HEuq6783CbJ+iHRY2wHxCkPrePOVwv52F4pgLAps4RQy4Zt3Wh
6j/SDvp1id0vjwWXkhNHITgWeIyG+fPljo695qPzs7vfQF4GEfvtMxhSD3XX3te5
9ZfNSDeB+MY1kLM2h7g2tfzkzAygcK1d2bpvE493hTOV84XooDqL/42jZRdcOm5v
LsF/g2CuWl6LO57bVq+LXrEiOVkUIccWQ6RRQ7zaTdeHecm+DXW53bGdOt+enQgt
Pt9od/TDywBTE8HzPKlfhYgQD255r+UcnWb4J7tAfsPq1YrEPWV018qcI0+M2/yO
mkdU9ouMKHY6AUfCV0be
=BSNT
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
