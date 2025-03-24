Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D0143895
	for <linux-serial@vger.kernel.org>; Mon, 24 Mar 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809056; cv=none; b=TLWJYuoBsgZcWFarY+gzSIdNSZx6vovknzyHOyCOWR78aWdVL0eVvT15OnwHG8vLLlAVAn0W3+cMtE5L1E7Dw3NycVUZ06GCB/IdC6BynjdOE65GXR09HBfTEABYrZb/eDIIve4BUUbfjB52cAAh4TrD0mPGrDLX1v2Nxp+s0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809056; c=relaxed/simple;
	bh=z0eqo3kdnsr4PW74Yw1puGdn1dpxJnWp+K2vqzsvLMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQjfIoqctX95nwON7rooe3xtioRBqgP6ElmCCIimpVeS01/g3lFHxK3hCdkElGUwOFrIaXbmc7Y7YeT30IMtbcwmn8N5tCviQyf45AbnKyAEAv2fMkneeS/Ex4tvMbMFwetpwKyaSmP+aPeAoW7SKUyjcZ7Y8/m1F2mRq0RhKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=X4Y4OsZv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="X4Y4OsZv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=VirM
	BDOSWR/E3W1DMN10oHb6IDjYfCXkYs8oNLScoZk=; b=X4Y4OsZvDQ3ejKY7QDfW
	ai7RFasg2Fqqegn1mQE2zp0OsefUjHH7pjOZSNLUBnzSyb5gp8xPMoFkcCezRn+1
	T/83l0bEB2TSKybyaxA5nWX7HLZbLfOq60D046dpy1NOpYtJ4IH5syFcbNo1ajw9
	FeaWucmGm83sQz5hGKOLmLdXiwdonDs6WvauWLW3G27Dw7G8hE76R7SQDRhvCqT+
	51bEdf/Q50R3EaHm40j8o62+It0beJKGwjzaAQ8jJoBTrtXlnqoN/ElXlsEvgaGl
	ItOZJ4bP48b4WAiDBhzHg4BhIqPZfUq0jEokOGcgTmAGbolAoXjtT0DipsO+NkF/
	JA==
Received: (qmail 2483856 invoked from network); 24 Mar 2025 10:37:31 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Mar 2025 10:37:31 +0100
X-UD-Smtp-Session: l3s3148p1@D1pkWhMxUERtKPH/
Date: Mon, 24 Mar 2025 10:37:15 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Cc: thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 09/13] serial: sh-sci: Introduced sci_of_data
Message-ID: <Z-EnyzUqSaYuAQmW@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250306152451.2356762-1-thierry.bultel.yh@bp.renesas.com>
 <20250306152451.2356762-10-thierry.bultel.yh@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ZLa3tBajrod+5IN"
Content-Disposition: inline
In-Reply-To: <20250306152451.2356762-10-thierry.bultel.yh@bp.renesas.com>


--2ZLa3tBajrod+5IN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 04:24:43PM +0100, Thierry Bultel wrote:
> The aim here is to provide an easier support to more different SCI
> controllers, like the RZ/T2H one.
>=20
> The existing .data field of_sci_match is changed to a structure containing
> all what that can be statically initialized, and avoid a call to
> 'sci_probe_regmap', in both 'sci_init_single', and 'early_console_setup'.
>=20
> 'sci_probe_regmap' is now assumed to be called in the only case where the
> device description is from a board file instead of a dts.
>=20
> In this way, there is no need to patch 'sci_probe_regmap' for adding new
> SCI type, and also, the specific sci_port_params for a new SCI type can be
> provided by an external file.
>=20
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

Same comments about not-per-line-reviewed from me and much testing
needed as for patch 8. So:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>  	}, {
>  		.compatible =3D "renesas,rcar-gen4-scif",
> -		.data =3D SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
> +		.data =3D &of_sci_rcar_scif
>  	},

This change to a proper struct is really nice IMHO!


--2ZLa3tBajrod+5IN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfhJ8sACgkQFA3kzBSg
KbYLlA//fTdO6fKVgmwDtJO4omPtdvzuYFNQciD56W6B6lTpCzIEln8iuPmYS+QI
DHTryCBsXUgi4rEmTK6NcdmrGIvnpuoy4JUDZ5nH2uyLGP82iXoF7r0A6oupHO09
JbERPAKAPgP76A8tqe0PTQqd3sAzKzyHiO2WrZUq5w8YBTk3pEJKbJoejrBgv4U7
olGf18zVslPHCHQK0Y1j9hLcahTq3zYGOnSphtpJtgTNdlI5FCuStp8zY8DvYLs4
8tlZgvssJH9JITo6Q/hgnEoYJ8MWq0riin8+pmrjZT9bZemoWFRzAJln8qzSbikj
PAUXkevlfUtlEBs0t/r8KJTGwIdeaEbIJob1YsZmPEj/TSwnE3J/AcRMyLysnC68
X1y8qHMTAfzewOxGE4FIJWdnv7FOXx+3bdIGLxyO89XU3vCOb6r5b8GWtKVkF+ZJ
5qKFHCk3Fa4eIInoo8I3rkX355ndGGiaH0lhKry3C6Hu9F57G8bmuZULdCQi8AHI
Wn9QP322YgrDMD2X1UEihqEBmuVwgYhZY+iB1yKzCeQK4Xvpk8uDJMZ3PxK+qcJM
JPRGeBQk4tJnZJGMrNDEUwiLnKUOeZXVdmXOrFlUhPWqdnUMrE8ErYWjKEMD4n71
O4zWAgDBF/aMGK14NDKZ2Yzqa4+D+V3PLMuDxtWjJq6ZIUFYbUM=
=wx7b
-----END PGP SIGNATURE-----

--2ZLa3tBajrod+5IN--
