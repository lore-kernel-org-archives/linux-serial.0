Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689623ED60;
	Tue, 29 Sep 2026 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715456; cv=none; b=RmXNCfB8rPQIlh7MOP6f2YnZ2oEVAf0ymiRk57wYw5kRKwwyWzrDgOtMe105CHMfeOdGSWTh5VU55rb+KkGp1NZe7vcNbVP/nI12awPa/ANQtVqKB3ESDtdQYN6pzaXzTZ9wMAsS1Sk3U3mUNUhDkbM4W3kp7vd4Bqpvmf4Yj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715456; c=relaxed/simple;
	bh=XR9On9yvlHrImub+7YcvPid98eHqiR9sjTTAKIJVVHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQByTUo0hLwVNfYzDdjs+IJKFOK2xQppMqermn7Pbq7jRAlmpmQ82gY2rWSb4RMOAAW6U5eoAHwPhjM9IciOnGsfRcD1+WxF0Hh/ovF+61y5D6PSkKsLarXKIu0pcphEx0+SA0R0TDsVea7FVO5irmEfU4ZxQPZRbiSeT4t2SHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eteCmMnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eteCmMnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C8F1F000FF;
	Tue, 29 Sep 2026 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715455;
	bh=RdMYl/+FBs8+3dkIXmXG7fNOAukH2HxnfzLbOI0h0VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eteCmMnlmav3BV9VmIipEBehbu9MTFpWU7S6rlw/JRia+9yinMtesCNa1FJszhQBo
	 9pIx9UwUPunvTDbQ3BMZ5HNOAm+FM8LDRAbDFUr3kZGlCt4stWQ92tAHor65iXCROs
	 qF0XX+QQeO+JiSI7RDe4AKaTwyYk2c5YHhPMrqfL92pGtmZdeaUgG/1+R1Rr4+WB04
	 zWr8ude4al162lAbvao9A9DnQeghEK66UGovrYWmDYyFFmx4iSiD0rYb+3R455grRn
	 2VQ6ETuT9fth/ejrYazTM1W+EG44QopZ0ZzqJVBbDgkYSGICfwT0ULnyqDIT5Wqmjn
	 5zFG7HfbqSx5g==
Date: Tue, 29 Sep 2026 22:57:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, mfd@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/20] dt-bindings: i2c: dw: Add Synaptics sl261x i2c
Message-ID: <arwmKWR0GD3RVr75@zenone.zhora.eu>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-3-jszhang@kernel.org>

Hi Jisheng,

On Tue, Sep 29, 2026 at 02:13:59PM +0800, Jisheng Zhang wrote:
> Add the compatible for the Synaptics SL261X SoC I2C controllers, which
> are compatible with the Synopsys DesignWare I2C.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
