Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD32DDD3;
	Wed, 14 May 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208260; cv=none; b=dJmmOMngl2FnX/Id+lDQqHlLEPbvHq6nyJ8skTRsQ2HECWkung54a71Pox99S/+iD35uC+Sf02++5C1Yovfonm8uPQGAOKZDQxgStbU2GIIK5GYyTqp9yS8Yu38WgeiZdG26DMralkwNx1fO3qW1YYO0wXGu314dNG25G0LizI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208260; c=relaxed/simple;
	bh=F0y7ofSa6UIPn9c0w+nXpRMsY1EP8Pck94HcAtDu9x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9AzT3oYthFdPCw+yF92ONs7ny9orYVv+UYZ3uw0QyDUzUiLku57mC1s+BZ8bGyUQw55K3V463MsJ8JmdPZHgssq9pVJiRNKk8VTdbQzW7UuE5M+MrP428QkKt1mj21IHbdKX2m1bGzw0X2mWubZNhjNViu62nAquOCVVBEGVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBqJlo1F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBqJlo1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A39C4CEF4;
	Wed, 14 May 2025 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747208259;
	bh=F0y7ofSa6UIPn9c0w+nXpRMsY1EP8Pck94HcAtDu9x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBqJlo1FN2MYi6K+ntxiI8tL0a4PCqvFQ0MAxaC8jOfEbHzXNGbLO9eqXIHMXwWqd
	 GI4UieoUdXBW1HI/h1zlAqvmWQ8x1xichmOcwL3CS+8Ec1ImwRSZH61/jCxV0+YboF
	 LODSFDaVioCXpIC8XNzmBKj7k4X06lnDbSGf4fi8=
Date: Wed, 14 May 2025 09:35:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Judith Mendez <jm@ti.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Introduce PRU UART driver
Message-ID: <2025051449-scarily-evaluator-0e03@gregkh>
References: <20250513215934.933807-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513215934.933807-1-jm@ti.com>

On Tue, May 13, 2025 at 04:59:27PM -0500, Judith Mendez wrote:
> The PRU_ICSSG subsystems in am64x SoC, the PRU subsystem in am62 SoC, and
> PRU_ICSS subsystem in am335x SoC include a UART sub-module. This patch
> series introduces the driver and the corresponding binding documentation
> for this UART sub-module.
> 
> The DTS patches for adding PRU UART nodes and enabling PRU UART is added
> in this v1 version, but marked as DONOTMERGE since the patches only add
> context to this series.

This prevents the series from being merged as our tools want to take the
whole series :(

So please, submit this in a format that we can handle.  As-is, this just
makes me want to ignore it totally and focus on patch series that can be
applied.  In other words, what would you do if you were in the position
of attempting to review this?

thanks,

greg k-h
