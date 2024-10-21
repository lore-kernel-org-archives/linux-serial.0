Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8A1E5705;
	Mon, 21 Oct 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533640; cv=none; b=L3aISBIOJyzPs15z40ihTTstBqEsiQNBxN23fWyofmCYp4zdD9z0fdLmsh52Nrrr5i/cLMRRWoWS8ce07P+hUnAKduv8hBU9NJTNexiopAJFT92FowS+U4KbifAXL6eX1hx1SRTdzdWfCnsotFy/dOBbGWFiERUVQqG9bRuQdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533640; c=relaxed/simple;
	bh=fgWxk2nymv2R0eYb6z56JNmzGGen8Gh9a4cYgGr2o2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZIt6PLCL2B6GlnDcIMN0SermE8fjnq38JqESn9pPXYHtCFXujX6CTqkdIXyaCVQDkbZf/ByyoBBLqsb5MdhRtuhffbAUxJSQDq+7/kYhBG9Jq8F7f9HuMaLOlI5gSJsvsYfmiaHoragKzOVMMphU40Z27fDss1haErjLDgTTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7Stmwr5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7Stmwr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D68FC4CEC3;
	Mon, 21 Oct 2024 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533639;
	bh=fgWxk2nymv2R0eYb6z56JNmzGGen8Gh9a4cYgGr2o2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7Stmwr5YXDcTvbGjTGnDUQhQ2DXd6REQBki6PSTTHdv94HZ/tGU5QADRmyR6/KO2
	 Wx7uD/aWbFRkDtTA89ef5ijSaxuwn9ax3xd7PAbcFt5s3ZOWAaSx0RQHSjqRzWh6qF
	 JwMvmMZOMpkaZDUHu/VsW3bYGM/5ag/9anF+rupIcyf4dU92cFKTwpWC85WTUlBxqN
	 ZaUpxpXHqbiQswF98gew+ctCLeTYmQr4bH4CbTY9wQFD4R+JCDCJC4KyoyLPac1BdK
	 9+Dx4DtOkjFOo5OyVRCez/wc2e8WtLuZI514Qwzd1VUbYLJzJh+TUDGyPJ+5DMm4hZ
	 adGzwgSsVdX+A==
Date: Mon, 21 Oct 2024 13:00:38 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
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
Message-ID: <20241021180038.GA738756-robh@kernel.org>
References: <20241021072606.585878-1-inochiama@gmail.com>
 <20241021072606.585878-2-inochiama@gmail.com>
 <20241021-outlying-washday-8f171dedc703@spud>
 <r5ngs2j776jcy6sfirwzmtsoljotatfvgmlmv4sj4xksye2bff@xtn7adafbpfz>
 <20241021-rosy-drove-1ae3c8985405@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-rosy-drove-1ae3c8985405@spud>

On Mon, Oct 21, 2024 at 01:21:58PM +0100, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 08:18:58PM +0800, Inochi Amaoto wrote:
> > On Mon, Oct 21, 2024 at 01:10:52PM +0100, Conor Dooley wrote:
> > > On Mon, Oct 21, 2024 at 03:26:05PM +0800, Inochi Amaoto wrote:
> > > > The UART of SG2044 is modified version of the standard Synopsys
> > > > DesignWare UART. The UART on SG2044 relys on the internal divisor
> > > > and can not set right clock rate for the common bitrates.
> > > > 
> > > > Add compatibles string for the Sophgo SG2044 uarts.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > index 4cdb0dcaccf3..6963f89a1848 100644
> > > > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > > > @@ -58,6 +58,10 @@ properties:
> > > >                - brcm,bcm11351-dw-apb-uart
> > > >                - brcm,bcm21664-dw-apb-uart
> > > >            - const: snps,dw-apb-uart
> > > > +      - items:
> > > > +          - enum:
> > > > +              - sophgo,sg2044-uart
> > > > +          - const: snps,dw-apb-uart
> > > 
> > > Why does each vendor have an items entry of its own? Seems like needless
> > > clutter of the file IMO, except for the renesas bit.
> > 
> > I just follow others when writing this binding. I think it may need
> > another patch to fix this problem, right?
> 
> Yeah. But I'd hold off to see if someone gives a rationale for it being
> done this way before sending that. I've not deleted this thread, and
> will send an ack if someone justifies why the binding is written like
> this.

No reason to be separate.

Rob
