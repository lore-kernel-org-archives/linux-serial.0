Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5B3C1404;
	Wed,  9 Sep 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937974; cv=none; b=EFwRkYQjfigDhba69F6edOycwBCSSV5sJ9O9UMHAaB9vHoAeYZbqV2Hq5nN+Z2SYXGZSk/nMDeOyJux5I3BOWtxPjwW847sW/wGbU9LleOaenzrpvFU+rr292faQA/IhMwwQOq/nSxWyVli18js7LD2GSp8dTexqGCCO042tjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937974; c=relaxed/simple;
	bh=hqeJ6JFtF61dco4k7fWQt98q1prPTuM8cmVS/Y2jvjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkswOUCsbX4O/x6mJ4BGGPOaI42BL+y0iTU0dWeXjclYoIqBMk6yEBRTxTo3ownqW0N7vpeBJM5qo6DUrOLoe4zEAOAkyLC5bbaCYNFpv9cFDvQahl+LV+vMKYORfaY98IBqRM2JBFdJehdAckFBRJdMx9xD2msst2IKYrBB2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNfoo70w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNfoo70w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9514E1F00A3A;
	Wed,  9 Sep 2026 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788937973;
	bh=ALD2G3jLNVJJ5O+pX/xMU4AjzIvGRp3/WG0X3qz69kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hNfoo70wmZQoE4YWfUsqb7MPecMxoYTzIiGaRpy49sL4YXsjzvGy5U+/LLh3btFAm
	 5iLumNWGlfevlvTpsSZNpVNRnJD2ul2afOaGCbP9Xr60IKjfRMR+SBCKXWQ3yc5EtL
	 eHlx213LUo6gclqX72JlA4g1t9ufkrR05v/9Q5VCVnFjJV3mfT73ycmJagTHRYIGMG
	 SQPxitTeSO7p9HMog77P4LY7TBhA25OZPip8+ck/j5wftgZamKqHiMkR991WXvIvUp
	 hlwhYZwaCoi+o2c1yFHrl9Rw4/FlUk1gfHn5BwAa+pYjhaBd9ZLw8D0VN4ovdi6Yji
	 rUg293B5gJwRw==
Date: Wed, 9 Sep 2026 09:12:50 +0200
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
Subject: Re: [PATCH v6 06/13] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Message-ID: <20260909-objective-zircon-cat-e0ce6f@quoll>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>

On Fri, Sep 04, 2026 at 02:38:13PM +0800, Long Zhao wrote:
> Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
> binding. The block is Ambarella IP with a DW-like register map, so it
> is described as a DW APB UART variant.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

