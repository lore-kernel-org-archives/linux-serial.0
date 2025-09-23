Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2332FB0BF;
	Tue, 23 Sep 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654424; cv=none; b=Sl+30odK+YQopMNiHslTF42/sptCk8eCKQhm1YBhnf3A6cidDOstmhtD0iN+q8l7BI3pYmBbrsxiZX9GyEbl0Xb/iXTG3LYZiDgfaXO+al4lH44PAuouQX+rXmpHMoG5PGee3kvI7BJYnmzu67NCEZlqMfHg/TtmBw/IwRCdh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654424; c=relaxed/simple;
	bh=A5KuCxvXzisCMZQ6ZLL6eW8r5jlhUbt8FDx4TRI3YOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRMI/Upx2irmX5Zuj4B0zaMBKh4GzIEQI5VTrwiGQZVfAL/zf64W9f6k/Sd17/gO1b5vBRW3W6gI2bh1QogdjdQTga4hPjnqP8zjlb9FNNxi18Cic8IBhCFmUNYg3Yo/Q/oeYB5g+JVz2f1PyqVp47Md95qTfADx6whMbZnP3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZsEq/Sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZsEq/Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A52C4CEF7;
	Tue, 23 Sep 2025 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654424;
	bh=A5KuCxvXzisCMZQ6ZLL6eW8r5jlhUbt8FDx4TRI3YOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZsEq/SfeWwVHc+goEzZ8oxCNFzrW/53fa1JMhKWMj9ARS5b+EyVsnHhBV8F7Coyj
	 q+rlcp+sBoHLj8w95I2BPYOzXV1S10NkyrTjiehzxdzwTz1X116/IlZxNMYU4c+u9V
	 Ib8OBwpE4GO+6R7Ltg8687ZMgEkJgAKPigBQmFXe1KrJBCWLQIU+QIYEeACugDxME7
	 OJ/zebogv2iQckWbW7JGGuP+nZxAeIXMIogeFjvkyLzcM6a5ITr2nhkpXGaoFq2wbF
	 6hM70RO8EcJpbGRuQVPVlWkOnfBybzgPqQ/GPd+qWF2V2Pl+qPvMqpH9+gLOWzwvi2
	 QEQVP0qiLBaRg==
Date: Tue, 23 Sep 2025 20:06:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 07/11] riscv: Add Anlogic SoC famly Kconfig support
Message-ID: <20250923-culpable-unifier-735865b6e6db@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-7-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgTIzb98iU3E7UwD"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-7-64d28500cb37@pigmoral.tech>


--rgTIzb98iU3E7UwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--rgTIzb98iU3E7UwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLv0gAKCRB4tDGHoIJi
0rahAQDIa7iQcHkcobvPkRUM+vqUfxfP+uo/OOKYSvUNPq7FNAEA1s6ZHkmeTn1R
yIP1l7ue+9aXtFr/XMwe7K+F4b0QxQ8=
=Mycz
-----END PGP SIGNATURE-----

--rgTIzb98iU3E7UwD--
