Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B71AA7A5;
	Thu, 14 Nov 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615129; cv=none; b=kDX12Y1SIb5Wa64NXwQ1ppkhObATjyM3NmpcLD2pQDOV1xkDn0pRUL13iBQgIuQi9ecSdzHyYegcwLHRc8QA8ccbrQJlwh1itpToO6gGs72Qv1qN3yBaUl5toBIR5hLj4JpJUb+tp5aN6VOvaqw785z4CWA21nYjbz0efXsDleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615129; c=relaxed/simple;
	bh=H7uW/0TAcgDzBQEFWvgxrMAxLVeZi9+y4ArBI5hHAew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy+sFLFy9H1YTw69cr4VS9hD4fK1bFCDJynfABTS1Swfp7n+gqgp2sxsYdr3luyTRsUjHJoBy40RDDQNDwvnaopC8Xtt/qGjDoURHIAlr3Y2G4KCVpxbEoDb6ewTpWFVexnpGGUmM2xEnDGs8JEs4WD+3V69IFh3g0A/MaQiKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAYnHdS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAYnHdS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E357C4CECD;
	Thu, 14 Nov 2024 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731615128;
	bh=H7uW/0TAcgDzBQEFWvgxrMAxLVeZi9+y4ArBI5hHAew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nAYnHdS9rYqtw0awHr+P8jMRURaVEW094WZ08UVpANHlc7ZKch0ul3YbktacCAqzB
	 Wot80Iyic2BTa4h39EX0kqgwoQN349jvraHME40U4kWfQuQcUuwb8MvojM6oTqeIcD
	 L2qqH6FzfDC5hxzAkVkyELsdcV3Sd9Ee4HRHt5jogDxgWLv/nEg4c4qrZZgEkDMpPA
	 whDG5JHwD//Oz4iNMP3rvqFubRVazW+XtUbxlKYMXLsbpe1ciYjqoSv06JKVacGvwY
	 IhvWz5e8d6ioKjOLMdQV1TNvpYHXPZvEokRdW8PtdjoSWBGdrTvLDTQyGXtJQ0ohvk
	 s5e2xKiSgko6w==
Date: Thu, 14 Nov 2024 20:12:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	wenhua lin <wenhua.lin1994@gmail.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: Re: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for
 ums9632
Message-ID: <20241114-elude-apache-770a335fad1a@spud>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z7LI916VMgKQTvjY"
Content-Disposition: inline
In-Reply-To: <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>


--Z7LI916VMgKQTvjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 07:05:16PM +0800, Wenhua Lin wrote:
> The UMS9632 uses the SC9632 serial device.
>=20
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Z7LI916VMgKQTvjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZZkwAKCRB4tDGHoIJi
0ka8AQDKLDahMB2xlr+o8OldBHxl/bNAxIwALvNRV87kPSh+1wEA4s/fvR+87JkY
12FgdA7/wcmyhX4bIWkWHtnv35OV9gc=
=gyfr
-----END PGP SIGNATURE-----

--Z7LI916VMgKQTvjY--
