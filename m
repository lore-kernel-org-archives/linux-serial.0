Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007F3F8ED8;
	Tue, 13 Oct 2026 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891541; cv=none; b=fpVcLmiTL2LiutLdmPeeVkmnSFL/UukYc8X2CuWT31U6jXHCBYAhl8K9g7LW9ha5FCUX29DXdpT8rqqLoEQoFPJvBxozqkOVW/i95IBOPjLAtJVWdNmbjsfT2y/iQQtkgKqzNI3BqcFBtt0M6OdRhF0wtp0OqHIkIV6HulscF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891541; c=relaxed/simple;
	bh=YFsUef0f38ac/+8b1qLSfSN9685amM3deilBErx/gTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Gk+Et0Xg451K+CJfr5jqJ42nrnDpiE/fA+2bqrC7eaRCIGHydeXGpKW3mXqLBeUoATa61GLwB4jK8orFeIpzCRnrRJxXBq3grkSsy7oriNXjiw6pdcR7GCZGVWdFQWGUtkjiDaYK39If2X72iUiPZI8HwVvLqlno5xiNqGpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkfFpE8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkfFpE8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02111F00893;
	Tue, 13 Oct 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791891539;
	bh=P5s1qW3zZcChHW3VhOHAkmvlfucncjuOWhArdg/PEzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkfFpE8KdXIvNqzBbwSpfzKEh9DQtukW1FykWQ77AlxRz5p5KOoVi7dAMNfyLVH9F
	 6z1uURP6uN/LCFu00SoJnh2nfNC+3BTELjZt8zfya4kplgHxHRPMbxzkAK5lFxyfxT
	 gIU1FJhYQtqASy/bF3mQRuo15QWaHztjjFdQBhCo=
Date: Tue, 13 Oct 2026 13:39:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Donald Shannon <donalds@nvidia.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Message-ID: <2026101310-scuttle-unison-d4c3@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>

On Mon, Oct 12, 2026 at 08:35:58PM +0300, Adrian Ambrozewicz wrote:
> This series adds drivers for the NVIDIA LSTP USB adapter: a USB core
> driver and GPIO, LED, I2C, SPI, UART and BMC-side IPMI function drivers,
> with their device tree bindings, an ACPI description document and the
> sysfs ABI.
> 
> What LSTP is
> ------------
> 
> LSTP (Low-Speed Transport Protocol or Low-Speed Tunnelling Protocol) is
> a vendor-specific USB interface (class 0xff, subclass 0x3f) that
> multiplexes several low-speed "channels" over one pair of bulk
> endpoints. It is implemented by NVIDIA's SMA, an MCU (0955:cf11), and
> by other vendors' parts: two hub/bridge chips have it built in
> (0424:4940, 174c:2214). Boards use it to
> reach SPI flash, I2C sensors, GPIOs and LEDs, a UART and a host-to-BMC
> IPMI path, on both BMCs and host systems.

Also, if you really want to do this in a dynamic way, use greybus, as
that is EXPLICITLY what it was designed for, and is patent-free (i.e.
unencumbered, and we already support it in the kernel.)  Please don't
reinvent the wheel/spec just because no one did any prior-art
research...

thanks,

greg k-h
