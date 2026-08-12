Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0537E5E9;
	Wed, 12 Aug 2026 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502868; cv=none; b=IOoDwqmOUGzgfGahKXoa7ah9EvGgc87dceoB8iKOf+iaJWXGZHaKvcsPrcOVTgltImb9S5x6mGy8T3akOgXKj96/AfKxaPCEAn8oBgFTtNtAI/lDWySH0EShK6RV9TAO8orCwXaMJFBmMkr+NDeZ6vD3IutBATJbMV8kw2gzH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502868; c=relaxed/simple;
	bh=72URCmWOjSFx+3UxH7LUv24KROUuX0ZPDDmzk/1HvtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAFDGsJnagxk5qbPuwdBxZt73cl/OZJIFdeeJjcOfQa8jHXqQr4iBNc9n8zoDPjky4rac1oeM9nfkJfRC5+i9hChzMhOupxzBUjOIAkyJb7LVYCFpN8oLSc4mHLQqOcsvvuSP4B4al9OBdUKQzxtI84vTgNRasQ/MEYTRUgbBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiSsysQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiSsysQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C81F000E9;
	Wed, 12 Aug 2026 02:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786502867;
	bh=+ASwc2Ygv66cUz6aU4pmnpAE1p1jo1CzJkrv0lM5YYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PiSsysQ7qMrLsD03v8wZWLZRJPBrRPg0zQexvwmp2S282dkNa3REJo1M63fTsTV9r
	 hPmaNjHCENc8iy69IgbO8Awu29TEaUB3TO5gEn2jq+RG2p8RfRbphQLIwlFc4HQOem
	 Njb72/0K3gnwtGRt7feZ0pGQn1EdqZBHd6tytpxlhetXY2o8C52jASL5CUMQ33SAcZ
	 rpvKsqUXbQS5HsjzaFCx+HWFUdIOenchXYQH5WXQYQ5I8Cg4qZJa8YuLwDp587JSlo
	 LOQyIzSMclP5xEUXi+6hnnvnIt6TxYYw5ggB/hs14ydl0VX17be28gcFTcXQbA3toa
	 bsBuCUTLpGs2g==
Date: Tue, 11 Aug 2026 21:47:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, devicetree@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-gpio@vger.kernel.org, Will Deacon <will@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: serial: add Ambarella UART
Message-ID: <178650286553.616367.17873097780629180417.robh@kernel.org>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-5-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-5-6b09707c5fe9@ambarella.com>


On Thu, 06 Aug 2026 17:34:13 +0800, Long Zhao wrote:
> Document the Ambarella UART controller.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/serial/ambarella,cv75-uart.yaml       | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

