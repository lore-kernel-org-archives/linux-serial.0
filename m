Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFF49CF3E;
	Tue,  8 Sep 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861183; cv=none; b=EzhY82lNqtgpRLLfTtWovdu4ZEfUTxCNKs9jOdZiRlsDD0uhxALYRlx04K0gHq/egzK8b/Z1QrS4Kdei4lPdd8A01akvhbq9fN3ynEHvqArpTtDOXsm42BjfEjjx8672FJM+lwge45FsPRLJ7M9kK+dk7oyNHOJAa3rJhQOV27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861183; c=relaxed/simple;
	bh=/tgD3t29az3q/wwV4L/k3bqAfDdCS7HWJ80WcFYH4iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A86CAqGbPseQ9WNBsT+tQtoYcquJy0D84oWg8zs5Kmmk/B5udbyMqO0o+IG/F+TKns6ch8hlUjL1gYUQgW/BvN0FFZnO7FayFwmNW7MS5vY+wC0w2fvDbB4nkTEEdbGRtqoxOHV8Fs2AOkzfUcr1HOPpCzViVBMBDRr9lNWL7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4/PTSKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4/PTSKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E3B1F00A3D;
	Tue,  8 Sep 2026 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861181;
	bh=I4NWzhzA7OYXJTSRs9Gx7Qnhw4JJuKAPdTa9sXEPjrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4/PTSKnkR9pRHQxo3AaT4hnDfG2Z292EkA/WD2oLwSltUZkq5w7RfEjQehXuhRtA
	 yM1rYs0U4qmUuOufB8w9yW9tEX6IYZP2JBr/7/4D26/A+vuRhLwlznRj+QpdT/ZsST
	 ej9NMM90L/cfx4RfVLRTikG49quK/Ejg2PluFRRPPjyqiEHPOcAQMFrndji+YArKHO
	 yZz6AF2gbRXOZJRncDIoi75RkBw85agB2li3Ez16dhT3hV8BmKbXsJYf5/YqPhF+zS
	 Gu67nDIdj+Dr1+8JqcErycsql+YWHd1Fll9gS88ZFioJ8f2oZMHe4bXkME/oXRXIRX
	 gSqR4HWTjjlsQ==
Date: Tue, 8 Sep 2026 11:52:57 +0200
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
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Message-ID: <20260908-magic-ecstatic-lemming-b1db9e@quoll>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-2-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-2-e918514cb3b1@ambarella.com>

On Fri, Sep 04, 2026 at 02:38:09PM +0800, Long Zhao wrote:
> Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
> scratchpad registers on CV75.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

