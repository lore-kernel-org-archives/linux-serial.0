Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D133A01E;
	Thu,  6 Nov 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449046; cv=none; b=Q/S+xYoJ/AvXP5m6Z6BehdcWdmgzr03cpG/VckHnZxjlM6hHFOSR71mN3UL4lbNrJvbngCBu64INZnEPIPCnwppBsVCv4d6EMIV3rqFDe6GkMTm4ihsiF6/uQO3Hn9i+VxyGcaEtXSiED63a8YbIHTon2IxiJWIZRiME1nEjLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449046; c=relaxed/simple;
	bh=5RJd2yoe7u43AeupxdyVCQ4K/Vt3gB+8I1S4CehziNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6dFYXAtman14XrNWBl41peA+qjWgOCr41GwU798ddWHkztYXN/KJOg2KOpwbbx4MoZNgjPD3aWZa8QoKvBjTRs/+aCu+2DNLXsuPUGiRx8YxLg2DRH7GPcoNxTNjGBEbcgGp1Pe6jdEOgGLdsXpoSomFBOhitqJdkpmJOCi5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkBZ2i+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkBZ2i+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A649C4CEF7;
	Thu,  6 Nov 2025 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449045;
	bh=5RJd2yoe7u43AeupxdyVCQ4K/Vt3gB+8I1S4CehziNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lkBZ2i+/mwOOuX9GhGdECytYLR4ZoDkJl849J2hQtO1L+/oDFNXYCeNt174ancQT3
	 xbCnN9sPThUf3r7wQHPF8iYrx9QE8ByQfGeeXHSpXSc7X1ozl146yDIHzIyhN477Zl
	 24roSdsWpljUoU1b1XPiOx3tQ9nNpNF0qwmsuiok+l3p312VCp83G1KCMDxzYj3j4R
	 V6CN2ulyVc4L6VZFinUoMZZKTE8+9ekl/LsZXnN1C4wR4qq87Iee247p9DqgX4zpQx
	 Mdo/2h36rXZ5gLXNVAuKxGQMnTO8WdbmjhK4ji+z1/V5GYGE6HlP6rgt50139EhDg6
	 7lEF3XunOSRJA==
Date: Thu, 6 Nov 2025 17:10:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>, tglx@linutronix.de
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	Inochi Amaoto <inochiama@outlook.com>, sophgo@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 00/13] riscv: Add initial support for Anlogic DR1V90
Message-ID: <20251106-tinfoil-primer-30ff181203f4@spud>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
 <20251028-busybody-disallow-e068b221db6c@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RxsOAUIaAk6EjGuV"
Content-Disposition: inline
In-Reply-To: <20251028-busybody-disallow-e068b221db6c@spud>


--RxsOAUIaAk6EjGuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas,

On Tue, Oct 28, 2025 at 07:39:07PM +0000, Conor Dooley wrote:
> Thomas, Junhui,
>=20
> On Tue, Oct 21, 2025 at 05:41:35PM +0800, Junhui Liu wrote:
> > This introduces initial support for the Anlogic DR1V90 SoC [1] and the
> > Milianke MLKPAI-FS01 [2] board.
> >=20
> > The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
> > UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
> > programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
> > the first platforms based on this SoC, with UART1 routed to a Type-C
> > interface for console access.
> >=20
> > Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
> > and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor=
=E2=80=99s
> > U-Boot. Because the vendor=E2=80=99s OpenSBI is loaded at 0x1f300000, w=
e have
> > to additionally reserve the DRAM region 0x1fe00000=E2=80=930x1fffffff t=
o prevent
> > overlap if using vendor's OpenSBI.
> >=20
> > Link: https://www.anlogic.com/product/fpga/saldragon/dr1 [1]
> > Link: https://www.milianke.com/product-item-104.html [2]
> > Link: https://nucleisys.com/product/900.php [3]
> > Link: https://github.com/pigmoral/opensbi/tree/dr1v90 [4]
> > ---
> > Changes in v3:
> > - Update DT binding to use ACLINT instead of CLINT
> > - Drop MAINTAINERS patch
> > - Rebase on v6.18-rc1
> > - Link to v2: https://lore.kernel.org/r/20250922-dr1v90-basic-dt-v2-0-6=
4d28500cb37@pigmoral.tech
> >=20
> > Changes in v2:
> > - Add MAINTAINERS entry for the DR1V90 platform
> > - Remove the riscv,isa property of cpu and reorder propertyies
> > - Fix clint base address in the dtsi
> > - Change the memory node to cover the full 512MB RAM in board dts
> > - Link to v1: https://lore.kernel.org/r/20250721-dr1v90-basic-dt-v1-0-5=
740c5199c47@pigmoral.tech
> >=20
> > ---
> > Junhui Liu (13):
> >       dt-bindings: vendor-prefixes: Add Anlogic, Milianke and Nuclei
> >       dt-bindings: riscv: Add Nuclei UX900 compatibles
> >       dt-bindings: riscv: Add Anlogic DR1V90
> >       dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC
> >       dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT MSWI
> >       dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT SSWI
> >       dt-bindings: timer: Add Anlogic DR1V90 ACLINT MTIMER
> >       dt-bindings: serial: snps-dw-apb-uart: Add Anlogic DR1V90 uart
> >       irqchip/aclint-sswi: Add Nuclei UX900 support
>=20
> I'm happy enough with this series to grab it, but while I don't mind
> taking some trivial binding changes with it, I don't want to take an
> irqchip driver patch. Would you be able to apply the irqchip stuff
> Thomas?


Could you pick up 4-6 and 9 here please?

--RxsOAUIaAk6EjGuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzWjgAKCRB4tDGHoIJi
0pjLAP4i3LKjrcugZ1SHa8IN8d1ahJjzKig/a42m3C3BLhx/6AD8CjGNPrqdnGjb
X9OAq+b6bdQXfUDl2Y1epPRbb3x1AwE=
=g1P8
-----END PGP SIGNATURE-----

--RxsOAUIaAk6EjGuV--
