Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445493B9931;
	Thu,  1 Oct 2026 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880278; cv=none; b=eKbhGYLB74O7bnagP+NriPJkXZn+sEvGKW7wTT0O6ouIJn/Id6FOAcgOrl6wytrJx7MbESk9i8/QSt+NyCDxCbXFqD8dMHN4N2q1MS9Yk4cw7duvjd0jlQCmACzsv5xPxHT/X0xO7Vt9kt+WqvUXdHQFFpd6jeWo9FPGdrZ4e5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880278; c=relaxed/simple;
	bh=EcVt5V4emgNML1hpBJB/DFOaHmqtag5BH6CKvKmi5wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4aEeB1Jo4+H6FJUi4q/NAELAuv6oQkorY7HsgpLwJcQTS65MWwBeGhZId2PUrutJKmbOqrrYBJLUUIPftEI5KGZwjge5qNwUOqkixvKvIQKVOMvoglP8gXuhsS7jv4dU4q0BD5mRm5pc15y274X5JBjbjA3BnX1B0Q2Q13FWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUES2/T0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUES2/T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25A01F000FF;
	Thu,  1 Oct 2026 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880273;
	bh=EcVt5V4emgNML1hpBJB/DFOaHmqtag5BH6CKvKmi5wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KUES2/T0jGLzAt9vBvsvBtpMG+ZttNFzeEGNVCj0E8jDFGFDkCVynlgvkfW2Vp4/3
	 Pcq8ufV/Xv3RhaRyaBYVL4Q2q/PwyR2SALhMvf9XKrJtWr+Oyj6UjKoLEbDkPVOEHx
	 LC3CBnR3Lvy6AD3IO8YB1xN3n1bQPDcvZ0qYb1DgKSqqeDIJyUWK25crEB6DP63v5e
	 +7M25hMpSjOS2Bcz6cJ1ppgzk1dGYt2vAC1wllwVcJhZMdEsHxo6gnKCteQajiuz3d
	 2Ux55AK5bhD0svXoqJcgJ+L1IHjNrJGW5U0xLATShENUYNq8k243wBIxjNRg1MuuCe
	 EjJAX0KabS7aQ==
Date: Thu, 1 Oct 2026 19:44:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Drew Fustini <fustini@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Securifi
Message-ID: <20261001-preshow-specimen-0e7c656588ca@spud>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VIbWKoJOnLsgAcEn"
Content-Disposition: inline
In-Reply-To: <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>

--VIbWKoJOnLsgAcEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VIbWKoJOnLsgAcEn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6qCwAKCRB4tDGHoIJi
0pubAP9pef0IMk7FICYBiCDC3YBBQ5m533F1+NaJw7SLNqPA0QD/XdKW4la/oQAK
GmchGVM9zKVv5hEzrWsXyVASzG3lhAQ=
=JUaH
-----END PGP SIGNATURE-----

--VIbWKoJOnLsgAcEn--
