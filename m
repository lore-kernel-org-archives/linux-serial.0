From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] serial: 8250: Fix THRE flag usage for CAP_MINI
Date: Tue, 27 Jun 2017 15:36:36 -0700
Message-ID: <87y3sdkqh7.fsf@eliezer.anholt.net>
References: <1498485581-72097-1-git-send-email-phil@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472457817784142289=="
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1498485581-72097-1-git-send-email-phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--===============0472457817784142289==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org> writes:

> The BCM2835 MINI UART has non-standard THRE semantics. Conventionally
> the bit means that the FIFO is empty (although there may still be a
> byte in the transmit register), but on 2835 it indicates that the FIFO
> is not full. This causes interrupts after every byte is transmitted,
> with the FIFO providing some interrupt latency tolerance.
>
> A consequence of this difference is that the usual strategy of writing
> multiple bytes into the TX FIFO after checking THRE once is unsafe.
> In the worst case of 7 bytes in the FIFO, writing 8 bytes loses all
> but the first since by then the FIFO is full.
>
> There is an HFIFO ("Hidden FIFO") capability that causes the transmit
> loop to terminate when both THRE and TEMT are set, i.e. when the TX
> block is completely idle. This is unnecessarily cautious, potentially
> causing gaps in transmission.
>
> Add a new conditional to the transmit loop, predicated on CAP_MINI,
> that exits when THRE is no longer set (the FIFO is full). This allows
> the FIFO to fill quickly but subsequent writes are paced by the
> transmission rate.
>
> Signed-off-by: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>

Confirmed the hw behavior, so as far as the platform goes,

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAllS3fQACgkQtdYpNtH8
nujX1Q/8CYs/c3wXXj4BaaphUT+qbpT1hEYenFt9FCfJ0y2sXt9cfEWEemGyFaE1
avLqknSdsR456AkFVtfaICAqJuAYihFXjSfDsePCG9eRu7PO3PHbbz0Mt7Ed60eu
7JCa9vku+YJdXnuGfk81g8NtKpTBmDPTEY2f+AZCa1Co/csHSad4ArtA8Gsh94pp
U6At2PyrPdzvADdo7XZSjvxLlHlifoQd0O/xep6h+LbDC61t2jA1qwI6SHWswfIr
zcwAsFN5vNp1IE3LLJggFfQY3SbX96WmITipCkuvm+eRi31b8Bb1toMH5gbfR+/0
qSzk2bMXjUYcVFhLnvVFOa5UIUy2MDSHZwGq0WVpSbfRWksCP+HFpMGLhABix4rM
N1kcJTAjhmcM+cEOwUX6MZDfF6k31RBUY6+2mg8TDSEJgESXt1BqqCdPOnt95MIq
QeIYliqjDf2mnxO2fh0JlhRv2Rc/A/Fm6RwvJBLBEbzPtrW5fZEZIvQzXCaaMYjR
F2Kaiy5Fj8RMhs/Tk5jNSSFSE2k2tDYxKNO5yfIlTYPBt16kmCWGkRGKrdeVYzzv
IgdMzwyd0RKjEJQ1EzpSDaZWsodXUYDJAWNqNKHKOIxGs8TLihVbIxT5tZ45zgvu
Wu3bHjf4FEjQ1kfeTleCqXNI5qpfMTOINIC7J/psI5aYhQEI/2g=
=vBKC
-----END PGP SIGNATURE-----
--=-=-=--


--===============0472457817784142289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============0472457817784142289==--
