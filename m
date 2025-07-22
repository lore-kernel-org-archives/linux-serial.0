Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544D26A0AB;
	Tue, 22 Jul 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197688; cv=none; b=j4D9PMtkeECDeDC+VSfwarKU1x7EwJFrwORwg8PcqG22I23+ITNP1ZTKy6y3L+V61M8AJfWH2tLk1+oLQe6mdg10d/0fPY+CeYkj3//wdK6y8leUykGfGLQVVKLWCXvAfEAeeAimx5BgqfD61BlZodnyE1HTU7DhhcXeFxDFkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197688; c=relaxed/simple;
	bh=cf0wdr1CvohXeEFUICFRM8xLV372zGAy0zsKMtrFMXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyA2V7nWLeojXXMYNL7LLiCWR8s3oK3cbFAhr2ZSHEffjBaf/VyFK4r900eAFs+jfeqn5sktCtL4kTrwAWcNEDyVdZBHaX8cHyU+zifjXvs4j1Rx7da+A7bFE1PbbRIrGNgkdzrhQQXCsLWbdw6H6Wpe6elrc2dffqUZtal9J9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGWPeere; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGWPeere"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A82C4CEEB;
	Tue, 22 Jul 2025 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753197687;
	bh=cf0wdr1CvohXeEFUICFRM8xLV372zGAy0zsKMtrFMXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGWPeere1LxvDxtuOVyK02QKkMZdY/fVcf3E5EfkgtyPVXEpfIZetiJTqIPg6s6j9
	 YJByTAcP1O7AxFqkFRYruTsfur3tgCok95h9i1AiVWwtTy8a7Hcs24Q50fvvoybvt4
	 cYShSTzeVcdZZf5MkEgnSj/SWHw+I6njph+UnSvxkVAhPGJ2B0NlJE+q0MGlwXWtrF
	 fZzVc3HoTb1KeDQediGCl/TFQtgf1d5g3kLFLIHbup9dx8+haFDDAJdtms4o/EOmrH
	 3AOJ7RjTgegP+cTvP4CWvn4pwGiPFMFNP8CQ4j/rYnMTEdnAVH0AhROTlfa9taabHM
	 EKu8+sih1BI1w==
Date: Tue, 22 Jul 2025 16:21:21 +0100
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
Subject: Re: [PATCH RFC 08/10] riscv: dts: Add initial Anlogic DR1V90 SoC
 device tree
Message-ID: <20250722-proposal-gothic-e0c3725e0874@spud>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
 <20250721-dr1v90-basic-dt-v1-8-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="afRjLr3VfY6LSQZo"
Content-Disposition: inline
In-Reply-To: <20250721-dr1v90-basic-dt-v1-8-5740c5199c47@pigmoral.tech>


--afRjLr3VfY6LSQZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 11:46:14PM +0800, Junhui Liu wrote:
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <800000000>;
> +
> +		cpu@0 {
> +			compatible = "nuclei,ux900", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zba", "zbb", "zbc",
> +					       "zbkc", "zbs", "zicntr", "zicsr", "zifencei",
> +					       "zihintpause", "zihpm";

Why do riscv,isa and riscv,isa-extensions differ?
If riscv,isa is not even accurate, why not just remove it entirely?

> +			i-cache-block-size = <64>;
> +			i-cache-size = <32768>;
> +			i-cache-sets = <256>;
> +			d-cache-block-size = <64>;
> +			d-cache-size = <32768>;
> +			d-cache-sets = <256>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};

--afRjLr3VfY6LSQZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaH+scQAKCRB4tDGHoIJi
0kcxAQC07OuxpRCZ8Q37NhGJuCtcTQZB2khVWHrIO4eTpF1rigD9EGK+eM/M4tcx
h1x5Hhtr6tSWm89moTRnYqNzdGKdzAw=
=q4nA
-----END PGP SIGNATURE-----

--afRjLr3VfY6LSQZo--
