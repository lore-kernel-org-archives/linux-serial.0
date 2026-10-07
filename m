Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9945D5D2;
	Wed,  7 Oct 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369421; cv=none; b=YQYoPVllea2LsD4RVdmUsswREWW6+91ZM0AthKlOxexR2FFmeoOk4A8MvLmGNBwbo+6yAFx6Y/6My4rs7auZw7k4cEDm0tYeb7YyWS0gX7+nCS7BdcUYPNFRJknRAcCID5ZbDBHXkRFMg03GJufMyKdnFGpbvQ8jHNwOFr5uARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369421; c=relaxed/simple;
	bh=1rmlolJFZxCCwJgiNLg8QppYZKafCV1r7ap26grEgNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U03RXUBbyYPhNkspwyy+eGbX5mj0qSqJtCVEohENsBRxcNmFZ+kpb3TYQAaDB3rJwlkbwJCNwNR59fGh+IBwaqXHiy0jwvfVKfU2sxy/r7RSoa9o7PuOGik1DrayVstjoAon0GUrCtyET/4EQlz/6F6l87CF0RofJy2uozdlBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auK1Ztio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auK1Ztio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E851F0089B;
	Wed,  7 Oct 2026 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791369389;
	bh=1rmlolJFZxCCwJgiNLg8QppYZKafCV1r7ap26grEgNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=auK1ZtioATbPb/HOhEqnFvtfrrwLIp4Hx1nvIK3kO+F8wF4P9Hl1E811eJvT2szZ9
	 zK37YdKubWTJgbp+SGHVZv26uNJtCn6vQcN7FsozlSUb0qIQhluFAFl5m/B5G5LnP1
	 iBbm5nT4hPNutH8UpG1TIrdSoDdHPrMREr1ceJ30kpwCd6F5EMCSaA9PBjWiaVXIG9
	 9/0m0sYUFoia2Q67fNytAizv9THhQE+YI/0MorHy7pAL467kRyRokbYAQ+M93sanVx
	 iVB7+UL6obbbRgPiN14SudhtoR/vve8IkgaTtMdfBZgZtGApS3N7iIVI1cYyCihCJ4
	 /imBfxe+ZLYlA==
Date: Wed, 7 Oct 2026 11:36:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: snps-dw-apb-uart: Add Allwinner
 A733
Message-ID: <20261007-9f3c1d7a611bbe349339a3a8@squawk>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
 <20261005172538.398522-3-vinicius.eduardo.pedrosa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iXnLyLOgw7A8YKtI"
Content-Disposition: inline
In-Reply-To: <20261005172538.398522-3-vinicius.eduardo.pedrosa@gmail.com>

--iXnLyLOgw7A8YKtI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--iXnLyLOgw7A8YKtI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYgqAAKCRB4tDGHoIJi
0vAnAQDqt34T+iseL5sVvpFwrHRSgMZwRPjwBIRWnWXrtuaLkgD+LgAKSQ6O2eZb
O2f1MNcJ+wQX6IBwYvnG/bFRhgNxqQU=
=5S91
-----END PGP SIGNATURE-----

--iXnLyLOgw7A8YKtI--
