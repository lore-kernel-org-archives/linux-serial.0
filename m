Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675792;
	b=omM3nnGRul2lto06wvZ8zVL0tSF+nGE09SkjDGpaq8Tr1HbGyPrnXqWV+f+63U0UTkbX
	 vFm1uB++XQPqVdfdRIylKQlr/osf6Cd/oKbhZuua7G1l8ttBwchszYpMA3u+WT92vGlvQ
	 LzJqu27hTQvbmTf9iDXZE4yi1rFmahg13Y766zdcnhLyzaCV8fkhT+F+Ug1fYyGbMDjJD
	 /f/rXfSpcnnfiodIh8u2oTYLDTrFSv3Zr6RyUIWeAAQMDn0USRyO6unU9l+YIIwQVLAMN
	 /2VcPEF4DqarFKGvAkltMuvJufHR9e1uUT1JaEBewMupiASP4gDUmKtDMWJ2k8Z3T9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675792;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BHloWhYz7GJBLiM/ipNU8e/tSSUGBZyPKJWypWVrUrM=;
	b=fPXxQ7OLti8rvzfqm5FvthazY1qAcEmKNJzqVABLTd1lOWTCrZPQ8j87uSo2P1HxKF87
	 fCeOqUn5xvCKMwQ766UZMplXueAdnHWH7NQ3e/5HpigcaafJgOg3BKzi7afTuq8inu1bD
	 X1faldDm/pa8wLUG7wsSmgqpCEB/LiumbHGZpdCCaSF66tZ1jbamwKFdeZfvuGkoRKgU2
	 GvUHCtkwI3Mdjs2RyH6uHII39YRcNTMJr+Z06DV3OB17V6sX5npChG334j95M7EITTIFC
	 8Ip27cMXq2MoMY6cRJuHkNct76H0+cEP+4uf+GlgUA3PQI4nM0PA8vqI5v55es0bmxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ipjyl4WV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE960A2604;
	Thu, 22 Oct 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ipjyl4WV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81D71F000C2;
	Thu, 22 Oct 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792675791;
	bh=BHloWhYz7GJBLiM/ipNU8e/tSSUGBZyPKJWypWVrUrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ipjyl4WVUMaePbP8eQPmaEfK7J/3RZ1TYrKdiNb92bEF42Dy9+KYZdsQFMRMsboSF
	 zKu9HrcsnZenjyraJqvjlVuHMvgpWMorBB7kvBnawTj3Ld7pah59+zVPkaekC4FC4z
	 b87E/GW1wE+3LrxDIpnlCtSHe+LyRpVtpS/hihPU=
Date: Thu, 22 Oct 2026 15:29:43 +0200
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
	Jeremy Kerr <jk@codeconstruct.com.au>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Message-ID: <2026102222-oppose-saggy-983a@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <2026101355-species-glance-9ff8@gregkh>
 <20261022104025.3956402-3-aambrozewicz@nvidia.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022104025.3956402-3-aambrozewicz@nvidia.com>

On Thu, Oct 22, 2026 at 01:40:26PM +0300, Adrian Ambrozewicz wrote:
> On Tue, Oct 13, 2026 at 01:37:11PM +0200, Greg Kroah-Hartman wrote:
> > > Why the auxiliary bus, and why not MFD
> > > --------------------------------------
> >
> > Neither is ok for USB devices, that's not an argument either way.
> 
> Here USB only carries the traffic. The I2C, SPI and GPIO channels are
> ordinary controllers on the board, and their drivers register with
> those subsystems; hosts describe what is wired to them with ACPI, BMCs
> with device tree [1].
> 
> usb-ljca is a recent driver for a very similar device, so we modelled
> the core on it: one interface carries GPIO, I2C and SPI, and the core
> creates an auxiliary device per function and attaches its ACPI node.
> LSTP extends that model to device tree.
> 
> Whether the next version stays LSTP or becomes a set of divergences
> from an OBMF-ICP driver, as Jeremy suggested, the need is the same: a
> device behind a tunnelled channel is described like one wired straight
> to the BMC, so a board can move between the two without rewriting its
> description.

THat's exactly what USB is supposed to be on its own.  Just use that,
don't attempt to "overload" a single USB device as somehow being a
random set of devices attached that way, that's a peversion of the USB
spec, don't you think?

But if you REALLY want to do that, then again, do something that has
already been defined, like greybus, which you can use your USB device as
a greybus host device and "hang" the other devices off of that (i.e.
your firmware knows the device types and describes it to the host.)

To attempt to use a non-self-describing device/bus in this century for a
brand new protocol and device that actually uses USB as a transport
layer is insane.  Please learn from history and don't repeat the same
mistakes.

So, again, why not use greybus for this?

thanks,

greg k-h
