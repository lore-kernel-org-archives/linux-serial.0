Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E175189F3B;
	Mon, 15 Sep 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896014; cv=none; b=Og/H4Zu3FDYR0NxWpMEvo23jJG5f8r9xltQMwdLnpkvh6eYFs9TWGVggeQ9HoZb+t8y0JoTV3Sh/4IIvEipjp6EpEVM2rYozmegE+dRwj0bKX7uee4WIQ2r+mIu8/95sNMfZoDsYuua3uQIqQ07Lkz7xFySNKTVHzg9FTSutww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896014; c=relaxed/simple;
	bh=3Dx/mn3xCZ9cFztZlIlY12/JFoqPz3qS5Pc30XcDa8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDPxPbfq8/+bjJbXy0X3Jp8TIQM7cgtBeAVuyO5os8q/e0Ebn1EnTKLXRDgxXlsxv8xFczxfL9CvQ8IE1FxeQVbUblobJDl5rq3UWpNHRPB9ZmXQ/W+riCc2+DkGEezvqD1CrXhQAhu63oCEmGRJT1sWx36RF5JeYveesnDTews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXJmkTCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXJmkTCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E8FC4CEF0;
	Mon, 15 Sep 2025 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757896013;
	bh=3Dx/mn3xCZ9cFztZlIlY12/JFoqPz3qS5Pc30XcDa8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXJmkTCRsTVLiSh+l0Jf1DZYPWuamY5HMcchw2b+aJhPkWtrS3kADQCwnHbQlvW//
	 lWIojH/RpdLdH3J2goSeCsxXKwSM/xiCR0asbjOIOCxxivtk/baiEyJXerJoHKgRrt
	 0Vsg4CR2yzcBD3gnkbzxrX0JXRhW79GXspXF1wFChsNsvhLjoJDmlXG+zytRikfsqf
	 sHUcmjpFOf0nTHuKLSMZG0AfO4cwjKXxivtFXfkE25ihUXEXVLKLPL3IqPdrIPANqg
	 WjEd1wL0GGEGolCcZGPQv8+OEZ7CaBR9iuXj1clmzXOkJ+XLMXflbtCF3Ci1/CHkIv
	 Rq38UPGENu8+A==
Date: Sun, 14 Sep 2025 19:26:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, khilman@baylibre.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	yujiaoliang@vivo.com, Conor Dooley <conor+dt@kernel.org>,
	d-gole@ti.com, msp@baylibre.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, a-kaur@ti.com,
	linux-kernel@vger.kernel.org, vishalm@ti.com, b-liu@ti.com,
	linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	sebin.francis@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: 8250_omap: Add wakeup
 pinctrl state
Message-ID: <175789601228.2311556.16257478264860119681.robh@kernel.org>
References: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
 <20250910-uart-daisy-chain-8250-omap-v2-1-e90d44c1a9ac@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-uart-daisy-chain-8250-omap-v2-1-e90d44c1a9ac@ti.com>


On Wed, 10 Sep 2025 16:23:31 -0500, Kendall Willis wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Pins associated with the 8250 omap unit can be the source of a wakeup in
> deep sleep states. To be able to wakeup, these pins have to be
> configured in a special way. To support this configuration add the
> default and wakeup pinctrl states.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

