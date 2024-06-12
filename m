Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EE16F295;
	Wed, 12 Jun 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210255; cv=none; b=FpisefgWlqxCAITB52eI5B9NbgR/hRX2d/SRBPm5toCdsqMiv+o6S90MS6g++LeWDjYh/PaoLQmthGYg7Vs/9CkTbDTP+J4G/0L1TUepubPE4zpyCGSQ32lWg4aPbqJkuSVJZpvrGF4NqO5+ewBLLqAKOWfgGGi6wfza2phMFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210255; c=relaxed/simple;
	bh=0MjRZokEqRkCUo1uCDr0yndQXFK5Z6Trx87QYmEtkYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw5euDgo+VHSTOjNU4ekFTFDaab4bH0x0JcKCxcknuorybGzzhIq4dXWgtybQplmLKC8OxoOTX8ZMT/buTT2PIbk/Ik0QX2NXTEGctw4D4Cx0ha/Mwzb+9eAzlL3p/+x9q4yzETqbXMiQNGyU14tLwmgqvvU3guxFnY/ZgECuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke2j0YT/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke2j0YT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCE4C116B1;
	Wed, 12 Jun 2024 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718210255;
	bh=0MjRZokEqRkCUo1uCDr0yndQXFK5Z6Trx87QYmEtkYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke2j0YT/M5eYWhTgZtuc+Q+NshqvsYf1f2bie4rNePcwRiyMQWCpjNcmqG8+1VTpk
	 /9USqxGBCrdcLf/JWCRw9HAEqe9V++vfSUNCk9Q9HXpgvSZACjT0hrKnH9S8IxL2gF
	 C225wQvPK+zVEiZvZKzGM59fJoSc0RgZf9X+M7oDoQL4rN3kcUgTJx4qFDEhfib9DH
	 q7WHL49i1fmhVa0z0us4CSEOEUTOkG2AULSPc2/QTh9bj7IQeT2BeMLmubDL64BuNg
	 KkJHG5yMtgmO9RY9crWcP8eksRuc6dVuKX6bF1U8lUfNOxD2DNYO8R1KBfCX/8VLZ4
	 r+SNPQ2LLHl9g==
Date: Wed, 12 Jun 2024 17:37:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	hvilleneuve@dimonoff.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andy@kernel.org, lech.perczak@camlingroup.com,
	Maarten.Brock@sttls.nl
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Message-ID: <20240612-skeleton-bullseye-71067b2244b4@spud>
References: <20240612131454.49671-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KgN7Km3/jYhonulv"
Content-Disposition: inline
In-Reply-To: <20240612131454.49671-1-hui.wang@canonical.com>


--KgN7Km3/jYhonulv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 09:14:53PM +0800, Hui Wang wrote:
> In some designs, the chip reset pin is connected to a GPIO, and this
> GPIO needs to be set correctly before probing the driver, so add a
> reset-gpios in the device tree.
>=20
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
> In the v3:
>  - drop the Reviewed-by
>  - change gpio to GPIO
>  - change "this GPIO" to "and this GPIO"
>  - change "so adding" to "so add"

There's no need to drop an R-b for grammar changes in a commit message.

--KgN7Km3/jYhonulv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnOygAKCRB4tDGHoIJi
0pQYAP4toJo1nVgYG+9CIhfSh7IJg2hsD7vxNOXHtHvI2e7+rgEAhHVNt7Pz0iqG
TWeXllr4TJRAqSWFaqd37wgY3NMeXAw=
=fBuM
-----END PGP SIGNATURE-----

--KgN7Km3/jYhonulv--
