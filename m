Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AE1E1A3B;
	Mon, 22 Dec 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435799; cv=none; b=TZZ/41p4SzdnWSYlAcnfkmUH3MF9vh35ouO1eOq10FBgl9/bAAWHkFMhCuvH4THmOxJG39atpoNgnEELZL7DqIXE0q4VUJuu2N2wO4k9WNCGlVkzrn+vO0OOs1OPq4KPb5XqLceXLzpigLIXLSpel1YnaCwpJmkm9qfvxjK5p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435799; c=relaxed/simple;
	bh=OCb7Ri4ue/mb6gJDnZKrlyQpns/UtB1eogrgWP7fjbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjEWa4rQ+hz7OV0CJ/x+lhTKklhYWQ0i3rmtAZws2nj+PagBOC+naYuxcEcMmldJBEURoDrlY9hBy7Qo5BSoC3t/+p+HoTz7ftkDbVTnP7j73b+CRINbajU+ei3LfAIS7RtgwdPxnf2rauT++pUqrdnY8RXLCPktY9UWcFLgEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa/IV9M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa/IV9M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FCBC4CEF1;
	Mon, 22 Dec 2025 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435798;
	bh=OCb7Ri4ue/mb6gJDnZKrlyQpns/UtB1eogrgWP7fjbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aa/IV9M7BDWFqyXp55P/4K1Yq0lalz6HntPHGQCkSiR0mdrOVkVR0sRPJGED0gO94
	 XCxP5+vn9aPA5o8wWrf9Qx3wm0e9E/kvAGrpcxKK8xZbP6P1WxgcOdXLwG5jwAEPvo
	 yB4ceUWwxDUlf8AOiSLhgxwiFchWfAvQ46SUrHGUgbYTlnQd6GsF41pNRpH2+h9XMc
	 h79ehRoHCpc4EAT4fblDojaDr+PNt0IOwKau7zNTUP7ubJWU5rmQ2+A1xoV1TGEbng
	 zqQGwgYz3PDYqL1h4havXBcrm7U91TZmELKRRqfkAhrVtIgOlaf9wsavj4C/aUGctz
	 V/pJSuJ5qt8wQ==
Date: Mon, 22 Dec 2025 20:36:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Guodong Xu <guodong@riscstar.com>,
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
Message-ID: <20251222-dimmer-wooing-db29fe925498@spud>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
 <20251216-k3-basic-dt-v1-7-a0d256c9dc92@riscstar.com>
 <60948ca2-ed3d-485b-9b11-15df7ef8791d@canonical.com>
 <CAH1PCMb=+TvB1w+G6a2ANDp05HUwC4r6CFBDHXFwSmoP3Mm8xw@mail.gmail.com>
 <f9b6b5e2-ec9e-4208-8267-77020e0a9411@canonical.com>
 <20251218-basil-quantum-225ce16e4699@spud>
 <CAH1PCMZ3KM9-D3NJ1N2LUHTHFSDVKmGKT5fU8knAL7NnV9E-gw@mail.gmail.com>
 <20251220-repacking-football-c79e660e788a@spud>
 <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="988vl9+00At+flzi"
Content-Disposition: inline
In-Reply-To: <4e4c9e7b-d95c-4157-94c3-b06002f94a48@canonical.com>


--988vl9+00At+flzi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heinrich, Samuel,

On Sun, Dec 21, 2025 at 01:10:15AM +0100, Heinrich Schuchardt wrote:
> On 12/21/25 00:23, Conor Dooley wrote:
> > On Fri, Dec 19, 2025 at 10:03:24AM +0800, Guodong Xu wrote:
> > > Hi, Conor and Heinrich
> > >=20
> > > On Thu, Dec 18, 2025 at 8:56=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >=20
> > > > On Wed, Dec 17, 2025 at 09:07:14AM +0100, Heinrich Schuchardt wrote:
> > > > > On 12/17/25 08:11, Guodong Xu wrote:
> > > >=20
> > > > > > Specifically, I must adhere to
> > > > > > Documentation/devicetree/bindings/riscv/extensions.yaml (and cp=
us.yaml for
> > > > > > properties like 'riscv,sv39' which stands for the extension Sv3=
9). If I
> > > > > > add extension strings that are not yet defined in these schemas=
, such as
> > > > > > supm, running 'make dtbs_check W=3D3' fails with: 'supm' is not=
 one of
