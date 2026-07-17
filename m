Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FC3E5588;
	Fri, 17 Jul 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277427; cv=none; b=kruhcsktXGM4ZQSiOR57fwLZnb68KPBAAGbZZsd7fbdQOIDJG3Zvk0u4U6T160GA1TeFkllWaX6pN4OeA9PsSa5+LENJm9letrka6F9kKfdFlVBzT0UF6x/v2ibD7M16EhDOUDbq+OteYTdBSUqaEccU7ZrO+47ge/M3Lny3/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277427; c=relaxed/simple;
	bh=8G6mGKhFTHrgbCBh0BP3lAY1jUxzKRyfdfjgBOUyD38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mef4v9ICGF00GDuhglpkFvaoPpJzLpCEOoM6OSRXoNgeHRQYBDf7UuvdkBvGAh7z1YGp3/3TPhX4/86YEGLx5EX+GTQGLOzCSwjaQVghCtIknpXZ7BG/eFm4lvoq9R7XTQXUEEHNoKxSidoY8n90nTkI21Vq/fIOZCZ2M5OkDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHHM9uyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHHM9uyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715371F000E9;
	Fri, 17 Jul 2026 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784277425;
	bh=5Nx90yYsedjeMovsM9fLZ8Rjn6vGASvEZ0i1aCVi9BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AHHM9uyGT9+vZ43eym9FxQZKiSmPSoTmj3pn0SuQnB8IWi0vQ4nMdvvXjOoNJxCD7
	 e6z3oKNR/P9PEDEgM34HGe939XvWSzULQFM404CLJ01mSosgo95faXCfkhsqjuTPz1
	 xoKe52yDVCNSUazPHEibzKOH0pX7bEPyc7YBmdZyWXeg4FOigR1a8EctSSqlnMESg5
	 EBO9oWsbD4PMxwwGhyN3/AeX6H5y5KOUrQVZZXrL7gAoqAfeQuVEAXKb5vQDGXoqRw
	 SZ/XfEEe2G7iYgnfiHPZHgXJeMdKFV9RmntM4foSjJL7qULJHRmX0H6LdhvrMX6Yb5
	 zhBBAHHnEv3sg==
Date: Fri, 17 Jul 2026 10:37:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>, 
	Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: usb: generic-xhci: add Axiado AX3005
 xHCI variant
Message-ID: <20260717-sarcastic-hyena-of-music-27cc5d@quoll>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-7-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-7-c429095143ec@axiado.com>

On Thu, Jul 16, 2026 at 08:51:14PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 xHCI controller. So far, no changes
> are known, so it can fall back to the generic-xhci compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> index 62678abd74b5..d7fb0301fe4c 100644
> --- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
> @@ -14,6 +14,10 @@ properties:
>      oneOf:
>        - description: Generic xHCI device
>          const: generic-xhci
> +      - description: Axiado AX3005 SoC xHCI controller
> +        items:
> +          - const: axiado,ax3005-xhci

Just add it to the enum in "Armada 37xx/8k SoCs" group while dropping
that description. Description anyway repeats the compatibles so is
completely redundant.

Best regards,
Krzysztof

