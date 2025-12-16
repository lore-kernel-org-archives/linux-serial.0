Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8F30B52C;
	Tue, 16 Dec 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903263; cv=none; b=rIFCT3XtwVtALUqaKaacakcHp6bLxc4ZagEVKPvRRfScvkHDEW6PvajUMzSHuUZLnEW91GvokuUUXtwtNhEf4iHX3Dmn7aNfYKxwa9qtgVkhMeTpgQ6Jwv9BUeTelIUmUCPvPgFKh2ooonTfkkQugivrqYDBQJDiayAHGnWssjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903263; c=relaxed/simple;
	bh=gLWf9IOQkDnImM+DlGc+esOKlGsP0FIXh/V7uRJefKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn+Bh/KKd/5ixcyIg6H0gptYyC6OE3hlO7d/40h7i1PyRROBvn9fIbi2eQ14qFPHJXpHzt0XLj+fWz6KzQ56nPNNZDkjsaxXMc6sqm1m9kuwEioxWX2lS7QoAGdxT8qQSm3gW5V3WuOhYvA9U8R7VrbpU4kPu7G3suqYSlu+Vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhazTWPd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhazTWPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF88C4CEF1;
	Tue, 16 Dec 2025 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903263;
	bh=gLWf9IOQkDnImM+DlGc+esOKlGsP0FIXh/V7uRJefKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhazTWPdLbi3i9qJUTN2ZC43I/OyNoykyVQ0xg6mHucOwLfANYHpJX3FvMkWYufcV
	 o1RLSXsuF/lOQg+3/VSHMkKPppBRH/y73XBRjFmP8ixqdymFVjTIGYz4P6QfrQA/oP
	 Mxq9VZXUYBrQ4XX4M/I2MFVEeBsXbut4pn5xDBj2B4znltfNhrqgsOAoAfuuXCF2cV
	 apKdfLFJWpf6JHn3XhwjMJQfYDlASZCciMeyLQcPlRFlh3ReVnoJgWSOdsTRNYQNYF
	 0nNRGg3RULKZ+u9oqvEdIIUbIaf1yJ1t2dxIe8c6w4IlD0MgPzNfW49klSwZg609BB
	 Roeq9iRc82hxg==
Date: Tue, 16 Dec 2025 16:40:56 +0000
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
	Palmer Dabbelt <palmer@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: interrupt-controller: add SpacemiT K3
 APLIC
Message-ID: <20251216-aching-feed-1d27e71a0c63@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-3-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JhmyKJ6DVv3RyAWJ"
Content-Disposition: inline
In-Reply-To: <20251216-k3-basic-dt-v1-3-a0d256c9dc92@riscstar.com>


--JhmyKJ6DVv3RyAWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

pw-bot: not-applicable
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--JhmyKJ6DVv3RyAWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGLmAAKCRB4tDGHoIJi
0pcqAQDpB+Dg1i3rnP/xTAl/Jw8jDSstTyZ2dBxoRyt/wHK9CgEApR/0s8e6AF1M
cF49Ot1LSkgE66g/pqgEEP0wGxzizg4=
=JI5p
-----END PGP SIGNATURE-----

--JhmyKJ6DVv3RyAWJ--
