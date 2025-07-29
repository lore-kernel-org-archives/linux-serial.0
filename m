Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A619F13F;
	Tue, 29 Jul 2025 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823344; cv=none; b=e07L5/VLxU5sprIxaDKF2kAK0Zi4pygDtUHEtr1XU+Q0HgZSh9qwmUmBhymx/GoqjSYA6dfY8p49puH82x4q6/XV9NOwWe46MwIpFT0ifceOk+tmoSOYY3ai+dQ97Hqw8+JDNxPG/d8Jn8RsA4YUk60MGvIPauf7z89nAGvz2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823344; c=relaxed/simple;
	bh=orYWl9MQUpVxay6NtZUdcW+T0sGohbXTaAXtvvGeIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGnTffeqbdNM6GnypkEP17cO9Ju5yvYvdSfo9B6bg778hyeB0JflfUk5Xfh/jS0hxtKkmgpPtSkvqLAvxIHG5XUhmdoWZkjDjjMqIoKQN75Lo9+N3d8gudgmnGNIyz8+KQlf8s1NpyrVBu26Uj60JVRrLC394C/9u+IxYwRRVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqaeYKW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqaeYKW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C368AC4CEEF;
	Tue, 29 Jul 2025 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753823344;
	bh=orYWl9MQUpVxay6NtZUdcW+T0sGohbXTaAXtvvGeIdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqaeYKW0XiEBKkLho2RnLPPQedoC4HZMJ+G4Bs9nKlF0UWqyv5Q51Azaft8DyRGwa
	 3rZEazkImxSdJYrD9x2XWg54krstNUEwRZ2l/EFWsIawSNWQTNP4o+Ck5BVk29VgGT
	 M6xi2s6HDWNOz0zjKM63ZcNcYMdxVGKTawrhc8kI5W35UyGjonlg2rUN0LvJxOJcO8
	 PBaxIOkzXfyK7Nyf/RoefUGpud3rTbeez+ntTejiLu0tpycC+ycMHAGqLOijApv9M/
	 Nx0a9sHyVKcJfEh84h2BLTjRmlEwCtS991nHgABVko223JOfRA2pUFGM1tlEYofAZB
	 ICH29JngSC+tA==
Date: Tue, 29 Jul 2025 22:08:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lkundrak@v3.sk,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as
 clock names
Message-ID: <20250729-clench-hastily-b80f11f73336@spud>
References: <20250728220002.599554-1-elder@riscstar.com>
 <20250728225319-GYA900803@gentoo>
 <20250729-reshuffle-contented-e6def76b540b@spud>
 <5c3f9f10-6a9d-45b4-80c0-09402b35bf47@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YgXRia/6I6USAE26"
Content-Disposition: inline
In-Reply-To: <5c3f9f10-6a9d-45b4-80c0-09402b35bf47@riscstar.com>


--YgXRia/6I6USAE26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 04:04:05PM -0500, Alex Elder wrote:
> On 7/29/25 12:54 PM, Conor Dooley wrote:
> > On Tue, Jul 29, 2025 at 06:53:19AM +0800, Yixun Lan wrote:
> > > Hi Alex,
> > >=20
> > > On 17:00 Mon 28 Jul     , Alex Elder wrote:
> > > > There are two compatible strings defined in "8250.yaml" that require
> > > > two clocks to be specified, along with their names:
> > > >    - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
> > > >    - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
> > > >=20
> > > > When only one clock is used, the name is not required.  However the=
re
> > > > are two places that do specify a name:
> > > >    - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-bti=
f"
> > > >      compatible serial device is named "main"
> > > >    - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
> > > >      serial device is named "uart"
> > > >=20
> > > > In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'u=
artclk'
> > > > and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction th=
at two
> > > > named clocks be used for the NXP platform mentioned above.  Extend =
that
> > > > so that the two named clocks used by the SpacemiT platform are simi=
larly
> > > > restricted.
> > > >=20
> > > > Add "main" and "uart" as allowed names when a single clock is speci=
fied.
> > > >=20
> > > > Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an option=
al second clock")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX=
-lkp@intel.com/
> > > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > > ---
> > > >   .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++=
-----
> > > >   1 file changed, 14 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/D=
ocumentation/devicetree/bindings/serial/8250.yaml
> > > > index e46bee8d25bf0..cef52ebd8f7da 100644
> > > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > > @@ -61,11 +61,17 @@ allOf:
> > > >               - const: uartclk
> > > >               - const: reg
> > > ..
> > > >       else:
> > > would it be better to drop this 'else', and moving following 'if' blo=
ck
> > > to the same level with "nxp,lpc1850-uart"?
> > >=20
> > > the reason here would avoid too many indentions if add more constrain=
t in
> > > the future if other SoC uart need different clock-names..
> >=20
> > I agree, it's more typical to do it that way I think to boot.
> >=20
> > Also, why is there a k1/lpc conditional bit that is not part of the
> > allOf in addition to the bits in the allOf? Can that get merged with the
> > allOf please?
>=20
> Are you talking about the blank line here?

No, I'm talking about what's down around line 270 in the binding.

>=20
>     then:
>       oneOf:
>         - required: [ clock-frequency ]
>         - required: [ clocks ]
>                            <------ this blank line
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: nxp,lpc1850-uart
>     then:
>=20
> I didn't notice that before.  It got inserted with commit
> d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
> 'uartclk' and 'reg' for nxp,lpc1850-uart").
>=20
> If so, yes I'll remove that as well when I update the patch to
> get rid of the else as Yixun suggests.
>=20
> Greg won't take this for a couple weeks so I'll hold off sending
> v2 for a while.
>=20
> 					-Alex
>=20

--YgXRia/6I6USAE26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIk4agAKCRB4tDGHoIJi
0hvVAP9MSkxYQRJq/F3dGiBfEa+qwUVo72j7vgmJz6GNMK6sdAEAknenMTzEStrr
jYZgvaIkj25ecXLymMe9NgG6iitGUwY=
=SqMb
-----END PGP SIGNATURE-----

--YgXRia/6I6USAE26--
