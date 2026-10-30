Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333186;
	b=nhJNCfRsCGodx0/DCc2AH9WdxAI1FKGGIYskSwSIgqv9D0k1QcndYc4mtqzU8dpv7lIM
	 PvcdfgYNXolGwyCp3fyl4D13PjNg5j9+dO0iBrQNIbbRDYZMpJiKZTLw3pVJ6OAwj5LeA
	 ADsby87dcFGrkmHnbGcUBS0QxNTg4znOiypNvIdzupkjgFT+20nzTfJhFY4LbOdGQ24Q3
	 Xgpu3ovWK5mE9RhetQ1ZhtqQQk348JRjRBJIYhKJYWpKRl+3EsUeNfKi2T9SrbIcaNxQ0
	 9uWiXdCHFaT2bnjF/UPKihCHn78TKiogdCiciUB7SSyn60S6n1DHU5HQ+3trH8czZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333186;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=grdHjhMd7QvaUC0XVPHxOaowqqDmcsmw2rXkQG3QSuY=;
	b=p5IwRt9xXXFcUVbokMtt8i2NuT7ezLxx+tiNvYyB9bnADr2xxI5LUbgVmCeyvy0cUV/L
	 4uSpsmGSmuBruijVgiyl9OFB2nBCv1xSMMdUSxvxTsNm2Bh3PKt2qZiWbmNAH3GCt3G8S
	 U48ZJeSAzKoNO2frzp/2r1tN4p+1/F5bYMxcUORKazl8/LC98pYd4A1Y/pIvedpIKUqyU
	 MrRXet0MIh+9tvPQJsyhOKsSrtv9dtlpu3VrM1i6oyeh1dzGPC9DZFUnZrkAoo+SVM9kG
	 6JbpLbj40mX42eTcBzEhduCgq+pB5o9aDN2d2bB9ykkFao6gFo6r5NE8HKPQ+tuYGLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gP4O6XbB;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C6606A31C;
	Fri, 30 Oct 2026 04:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gP4O6XbB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793333177;
	bh=grdHjhMd7QvaUC0XVPHxOaowqqDmcsmw2rXkQG3QSuY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gP4O6XbBNP3E0tCn55RYSkni7rxRKdrPd+cAyKq7Q7ka6AX+fl+13CnYSbEz7qfEV
	 LUM/eSwndXbzayTZMnEAp911V2klLbt5RdolBTtGj9AJTcE18qFP1hOh1I7GA16LN9
	 PECOUTfLQgdUDd06Osrb37D8zntZ+Lgd9AICm5Z3Z9dkLnvotzrpcjxQseRVizJ4Ja
	 5Ht44VRDHFQXUOgBigtuRcLyXFEmMcx7oavVBo3fsC6Yih5Gp6XxAiuSXecPSpLKUg
	 lTfO1PMhHtvMi6NObu4pDTT21lbh/vev1DcBDlJCjrCS0cRbkFOrTlFJFvpNXcQ1Jn
	 7NZqQTlVp2x1w==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8496470E87;
	Fri, 30 Oct 2026 12:06:15 +0800 (AWST)
Message-ID: <f3f305a0f3195948bd25ca7eea4348113f998ee2.camel@codeconstruct.com.au>
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
 linux-kernel@vger.kernel.org, Bart Van Assche	 <bvanassche@google.com>
Date: Fri, 30 Oct 2026 12:06:15 +0800
In-Reply-To: <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
		 <2026101310-scuttle-unison-d4c3@gregkh>
	 <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Greg,

> FWIW, we did raise greybus as an approach to various HW vendors; I
> assume there were reasons behind OBMF-ICP, and assume some prior-art
> assesment was involved, but I don't have specifics for those reasons.
>
> HW peeps: This would be an excellent opportunity for elaboration on the
> motivation there, either for LSTP or OBMF-OCP.

I have been doing some asking around, and a few items came up around
motivations for OBMC-ICP over Greybus. My motivation here is entirely
around OBMF-ICP; the NVIDIA contributions for LSTP somewhat comes under
this, and so we're working on composing a unified solution.

Collating some of those items here:

As a bit of background, the typical use case for OBMF-ICP is for
platform pre-boot environments, with limitations in capabilities of both
the hardware and software stack. Microcontroller and mask-ROM
implementations of either side of the protocol are potential targets.

This leads to the structure of OBMF-ICP being intentionally
light-weight; the channel configuration (ie, definition of the
encapsulated devices) is static, and the channel-level messaging is kept
simple, mainly through a requirement of only one message in flight per
channel.

[Greg, this is related to one of your points around why not use a
multi-function USB device for individual, separate devices: the typical
device-side hardware does not have support for enough USB endpoints to
do so. Like greybus, the intention is to be able to support multiple
downstream peripherals without constraints from USB hardware on existing
SoC devices]

There are a few design points that lead to the preference for OBMF-ICP:

The front-loaded configuration mechanism means less state to manage on
both sides of the protocol; the channel set and channel-specific
parameters (like individual GPIO descriptors and flash geometry) being
stable over the lifetime of the device means simpler core protocol
support and channel driver implementations.

The simpler channel communication protocol is better suited to
lower-complexity interfaces that are needed for the pre-boot
environments (GPIO control, uart, IPMI, flash access) than the greybus
targets for mobile device runtime, with higher-bandwidth communication
requirements (camera, audio, display). For example, typical platform
management functions generally involve a lot of short i2c operations -
ICP messages for these are around half the length of greybus
equivalents.

For the platform-boot use-cases, we would need to provide a bunch of new
channel definitions for greybus. This certainly isn't a showstopper in
itself, but the specification does not appear to be in active
development; last change was 10 years ago, and the spec repository has
since been archived as far as I can tell (and so is read-only).

With OBMF-ICP's super-minimal core protocol, and the use-case
appropriate channels, seems like a suitable approach to me.

The USB-IF has a class ID allocated for OBMF-ICP interface descriptors,
with the intention that we have multiple vendor implementations of the
common protocol; we would like Linux to be one of those.

Cheers,


Jeremy
