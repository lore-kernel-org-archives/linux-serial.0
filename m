Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D21F873E
	for <linux-serial@vger.kernel.org>; Tue, 18 Mar 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334615; cv=none; b=sIJtnnIV6P78fUGB/SCpU3Ls0UIqgX1FyznqTZertQYWE4U7tniX7zGD940yUjAOy7Pzdaf3p/nNywGGR4oq8DtMSjP6n1OnUgu/a5G+PRvhuY0AFOk8yJaBZHhoP0wLjGsQNripEGwGhZ528ff3rm2nQTK5Vgi47CezDb/Jvc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334615; c=relaxed/simple;
	bh=oao8GnIO2RRjFOQFSEiRh3HRTh0zsmwKCIKFeMqkgKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UINbO7wcipQY5+oQdbd9w3KiYZBr9inASOdpPP9CQ4cyC8cMtgcHYWK+Ota6E6uG3DEW4fSkSAY8QowpwSHtnsqNE9sUOZQfmMB1xyoSCcx0LHP8GbXwfyFzplS104NDAyVW0n6futU2r3RQehuK+4FHI9LNQ8heocN4Q8e3EGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=T6C/xINB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="T6C/xINB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oao8
	GnIO2RRjFOQFSEiRh3HRTh0zsmwKCIKFeMqkgKE=; b=T6C/xINBZ3Vof0rsaOZo
	4Rjl0br/eIX+4YoeB1LIMaGqBhYl4zCv07d/CZ4XF7c6VJeO4JhMwLh/h6i0PCrg
	rSQ6y4Fpx5OzSakKGqpat7Ja0xWGrsXgo90t5ByBnh1Ptebh4rffNrqKnmlLkkh9
	7hE7Me3CUidta2fJtCp08lkJhQhR7kZz6qzteyWlza8cnaaiu1nV4ItfHI73KtT+
	+QO3JIZ6VmKyoiz9QLdW1qbyB9Y50W9soM1Nj4zBIVxMvvZEhEGzXUbE+r37DQAF
	eE+Z2ShA1VIx9Ej8JOZK/znwz3fSsEuAGVnRvHSFL18ZasJkTocXQcJUCoMcgvqy
	uw==
Received: (qmail 4011020 invoked from network); 18 Mar 2025 22:50:10 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Mar 2025 22:50:10 +0100
X-UD-Smtp-Session: l3s3148p1@3paH46QwWtcujnsn
Date: Tue, 18 Mar 2025 22:50:10 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Cc: thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 07/13] serial: sh-sci: Fix a comment about SCIFA
Message-ID: <Z9nqkpZtRdASaEAP@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	thierry.bultel@linatsea.fr, linux-renesas-soc@vger.kernel.org,
	geert@linux-m68k.org, paul.barker.ct@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250306152451.2356762-1-thierry.bultel.yh@bp.renesas.com>
 <20250306152451.2356762-8-thierry.bultel.yh@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uV8tMxqN08qsiLkQ"
Content-Disposition: inline
In-Reply-To: <20250306152451.2356762-8-thierry.bultel.yh@bp.renesas.com>


--uV8tMxqN08qsiLkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 04:24:41PM +0100, Thierry Bultel wrote:
> The comment was correct when it was added, at that time RZ/T1 was
> the only SoC in the RZ/T line. Since then, further SoCs have been
> added with RZ/T names which do not use the same SCIFA register
> layout and so the comment is now misleading.
>=20
> So we update the comment to explicitly reference only RZ/T1 SoCs.
>=20
> Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uV8tMxqN08qsiLkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfZ6pIACgkQFA3kzBSg
KbbC8g//aqbr/u/g/ZXg5kDNZaluilRKOXs5G0YCvz2L3OA2pb/N2gQmgHd/TM72
l+QqGpCc8OvBntAEmhwJ1cW9eq0VQ/eiWOowKy/NvP/WBDcYINoJ28U7taL7K7Ym
ZTcc1Z6BuGswRMZtzlRcu3zdlTU4V56xdNP/VxJc9a9xaKGSOpemebFsOkmDOTE9
kREa58a94GnZH9+7w5nFWBnQvi2nV2mCQe4RywfKLWOEme7mGKNpcN4JXKIme1Fl
JxQtBXN4Uk++JV89geY9U7GJ2D18g2FHfj8DzGuTvAiv7dp6oR8r5UVrq0pTpJin
+ABTiKWKe5cpP97RY0lTTghjXR/z0KhmO9bTzauKH74qzu1XCMye61VRFM73MudJ
/8gOYysWUZx0QFqYBSQZQbxAwUa7cEJTQ9bJZL0PiWPZsTpxsN5dlr1qPcOm9ijd
LVDOMEhyfw+nX54SwOqr9xWjh+4QokCSoLjl1hQ0v3XAS3Dyo54UpY6ZmE3dyZ/3
UtE3PLg3UDZLHfgYWTUBcyDLlhLGEguEqDJGjGpg/L2LMehIz4LtNmTgJ+rP4JG6
GF6mmhN7GMG0cLl+s9PPe70Os1GJ2p1rZJv3uNzRKNmahhvKkt/Q/8i1wAYjw5I6
ES3xa8AgbuYPhpw13iZmlLDyCwvlgg8tjNplTOvghHHk75/9ZmU=
=HZe8
-----END PGP SIGNATURE-----

--uV8tMxqN08qsiLkQ--
