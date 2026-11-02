Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598962;
	b=YavxbU5EMo1ezAd4Cj3l8VBm4jRbc+w+2nJCDUqF7BApcpVMNppvjcDvKpAzBb++nwsq
	 mvjJxwP7e/4xrt1U4luzeAZYrYzB9eSNnlMGKmP8krumpu8sW/DU548stjQNUX5rz9hrh
	 fbadN7rbs9zW7nyU+zDORh6K6ryHrOFAFteAvE7i2W5XPny9JwF6c103OlRFwIO514rIe
	 zE0Jl0+00iYELKUbxHgJAISJuIRKFeCYEuJQiJtwMJzkZeDX+brt6LfAElaL3bsVKw292
	 ITomeniGyHb+1veNHQtPWWQeSRrDwWRicjVQ4tfzaCM0WMaMZNWIYL2fCAkh37M/wVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598962;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=galmyEn4LbKSLuawhs4ZGQeiueItg3W/HcKq5KP6Bgs=;
	b=vzkMZdVvmgQyjU5YcZ01n0KmtEVBlLrTtZxF/afaprf07O57UsshoN1T6bqH2ts4/O8T
	 8W/ZYio3AKMohrNDA0hYdgrNeMaUEiwYpugTCmrsR+q2YWnGSIPwD9Rnh2SGhncQCskjA
	 srrm+R+RgmsBCnYDpRHJwnzUhavayJH7fB7tiHBOrYyplbILYR9neHQ/3dmi3gIWsTXXr
	 i+VO1Uxq6+j9mP5hGNo5sWhjGLU15L6acyRnoypPfAWoetXc3Gz0Y63n5b57j3nu5cGNy
	 royho+hP6GnIcuF3apjkTT+ddD4DzsQ7RalOC7qu6KgBGmp14uYqsTF+3A6oWypWcYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=joEgN+t6;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA3606A326;
	Mon,  2 Nov 2026 05:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCA3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=joEgN+t6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793598959;
	bh=galmyEn4LbKSLuawhs4ZGQeiueItg3W/HcKq5KP6Bgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=joEgN+t6NvoovW7oKCyZDr2eqdix+/duqp4PMFPCW3+RRwMNBkk04YEGTrQqXFBfa
	 tCJu2UBAyLCb6xV2/OxjkIAgqYEwt8p4FKq7NIXZ8waf1xyRvl97ugJ8Az60PQtVde
	 NvMCCJ2xvX1Y80yfKQIMFQPgliXk6vJBrQiVp8GlhsxUBGqyqXyFYipUEdra2x9jW6
	 7tbTiIxaXd9V6tZX11NmuzG84SPnnozNpGRH4UM+InMJfNnB/aLnlIf/7VxlhdH9xn
	 720JtOYjZ6d7n7DjPBBG7Dva9h3DRuPJgRgoxCI6V889anGcx67nbuYl1n0zXg5WFV
	 FmmJo+qfQ9KKA==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6A55B648DC;
	Mon,  2 Nov 2026 13:55:57 +0800 (AWST)
Message-ID: <06e25064f8a5455c12b47033a1a62b94100e7590.camel@codeconstruct.com.au>
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>, Donald Shannon	
 <donalds@nvidia.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij	
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Lee Jones	
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Andi Shyti	
 <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, Jiri Slaby	
 <jirislaby@kernel.org>, Corey Minyard <corey@minyard.net>, "Rafael J.
 Wysocki"	 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Sakari Ailus
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
Date: Mon, 02 Nov 2026 13:55:56 +0800
In-Reply-To: <2026103015-stained-shudder-1582@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
	 <2026101310-scuttle-unison-d4c3@gregkh>
	 <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
	 <f3f305a0f3195948bd25ca7eea4348113f998ee2.camel@codeconstruct.com.au>
	 <2026103015-stained-shudder-1582@gregkh>
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

> I haven't read all of OBMF, as obviously that isn't what is being
> proposed here, I was just complaining about the madness of attempting to
> create a device tree representation for a single USB device that wanted
> to be carved up into different virtual devices because no one decided to
> learn from history.
>=20
> I have other objections about OBMF-ICP, but that's not what this thread
> is about, sorry.=C2=A0 Please propose your own patch series for that and =
I'll
> be glad to criticize it there.

OK, fair enough - I'll defer this for an OBMF-ICP submission, rather
than piling it on to this LSTP thread.
=20
> > With OBMF-ICP's super-minimal core protocol, and the use-case
> > appropriate channels, seems like a suitable approach to me.
> >=20
> > The USB-IF has a class ID allocated for OBMF-ICP interface descriptors,
> > with the intention that we have multiple vendor implementations of the
> > common protocol; we would like Linux to be one of those.
>=20
> It's always fun to make a new spec and protocol,

We seem to have different definitions of "fun" :D

Thanks for the discussion so far, I'll follow up again when we have a
series to propose. That shouldn't be too long.

Cheers,


Jeremy
