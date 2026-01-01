Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C21E3DDE;
	Thu,  1 Jan 2026 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227048; cv=none; b=IvI2fOtMmEJRvsNessps5msXm9Vy7im7JVM2WVI6DYSbFYILIfWWC82VHoJVe5VaqXsvVWZbNidttvPBRuYRuMvXhlxTGSVsNEA44V/VApx3JedJA798VD2a7TKTGke/cF73N+o88neMZlK3tXO35F3XxMG8ayOvL0wF13aX6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227048; c=relaxed/simple;
	bh=KNoiApyMWT+DJ8JQATW2+HokfFFLugunixpx2ju/Efw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcYIeWKJ+7/emBkVswlHZ5GaQMPTeMaJhSMS0wKILQ1bdN/+hNGdfAjOL6G8XI976oXI4Dy59dQdBKNz3Fn44XsaNM5cgfvsvMZb9lOe8bA0Exol+1iY0MOytYYgLT8TQ/xM18yVmjmpq3ImPgAqVN6lvDL6hGGb3llUSjpM/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/5VTD1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/5VTD1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A82C113D0;
	Thu,  1 Jan 2026 00:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767227047;
	bh=KNoiApyMWT+DJ8JQATW2+HokfFFLugunixpx2ju/Efw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/5VTD1BhKf5/WmuhqAfM50d2/IyTD8N6HxvtXDzKesz6dn/jpDImNFrOkRc/TdsW
	 rpJxwoW9hd1fGmrsP0T1sU+a4jrWPAv+zVthRCZOXFc4h/Y7auCh90lJj2946gVhGb
	 3lTyhgxycbHSOnozzEVTj7nD6nkQYohyk8SsUBzXRkXL1T7tBt5MwNSba5mCuo4sPB
	 MZ9pBrD4u2RJ+jed66+QfogHzPi8nF7yukLACKy5peqY2TAM7e2uR/GAVec9TCvVlQ
	 nADJT2YCvkhGrAvJvOw5NOWB0KawztDXlhqHH0moqLtgoQI+l90C+q7gGOPQPgrEhf
	 8su+eCYh/8uxw==
Date: Thu, 1 Jan 2026 00:24:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH 7/8] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Message-ID: <20260101-legume-engraved-0fae8282cfbe@spud>
References: <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
 <20251220-repacking-football-c79e660e788a@spud>
 <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>
 <20251222-dimmer-wooing-db29fe925498@spud>
 <CAH1PCMbane4uN=N0UPRDG9x9NUbD9SYsbH+NnP-gzU6Bo8L2wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X7aUwCxMZok6EY4n"
Content-Disposition: inline
In-Reply-To: <CAH1PCMbane4uN=N0UPRDG9x9NUbD9SYsbH+NnP-gzU6Bo8L2wQ@mail.gmail.com>


--X7aUwCxMZok6EY4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 02:53:10PM +0800, Guodong Xu wrote:

> As we wait for Samuel to share his opinion, maybe I can submit a patch in
> (I already have it)
> my next version or as in a different patchset to implement what you sugge=
sted.
>  - Assign RISCV_ISA_EXT_SUPM a standalone ext number in hwcap.h
>  - Implement a riscv_ext_supm_validate() and put it in the callback of bo=
th
>     ssnpm and smnpm.
>  - Kconfig will be kept as a top level gatekeeper, no change.
>  - dt-binding entry for supm will not be added.
>=20
> The only reason support me to add sump into to the dt binding
> (extensions.yaml) is it's now a mandatory extension required by RVA23U64.
> However, as you explained, that logic seems not strong enough.

Regardless of what we end up doing in dt, I think you should write the
kernel code as if we are adding it to the binding. That way you can "imply"
supm from both ssnpm and smnpm (see riscv_zvkng_bundled_exts for an
example) and add the validate callback that checks against the privilege
level to supm itself. I don't think sxnpm should be disabled if the
privilege level of the kernel is different to that of the extension
(e.g. s mode kernel and smnpm) or if the kconfig option is disabled
(because I think ssnpm could be providing kvm with pointer masking even
when it is disabled for userspace). I think doing it the way I suggest
works better for those kinds of cases but also will just happen to work
for ACPI systems that have supm without the relevant sxmpm listed.

--X7aUwCxMZok6EY4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVW+oAAKCRB4tDGHoIJi
0t9lAP0S+GP12VlrrHu2vbrcEV+WOXWl8WA2T3jhIVGaQnHF+QD/bc6sUs2BIlUa
/VSDfvq3JlZVUzvMjkx29+2XvTi3yAc=
=RYdG
-----END PGP SIGNATURE-----

--X7aUwCxMZok6EY4n--
