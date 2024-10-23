Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE51CC170;
	Wed, 23 Oct 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709640; cv=none; b=QzYtQJq+x2pQ+qrCaIxCHN9bkiMcvw4FLIRZt8IRzYgoHXQUV4Jk/rDF+j/KO7ulUbyhT50ID7C7f9rlXzV59A8qbNu4Qbz1PF1EQl9UJLym55lTNSdVayiHl/+YfZUzyVpXnzIeFHwgP01yuPNwgZAel4toyTJzbdSFOdpJLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709640; c=relaxed/simple;
	bh=5Pt3SczTg9tl+y/wXVlx0w43lG1EclvLYHV4haFhs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2qZeJx1hYPONeptjclxFoMeqIPztvv7LJs3xGSZTOlIF6IHASaml7MEFnMktGPajD8wAgVHVgpDo/IQB+yJKu1sCNQJy+WxlIMPoroCE0lP2V2i3pzBrRC1dct0NUX9f9bCZYXacaVMJ7CS6VGt1vUB9cts9loX34JttHUVdkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNzG/EMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNzG/EMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFF3C4CEC6;
	Wed, 23 Oct 2024 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729709639;
	bh=5Pt3SczTg9tl+y/wXVlx0w43lG1EclvLYHV4haFhs1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNzG/EMybBKcPcmF6JfUU7O4/pzCGNTc3FbY2AIPk/pV3i5r0q014C7hxyUIa7Swe
	 83cLVQ0Qm/Tv5icgh/xnE2rzGVXkpsvBSE0fPRJPGGlJiGl1djU8uXU30T/SzwX0J2
	 6A0ovwGz6FhgUiKLeHO0bT4wBfESzEOjUurXDFdtjLOac66fE6s+OvAHffCi9JxaX+
	 7wPAyPlOi7fdRt0GQjzZbFfA4LhTBUdTv1QSUWP7hpxi50iE2uMClB+4lSxmPQopUp
	 fIJkkTLJPSRN7s3oaMTBVdgdZ2+oHWdRcivGEi7L6QmHoB5ntutdiButfQ6XdtYZ1d
	 gYPoS2hBUFyoQ==
Date: Wed, 23 Oct 2024 19:53:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2044 uarts
Message-ID: <20241023-backroom-pending-279f9d12e9d8@spud>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
 <20241021-rosy-drove-1ae3c8985405@spud>
 <2zawe64brm3sfuslh443352wfupgnhb4xw7jragkzxu6kgg6t7@b4qiya3jdij4>
 <20241022-washday-glass-3db9f6a2cd27@spud>
 <e32xi34m4lubrquluk7uu6nvqgarnxtmj57ricxg2gv45xpgcs@x6t7itvwng4h>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Tk608JwS4IXNVJ/"
Content-Disposition: inline
In-Reply-To: <e32xi34m4lubrquluk7uu6nvqgarnxtmj57ricxg2gv45xpgcs@x6t7itvwng4h>


--+Tk608JwS4IXNVJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 08:32:42AM +0800, Inochi Amaoto wrote:
> On Tue, Oct 22, 2024 at 06:25:00PM +0100, Conor Dooley wrote:
> > On Mon, Oct 21, 2024 at 08:23:30PM +0800, Inochi Amaoto wrote:
> > > On Mon, Oct 21, 2024 at 01:21:58PM +0100, Conor Dooley wrote:
> > > > On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> > > > > On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > > > > > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > > > > > The UART of SG2044 is modified version of the standard Synops=
ys
> > > > > > > DesignWare UART. The UART on SG2044 relys on the internal div=
isor
> > > > > > > and can not set right clock rate for the common bitrates.
> > > > > > >=20
> > > > > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > > > > >=20
> > > > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml        =
  | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw=
-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.=
yaml
> > > > > > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > > > > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-ua=
rt.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-ua=
rt.yaml
> > > > > > > @@ -58,6 +58,10 @@ properties:
> > > > > > >                - brcm,bcm11351-dw-apb-uart
> > > > > > >                - brcm,bcm21664-dw-apb-uart
> > > > > > >            - const: snps,dw-apb-uart
> > > > > > > +      - items:
> > > > > > > +          - enum:
> > > > > > > +              - sophgo,sg2044-uart
> > > > > > > +          - const: snps,dw-apb-uart
> > > > > >=20
> > > > > > Why does each vendor have an items entry of its own? Seems like=
 needless
> > > > > > clutter of the file IMO, except for the renesas bit.
> > > > >=20
> > > > > I just follow others when writing this binding. I think it may ne=
ed
> > > > > another patch to fix this problem, right?
> > > >=20
> > > > Yeah. But I'd hold off to see if someone gives a rationale for it b=
eing
> > > > done this way before sending that. I've not deleted this thread, and
> > > > will send an ack if someone justifies why the binding is written li=
ke
> > > > this.
> >=20
> > Well, Rob doesn't think they should be separate so please add that
> > additional patch in your next version.
> >=20
> > Thanks,
> > Conor.
>=20
> It is OK for me. I will add a fix patch in the next version. Can
> I add you with suggested-by tag in this fix patch?

If you want, but I don't really care for one.

--+Tk608JwS4IXNVJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxlGQQAKCRB4tDGHoIJi
0lWCAQDLqp4C3pRf90+AdSgA9vyQTtFUkYtMqLHF8L01+nyJ2QD/cvLql7LjVd04
9Mv7I4joqV3H0Gvfo2rKjnJsSHJcfQw=
=SV4x
-----END PGP SIGNATURE-----

--+Tk608JwS4IXNVJ/--
