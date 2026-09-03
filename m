Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AA4E2367;
	Thu,  3 Sep 2026 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450172; cv=none; b=LEiG/L8Un5/uMck8CIl7czRkRq1DunkP6AeU9ErMAilzQC3i1CwS661oVPzoCx0I6TN1n+BI1+CKeK9F7ENGdrB/uRCzunNJa3a8Q/3rVU2FMaX3eNm+Tj79BxAFRHrPYTY6vsViTx+rgbmla+8AnfWirsF1YfrYTybMru3wodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450172; c=relaxed/simple;
	bh=Yv8wTaciYZggWvkNJvSINmPoeNVSpvwetbo8Fkv1eJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpbDsJLBT3+oop0svw/JyTyGgEtpOsFy+lfYkSoMOnDfdfzjVOHUlpGWPdFFa12kvkK+CWpS0ucVzBAHg3sYl3ljIqUjEnJ0efZMaULh9iBozSOqQFt0nMbsqQ3iFcBuHvV9Mol+EZKliNIM4Xp2H1eUjrOKSdq6enQ9KJYAcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYt594fQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYt594fQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311091F00A3A;
	Thu,  3 Sep 2026 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450171;
	bh=sivXHIUBZ7Xa/Z4kbeOOp8A8aDPzeMdDcwJpqwfu5YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mYt594fQ3I7OFZbj4jVEcTMPYsuQTGqVfELe/FWDz0RSqWceyMPl7xIAlO9cYA5bk
	 2K/aNTouAxXAAWpW3yu9/vqiOmYoNPuS3pdNvd6m5D0pvUj+INrAZ+DaTQInMGvmZg
	 CTR4ARbB8yiuwWVm59U5hIboW7m9ecXyGhTPAe2lKWNwMAdtYCRFt1PDWpnRp2ps7b
	 9SfCtBrm6gQdGklOGb+klrfeUslkZ8tneMN6D3FNCiCnPx2F7kUO3eSD4Ro3nv7N8Q
	 K8Mvs2iAiKoEqY80Z9aDxC2ue6lkbkgpNElZi6tiW6D2bB1VztHTFp2MCyolRteie3
	 1XULqWGXPbqpQ==
Date: Thu, 3 Sep 2026 16:42:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	in file <devicetree@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: 8250: add marvell,armada-38x-uart
 compatible
Message-ID: <20260903-pettiness-crested-c4fb1b3ac05a@spud>
References: <20260901004203.49686-1-rosenp@gmail.com>
 <20260901-corrode-unvented-4cf271941722@spud>
 <CAKxU2N9X=fvr-a5h5o5XaRLuRuSUq7wR85xmSduK9vff4z4CQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DBKWE0sUUYkaBDGj"
Content-Disposition: inline
In-Reply-To: <CAKxU2N9X=fvr-a5h5o5XaRLuRuSUq7wR85xmSduK9vff4z4CQA@mail.gmail.com>

--DBKWE0sUUYkaBDGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 02:34:55PM -0700, Rosen Penev wrote:
> On Tue, Sep 1, 2026 at 10:51=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Aug 31, 2026 at 05:42:03PM -0700, Rosen Penev wrote:
> > > The Armada 38x and 98DX3236 SoCs use this compatible, either paired
> > > with "ns16550a" (armada-38x.dtsi) or on its own
> > > (armada-xp-98dx3236.dtsi). Neither form is covered by the 8250
> > > binding, so dtbs_check reports:
> > >
> > >   serial@12000: failed to match any schema with compatible:
> > >   ['marvell,armada-38x-uart', 'ns16550a']
> > >
> > > Add a standalone const entry and a two-string variant paired with
> > > "ns16550a".
> >
> > Only one of these is correct, add one and fix the users.
> > Given there's match data, it's probably the standalone one.

> Commit 62480772263a adds the second one to support earlycon.

So the one with the ns16550a fallback is the correct one?

> >
> > pw-bot: changes-requested
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Validated with make dt_binding_check (8250.yaml) and dt-validate on
> > > armada-38x and armada-xp 98DX3236 boards: the UART schema errors are
> > > gone.
> > >
> > > Assisted-by: opencode:big-pickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Doc=
umentation/devicetree/bindings/serial/8250.yaml
> > > index 8c2c177faf89..f71c6afe02f2 100644
> > > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > > @@ -109,6 +109,7 @@ properties:
> > >        - const: aspeed,ast2500-vuart
> > >        - const: intel,xscale-uart
> > >        - const: mrvl,pxa-uart
> > > +      - const: marvell,armada-38x-uart
> > >        - const: nuvoton,wpcm450-uart
> > >        - const: nuvoton,npcm750-uart
> > >        - const: nvidia,tegra20-uart
> > > @@ -119,6 +120,9 @@ properties:
> > >                - exar,xr16l2551
> > >                - exar,xr16l2550
> > >            - const: ns8250
> > > +      - items:
> > > +          - const: marvell,armada-38x-uart
> > > +          - const: ns16550a
> > >        - items:
> > >            - enum:
> > >                - altr,16550-FIFO32
> > > --
> > > 2.55.0
> > >

--DBKWE0sUUYkaBDGj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapmVdgAKCRB4tDGHoIJi
0ugJAP9CEpTAZrQshKhMIrGfdM5G0f/W63NRRd77zD72kYTIHwD8DPOP30z0tHZd
IHsRfMHHMumLIQqpnD3I+fYWgtvdQgk=
=XWeC
-----END PGP SIGNATURE-----

--DBKWE0sUUYkaBDGj--
