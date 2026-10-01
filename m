Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451D306B3D;
	Thu,  1 Oct 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880330; cv=none; b=JqafzbOO9BJU5AkWnlmqVIl1ooEbCBPJimPO3MLualadbjZdWmAaP+IKfWyKFw1VJQtKM4kufSEw9T0rJelvC4jO6ciuDO57P8OTIPfdQb+RbgH8CQAW8hjUpWwpEjP90VitKVVK5ytdDqpMAOhlGQc/eZnkeXpS6iQMQ/8GAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880330; c=relaxed/simple;
	bh=jszoA3XCxoEtB4stb7vyonPbCiXJ3Z9IY5HE7xxvGMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9BUc4QbCAE2WHS4mQLdfnedzXNltJtQ8JhPOuhQw1Dul4vqpc09vWhKpohJN4HWrE9JJdVgIacbtFDxgVrRihiDVssV2QxDZy1Zq8uKW8PizvhShtm1cOFBgI+IzUKH5q86EDniKeRxIRTCiCXO3pQXTXzGQONaIsTGfyXHX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx5lrdCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx5lrdCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE571F000FF;
	Thu,  1 Oct 2026 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880327;
	bh=jszoA3XCxoEtB4stb7vyonPbCiXJ3Z9IY5HE7xxvGMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bx5lrdCIg+vAvJPk6J/0iqL5iNVtxV++dvqOZD080bsbc6eEznwx51FWqT/zJisX0
	 a5iHZXg87SABt/v3AoiJTYpYbpayVIvwk0LsLDdkNwaKHc3nriFxEfO6sA+LpT1LyO
	 CZ30qzldXt0Cf6Dy4wqpCv0Tm9X2duT4S7F/Pp6EWeS3nBEhY0JDVH/npfyediK+54
	 N5dR4xowy0EYFL5RcvR20HqD/pH7I5uMOlpZVeRz29HRATTQHEYcz9hHsaRUXiCrRq
	 540XJjmrCPB9Qk5xb90Sdj4I7P4Hv1owfZUA4iFEO7ZFy4tvGmnmMRXzd433M8VrwV
	 WUe2+CzF9U1mA==
Date: Thu, 1 Oct 2026 19:45:22 +0100
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
Subject: Re: [PATCH RFC 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Message-ID: <20261001-grandma-flashily-030cc6be668a@spud>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNp4YIjOhCgaALYe"
Content-Disposition: inline
In-Reply-To: <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>

--sNp4YIjOhCgaALYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sNp4YIjOhCgaALYe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6qQgAKCRB4tDGHoIJi
0v5eAP4yBla6FLpGOznfX9dVo72IldPw83rGqSIkNXaPkSEzZgD/dXKBTYNqJDTg
rDFGGX/sT9Dj75eyTgZov1nMilqxcA0=
=kdfg
-----END PGP SIGNATURE-----

--sNp4YIjOhCgaALYe--
