Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EE2147E6;
	Mon, 12 Jan 2026 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253956; cv=none; b=EQICgHiszdxw4N/3x3C9hHlMn6uYldiTrfyHPuyVo0C9vYYPtJ0QOgrr0T/R7sFkeWkaa7d7cA8KepEF7j2eCXuqCjNk3ez9RVEksD0N99ROXF1BQRUXyGlAq7fkrZV85r4RJp6EQoAvJtbifUSh3cSWr5ogN4oxSRa6XKOpRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253956; c=relaxed/simple;
	bh=FWT3DFQ17PQuQNbf8lbPWQJloV82WeIIgcbUlhAjsg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIWNkqj+fY6YAS63/NaBmZlfSzAy6CwYiv+jsNaSya63LzAHjEgpvno/ny5ibfH6W34oXTMfRasY21fzYhYh6Aplf2RqgHknjUscJ40zFAMBIJdnCf6uejYqjAXG2ZvNtsixCeM8lYe37BAMXrwNR9i/ooU+YE6QFSf9aAlxsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juxH6omp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juxH6omp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69929C116D0;
	Mon, 12 Jan 2026 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768253956;
	bh=FWT3DFQ17PQuQNbf8lbPWQJloV82WeIIgcbUlhAjsg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juxH6ompWuZeMkJ77UnGSdBIltEPBSc+yJ5kAdENbdFosLqW2lC2vQgsIeATmSeQ7
	 cvUyKea6+EfFWMnwIU28WIyNCMdN5T+hK2/OYJeQAudCNdzwJriCGNUgsnHZ55EaB7
	 AhUOFn2YRbwdr1vv+DrNdjwLaaCkcOuYjmrDQcHp4mWiH3VB7zT3yTJWW8kHU0LaUD
	 6I7EPK6SiN5lOnwkfOKag+MrnalmXO341xWD93ih6tYhsnioBWoRBQtUYJJIMJ9mb8
	 Jr56Ld5AK0t5hmxSMZpVhMWbYf/k7ximjsXZ3e/VSODRp5nb2ey2VwAMFZ5Cdz325k
	 eYsb0fVtV5k5Q==
Date: Mon, 12 Jan 2026 21:39:09 +0000
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
Subject: Re: [PATCH v4 08/11] dt-bindings: riscv: Add Ssccptr, Sscounterenw,
 Sstvala, Sstvecd, Ssu64xl
Message-ID: <20260112-diaphragm-verbose-142d6a60d33b@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260110-k3-basic-dt-v4-8-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+vzLOfp326l2Yqre"
Content-Disposition: inline
In-Reply-To: <20260110-k3-basic-dt-v4-8-d492f3a30ffa@riscstar.com>


--+vzLOfp326l2Yqre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+vzLOfp326l2Yqre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWVp/QAKCRB4tDGHoIJi
0gvQAP0TUGTl1CYn4JsYoUUXRTUGAJN3oi7YgYIzDHYy8Bld4QEAuy3WfklDTJeL
3AbHkMbLmB4OPplmtLOqGFoyUsmU5QE=
=hgdS
-----END PGP SIGNATURE-----

--+vzLOfp326l2Yqre--
