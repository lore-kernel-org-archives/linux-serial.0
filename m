Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8D1D88D7;
	Thu, 18 Dec 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076887; cv=none; b=evnGyegE6+AoTQkEsk3B6gL2CxF4nM5DWjhm0JlJ93VdMO0aBu3N/EpwNCWUxIuZ/1H0OyPf/W/kZUBuh9HE79nBW40fj0SiSKJ0s7MwUGSUaSdeNhyAni76Qkwht4ywDgyxpQEt+bx2QyUAJb3V746PZDvVeiekGzG1uoZ+Ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076887; c=relaxed/simple;
	bh=NVKX0lTas24U04aOsFlM9XDeaDNP7g8C+337je/pR2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1lXnmylckuByAra7pFDoPQDoSV8L9lJEO4JhoshxQsQRzZ9vMpsU187gulOdL0xRdOtNnPm4O2SrHgAPqR6yEyyI+tDs3p0r7fjl2CK3piW0rEhWJLWVsGywpc10xHDsfdWbWgLW7HTBOc606wMfQxPjtWSzHbV8ZdskLocmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICQwGhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICQwGhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE9C4CEFB;
	Thu, 18 Dec 2025 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766076886;
	bh=NVKX0lTas24U04aOsFlM9XDeaDNP7g8C+337je/pR2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dICQwGhj44AIG8WH09cIhplIzdn7oMy0PSNy9SXIUQmORmdOQtk5xAHy6U6GmINjy
	 wdczqamWLVkgOynNGAfEY3+e6fZ0rX4YQ5R8hlLGdw+a5Wr8K4csidlEa9M+yQr5iC
	 anhl/pLguZQKj7MuCW6I7Gq5H2dQ1bzXvoFXxU0mvYSFQXODI2gGbJZqBHBWn45gWw
	 ARaTw2BWdLqA0F9EJt6pItJm2wlbBSYDCzeIcR11EeCkROsdAo6dpODRc7b6VmbB6B
	 gQ6LTC2UqD3+P9nxljCWDum8P89LT4g3ZbPU7eqyQOqHM6yktV9dmunqE6hQX9LONf
	 +3J/Banfj0prQ==
Date: Thu, 18 Dec 2025 16:54:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Restore sysfs fwnode information
Message-ID: <713aa37f-161d-4f08-9417-d7d2abdcdfd9@sirena.org.uk>
References: <20251127163650.2942075-1-andriy.shevchenko@linux.intel.com>
 <CGME20251218152957eucas1p196470bc80be0d8a4037edfe6e53f3d13@eucas1p1.samsung.com>
 <265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8ICi0Cl+oxFShKFk"
Content-Disposition: inline
In-Reply-To: <265b9083-d744-4438-b539-9e001f2138ba@samsung.com>
X-Cookie: teamwork, n.:


--8ICi0Cl+oxFShKFk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 04:29:55PM +0100, Marek Szyprowski wrote:
> On 27.11.2025 17:36, Andy Shevchenko wrote:
> > The change that restores sysfs fwnode information does it only for OF c=
ases.
> > Update the fix to cover all possible types of fwnodes.

> This patch landed in today's linux-next as commit 24ec03cc5512 ("serial:=
=20
> core: Restore sysfs fwnode information"). In my tests I found that it=20
> breaks booting of most of my test boards (ARM 32 and 64 bit).=20
> Unfortunately I cannot provide anything useful besides the information=20
> that booting stops and system doesn't reach shell. There is nothing=20
> suspicious in the kernel logs. I suspect a memory trashing. Reverting=20
> $subject on top of linux-next fixes booting.

I'm also seeing this in my lab and Arm's lab, there are a few systems
that survive but it's a small minority.

--8ICi0Cl+oxFShKFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlEMdIACgkQJNaLcl1U
h9Coggf9Eg9zpssvPxlJCKwyI0muVzdb9d40zGht8xRumXDGPk6jHgGRAmGe8Vrq
QHaP5h9W55z0uGEMr31jovkYJjfS93N7UG8x6/fhgEEmDYuzACzSNPK8R9GLoFe0
5fE9v2taAFjBFBLg/m5gibnDsZeaQgG2HD169ovELQepwqqWg1cP5UWJP0DVd0wx
zBo2QHUD/gdQWcowRYLwmgUxLHpW2XoVdtSJjxzdk5R17uqDfT27EoNLUK1R3RaO
jyTY4jAAXiswV6iUqTfeJB4W1ToLQVDvWTUxLivwzapAyQTV4Lovknfk7zz8Xi2B
ntfSQzbnwztNbP0E96YDGlxkBcVV5w==
=dqjG
-----END PGP SIGNATURE-----

--8ICi0Cl+oxFShKFk--
