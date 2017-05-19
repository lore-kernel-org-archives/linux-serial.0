From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] serial: 8250: Add CAP_MINI, set for bcm2835aux
Date: Fri, 19 May 2017 11:09:54 -0700
Message-ID: <87vaowg1l9.fsf@eliezer.anholt.net>
References: <8d9c605a-bff7-607c-2c5b-4ec75e68ac2d@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8455445288799048727=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8d9c605a-bff7-607c-2c5b-4ec75e68ac2d@raspberrypi.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Phil Elwell <phil@raspberrypi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren <stefan.wahren@i2se.com>, linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

--===============8455445288799048727==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Phil Elwell <phil@raspberrypi.org> writes:

> The AUX/mini-UART in the BCM2835 family of procesors is a cut-down
> 8250 clone. In particular it is lacking support for the following
> features: CSTOPB PARENB PARODD CMSPAR CS5 CS6
>
> Add a new capability (UART_CAP_MINI) that exposes the restrictions to
> the user of the termios API by turning off the unsupported features in
> the request.
>
> N.B. It is almost possible to automatically discover the missing
> features by reading back the LCR register, but the CSIZE bits don't
> cooperate (contrary to the documentation, both bits are significant,
> but CS5 and CS6 are mapped to CS7) and the code is much longer.
>
> See: https://github.com/raspberrypi/linux/issues/1561
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlkfNPIACgkQtdYpNtH8
nugLGA//VzPG05ItgjWqHgtWO/x3EadfRpUSeRKRQX1ppWSYB7a3/yVvwIUNMVkL
+gkHj4xjUAKMbT6RLp9EVNmyPBQx6KcgxocPFjORlBwUjGyDHfMtw/X+JSCiR1o/
7RjQMjWE1QGyJL3XZ5Rx0OldK67Vi3DcfE4CrkCFJn0zenJlNu5dkpQlnqC40QCj
TNyZMTipRCxJBYgWigSCLnjIFsJhXE4IS104/1rVStRMGG6AjMM51DqbwFab+pZJ
nEuXlqxhcQdvJ4ZVJFV7Muw/BmqW5gl0ADWI34fwRaZ4f3txjHSxVi4nn2pSyhZt
NTyAp+IBQ5p/cevcnLsSkhFFxLk9fYo3pDarH7AJriNu1xjHXvo/HEwET+YCkAUH
4f5mLckmqCzfgvOk57sGcvTBviYDvA6vnzlRnNDyFHHptM4+0ZgWrbc3sZiWmO9c
63lH1iobgeMfvvoZaDyZoVl0PeZEf+Y+y4vxvrCg8n1J03B9cu7Ln/Ubz6nRVc+s
NBGsHDG4m/r+YqnCnhoWiapaENk/ziiwQeJsrDt6LtkqzORAF7Tq7GawKIOcxmEo
MPzpEZZYpqydDZZIAuYuNmZs5ZFbMf89DHiRQz5SuQoPBUm/K0G5QZrrPJvS1Ymn
2kao0pl/PPypDciNxj4o+EGk0LFalcJusqi9fpmLnrDas7/pqWg=
=PbLV
-----END PGP SIGNATURE-----
--=-=-=--


--===============8455445288799048727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8455445288799048727==--
