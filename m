Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865037649B;
	Tue, 21 Apr 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791201; cv=none; b=qcpZbO73rrju7sys5Nr22b8RgkGp1aL4i2oYMhUfXN4jvl6W9AwJ9h1qK8eK8mRUyPc/oPz+mrY6EekASgDZRA7PPwAAW9dtNEKk01l4mN6AX60dNZ9YcXm3yXz6pKlmBrj+Nc8gk596++VOd31VlM+eeYwNHtCst6dja/Lao0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791201; c=relaxed/simple;
	bh=n9q2YS34fFqkMay4N+lrMQ6uuGLsXgDbtgaWIG/8SM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPWDjXgxd88RuoE9pR8MuIPZqSZcK3mlZD6zfdSe+j9bUgdbwDzDGqYDhq06K/tAURhHnspoy3AOhfxWMRf1DfWW/7lq2YFEEYiimGkAkk66czfVXyS93RstmwbNuwZGlMzSMklNZMgXD2iDpZlVMeVp6OlbC7BMe4tWwnrNhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO4OxqpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO4OxqpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8CAC2BCB0;
	Tue, 21 Apr 2026 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776791201;
	bh=n9q2YS34fFqkMay4N+lrMQ6uuGLsXgDbtgaWIG/8SM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bO4OxqpEB8Ksu5d8yRsywLSimntqw4XXcKF3CTq9kev447dZxtsLNhObrlrPi5rLx
	 iJ2JP2yzyGPcBcVMQrxRu5DpsbY8wiFWP2ACE9RRpjCNwfZeYzYhcVbyH8FqX6GK4U
	 tYKJRq5oqK4hH0nfZoFXSl8JxHh6AK5V+s6lX4b2cnnEV/JHZc4aZcuOe8t+Yib7tv
	 kPtFhsexarv+ygf60/1hgQKduc6SJ8PDddEAKbw5Ka+6Mq1TfUkEzSxL/xCtsvKjoC
	 OmWwJHj2TCvbVEfY1a9A9DESsOvFz3xUI9HWQO5xKn6VearSXDypD9EYlRL9IktN02
	 oEE0Wsj05B0Hw==
Date: Tue, 21 Apr 2026 18:06:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: snps-dw-apb-uart: Add
 UltraRISC DP1000 UART
Message-ID: <20260421-appraisal-tainted-b7a645d2225c@spud>
References: <20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com>
 <20260421-ultrarisc-serial-v3-1-3d7f09c2420e@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zHuIrEG4DhXTeSjJ"
Content-Disposition: inline
In-Reply-To: <20260421-ultrarisc-serial-v3-1-3d7f09c2420e@ultrarisc.com>


--zHuIrEG4DhXTeSjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 01:58:51PM +0800, Jia Wang wrote:
> UltraRISC DP1000 integrates a Synopsys DesignWare APB UART, but it does
> not provide the standard CPR and UCV registers.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zHuIrEG4DhXTeSjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeeunAAKCRB4tDGHoIJi
0nzSAQDvCtu1nSoeOKO9tXUdFuzztRfU72U5K8KI6YemMiMozAD9Gigo3rI7k19t
W1NBojmzXptO+2Q9T9Ko2ihw3/6yFwM=
=Kb8+
-----END PGP SIGNATURE-----

--zHuIrEG4DhXTeSjJ--
