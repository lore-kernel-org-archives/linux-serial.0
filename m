Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C883F181D05;
	Wed, 12 Jun 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211524; cv=none; b=NBGrVmsJwKavgObcCY1AV0TuCnEYA77UwRGwmMcLfEMYFABq8eVeoMSG31SgoOW0sTkI7sgROJXprpCKK/LeRWd5IflOusGMw7CK9xyftailRhkNpK/rf66vxqp6REn2YlBd/V62abnLUoH1Woy6PyhX+YXQagdQJJZ9u5srNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211524; c=relaxed/simple;
	bh=MbojNuzNsbnxWYGBAKUy/NmL5mQV3wk0tJ4121HL8pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Ym9ebFhGIoNj7IResD4BiH4TN8ieSM5gpB9PXLDa4MGQPfnasrzOvJRBZDqy7+7rR6gYEPnqJ7fQ8rFkUwGTVeBznkyElvsjaeY1T79Du2X8d5XbF5WMfwdMIYzTbCVcFm5GkBWL43C67PdIfYf7LIhXab9uueBFyBnA3Xopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5qrUew4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5qrUew4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DE4C4AF1A;
	Wed, 12 Jun 2024 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718211524;
	bh=MbojNuzNsbnxWYGBAKUy/NmL5mQV3wk0tJ4121HL8pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5qrUew4kVr6qBRQP11l7p4atN2eJKqmhXhdFoDbLehxBUNJ0ukqXBLK4HI7zx9ci
	 7mHoratmeMN4a10CxGBzfBfFuKjJwQlP4AE/vOt59ONNU7CoAooSofwa2YIFqMpApN
	 DV+UAG3v9fa7uhFZIg4jqpMQCoY22KBFm7jdctpSuRtFX1iG+XpWUNucZacFKvy4N+
	 Pilw7nph1Q72NwR8ry/Pu8IKd5BIEYJLOsLb8o2Ws442KxFIDyOK0YhsPeL0y18/BF
	 xFc7SkR5cb7n45i4mBhCjbOhuTBNaOH919epxqqEU8DIlRyrhwaspXvK87j5GdARxd
	 sETeZzuMdOAjg==
Date: Wed, 12 Jun 2024 17:58:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hui Wang <hui.wang@canonical.com>, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
	lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Message-ID: <20240612-spectacle-pentagram-6ad4357e148d@spud>
References: <20240612131454.49671-1-hui.wang@canonical.com>
 <20240612-skeleton-bullseye-71067b2244b4@spud>
 <20240612124943.5ce6996abdf670651d0231a5@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ymap2M9CjY+gIjjC"
Content-Disposition: inline
In-Reply-To: <20240612124943.5ce6996abdf670651d0231a5@hugovil.com>


--Ymap2M9CjY+gIjjC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:49:43PM -0400, Hugo Villeneuve wrote:
> On Wed, 12 Jun 2024 17:37:30 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Jun 12, 2024 at 09:14:53PM +0800, Hui Wang wrote:
> > > In some designs, the chip reset pin is connected to a GPIO, and this
> > > GPIO needs to be set correctly before probing the driver, so add a
> > > reset-gpios in the device tree.
> > >=20
> > > Signed-off-by: Hui Wang <hui.wang@canonical.com>
> > > ---
> > > In the v3:
> > >  - drop the Reviewed-by
> > >  - change gpio to GPIO
> > >  - change "this GPIO" to "and this GPIO"
> > >  - change "so adding" to "so add"
> >=20
> > There's no need to drop an R-b for grammar changes in a commit message.
>=20
> Hi Conor,
> The R-b tags were never given in the first place, that is why they are
> removed:
>=20
> https://lore.kernel.org/all/6b1b0635-304c-48d7-a941-fae30962083a@canonica=
l.com/

lmao, yea that's justified (and probably should've been mentioned).

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Ymap2M9CjY+gIjjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnTvwAKCRB4tDGHoIJi
0sApAP9dZh8177YB5bl1g4AIoNKqB/1NfHZp09VxMHzsKNc/sAEA2+RT9qDcIOkZ
Q6YIhAaKRhA/SvgLtwi40hu3qW8vZw0=
=LjNq
-----END PGP SIGNATURE-----

--Ymap2M9CjY+gIjjC--
