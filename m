Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4A2D3A77;
	Tue, 16 Dec 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903290; cv=none; b=Uks6sqdTxyBAJUfg04lunOee6l4ZiTAzbFvbdxNF5tpijy9NuBe32Xgf2iGLoNGKppYmU3THfWLfT8OCvtvpQNCIVCaGsx/oq63R60W+e+8anx1uNEZzpy+zfPNPxRGNIQCR5kJVLHyRT5R1+IecvyaG29T8m7a6cz5iAtI0dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903290; c=relaxed/simple;
	bh=Se/DK8m93a4S91149Yg8i4Gry3opMMWQfbXS3uw4q1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEZNeklE9481GR8nqvwTDx8vkAizyqiTilhgy5wmq7H5FItVTYvqdpYhXDTe1aWmq/m3gE5F/LgVLIB1fMk5ak8jAtqRJ9X8Lh2QtqdBi3cnK1f28/w8/nnwvfxz3ufOwBPQWT3SVc8CfaWrnAuHMFFztjKUh95297O/wBwqhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9dBlgt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9dBlgt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11611C4CEF1;
	Tue, 16 Dec 2025 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765903290;
	bh=Se/DK8m93a4S91149Yg8i4Gry3opMMWQfbXS3uw4q1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9dBlgt7+8r02618IAf+x+IefVeRB44+xlz3X0Pj9ZBBeZm6ENDYcfzDEIobH5YE2
	 6kYh7UstB7R24S/U+uuNB4uYpKe2FjIbCt+4qpK4mkiir3yQDDc3lfc8FxmT0RX+Mx
	 0guEUdH0Fp2eriqmAezfH+iS+Gn0SkR9oNVXyoJimVZjrRJzla3TljFoMdMHIDh8pB
	 pVGZcsASXRkl9DilDaNItuQpKQ5zFSJth9ZkNqW3YMSV6RXmtAcbKIqHnW3IjjqMqE
	 ayeKXb0LfAwqYvbjIlXZR7fBIEPGGmc9aAxY6sbHuvugKk4G5PULWHHilGAAeAHqD5
	 dCzrJrV6NudkA==
Date: Tue, 16 Dec 2025 16:41:23 +0000
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
Subject: Re: [PATCH 5/8] dt-bindings: serial: 8250: add SpacemiT K3 UART
 compatible
Message-ID: <20251216-reforest-list-ceb775dc9dbd@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-5-a0d256c9dc92@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPFQEofot18lifdU"
Content-Disposition: inline
In-Reply-To: <20251216-k3-basic-dt-v1-5-a0d256c9dc92@riscstar.com>


--DPFQEofot18lifdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--DPFQEofot18lifdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUGLswAKCRB4tDGHoIJi
0g1NAQDL9fx7G+lJVeeNHoBHTDkYugqV7bhsvIgVM3pX/jBY+QEA+emY/EGgQGnT
Y0ExzgcquFyQ1T6l5rM0hgNUaLylNgc=
=y5Wj
-----END PGP SIGNATURE-----

--DPFQEofot18lifdU--
