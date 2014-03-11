From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v2 0/7] tty: xuartps: Rebranding + DT documentation
Date: Tue, 11 Mar 2014 11:46:43 +0100
Message-ID: <531EE993.80400@monstr.eu>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Uihq5Ov6SDStNcGpgA3iVBDBpLxmW1BK4"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:58855 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbaCKKqx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 06:46:53 -0400
Received: by mail-ea0-f175.google.com with SMTP id d10so4188931eaj.6
        for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2014 03:46:52 -0700 (PDT)
In-Reply-To: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uihq5Ov6SDStNcGpgA3iVBDBpLxmW1BK4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> Hi,
>=20
> this series rebrands the Xilinx PS UART driver as Cadence UART and
> documents its DT bindings (+ some clean up along the way).
>=20
> The rebranding goes as far as reasonable. Things like file name, kconfi=
g
> symbols and other things with user space impact are left as is. Please
> refer to the discussion in the RFC threads[1-2] for more details.
>=20
> Similar the DT binding has been extended. In addition to the new and
> preferred Cadence binding, the current xuartps binding is maintained.
> Though, only the Cadence names for clock-names are documented.
>=20
> References:
>  [1]  https://lkml.org/lkml/2014/3/4/405
>  [2]  https://lkml.org/lkml/2014/3/7/450
>=20
> v2:
>  - no changes regarding the patches
>  - fixed (I sincerely hope) email recipients
>=20
> Changes from the latest RFC:
>  - squashed function/symbol renaming into 'tty: xuartps: Rebrand driver=

>    as Cadence UART'
>  - Revised the commit message of 'tty: xuartps: Don't write IRQ disable=

>    register to enable interrupts' (was 'tty: xuartps: Remove bogus
>    comment and register write'

One more thing. I was thinking this is based on my 3 patches I have
already sent to mainline. But as I see they are not applied yet.

https://lkml.org/lkml/2014/1/21/107
https://lkml.org/lkml/2014/1/21/101
http://www.spinics.net/lists/arm-kernel/msg302796.html

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--Uihq5Ov6SDStNcGpgA3iVBDBpLxmW1BK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMe6ZMACgkQykllyylKDCFrrwCfX/JsE2LZP0PX4Qk2Z4BmPGOV
nyAAnjpT8J6IiMT2FGszoziPENhIZkNK
=r6xw
-----END PGP SIGNATURE-----

--Uihq5Ov6SDStNcGpgA3iVBDBpLxmW1BK4--
