Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC32147E6;
	Mon, 12 Jan 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253924; cv=none; b=mSipWodH0618LiCrHr2M838n5WT278g9Ag1DVCsnXI60PbhbXfHvVeTUpiMEGVx7NKubL0kW6fKwEceh+s9Zl+wQAp+DjhUb1QHCPukBnhiWl19LONKeP6x3zAK3W1335zVYcG1Ul/LM+GVwlui2botYksPNLm2pDrxWI2GKY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253924; c=relaxed/simple;
	bh=vBi7wuAJuJ8NTq0C8JbqIvOjzKPuDK9DGpU4UZLWUko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO94xDbNEapwE9Sy7x13jCxJTjTK+/hb/NhRLf0NH+ixDh70rHp5rPAfOO+SVib2zR7DNmVtFawrbPm3gK/2jDbz3Q5f+nZ5r9x8tuowdp1lYpmbtxyKPFl7kQR9BrwILjHengGZFsGrcdXAYsRHcKLSEuI7OnxP7K4L1JuxDoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb+exARq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb+exARq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF2BC116D0;
	Mon, 12 Jan 2026 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768253924;
	bh=vBi7wuAJuJ8NTq0C8JbqIvOjzKPuDK9DGpU4UZLWUko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jb+exARqsHhS4kIzEP0rwZ5c4MeHnfQLVvoLMBgjZGVvtO7t4CMlv9sQVi11bq+En
	 Faj2UIeASk2X0VoeXmAb0NO8c4vbavB5fWXyg2Zxdlz5+L9yPMLRboQltnGb+U/1bY
	 xX48rfyew/rZNKc0FHByCDWmprzGetlyCiFKDNTxtKPkKJOYM9CTzf7a3Z5DWotIms
	 JRtscJa1yJ6iQIk/oCxKxDBifCy/RhaRTGI4CFRALPvGw4mcXdXEu6S2IsmrsBVQT/
	 G3MeriXZWlRYqtgVkXVOHMYGKH16v89JjC0wu6UBp/3TTjOxFLsv5r4YwhB41EHYys
	 SBrEgHVRBRRuw==
Date: Mon, 12 Jan 2026 21:38:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 07/11] dt-bindings: riscv: Add descriptions for
 Za64rs, Ziccamoa, Ziccif, and Zicclsm
Message-ID: <20260112-unwrapped-affluent-5f68cc82c335@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-7-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y9kycwEVFeG6sD6q"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-7-d492f3a30ffa@riscstar.com>


--Y9kycwEVFeG6sD6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Y9kycwEVFeG6sD6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVp3QAKCRB4tDGHoIJi
0qTuAP0S3FttlkbDDN/4Ybc7gLd9lNnSSoSGB6im59BdpbsO3QD+IKthJmyKuens
uiqJ/T4IbtuwWEyjJVvXvDNLqODQ9QU=
=u++5
-----END PGP SIGNATURE-----

--Y9kycwEVFeG6sD6q--
