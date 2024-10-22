Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27EA1BDAA9;
	Tue, 22 Oct 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617906; cv=none; b=feRkxZOZlZhJhcXe4rgUxaSxXpD5Kr5aU5QhwMBXdNy1vWF5z7HpzoqIRWh3SyCRhAbSos8oP+qYDcWlZ/BMdJdvxRpB1nmRkV8mN9C4PQhmemqhSZmlYLRpm5eJLT94Mipof4m8vrN/im0CBSNJAyAu9NS8MPy8k3rymHLQd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617906; c=relaxed/simple;
	bh=J2g2Yu6XyCY4XxVZm/Amweebvid8FNKBJjTzHEntF58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcJRTUPP8lWLdL52xpwOaLhk9xtfU85TRguDxOdwQaZVSGZ7o4HYj4FtegMxUASgTZcA7PMswKki6VulX3nHSh3gjQgFX1HpaRwWqCHgCdDfza/XqWZ2fW93yifa5H9bxyt+CMF9+TYyuHh8MFFLYAPDFlXBuKUXC/TgsV7IeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeQzAJXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeQzAJXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE3DC4CEC7;
	Tue, 22 Oct 2024 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729617906;
	bh=J2g2Yu6XyCY4XxVZm/Amweebvid8FNKBJjTzHEntF58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeQzAJXGWXioB0cHPEFbrENDMSeYJUT03aeULihkKQElFB6xnYz1EOYWyKa6WrQpk
	 WNcCZKfWABw93ZSg7IRsJpU/cxYxfyA+Am4Lt+EDh7vTPeW9TQa7uMiLYwJg9uVP3A
	 2D2RsgFnaxZYsmTRxWgxNtJrltZx+CcTzkqtw+pt+oWPKdeFCrSQ7jrZmT4BkSupLw
	 zgZ3pXZ2yoth+v6ThAGGnx8SSKEXF1ml2kgN7enbFdh/hEt1nTQzT80Db9/xa60aOR
	 PAasYmEBq13zODGSBBg3njNkaCJt1uECwCLgzCl7ulobqiqR/jLlMP3ZNkwHSyVO9Q
	 NZ3EDGtCdhAqA==
Date: Tue, 22 Oct 2024 18:25:00 +0100
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
Message-ID: <20241022-washday-glass-3db9f6a2cd27@spud>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
 <20241021-rosy-drove-1ae3c8985405@spud>
 <2zawe64brm3sfuslh443352wfupgnhb4xw7jragkzxu6kgg6t7@b4qiya3jdij4>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IG32fQA576T6oNHT"
Content-Disposition: inline
In-Reply-To: <2zawe64brm3sfuslh443352wfupgnhb4xw7jragkzxu6kgg6t7@b4qiya3jdij4>


--IG32fQA576T6oNHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 08:23:30PM +0800, Inochi Amaoto wrote:
> On Mon, Oct 21, 2024 at 01:21:58PM +0100, Conor Dooley wrote:
> > On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> > > On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > > > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > > > The UART of SG2044 is modified version of the standard Synopsys
> > > > > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > > > > and can not set right clock rate for the common bitrates.
> > > > >=20
> > > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > > >=20
> > > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | =
4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb=
-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.y=
aml
> > > > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.y=
aml
> > > > > @@ -58,6 +58,10 @@ properties:
> > > > >                - brcm,bcm11351-dw-apb-uart
> > > > >                - brcm,bcm21664-dw-apb-uart
> > > > >            - const: snps,dw-apb-uart
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - sophgo,sg2044-uart
> > > > > +          - const: snps,dw-apb-uart
> > > >=20
> > > > Why does each vendor have an items entry of its own? Seems like nee=
dless
> > > > clutter of the file IMO, except for the renesas bit.
> > >=20
> > > I just follow others when writing this binding. I think it may need
> > > another patch to fix this problem, right?
> >=20
> > Yeah. But I'd hold off to see if someone gives a rationale for it being
> > done this way before sending that. I've not deleted this thread, and
> > will send an ack if someone justifies why the binding is written like
> > this.

Well, Rob doesn't think they should be separate so please add that
additional patch in your next version.

Thanks,
Conor.

--IG32fQA576T6oNHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxff7AAKCRB4tDGHoIJi
0tUyAP4uTBvEkU56jMMlkmGFlti+ugxYK6+lqTVuXMm0srEjLwEA20y1lnrqE8Vh
eeC6n/MJPkUuZNkNk3KAqX3EZkGfQQg=
=blFm
-----END PGP SIGNATURE-----

--IG32fQA576T6oNHT--
