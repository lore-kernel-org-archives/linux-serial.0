Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228E17332E;
	Tue, 28 May 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912113; cv=none; b=doU9fBUoV+fq5XKq4WyYbER2no4M1BXkpolZtnJVJwqR+3KwHkLRvGPK4r7MQYbnQALNVakApgqJLE3rw+ma515bKaYCQ0ZkxDwdosF/wQqeY9FFN6UaFG3CJFyQ6rDIjrw1mUHjmwljHBp2uJ2NfxOCXhYUt8g1FpdCnFK+FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912113; c=relaxed/simple;
	bh=JZHasqy5LBI0hSvZ9z0NMQJ9KSGo6QMx+O4lDynTmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqZxZedEXeOdo8q0MyS1pwtcbIzKalXp4rap0raxH11t4TsBXfrNPbidMDjr0okWifYZSiyjs80s1kiuaqOkZGO/SYhb/lCqotaZ2HhroAXzIBcOMmEe6lNLtWSmkjnEdCoA5OvVNZNPVC8vlV9fW4aVf99EIxSCZ+iTa4mWlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC3e8O6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC3e8O6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFEEC3277B;
	Tue, 28 May 2024 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716912112;
	bh=JZHasqy5LBI0hSvZ9z0NMQJ9KSGo6QMx+O4lDynTmxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC3e8O6fULLq+dCBWFVZWW0nXZTUU46/d+CVgflMSoOQREx0ZbmrdEDyIDB9i0CIs
	 CkrMhV9NGHQljQFwTXlT8YuM03c+GCyh1cbsUBnf7wVfgbT7rVbMEB/of/rRO1m3fZ
	 wQZkal0wWfR7kWa9kUcTyBzMXlRGrp/hcZ2rB4VXMYcsjFaY6Jd7NQku7fxW1bg3g9
	 z1mTQ/mxo3a3Ltb7gtdOO8apOv5J8KvVr0JWBUtYpW7NNS0iefWA6thH6NBxGNQ+iS
	 vlDGxw7ifnH/KnAAK+fPjCiA92mHM0WsxGvuiExIlWnTFH5m5Bza21ykZxMYGWfHgd
	 Bi2p3tbTZtIQg==
Date: Tue, 28 May 2024 11:01:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Tony Lindgren <tony@atomide.com>, Vibhore Vardhan <vibhore@ti.com>,
	linux-serial@vger.kernel.org, Ronald Wahl <ronald.wahl@raritan.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Ogness <john.ogness@linutronix.de>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH 1/5] dt-bindings: serial: 8250_omap: Add wakeup pinctrl
 state
Message-ID: <171691210723.722570.2038595239352860907.robh@kernel.org>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523075819.1285554-2-msp@baylibre.com>


On Thu, 23 May 2024 09:58:15 +0200, Markus Schneider-Pargmann wrote:
> Pins associated with the 8250 omap unit can be the source of a wakeup in
> deep sleep states. To be able to wakeup, these pins have to be
> configured in a special way. To support this configuration add the
> default and wakeup pinctrl states.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/serial/8250_omap.yaml    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

