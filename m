Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96D130E44
	for <linux-serial@vger.kernel.org>; Thu,  7 Mar 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834166; cv=none; b=IDsaKXc5S9SDPYw/ccBEDytxeUGHptQrLe3JJPUE2YecSU2g+I+WLiUy/83Soivu4Uk9nCyMLsgWAvu7NDzfdkq9tKUCje44HlLbt/Htf2vsLqfG3/L+UDCywDelbnn5ifHFWHC0hOzR1XjMNuHAd9ISisZrUh5DZudNcX77pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834166; c=relaxed/simple;
	bh=zzpgR307W+PkVy2pQ4SerrtaP9TK7vZSHCQeFZauwVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bODcNZ5yE6XC6NwGn3o5uPBETDwoYU4hzRJf2e6KLdRGVN8t/cd8bhWuVjQLyAwJMjFLdOXPr/qdf+5uBu71AZD/8VkcbYEcqkHvV2qiPrurqnFw/DUauYASTbyEyKKsDrArjf6yUjefRciiQhgcvrvgdemhK89B3Cmd8lMSBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcJD16ki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcJD16ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF61C433C7;
	Thu,  7 Mar 2024 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834166;
	bh=zzpgR307W+PkVy2pQ4SerrtaP9TK7vZSHCQeFZauwVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcJD16kinBkS3CAHcMTXE4L2jiXzHpYI3SqxsgLy4+JAn70BeWxjn8uJdwQpc077K
	 7Zw/bs8MuGE4RaRGTf4W5AhM1YhqrUPOEAbnhE+ndKFUr+nV7sz9GM8aa2GQzV6vqF
	 2lTWQroiXGjrrakC5kLm3keNMM9V31f9O60UgKdoFEYL2XHr1f+J+B4Qj+LBK7SXky
	 2tRVqoWQcetPa8zaNz5yq0AHsTEHMjYgH0PwmiIyS2BDmhD4vV8OZJHvrALuqvA2w+
	 Sys/MI5a/j6fM3DY8a6AYW3IdqQphXES6HdI63BsxDMLgEPcy2Jn4spX15rqBRXKv/
	 Fny09Vdsd5n2g==
Date: Thu, 7 Mar 2024 17:56:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: sifive: Remove 0 from fu540-c000-uart0 binding.
Message-ID: <20240307-busily-encrypt-507cae0e7564@spud>
References: <20240304105947.SJcVAdr1@linutronix.de>
 <20240304-whomever-gladly-d43da7ad2fe6@spud>
 <229b34c1-5419-93ae-0a6f-a21cf4e4a276@sifive.com>
 <20240307090950.eLELkuyK@linutronix.de>
 <20240307-sacrifice-dares-09c91fc8fefe@spud>
 <4d85215e-64ca-491c-8f69-f2c83c7e72d7@sifive.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SAmxjma6bwXqQ9Z"
Content-Disposition: inline
In-Reply-To: <4d85215e-64ca-491c-8f69-f2c83c7e72d7@sifive.com>


--4SAmxjma6bwXqQ9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 11:43:53AM -0600, Samuel Holland wrote:
> Hi Conor, Sebastian,
>=20
> On 2024-03-07 11:39 AM, Conor Dooley wrote:
> > On Thu, Mar 07, 2024 at 10:09:50AM +0100, Sebastian Andrzej Siewior wro=
te:
> >> The driver is using "sifive,fu540-c000-uart0" as a binding. The device
> >> tree and documentation states "sifive,fu540-c000-uart" instead. This
> >> means the binding is not matched and not used.
> >>
> >> This did not cause any problems because the alternative binding, used =
in
> >> the device tree, "sifive,uart0" is not handling the hardware any
> >> different.
> >>
> >> Align the binding in the driver with the documentation.
> >>
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> ---
> >> On 2024-03-06 18:48:13 [-0800], Paul Walmsley wrote:
> >>> On Mon, 4 Mar 2024, Conor Dooley wrote:
> >>>> I suspect that the driver is what's incorrect, given there's little
> >>>> value in putting the IP version in the SoC-specific compatible as it=
's
> >>>> a fixed implementation. I'd change the driver to match the bindings.
> >>>
> >>> Agreed
> >>
> >=20
> >> I didn't add any stable/ fixes tags as I guess there is no point in
> >> backporting this.
> >=20
> > Every documented device falls back to "sifive,uart0", as you mention
> > above, so I think that's reasonable.
>=20
> Right. In fact this means the sifive,fu540-c000-uart compatible can be re=
moved
> from the driver entirely, since the driver would match sifive,uart0 anywa=
y.

I'm always a bit hesitant when it comes to removing compatibles that are
backed up by a mandatory fallback in where there could be some old
firmware/DT floating around that didn't have the fallback. I think in
this case that's pretty moot though, so ye, it could totally be dropped
=66rom the driver entirely. I'm happy with either, both cases are an
undocumented compatible being removed ;)

--4SAmxjma6bwXqQ9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZen/sgAKCRB4tDGHoIJi
0gBZAPsGFHKhN1kEYavlU7tgP1RAwM4t/Y/jASTOoiG36C7QlAD/RC+F1vQtcgdR
JcIGU88gRGoCHMcP0AyXsra9adDRVwc=
=BSr6
-----END PGP SIGNATURE-----

--4SAmxjma6bwXqQ9Z--
