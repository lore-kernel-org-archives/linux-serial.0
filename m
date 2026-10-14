Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4C3E1233;
	Wed, 14 Oct 2026 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791949136; cv=none; b=ia1zdMsxggXJWKa6fS1oYKxkptVnHZ4/OOEb6F4o9YhmKApfsTJjSyTMrFst55R/H3inygQRJkYwztJk1XYTPcW1sUAFC26gNuK0J2M55hA/qUCS9TKXak8abPkn/0hf3g69wLrs4jac7uyYMx53yke1N9w4JK6LElY9qxpYw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791949136; c=relaxed/simple;
	bh=wWv4sUHIfZP1ItvggJvpQO6/iSgwS9YDTUDmw+IVWVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0cq4Jn3nZA7W8B+EQO7UkPAv9TRgMHrDbMOV6IBzb6yoXfwjYfOQPWma77Zela3GZL2EX1gy+PcI987jMR4AsQ/gfop0pVedQtmmBxlZyZ53CEmRGHHUFLDdxOIR8Rj5h5i2PDshsUwsFuKvZiY1KTOaLhoBXhjvNs5+L4g1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=k4KKl8pH; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="k4KKl8pH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791949128;
	bh=Xr9nv3pCAuQ1Ufx1N8P/5BzbOX8F4y0Yex+Y2BlP8fQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k4KKl8pHFsg+eNdE9MoTQ1h16nqPhHKpCXWBVqVXLPW2ix4UmoIThsHCX7B5m0yz1
	 YD4+Dp2SK2s0tl4YQFuFWE6axcJgIvHT2y2Zg9A2fOd+XN2eACiZoGBvUPrX88CBVy
	 O1CQHTPFNjSbjQtIF556KtYdPeq6ArLQO2/JzZrY5fQWtrllS2yRvzRwx2HWMGK7WI
	 K4tK6wLG4c0gPqybPKIbjWmNtY5ozYr63SKhMIzFc9zGB+f0bP0Uz1z/fYNLXvXh++
	 Ly3MYuRRGsYymcj/L7Gnq07y5bYrM+nhYKw6ReTpvrtLCR3OemkUW5hyh9GBz7kNyu
	 yksHmIU1++rcA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FD926CEE0;
	Wed, 14 Oct 2026 11:38:46 +0800 (AWST)
Message-ID: <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Ambrozewicz
	 <aambrozewicz@nvidia.com>
Cc: Donald Shannon <donalds@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij	 <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Lee Jones	 <lee@kernel.org>, Pavel Machek
 <pavel@kernel.org>, Andi Shyti	 <andi.shyti@kernel.org>, Mark Brown
 <broonie@kernel.org>, Jiri Slaby	 <jirislaby@kernel.org>, Corey Minyard
 <corey@minyard.net>, "Rafael J. Wysocki"	 <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>,  Hans de Goede <hansg@kernel.org>, Lixu
 Zhang <lixu.zhang@intel.com>, Danilo Krummrich <dakr@kernel.org>,  Johan
 Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>, Quan Nguyen
 <quan@os.amperecomputing.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-gpio@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-i2c@vger.kernel.org,
 linux-spi@vger.kernel.org, 	linux-serial@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, 	linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 11:38:45 +0800
In-Reply-To: <2026101310-scuttle-unison-d4c3@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
	 <2026101310-scuttle-unison-d4c3@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adrian & Greg,

> > This series adds drivers for the NVIDIA LSTP USB adapter: a USB core
> > driver and GPIO, LED, I2C, SPI, UART and BMC-side IPMI function drivers=
,
> > with their device tree bindings, an ACPI description document and the
> > sysfs ABI.

Adrian, what is the plan for this coexisting with the recently-released
OBMF-ICP spec[1], which implements almost identical functionality (and
apparently with less DT/ACPI description requirements)

... NVIDIA also being a primary contributor to OBMF-ICP.

[1]: https://www.opencompute.org/wp-content/uploads/2026/10/obmf-icp-1-0-0.=
pdf

> > What LSTP is
> > ------------
> >=20
> > LSTP (Low-Speed Transport Protocol or Low-Speed Tunnelling Protocol) is
> > a vendor-specific USB interface (class 0xff, subclass 0x3f) that
> > multiplexes several low-speed "channels" over one pair of bulk
> > endpoints. It is implemented by NVIDIA's SMA, an MCU (0955:cf11), and
> > by other vendors' parts: two hub/bridge chips have it built in
> > (0424:4940, 174c:2214). Boards use it to
> > reach SPI flash, I2C sensors, GPIOs and LEDs, a UART and a host-to-BMC
> > IPMI path, on both BMCs and host systems.
>=20
> Also, if you really want to do this in a dynamic way, use greybus, as
> that is EXPLICITLY what it was designed for, and is patent-free (i.e.
> unencumbered, and we already support it in the kernel.)=C2=A0 Please don'=
t
> reinvent the wheel/spec just because no one did any prior-art
> research...

With this, we now have three similar facilities:

 - greybus - I assume there are implementations about, but more on the
   mobile side?
 - LSTP - with an NVIDIA implementation
 - OBMF-ICP - with a few vendors' early implementations

There are differences between greybus and OBMF-ICP that may justify
support for both (primarily: static channel support means OBMF-ICP is
simpler to implement). I understand that OBMF-ICP also has reasonable IP
protections for implementations. However, it's going to be difficult to
justify both LSTP and OBMF-ICP implementations living in the kernel.

Adrian: I could see LSTP being implemented as a set of divergences from
an OBMF-ICP-standard driver, but I'm not yet across why you need static
configuration. If we do need support for both in the kernel, I can take
a look at how that could work.

FWIW, we did raise greybus as an approach to various HW vendors; I
assume there were reasons behind OBMF-ICP, and assume some prior-art
assesment was involved, but I don't have specifics for those reasons.

HW peeps: This would be an excellent opportunity for elaboration on the
motivation there, either for LSTP or OBMF-OCP.

Cheers,


Jeremy
