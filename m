Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D371456DEC;
	Tue, 28 Jul 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251486; cv=none; b=HEESgRdablHsOQSuZIR5NfupKAiIPwLLMlfFOpx18MYwkooxkeEdpi51p1UNIoG10G33qNDkIHkJw+aMa4jKuoJ3P0P1hPcYlI8+BwLAJPtMJsJyGzDioYxeQI5AlquYaCORY7TTCPFxA9Yd/1MkgZk2h+zldNWeGVvF/51XACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251486; c=relaxed/simple;
	bh=Oheb5h8sMc8to/vLYHU6BByn/jRGPVwEJh5mGtTa+Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Gl+FkLZniV5l8Q7qsDd5TR7vOm2/d/u7++ZAuB7MzlmQvdp0y/heZF6HHJuu5hcs1csWo/vu3lLs2Kg3IKVxbQKkyJzg9mHa1B9GsqzPxfho74WczlVgrpRwzNGGVkOFx7+wnHQ7iYcC0OigaBGdz7tZF1RRbvgFvEbQzutuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVhR5Hlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVhR5Hlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7263F1F000E9;
	Tue, 28 Jul 2026 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251484;
	bh=P2h0zvhiWJL99Ql/LzjPEa4TBK4rGTdRlw5CNE1+M5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EVhR5HlvuT1lZzNuSDVgOjAPEYxN1UXWOjDHMF42Al88ql5VBXHTz0zc/I1+qKmA1
	 3TCF7yGMwxeewqJ6xW1vr+9JdpBYj8LfP6UxPQe2eOxOWRhbOtxsRwOxRvI2ewRJeH
	 d59QIYqyLJg0iNCBH26m5PaV4O1hiXkKjh0Hr1cRzfdyU3be/BCsdycZsOguWMpQNL
	 YmD+A3WKNSNcY9Fpm++V7tz8VB6duU88XPXLV55UnQWe9EdRVYWEBrkOvLhir+6m5V
	 avDAn1aZWF4Y1XE4DuxO2tKudWhej7/euP+WBRN+liVa9XRbMqsAYIFYjPVAnHYNm7
	 G8GpR9d8irT7A==
Date: Tue, 28 Jul 2026 17:11:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>, 
	Michal Simek <michal.simek@amd.com>, =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, 
	Boris Brezillon <bbrezillon@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 3/8] dt-bindings: i2c: cdns: add Axiado AX3005 I2C
 variant
Message-ID: <amjGh1ZQXTGXFv7q@zenone.zhora.eu>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-3-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-3-c429095143ec@axiado.com>

Hi Swark,

On Thu, Jul 16, 2026 at 08:51:10PM -0700, Swark Yang wrote:
> Add binding for Axiado AX3005 I2C controller. So far, no changes
> are known, so it can fall back to the cdns,i2c-r1p14 compatible.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>

merged to i2c/i2c.

Thanks,
Andi
