Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679521802C5;
	Wed, 12 Jun 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209558; cv=none; b=UmIKSuDZDqc1GSQzk8UEojLWIHf11YcWEJPWb7l9Jw3XKn/kRuuhtYxaa1PRJHitYSybLhPAbWYNfqgcMN2Hufgb/MBtpny3iXPgaNUJgJOfH+csvRk5v8lPRoJHF96EIbng7IrrLrAEOMRFfDhHAVyPOF5T1yYTqgCzraV+4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209558; c=relaxed/simple;
	bh=5Z1s0AZaMliCHSeP4dXZVVJkL4+VeSm1P0/nq1Pj6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnV1t92KHXjU6WP86KhsGAdcDC93JoBOEVdJNZn2LuB1dppPdKiXqRqs4LfHSe5ML5L5vEPomhgCFLy8qmc4EHdGVnXFJoMO0tkHkktPcJ4Q3Sd7KmDc0+ZH3wTRf1w68ADxEf5SLYGQeLJ1yQ25FlebzXyNEle4YWqxPJuTFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxgPa0ch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxgPa0ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B402CC32786;
	Wed, 12 Jun 2024 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209557;
	bh=5Z1s0AZaMliCHSeP4dXZVVJkL4+VeSm1P0/nq1Pj6Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxgPa0chey6NZIUe/Qm48fefBbo6XHZms4vqEQKNAPOmt1d0UDoi76vxHKirLjmrh
	 xN/ysO1R7V47rG64mjVeKumYz9xhlX3ZHjIui8pzhbjtmaL56jZcE2i2PVPgZ+PwNG
	 J3Y/wQum3n6MFsENRvqrp72Aq+NtBP3hzBKiruZAQ2Hpcz/HWWTEyvx3W32nSlcmtt
	 KLOxh4bLpoEPZWOwJrAzYEYfD78FYNMeQubL8/5w0OYDRrMwI+NJ/uE3U0b2F/2ZJR
	 YuqvMjCO8yxTDbk0WRA16up58AoiKymGJLBqoD7SjjjZAvjR0OzAMts9AgXs+CO02P
	 7pZ1hAPIOhMQQ==
Date: Wed, 12 Jun 2024 17:25:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: vt8500-uart: convert to
 json-schema
Message-ID: <20240612-vastness-overeater-c87e44f92f59@spud>
References: <20240612142951.37259-1-kanakshilledar@gmail.com>
 <dd529de8-07b0-444d-83c3-4b8c3424a7ef@kernel.org>
 <CAGLn_=s=LtCJsP-BWFG9vJp_hQfQ_hnAtB6oKdTW68YxLLE_mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a7SBvbAGy87O7fQK"
Content-Disposition: inline
In-Reply-To: <CAGLn_=s=LtCJsP-BWFG9vJp_hQfQ_hnAtB6oKdTW68YxLLE_mg@mail.gmail.com>


--a7SBvbAGy87O7fQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 09:02:27PM +0530, Kanak Shilledar wrote:
> Sorry for the confusion. I will fix the maintainers part quickly.
> I have one question that if I find any area for the SoC is not
> maintained or orphaned,
> how can I find out who is the maintainer for that area, or the one who
> last contributed
> for that specific area?

git log for the latter, MAINTAINERS for the former.


Thanks,
Conor.

--a7SBvbAGy87O7fQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnMEQAKCRB4tDGHoIJi
0twlAQD36EGA2l+13TlHLLLg3vHEFEUQ31CXHR9R/VOhj/b7rAD3dHUMiStH/r3K
JDiWTp9kxUHIeeJUlBQxGEnjghhlCw==
=+Ke+
-----END PGP SIGNATURE-----

--a7SBvbAGy87O7fQK--
