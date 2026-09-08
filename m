Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E824B2045;
	Tue,  8 Sep 2026 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861139; cv=none; b=pmj+rY+mtpzNJzJCLnIiiu7vuC1OfqB8qdd9e+X4iWfeJ9haJAobVG52nj/XKuj8jDWD/6o9zZQnaMsgjxo95Ee6RYgCTsrz7exdNsCI7Yi/T3QfQ+CHmA7yxd82jNFG76EpmLZccoBQlQPJBNnOiaOD9QfSPbuLLmnUVu3v7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861139; c=relaxed/simple;
	bh=4u87f6DxdHbcOXE+JRmwZ9XtkSfsMzesiW8NuypkJ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d92vvm/LNnLIfLLULvYFz6qsBBsLEDjeIrz3QL0+sBsBMbImP9AopGJKO7YDp/raXPQFK8VLdP6q9D0iZgg/daEPjdfNwy2H7T5c8vY9h4CDxXk+kE4n3DCIEdNrPPDmDdbDJ9+mcHps0ogo0keqa5oSmgexFziDYkGdQD9ZSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibhnAOJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibhnAOJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03081F00A3A;
	Tue,  8 Sep 2026 09:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861137;
	bh=+QlSkWvEH4s2aPafAZOQMVUAmuixXCZYC19yQjm2B/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ibhnAOJYbyef/eHNh1zFQt/ZezvBye8M7n4ePOS91pVGVqhwjVHosdajB/CgXQMmi
	 FqL3eV3XrWYXUhW4s7noJyH/V398p5YqCRBex130Rt+36KYGMLbCPxyCg/B/9vEc0M
	 BLz3VJLpTlAw1jO1QjfbUo0hxIEXvDFk2Q6aazNtL2/TUrcbq2OrTSHyzqtAjPQKje
	 Qc/N6nGMsl9EwEvUdRIsFnpba5MGbcxm0s4yBjAO2cFcv4javn19iUhLh8f/bQiu/z
	 8GVU+pDj8PY2HVA+ZIlZwmQ5PQsCedVuKJG8z6C1/VYEpY6Ks+DF9JddIEu8FI0LMy
	 47HBPrhhpkmVg==
Date: Tue, 8 Sep 2026 11:52:14 +0200
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
Subject: Re: [PATCH v6 03/13] dt-bindings: clock: add Ambarella CV75 RCT
Message-ID: <20260908-snobbish-honest-ladybug-3bdaea@quoll>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-3-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-cv75-v5-v6-3-e918514cb3b1@ambarella.com>

On Fri, Sep 04, 2026 at 02:38:10PM +0800, Long Zhao wrote:
> Document the CV75 RCT clock controller and the clock ID header used by
> DT consumers.
> 
> Document #reset-cells for the RCT reset-provider role. Soft-reset line
> IDs and the reset provider driver are deferred; this series has no
> resets= consumers.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/clock/ambarella,cv75-rct.yaml         | 64 ++++++++++++++++++++++
>  include/dt-bindings/clock/ambarella,cv75-rct.h     | 15 +++++
>  2 files changed, 79 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

