Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89283101B0;
	Tue,  4 Aug 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873822; cv=none; b=By4z8mLx3+wD19UrYiohLnMVNrOyAF24Cp4F4kIzDjVDZ5rEDI/99gb6iotFe3N9VoYGRsWsm9mgCA4tVmhFP1P48uSUNqW1yQ8h/L60A+w/9pyjFzgw/mz0jCWw0rnfeOK3miAavk9hmfNO/jYGTaATsbn39jAK5eC0RqjChPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873822; c=relaxed/simple;
	bh=hgcXqzsJ35C/PK4z8Fxizm06bZbpDKFlJX69a+ddZIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJblsFpOglaCKinKuKr2byc3yYax9sCZMWVMGqGWGDXxj2ZgVVcrLWzpU9+c0w8PFcAyInDpo9T099bhMBDziHvVdPWM3diSniXRIJS6OO10qv/KbnfqGqEtyqykVwUmc7noCRnbzh1WRtB9FDCtwy6FqDTJyq+UNTOPRr8GqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHBLK4/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHBLK4/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F61F000E9;
	Tue,  4 Aug 2026 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873821;
	bh=hgcXqzsJ35C/PK4z8Fxizm06bZbpDKFlJX69a+ddZIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHBLK4/fuO9IlkUVgoLTEUFYY0EEsosgnKWNZgajxagXKV0C69A6E1Dk/KEnkKsvB
	 hb/xEtUZOJqQI9iN+3rtVMCzXGUm207bf2zKfDWy+mb0X7IYl5iWRlOYonWcj4jHMH
	 9ksSI0CT4r7l80SIR7+WbZbGU40Z2YpmIxpQBI19J6oBFJiGRmAGMTvgqvRt5ZCr4e
	 Cd6ChwfTIfotm+anL5l852DkrLL9s2aFi/vdUXP3r3WgTZ3wiX21Z7QfWooEGWY0u+
	 GIkbAdZ1YgmQu/MOeGFcpepjT9pBd7LekLWh0rrpLBIaqcsSkPWs1PzWYSxaCZH/di
	 yEDgu0Kl73djg==
Date: Tue, 4 Aug 2026 21:03:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	mukesh.savaliya@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 5/7] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Message-ID: <25dd7d3d-1952-49a7-aad7-f6aceb449644@sirena.org.uk>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VJ4LQaWdyGBuT9Nv"
Content-Disposition: inline
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-5-61171ab1cdce@oss.qualcomm.com>
X-Cookie: Biz is better.


--VJ4LQaWdyGBuT9Nv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 01:27:43AM +0530, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to look up the source clock
> index and divider needed to fill the GSI CONFIG0 TRE for a requested
> transfer frequency. To work around this, firmware instead exposes the
> SE HW supported source clock frequencies as OPPs on the perf domain
> device.

Acked-by: Mark Brown <broonie@kernel.org>

--VJ4LQaWdyGBuT9Nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpyRZYACgkQJNaLcl1U
h9Cr7Qf+Ks5KKIkvEQ3YWLWthzIWu5dk3eSUCxEcpQds1fMTo/GgyfdJuSMYi29V
eFjXiDcd5AfZuf5f0F/80wgxPQvs+18S1+8KcXwwvqMF8Rex9NrBAwepNYo6QpI/
B+doiAZ1mjnKIxdrJpDGm+wxdYvTK3Tks36I8bNQ1RfJDE+tT9eClXfrMLuZJrE0
/26N3ja+vxPacl1TK+X5iYFkkF+GSxtrxB3/i+HcPZFvED5MYu9jdogGw90Rzn+U
hVlrEOsoZhAbeT1GCElJNNxVAq98HLMoiVegBb75+eqMEZpVi0HUiz5URL+zPZsZ
cx7q/e1NdI1TM4Rc/N41V1MX3N84Xw==
=yX68
-----END PGP SIGNATURE-----

--VJ4LQaWdyGBuT9Nv--
