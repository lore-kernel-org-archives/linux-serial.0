Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9D4EDCD6;
	Tue, 13 Oct 2026 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891428; cv=none; b=HjXBTp4lGmtjWNKdx0YF8oaewpzBJbsq7cyDjLEiuDFv8KauFMuCn5IKKD7FriePIw8J8ezYA08skqI6y8TE4IKtejhIBkpcdhBwTO6M2KQCOOBY37TBQV/0aXIw/9+jB5PBxbrWKx70u+p/+4Ek6Clv9EG2h6pD6RrYSDkThuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891428; c=relaxed/simple;
	bh=3WUSLzebOr2ySv4J/w7atqPmxuF+kPawmJ81BsoAz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBd8qirXq+EntcSo+vVSbp9jc+x+LevvswNNJHjTxS6gQMOuc84Ybt6iLuNt/O0SPAEA//bRdd8uVhtBRcmMV73GO31f90b7DctHUhiFSx1HqoS0ecrXDgifMnhN8d/6DNfm03+ujovoCDDMR8mqlR8XW+Jr1lhNcNGe/G75W24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7jZhXyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7jZhXyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11B01F000FF;
	Tue, 13 Oct 2026 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791891426;
	bh=whuCXrASEjiOa53ahdPLNNDh/L/dZAaNEwT+F9NvgAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b7jZhXyZnbu6aYvE/wYID94SUUXIfeqUui/Keow3vDwWhhFGxKEZw+81dvRUz2clf
	 3c6sv/uoWd4npQsr8kWdIc6DEpyMo5bMIGxKJSWiBEp5uq1324fWzqmyHBPAid4W1e
	 /nlvLJfO2Xe9hyUP2HJ0/IIGkOQ/VBYAPaoZFdIc=
Date: Tue, 13 Oct 2026 13:37:11 +0200
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
Message-ID: <2026101355-species-glance-9ff8@gregkh>
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

Why would a USB device have anything to do with device tree?

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

Cute, but that's a total abuse of the USB standard.  Why wasn't this
implemented by the proper "each channel is a USB interface" model
instead?  Have the firmware engineers there not read the USB spec?

> The channel types are SPI host, I2C host, GPIO (with interrupts and LED
> pins), UART, IPMI and MMIO. Channel 0 is the control channel: at probe
> the driver reads the channel table from it, which gives each channel's
> ID, type and configuration. The set of channels is decided by the
> firmware, so the same VID:PID carries different channels on different
> boards. No firmware description is needed for the channels to work.

Again cute, but that's not how USB devices are supposed to work, why
would we want to do this at all?

> Series layout
> -------------
> 
>    1  dt-bindings: gpio: Add NVIDIA LSTP GPIO
>    2  dt-bindings: i2c: Add NVIDIA LSTP I2C
>    3  dt-bindings: spi: Add NVIDIA LSTP SPI
>    4  dt-bindings: usb: Add NVIDIA LSTP USB adapter

USB devices do not have DT bindings.  It's a dynamic bus, with
self-describing devices, don't make the mistake of thinking this is
giong to work.

>    5  usb: misc: Add NVIDIA LSTP USB adapter driver
>    6  gpio: Add NVIDIA LSTP GPIO driver
>    7  leds: Add NVIDIA LSTP LED driver
>    8  i2c: Add NVIDIA LSTP I2C driver
>    9  spi: Add NVIDIA LSTP SPI driver
>   10  tty: Add NVIDIA LSTP UART driver
>   11  ipmi: Add NVIDIA LSTP IPMI BMC driver

So you have a custom "bus" for a single USB device/interface?  Ick,
again, why?  Please do this the "proper" way in your firmware and do
this one-device-per-usb-interface like the rest of the world does
please.

Doing it that way will not cost any more hardware pins at all, it's all
handled in firmware, and as you all have complete control over the
firmware, you can fix this up now to do things properly.

> Patch 4 $refs the schemas from patches 1-3, so it comes last among the
> bindings; it also defines the serial@N and ipmi@N channel nodes inline.
> The MAINTAINERS entry starts in patch 1 and gains each later patch's
> files. Patch 5 carries:
> - the core in drivers/usb/misc/;
> - include/linux/usb/lstp.h for the function drivers;
> - the sysfs ABI file;
> - Documentation/driver-api/usb/lstp.rst;
> - Documentation/firmware-guide/acpi/lstp.rst.
> 
> Patches 6 and 8-11 each depend only on patch 5; patch 7 (LEDs) also
> needs patch 6, whose GPIO driver hands the LED pins to it.
> 
> Why the auxiliary bus, and why not MFD
> --------------------------------------

Neither is ok for USB devices, that's not an argument either way.

Please go talk to some people with USB spec experience on how to make a
multi-function device correctly.  This way sure does not look like it at
all.

thanks,

greg k-h
