Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FB2E762A;
	Wed, 23 Jul 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278467; cv=none; b=Wt8jQiVN36TdOxZ9rXFJsbhdczW230M/nXVcBlMkQJzauq0qE1J4GnSwvMWFeGY7CqPVoO82sYsmuEkSwpNOLuzaA1dpnfzt/6BtfZlMeXtKSbIe9MyceA4kbauxnD6gWesJKrSiKezd2BvY47tMP/KNa0PbjzmtLRCRv31OfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278467; c=relaxed/simple;
	bh=Ot/UdzeQO5DarxCrrxun4QJevXgk61ADtTLiX9hMKWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPUU8jTgiS3e5eSQ68yrTWh4keOtQIdCQU+Zjxf1DYYTaMB9OSI/JmmR/rLwaf9EiuxmlgYepywW/fMSR5rxpyIoGZKKfSVxmgSsVoR7LJitGlTKJDPX7S2KnRWMk6XaitQHittM8I2snOvI3i3nHuCNFoUXwUkSyYdeyYRCnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROmbDO1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROmbDO1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44745C4CEE7;
	Wed, 23 Jul 2025 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278466;
	bh=Ot/UdzeQO5DarxCrrxun4QJevXgk61ADtTLiX9hMKWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROmbDO1nOW0cPCfvJhA900URnUlCLj90ozJ8F7CM30IeqieCaoF/AL2a/Djfp7dUi
	 H0L0gF0Ic8iw4wkct5db4uyGj5Cr/rNvxcA0KPKbjRuZNZFXBxsQQsVZQdlO2o8DqA
	 YLpURgK3MvDmZAgCFAKPUvcnzk6+7nIFHN+s/tWuAOaYEm5//s3NwQKXlSgiDJKNE8
	 arA7CThehzYsm69bja20t9VMvSTdbDk3/G8DiyzCh9ezn07QiY9fa8UZtZ0mlUh28/
	 RbhvGxrwcpQxJvMEQckPzhEF4fQYG67yAAzwtGANP5yJDNpxMSSzJJYFYjpVxCx6B8
	 8qYrTxRu5rzqg==
Date: Wed, 23 Jul 2025 08:47:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: snps-dw-apb-uart: Allow use
 of a power-domain
Message-ID: <175327846490.2145535.759049072094464087.robh@kernel.org>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
 <20250723085654.2273324-5-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723085654.2273324-5-jonas@kwiboo.se>


On Wed, 23 Jul 2025 08:56:46 +0000, Jonas Karlman wrote:
> The UART controllers in most Rockchip SoCs are part of power domains
> that are always powered on. These always powered on power domains have
> typically not been described in the device tree.
> 
> Because these power domains have been left out of the device tree there
> has not been any real need to properly describe the UART controllers
> power domain of Rockchip SoCs.
> 
> On Rockchip RK3528 the UART controllers are spread out among the
> described PD_RKVENC, PD_VO and PD_VPU power domains. However, one UART
> controller belong to an undescribed always powered on power domain.
> 
> Add support to describe an optional power-domains for the UART
> controllers.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