> > > > > > ['i', 'm', 'a', ...], followed by "Unevaluated properties are n=
ot allowed."
> > > > >=20
> > > > > If Documentation/devicetree/bindings/riscv/extensions.yaml is inc=
omplete
> > > > > with respect to ratified extensions, I guess the right approach i=
s to amend
> > > > > it and not to curtail the CPU description.
> > > >=20
> > > > Absolutely. If the cpu supports something that is not documented, t=
hen
> > > > please document it rather than omit from the devicetree.
> > >=20
> > > Thanks for the review. May I clarify one thing? Both of you mentioned
> > > document them, given the amount of missing extensions, is it acceptab=
le if
> > > I submit a prerequisite patch that only documents these strings in
> > > riscv/extensions.yaml plus the necessary hwprobe export? Leaving the =
actual
> > > usage of these extensions (named features) to the future patches.
> > >=20
> > > To provide some context on why I ask: I've investigated the commits &=
 lkml
> > > history of RISC-V extensions since v6.5, and I summarized the current=
 status
> > > regarding the RVA23 profile here:
> > > [1] status in v6.18 (inc. v6.19-rc1):
> > > https://docularxu.github.io/rva23/linux-kernel-coverage.html
> > > [2] support evolution since v6.5:
> > > https://docularxu.github.io/rva23/rva23-kernel-support-evolution.html
> > >=20
> > > Strictly describing the SpacemiT X100/K3 (or any core) as RVA23-compl=
iant
> > > requires adding these extensions that are currently missing from
> > > the kernel bindings:
> > > RVA23U64: Ziccif, Ziccamoa, Zicclsm, Za64rs
> > > RVA23S64: Ss1p13, Ssccptr, Sstvecd, Sstvala, Sscounterenw, Ssu64xl,
> > >            Sha, Shcounterenw, Shvstvala, Shtvala, Shvstvecd, Shvsatpa=
, Shgatpa
> >=20
> >=20
> > > Plus 'Supm', 'Zic64b', 'Ssstateen', 'B' where the kernel supports the=
m but
> > > they are not literally documented in yaml.
> >=20
> > I don't think Supm is suitable for devicetree, doesn't it describe
> > what the kernel/userspace are capable of rather than hardware?
> > Zic64b doesn't sound like hardware description (so not really suitable
> > for devicetree either) but block size information is already represented
> > by some existing properties (see riscv,cbo*-block-size in riscv/cpus.ya=
ml)
> > and duplicating that information is not really a great idea.
> >=20
> > I'll admit that I do not really understand Sxstateen and how they work,
> > but my understanding was that knowing about Smstateen is sufficient and
> > implied Sstateen, but having Ssstateen defined seems harmless and
> > possible. I think kvm is the only user of this at the moment, so
> > probably worth CCing Anup and maybe Drew Jones on the patch adding
> > Ssstateen to make sure it makes sense.
>=20
> Supm is described in
>=20
> RISC-V Pointer Masking
> Version 1.0, 10/2024: Ratified
> https://raw.githubusercontent.com/riscv/riscv-j-extension/master/zjpm-spe=
c.pdf
>=20
> The interpretation taken by QEMU has been:
>=20
> * Supm implies Ssnpm and Smnpm
> * RVA23 capable machine models display it in the device-tree
>=20
> If Supm is not shown in the device-tree, software might assume that the
> system does not support pointer masking in user mode and is not RVA23
> compliant.
>=20
> Hence I would suggest:
>=20
> If the X100 cores have Ssnpm and Smnpm, add Supm to the device-tree.
>=20
> If the kernel does not support user space pointer masking, the kernel sho=
uld
> filter out Supm and not announce it, neither in /proc/cpuinfo nor via
> hwprobe.

Samuel seems to have some specific thoughts on how this works, given he
didn't blindly implement ssnpm and smnpm, but has made supm be mode
dependent and not permitted in dt, hopefully he sees this.

Personally I'm not convinced that putting supm in dt makes sense, but
instead the kernel should imply it if the sxnpm extension matching the
mode the kernel is operating in is present and RISCV_ISA_SUPM is set in
Kconfig. That's effectively how it works at present, except it'd involve
promoting RISCV_ISA_SUPM to a "real" extension instead of being a macro.
A validate callback should easily be able to handle checking the
mode and whether the Kconfig option is set.
That way it would get exposed to userspace using the actual mechanisms,
reading the devicetree itself from userspace is not a valid way of
checking what extensions are usable after all.


--988vl9+00At+flzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaUmrxwAKCRB4tDGHoIJi
0nD0AQCh7tCcD/VUpyn10ynw6g14Ck95MSUjtbHdKUKfiQ6VTQD+PltQ3Mrq+GoG
ElDL9JRaanMKaQR08ZCQxkZeZxcEBgI=
=6WEG
-----END PGP SIGNATURE-----

--988vl9+00At+flzi--
