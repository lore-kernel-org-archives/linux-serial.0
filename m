From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V3 3/4] serial: bcm2835: add driver for bcm2835-aux-uart
Date: Thu, 28 Jan 2016 14:34:14 -0800
Message-ID: <87h9hxfi55.fsf@eliezer.anholt.net>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org> <1453032932-2512-4-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453032932-2512-4-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> The bcm2835 SOC contains an auxiliary uart, which is very close
> to the ns16550 with some differences.
>
> The big difference is that the uart HW is not using an internal divider
> of 16 but 8, which results in an effictive baud-rate being twice
> the requested baud-rate.
>
> This driver handles this device correctly and handles the difference in
> the HW divider by scaling up the clock by a factor of 2.
>
> The approach to write a separate (wrapper) driver instead of using a
> multiplying clock and "ns16550" as compatibility in the device-tree
> has been recommended by Stephen Warren.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqpdnAAoJELXWKTbR/J7oQ0QQAII0o1h+Xu2zmmxHiLYLcyOu
R7o++ZUO7h94Hx0b0wgXblL6STooRt5Oiap2/Hd3ekjdcUrF/gfxgz/hWHJX8KC9
gMmHv+El9VpWZEbknFurp5re8mFd9lNCzdw8725JbzEJXVaZTnEoHOm0bpFLX44z
4aRlYHlfwqBBAMZJMOKLoKmuoXEWuJDXtY1/f0/fe/+LoLUTwLU8Z19PjYE6nthJ
I0QlHQN8PHZM8o7OAkJqthw72jpqH8D24g0UWz7gupxGyu3IgpqQSN7vfRasGiua
ri3yEtS6G13PIOGwQKJi1UPPXPOs2xNZiIEiUKAQaCj7b9JPYGUzUjaUnWVFa2Kt
0xy/DfrNwbOK+XDzGUlG04uf4AfgKPJZjdQKqCGVFKFtg/Dcr2YkcKk4WDKK+mCR
JC+Zfnrv/E6sDPKj8cAPxruj6pwgfY/8UxVlKA4vSLX8VIYQAKa98C3QMghMjZe3
g62E8KrDQZtwdlculDO53fJyfU1K/my84xs+ZmgIaTt4Kb0Ow7MZ1tZjjgA3237q
JntPhxWzN975Ulkr8TTmZCX0cyiBadc90piA3Sighj4NbDGPB1E7m6Cpl0mL29Vn
Ip/iwrJhIBBtREcMRPOohLL4kjg3ElIunamFn7UlQCr8pX+sZVDDbpvL+ODSAy+m
ACAH2xv665cvKOOEFjVV
=AVDY
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
