Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248454E36EF;
	Mon, 19 Oct 2026 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414525; cv=pass; b=Sv/kOwQXRSbJlUYY6yxXKSgA5vUTBFJnZHBVmPX6Z1qeQ2cczfn4rQ/7QZ4o4DQHb4UhU3koAfWjOX46aT25jwc0p/qzf4TCdznFmfyzU/mEj4SUiRbNkA1Adyq9JkCxIjtS9Ge5H7BPOFV6hhwUe6vSZ1TpKflhU/4NYQb/qZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414525; c=relaxed/simple;
	bh=UE3KjtawDtoJMnO40sfSb4jeUTfZW5R6uwnCYBQkZPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isF72o+LATcEvbOLewnsgN9iEBKjuWynZcHQtOpfMvCGYN+297VneyWF8m86z66egvvPK0ZS5B9ewxsTKiBTW1xF9zYKLTzh+UPd3XO6zj6X/jQFZVnfAYwiDVENEjrrS0uUtrp09FgIDrsazmvtznZVAo+CJ1ixlkncADVUxWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gepNrz1U; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gepNrz1U"
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 631DE201B55;
	Mon, 19 Oct 2026 14:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792414521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDFACtr3joZkKek48vhVDUWWppSHXimH9DiDBJeDnxE=;
	b=gepNrz1U6+E8DSXqJNpla4aXDaQwIAZnouL+bQeaRSWSAnv2PkKkBDIfOu+/sUKzcSIb69
	Vb3gNn7tFjTsoSAdFA9FAC1jK5tMR/cYy8zNGtOj9R0kLVV9AEV0atx2vQR0hkuIRecLCo
	GGZg/l/BkkQXqi2qah6aklRy1TpfVXdcwjb3RnHha1JokSF6VVy29R9/r1XK7QDjXBlpfy
	ud42s54DCGMykv2BFWruIe/Oa3Kp5kB5gJplt96g1mFC1Ka6F9cijJo8605D3aJ0AD6T7w
	URe84NPQPBiddAqyK5z3YB3p1mnPJgINxVlBVF0vS0JPFRssVrf6vtTvEjrolQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792414521; a=rsa-sha256;
	cv=none;
	b=M+hY0bCqbBjAqkJiO2Dr0W85cayLgKDgnezkb8w7P8Kbnfem5o4rkdVs+OO5MYoRU1GhyY
	1emQfM7kAJ7J/0Du2oa+qljCtBrlE+muxwidb+1I0Rzp9det36UkWsn9F72JYTjMFicR5r
	3BDmGClKSVFcl4ZxDKWlQVNT8oPYgu0pvsvb9oPfch6QM97vUbkokmNUl2y8ZccmpwJw52
	T4X/FIfYiE4E11R0m9JaQXOccNBdLul94VMjlfthBlzujHddG61+0ArW8R8qbgYuawyALt
	ZIB+uJ68KX3UzMV7mb0bw/h/aEZJsNH/xmJBJljzNxVETGf7yhI+THk8vvkiMQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792414521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDFACtr3joZkKek48vhVDUWWppSHXimH9DiDBJeDnxE=;
	b=SUHVSVb/QsnfjboxpMPWcd1QAf94pumlmEDKgHK+WWDxGpOuKE7pQW7TXFJWTXqcf/dmQH
	YG7xgdA+2RnWlMj8FDVd6/IZ93shS0Si6MPewJztTSRrEq+tSGSKpM0JdzGNpYn+Y0Ejhc
	osYs7kdzZXtj9PuQBcmmrSr7QJd8q0Ol9Pij963siJ6W3WM+bT2Wwhb0dncClsMgGvTRwo
	kI3VVPwSQ+xfY5gum4LASWgNwQxbe7edm/DEItkd1W0C7MIx5tjqhrvTuLsqYM8t5jya54
	8aomFz9pg01MLE9NmR6a0PX/m0w0TVzYWCIC+RWrNEhYzyU1v+04FQiPExG6Zw==
Message-ID: <62860351b9ae360c174d36dd54d4110417f395ad.camel@pengutronix.de>
Subject: Re: [PATCH 05/20] i3c: dw: switch to array-based exclusive reset
 control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd	 <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet	 <jbrunet+clk@baylibre.com>, Andi
 Shyti <andi.shyti@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Lee Jones
 <lee@kernel.org>,  Linus Walleij <linusw@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Sebastian
 Hesselbarth	 <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
 linux-gpio@vger.kernel.org, 	linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org
Date: Mon, 19 Oct 2026 14:55:21 +0200
In-Reply-To: <20260929061417.20733-6-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
	 <20260929061417.20733-6-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Di, 2026-09-29 at 14:14 +0800, Jisheng Zhang wrote:
> The Synopsys DesignWare I3C master controller can have multiple reset
> lines, such as a core reset and APB reset.
>=20
> Refactor the driver to use devm_reset_control_array_get_exclusive()
> instead of a single named reset handle. This automatically manages all
> resets allocated to the device node sequentially.

Note that this does not guarantee any particular order. Are you sure
that this is good enough for all implementations of the DW I3C core?

Otherwise it may be wise to at least specify the names in binding, to
be able to switch to the bulk API or individual control later, if
needed.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 24 ++++++++++++++++++------
>  drivers/i3c/master/dw-i3c-master.h |  2 +-
>  2 files changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i=
3c-master.c
> index 4563d8761ba0..1c6c870f5bb3 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1657,6 +1657,11 @@ static const struct dw_i3c_platform_ops dw_i3c_pla=
tform_ops_default =3D {
>  	.set_dat_ibi =3D dw_i3c_platform_set_dat_ibi_nop,
>  };
> =20
> +static void dw_i3c_resets_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
>  int dw_i3c_common_probe(struct dw_i3c_master *master,
>  			struct platform_device *pdev)
>  {
> @@ -1696,10 +1701,17 @@ int dw_i3c_common_probe(struct dw_i3c_master *mas=
ter,
>  	if (IS_ERR(master->pclk))
>  		return PTR_ERR(master->pclk);
> =20
> -	master->core_rst =3D devm_reset_control_get_optional_exclusive_deassert=
ed(&pdev->dev,
> -										NULL);
> -	if (IS_ERR(master->core_rst))
> -		return PTR_ERR(master->core_rst);
> +	master->resets =3D devm_reset_control_array_get_optional_exclusive(&pde=
v->dev);
> +	if (IS_ERR(master->resets))
> +		return PTR_ERR(master->resets);
> +
> +	ret =3D reset_control_deassert(master->resets);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, dw_i3c_resets_assert, mast=
er->resets);
> +	if (ret)
> +		return ret;

This looks like we are missing
devm_reset_control_array_get_optional_exclusive_deasserted().

regards
Philipp
