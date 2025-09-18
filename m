Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94322E004;
	Thu, 18 Sep 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208863; cv=none; b=ru47S2UHYtVswCDbXNSFMGN3jKp8eqKYk29jPwzWx7SBGZ+uD1ieqeYxRuCH/pAilgbY/9ta2bUKutFL3YytsS7k/tplPZNRkFziEN+Y1oWrQx/GQhXgPzuGsceORB5QrzE1NoII1rJduh8Tgw+Z6l+DG14yH8keQE+uCMff+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208863; c=relaxed/simple;
	bh=6gHZci9/grpnQ30fU+eIQ9ISKRCyLinGxgLiUGNx8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnLPoAlknIXIiv/dnUEEhZyxNc+fns4ZyioQhNGEb4GrwthVqHqDQ5W3ND3+Nke/PJQbde0mWJ4emv43IiMLkpPs6OVNE0y9scVdDtE5xUVB+TVlsQhTvAj2rFH4kPjndTELXMORWPuApVbBwGG2JnGthbRWhcRLDZlstujqTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG0rEsyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG0rEsyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5E8C4CEE7;
	Thu, 18 Sep 2025 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208863;
	bh=6gHZci9/grpnQ30fU+eIQ9ISKRCyLinGxgLiUGNx8GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KG0rEsyr/kMWPVQa5kcb4oqLQ6quX4GDeySTh3f4M7sckSYCN6eUIB1vL6O5XO9IH
	 OcuJh5diydI7fi7tXUH3jouFROoyPzCS/Toc4w8ux7W3bdiJc8mOCyNmcQ1cpnlhej
	 12iwfRQO8d+K9GOu/4LaQV5NrgZVcKkip9wLVpqroUIkPSyYmGQrRfC1gKSyElr4Dw
	 y8qWDN0s52GKJEebdQrdIPt7Vw8fZbwcXXaGktCYP4FvBJ9Rhrnc2rUp6JwwTSOpLI
	 X9vdFZ8hLpGd4cal/gZJiYSMw+YjFvQg4xJHe8U5ILl0WtIGZWAsGi6x7jqVTmHN2T
	 uzRj3cOsvJ1Hg==
Date: Thu, 18 Sep 2025 16:20:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Ravi Patel <ravi.patel@samsung.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, ksk4725@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, bread@coasia.com, jspark@coasia.com,
	limjh0823@coasia.com, lightwise@coasia.com, hgkim05@coasia.com,
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com
Subject: Re: [PATCH v2] dt-bindings: serial: samsung: Add compatible for
 ARTPEC-9 SoC
Message-ID: <20250918-buckskin-panning-08b47b2523e2@spud>
References: <CGME20250918032715epcas5p1d1144cc09fa9c301315a5e2778d8668e@epcas5p1.samsung.com>
 <20250918032703.8885-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bka3UGLVuPORMstN"
Content-Disposition: inline
In-Reply-To: <20250918032703.8885-1-ravi.patel@samsung.com>


--bka3UGLVuPORMstN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--bka3UGLVuPORMstN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMwjWAAKCRB4tDGHoIJi
0ksbAQD3vHuNA5XdqujxS3pBGuiDXg1e5wnKpxvQl9qbSV3GCgD9E7+JB4mqrkXG
+trcFA6OFQaa7VJLZXW+78TGEnZkZwQ=
=PTo6
-----END PGP SIGNATURE-----

--bka3UGLVuPORMstN--
