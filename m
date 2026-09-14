Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6E41A93A;
	Mon, 14 Sep 2026 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379093; cv=none; b=J06O2y+B3FNLNuU11s1p3Vv1Xp5AgiTEv2vqzdM+84bfIkqgPkWoKMj+zJIECCtPfGwlRRWVzVe00tXKEocWVfKraA11xM88Z+DC9zBCGeuZVOQqz9hxr/gcq5QG3YeTHfGwKe0vQTtA3U0Nlna+tGNhDNhvfYAcL9Db72YjvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379093; c=relaxed/simple;
	bh=6nYt2qmvQiwbF8zdA1cWcafihjBF9zdHKhaWCkPbVsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PffzBM2Rlkek4/BENBDcC+5wehVpbMt8q+MB/dxCHseNSU2WcbrHJu0+tXPAd4VeTExtbiLvC/y9DEwEnPDSg6BYEzumkZqTM5/pnKeorIsUsPY5OKC2IlBame4az2hDV4SDVfqIe/JmqDSZOx+E2iLeOXgTdb+tdv7PHSlAIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwJKXUYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwJKXUYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06121F000FF;
	Mon, 14 Sep 2026 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379092;
	bh=7oTu0d+0Fng6387kjjfZt62xlgG4iwEnpYsY40VG/Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AwJKXUYxu2mk018JrvfobY4v2/1iitVaMT3IPdoEL9Dhptuk86dYWjE1hmwbGweip
	 G9YbI8JCD/Roai2iKXzafYLn7VJDIHvKI17gT5I1gWWOYsXmzjqZSQhQNBsHzuyGDq
	 1nK49n33KIeUVVdWn+taXyyAGZw0xq1efG6Py78j/samC5nea2i9H9TTuc80epxaRb
	 hEp+8O4fOix1UsVy6dGnIcKEFqv+Mw9K0Dj4cnmNokkpRtYaxF3FRPeXgCa14aUi+9
	 YahzdtRk++xKNYA3nR/U1gK6j6YXyqdOQR2zE9s0nL4s6nHAK0u6hyNkk9s1fTEPoH
	 y8gLqWQpfryXQ==
Date: Mon, 14 Sep 2026 11:44:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
	mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/13] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
Message-ID: <20260914-refined-elite-seriema-0f7eaa@quoll>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-4-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-4-e918514cb3b1@ambarella.com>

On Fri, Sep 04, 2026 at 02:38:11PM +0800, Long Zhao wrote:
> Document the CV75 pin controller binding using generic function and
> groups properties for pinmux configuration.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 239 +++++++++++++++++++++
>  1 file changed, 239 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

