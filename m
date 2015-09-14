From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 0/4] bcm2835: enable auxiliary uart1
Date: Mon, 14 Sep 2015 10:53:16 -0400
Message-ID: <87r3m1jbmr.fsf@eliezer.anholt.net>
References: <1441974053-2630-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441974053-2630-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
> The bcm2835-aux-uart is also special in such that it is enabled/disabled
> by a gate in the clock, which is managed by the clk-bcm2835-aux
> clock driver.
>
> there are 2 options:
> * defining the clock-frequency property in the device tree to 500k
>   instead of 250k, but this keeps the HW block disabled making the
>   uart not work.
> * defining a clock in the device tree, but this results in a baud rate
>   that is twice the requested baud-rate.
>
> To address this this patch-set introduce a new property in the device tree
> to define a clock divider other than 16.
>
> This currently just scales the clock by a factor of 16/divider.
>
> Note that the use of fixed-factor-clock has also been proposed as a
> workarround, but this does not really describe the hw in the device tree
> so another solution was needed that allows a correct representation of
> the HW in the device tree.

I personally lean toward the fixed-factor-clock solution, but could go
either way.  Serial maintainers, what do you think?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV9t9cAAoJELXWKTbR/J7ol2AQAJqjMTB5xhk0nm4LnV3FhOvd
FwlqVy0jHdNMjDqO+bxvGehczMCotdRpC6KezoI2/C490KLMN+mBTv/jUjfba73j
l+PGB0Fx5GUfFr8XTAlNip2KeAhGiN0llVce6jKH4Ip1Ix/HTskcxyPqm5TgMazU
YngIe3xQCehjGQnOW0ygOS1+OamV/z8yOAhV2uSbnfzMBdIRqn/u7RTa6VuDsLEj
v/uiJSoMRm4NcacMTtMXltcYURHk1MgQtgiZMcMRqzZZc1iW3oZgr+PUkmy+QeUU
CCcqM5qIz/4rEwz4RaiGEQWP4IXdKMYfv9hozey/YdywPfSNBknPbZXwcq83m9ns
faXHR0ABPvp2vlOoTJWjxfAdCl1Sm51nMrblicfwV88Z2QtuJQ1HTqgKVx/LM9X7
RVlcX9RRdtmGvNdDCm2ldHV28ygp8yYdNH7sT8P8MSDPfr+CujWTB5112wyiaTBH
w8T3lQVZmCvM5uXAQ8ejKd7vJIOMGfA3u840K7MfJJhCfxDGtPB8G+Kb0V5+xDj2
mobD5XHVkMBAKWE/rUuRqTNtIP+Ynhqj8VXTFA+DZRPGqpk0oqfF/p4bEcU0u6y1
3rJjkXpFkT72ianMw4u6hW0+gYqGkklF3F4GHbmlWb7uL7P23VUgzOLUVYV57gDd
/cxsUhtMpkzDqTpZjpXt
=Hodz
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
