Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2969C33CB1
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1BE207E0
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 16:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPQLp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:11:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgAPQLp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 11:11:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62A39B2827;
        Thu, 16 Jan 2020 16:11:43 +0000 (UTC)
Message-ID: <592d369511388cba21eb7b42e83a2cd061bb6748.camel@suse.de>
Subject: Re: [PATCH 0/6] Raspberry Pi auxiliary UART fixes & cleanups
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Date:   Thu, 16 Jan 2020 17:11:40 +0100
In-Reply-To: <cover.1579175223.git.lukas@wunner.de>
References: <cover.1579175223.git.lukas@wunner.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Dc5Q7Sa/zn13S52AvJ8s"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--=-Dc5Q7Sa/zn13S52AvJ8s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

On Thu, 2020-01-16 at 13:14 +0100, Lukas Wunner wrote:
> Here's a collection of fixes & cleanups for the Raspberry Pi auxiliary UA=
RT
> to prepare for upcoming feature work on the driver.
>=20
> With compliments from Revolution Pi labs (https://revolution.kunbus.com/)=
.
>=20
> Lukas Wunner (5):
>   serial: 8250_bcm2835aux: Fix line mismatch on driver unbind
>   serial: 8250_bcm2835aux: Suppress register_port error on -EPROBE_DEFER
>   serial: 8250_bcm2835aux: Allocate uart_8250_port on stack
>   serial: 8250_bcm2835aux: Use generic remapping code
>   serial: 8250_bcm2835aux: Document struct bcm2835aux_data
>=20
> Phil Elwell (1):
>   serial: 8250_bcm2835aux: Suppress clk_get error on -EPROBE_DEFER
>=20
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 50 ++++++++++++-----------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>=20

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-Dc5Q7Sa/zn13S52AvJ8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4gizwACgkQlfZmHno8
x/44TQf+JL0dYjkhVX8F3E4WC2qq+QSapjZBL7Aduww2Of5ey+40V3RtPULmBDLW
celwER+kH/drcggmYKTD1HY+fj5V8m7kBJDP4kTFgV+634J2hup6MhkXfAcl/XdG
PEmAzlfkG2P7qflgIFHaEE4wnRSNN+MYL/V5nKXnBWGkUU7fH9cSVtA1njuMCNfg
ywvHDsj4rqBMU+A4IfAS60ONagDkfQDFmlEICzlT42Irv78NDHJazYwGTl2X0YIZ
fWCMErJNCkb2NLFp6ShrdyZgPFhs7IWGrqwsuWG1yLTPcSU2bXWeBlG3ORCvwj5f
TpnVeP2l3iIL5jb60UfQO01z9fq+Rw==
=iamB
-----END PGP SIGNATURE-----

--=-Dc5Q7Sa/zn13S52AvJ8s--

