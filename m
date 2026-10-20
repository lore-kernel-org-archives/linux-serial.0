Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459324;
	b=hS2nGNmqm2bwwUwfuwqvjVeKsxlW0e7Nm0cytpHNb0+la1eugEQ9oRwNZXhJhghfqB7G
	 NvGfoR/DVNr68jSTdRBZipzQF0jkSiIqaBCR/xd91aoh6EHxiJzWJy+JGFH57W20SoU4w
	 8WOroa1Tf7gfgmeXFGllYBAk29WquHcIBtnmQwS50uWO/6h06YolG8707lOWNLQbAolF9
	 svB7w3tHQcrMlITiUDhP+qXzqyjV+MknQAYeC1koS7w3yu5yHaLp2GovXMdBn/RAcKxGc
	 d9VPZWtksAC7Lmlin/ilc/X3D2j1pBhDKIJo8bmIii6k7Xu4rDCG7pwf1wVeG75dfoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459324;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y5PuInUz/jG/sVc55vzwpQmtUc4DneWfMKEBS2B1HkA=;
	b=h6Y+7FKdNjawAO5qvyB2A3c7KgTThQ8g3xx0t1rip0eiluFKzdf9mQ2/lh/SwP4vkHiw
	 e7JWDmZbEUGJ/mKeFKtMg9pgHjLrqfHIN2I+feKE/ZLvtCWByqzo4OJC2coejqLG2uM7B
	 XLRBA2jlOutMRi16yMo9OK916nL7zLZTnz1JaOjdZP8zO80ZaaYapysa4xDnzWujh+bFB
	 0xtk852+JG3U2dlck5uOy3LAuyDdL0KsOnAdmRFp1BXwsXPTTq3Kkb969Q61TlKb3qVvp
	 vxp6onemapaoG2ZNn50mW0gPLRd50+jH6I8zZ8jm4v6Ss6S0pLRMQsP/ktBUPvJXaQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ij/ZTfSV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BA606A319;
	Tue, 20 Oct 2026 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij/ZTfSV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE11F000C4;
	Tue, 20 Oct 2026 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459323;
	bh=Y5PuInUz/jG/sVc55vzwpQmtUc4DneWfMKEBS2B1HkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ij/ZTfSVf2swDQKjpQY+M1H2I5MkLeX5CF4dH4/9XKE165jBsDdvEwhW81eUmMMjb
	 Qa7Npvl6yBb17a13UvFrx+F558g8qtjW3Jx8HQ2wmPfgDecd4FVrr176Pvye0m7huB
	 b8gB3PVWN+ieA2OWvMaqKqc1pFccggf6hGdppcfcNIIzPb4SLFLMiOICvTaBe8MAMo
	 ccYqYzmJWOF0vh9T+5mTGwhv1K8ArNjqo22DC2bm6gpAiLDfN6Zb7V8wILCD7w7hbg
	 OGRinhBbeU5+ZdzL+gEGhTHiNXTwxiIjthvTzVDhkDx0SgvL4YvUPNJZZ9WRLDx3D2
	 G3K1Ev46o1B/g==
Date: Tue, 20 Oct 2026 09:01:50 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/20] i3c: dw: switch to array-based exclusive reset
 control
Message-ID: <ata9fqjAm09xnBQM@xhacker>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-6-jszhang@kernel.org>
 <62860351b9ae360c174d36dd54d4110417f395ad.camel@pengutronix.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62860351b9ae360c174d36dd54d4110417f395ad.camel@pengutronix.de>

On Mon, Oct 19, 2026 at 02:55:21PM +0200, Philipp Zabel wrote:
> On Di, 2026-09-29 at 14:14 +0800, Jisheng Zhang wrote:
> > The Synopsys DesignWare I3C master controller can have multiple reset
> > lines, such as a core reset and APB reset.
> > 
> > Refactor the driver to use devm_reset_control_array_get_exclusive()
> > instead of a single named reset handle. This automatically manages all
> > resets allocated to the device node sequentially.
> 
> Note that this does not guarantee any particular order. Are you sure
> that this is good enough for all implementations of the DW I3C core?

Per my understanding of the doc, it only requires the resets are
asserted and de-asserted, didn't mention the order. And per my tests
on syna SL2610 platforms, the DW I3C works perfectly no matter I
reset apb reset or core reset firstly.
> 
> Otherwise it may be wise to at least specify the names in binding, to
> be able to switch to the bulk API or individual control later, if
> needed.
> 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/i3c/master/dw-i3c-master.c | 24 ++++++++++++++++++------
> >  drivers/i3c/master/dw-i3c-master.h |  2 +-
> >  2 files changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> > index 4563d8761ba0..1c6c870f5bb3 100644
> > --- a/drivers/i3c/master/dw-i3c-master.c
> > +++ b/drivers/i3c/master/dw-i3c-master.c
> > @@ -1657,6 +1657,11 @@ static const struct dw_i3c_platform_ops dw_i3c_platform_ops_default = {
> >  	.set_dat_ibi = dw_i3c_platform_set_dat_ibi_nop,
> >  };
> >  
> > +static void dw_i3c_resets_assert(void *data)
> > +{
> > +	reset_control_assert(data);
> > +}
> > +
> >  int dw_i3c_common_probe(struct dw_i3c_master *master,
> >  			struct platform_device *pdev)
> >  {
> > @@ -1696,10 +1701,17 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
> >  	if (IS_ERR(master->pclk))
> >  		return PTR_ERR(master->pclk);
> >  
> > -	master->core_rst = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev,
> > -										NULL);
> > -	if (IS_ERR(master->core_rst))
> > -		return PTR_ERR(master->core_rst);
> > +	master->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
> > +	if (IS_ERR(master->resets))
> > +		return PTR_ERR(master->resets);
> > +
> > +	ret = reset_control_deassert(master->resets);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(&pdev->dev, dw_i3c_resets_assert, master->resets);
> > +	if (ret)
> > +		return ret;
> 
> This looks like we are missing
> devm_reset_control_array_get_optional_exclusive_deasserted().
> 
> regards
> Philipp
