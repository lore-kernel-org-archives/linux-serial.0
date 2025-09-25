Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BE30F937;
	Thu, 25 Sep 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820207; cv=none; b=PuOvg6l20l+3654+geJZZIb6Slixurzwcg39CSmWvDTZqqtlL+pwiWF7pN8JI+/SV04JmgCj3/Xl4Z7kmRck1WlNrNIHeBUOFwCl1P7gcf2EzsmU3T9LA6ol4Y0+X3OSiWnJsVsWXsIDtSTZTvBlfamMdobOlYmbC0xoZE//SyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820207; c=relaxed/simple;
	bh=q9Rq4/H4aaM/wf9aFUG2tSAvIqRjG0CUjxb7SNWmI3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7V5ubatJR7x6/jvH96vg2yUneZdHdxXdzGPHEik0W22uWNI1FdlHbq2nP182fuo4LKjgHj/ge1w7wWtRF9LhLeshpUfXETkZWGYgGdNVy6MeWTGW1SCDbZPldBd6wn8d/wfPA+fbdbImJ5wT0HUEbOYsmiK6xKKOg+UFI60deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbWgcHmZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbWgcHmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF419C4CEF7;
	Thu, 25 Sep 2025 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820205;
	bh=q9Rq4/H4aaM/wf9aFUG2tSAvIqRjG0CUjxb7SNWmI3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbWgcHmZnhxuMEtRTUmUs93JI0IYz2Z3HEnTvjy4KzYzdF1vPX4T6i5ei0jgCNWAW
	 Tcy6D1XJhe8s4m92hBsXas9C/L3aBtcs7Rx9Bj0Wcg44SRNdPZa1cG+xUD7pRdWBp2
	 1eU6ZsWa9EDshi40H217ep1tgmHWKTwYN5PN8FO+ptJ4gbzXOOixkyTYInChCpYtwW
	 dOa2X7DGVgoWv70DAmjIiae6shfCf40YmkxTaUY4hXtt8P+8/LLz/BWhRzd4UJ5fuK
	 1p4ZKmHDUYb4X+0S/uudSnEBUZL6gyx+fMwCwETjAXDpuipbJ1yHQ6IbWtmOnacs36
	 HKf+aXpQlsBXg==
Date: Thu, 25 Sep 2025 18:09:59 +0100
From: Conor Dooley <conor@kernel.org>
To: "fushan.zeng" <fushan.zeng@anlogic.com>
Cc: junhui.liu@pigmoral.tech, alex@ghiti.fr, anup@brainfault.org,
	aou@eecs.berkeley.edu, conor+dt@kernel.org,
	daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	krzk+dt@kernel.org, krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, palmer@dabbelt.com, palmer@sifive.com,
	paul.walmsley@sifive.com, robh@kernel.org,
	samuel.holland@sifive.com, tglx@linutronix.de
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Message-ID: <20250925-jaundice-uneasy-ff8b3b595879@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250925030650.35694-1-fushan.zeng@anlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eu9584PsFdUWS5DG"
Content-Disposition: inline
In-Reply-To: <20250925030650.35694-1-fushan.zeng@anlogic.com>


--eu9584PsFdUWS5DG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:06:50AM +0800, fushan.zeng wrote:
> On Mon, 22 Sep 2025 20:46:30 +0800, Junhui Liu wrote:
> > This patch series introduces initial support for the Anlogic DR1V90 SoC
> > [1] and the Milianke MLKPAI-FS01 [2] board.
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
> > Notice: A "no4lvl" bootarg or dependency patch [5] is currently required
> > for successful boot on the DR1V90 platform, since the SoC hangs if the
> > kernel attempts to use unsupported 4-level or 5-level paging modes.
>=20
> Thanks first.
> Anloigc already has the open source SDK at https://gitee.com/anlogic/sdk,
> and will submit it to mainline at suitable time.
> The code should be a full feature version after lots of tests, not the
> modified and simplified version from Anlogic open source.

The nature of the upstreaming process will require what you have to be
broken down into multiple parts and be upstreamed at different times,
depending on how long components take to review. This is normal and
expected. Of course there should be through testing done, but I don't
think that what is in this initial patchset really requires much
testing - if it boots then it's probably sufficiently tested!

> And we hope that there won't be two different versions code of anlogic SO=
Cs,
> it may confuse customers.

If there's ever going to be complete upstream support for your device,
then there will be two versions, because looking at just the dts files
in the gitee sdk you linked I have noticed things that are not acceptable
in upstream. As others have said, you are not entitled to control the
upstreaming process for your device. The only way to have some control is
to submit patches yourself and to engage with the review process for other
components. It's in everybody's interest to keep differences with your
SDK to a minimum, but you need to accept that there will always be
differences because the upstream community simply has higher standards
than those in your SDK as well as a requirement for portable code that
you do not have.

> It is better that anlogic SOCs are long term maintained and supported
> by Anlogic officially in mainline and for customers.

It's only better if Anlogic submits better quality patches (no evidence
for that yet) or submits the patches more promptly than others (which
clearly has not happened here), and offers review commentary etc at a
higher standard and more frequently than a non-employee maintainer would
be able to do (there's no evidence for that so far either, given you're
trying to stall this patchset). Your claim seems to have no merit as
there is no proof that you'd do a better job.

Thanks,
Conor.

--eu9584PsFdUWS5DG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNV3ZwAKCRB4tDGHoIJi
0uaWAQCSkbVTTIbafxcfF96xk5lgaG5ln+YtgPuJtAGRusRBkwD+LaffLvZLIg1V
8qVEjLULVNOgXNHJOEiDL5yOwVweCAM=
=QmTb
-----END PGP SIGNATURE-----

--eu9584PsFdUWS5DG--
