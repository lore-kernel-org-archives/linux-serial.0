Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338343;
	b=Jv5MmAq41CW2+jzHii1Gy7aCs+fTcjx7Y39pL0b/iGjnN54/Rkz4z5zZ53UAujMKDrww
	 Gpq3s2dQUtr7gx4u6ekhn+bPQsiLGJqJ6NOO5qSrYZ+Y4KvBnSYGnnZ85vIqolNLOk/OA
	 Maj0dRzxpWFgY0swtDISETf7FdOpPaoymgveG1Eedso47okMcekk9y0d3FxPJIDzqgPZg
	 eexSpveVTgn3OTut1s+uhSofKgy11FLrSGfAW0cDFDKhh2rpwTCyZCieYcl+34nPQn6qC
	 hMzSw9w/Hdu8SH63FpUNAAbPuckgDifTzWOqPlZK1ijJOXhONFtC66N+pCZnjXebzRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iqzvhuQcnt+M1uy6q8ZgEZg+92jJlmTF/zBz9tyaOXw=;
	b=S11yUm6POSdMigMDjkWvkARK12OWAC4SWzols8nsit8fWpD7z36D9r6fz7LQOfYY7fOf
	 /OOUMCu04Nu6NOX9rGL0JAMtDcqq2ppFz8oT4+UN2KNPzfWy43M6Pfvk+8dwzvONbcxjc
	 sL1ugcvB+pdxsYbCYTvFBNn3wwk+s5j6e8cyFqzQ4O21dEX8eaSeyASXK6jdbWLWdHvpj
	 Et5YcGfW7I1ApI4GvqQtrY2SV0GLi5zjaIlxYjFMTclwUvj/2D+qlLwLb9olmcNfJrh/X
	 72DWM4z5rozfySf7Nr2ChCRWJy76XEIzeCCjTmmr2wPx3fqO788uqAIV50qJn4mrybw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bB5zxCnA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68390606A31A;
	Fri, 30 Oct 2026 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bB5zxCnA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7441F000C1;
	Fri, 30 Oct 2026 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793338341;
	bh=iqzvhuQcnt+M1uy6q8ZgEZg+92jJlmTF/zBz9tyaOXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bB5zxCnAMbRDPFIf7fH+qrDq6h84IYsxZwVp/YP9NhScXxtWDfbNqfwjiKxGmNH6/
	 LJbMP6M3xBtjNQz4LZ/Gfws6cMsl48OR4Uw+XmriiFRAMPHJ0IIEW0l/0BHbAAjG9X
	 /GRLLc8J6d4wmcFL6VBaQHGcG5HCbgIsVWfyQ8fA=
Date: Fri, 30 Oct 2026 06:32:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Donald Shannon <donalds@nvidia.com>, Rob Herring <robh@kernel.org>,
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
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@google.com>
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Message-ID: <2026103015-stained-shudder-1582@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <2026101310-scuttle-unison-d4c3@gregkh>
 <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au>
 <f3f305a0f3195948bd25ca7eea4348113f998ee2.camel@codeconstruct.com.au>
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
In-Reply-To: <f3f305a0f3195948bd25ca7eea4348113f998ee2.camel@codeconstruct.com.au>

On Fri, Oct 30, 2026 at 12:06:15PM +0800, Jeremy Kerr wrote:
> Hi Greg,
> 
> > FWIW, we did raise greybus as an approach to various HW vendors; I
> > assume there were reasons behind OBMF-ICP, and assume some prior-art
> > assesment was involved, but I don't have specifics for those reasons.
> >
> > HW peeps: This would be an excellent opportunity for elaboration on the
> > motivation there, either for LSTP or OBMF-OCP.
> 
> I have been doing some asking around, and a few items came up around
> motivations for OBMC-ICP over Greybus. My motivation here is entirely
> around OBMF-ICP; the NVIDIA contributions for LSTP somewhat comes under
> this, and so we're working on composing a unified solution.
> 
> Collating some of those items here:
> 
> As a bit of background, the typical use case for OBMF-ICP is for
> platform pre-boot environments, with limitations in capabilities of both
> the hardware and software stack. Microcontroller and mask-ROM
> implementations of either side of the protocol are potential targets.
>
> This leads to the structure of OBMF-ICP being intentionally
> light-weight; the channel configuration (ie, definition of the
> encapsulated devices) is static, and the channel-level messaging is kept
> simple, mainly through a requirement of only one message in flight per
> channel.

greybus is very light-weight, you don't need to have more than one
message in flight.  That's not a real answer :)

> [Greg, this is related to one of your points around why not use a
> multi-function USB device for individual, separate devices: the typical
> device-side hardware does not have support for enough USB endpoints to
> do so. Like greybus, the intention is to be able to support multiple
> downstream peripherals without constraints from USB hardware on existing
> SoC devices]

That's for LSTP, and USB devices are dirt cheap, multi-endpoint ones
should also be very cheap compared to the system they are attempting to
control here.  Don't place this on a "it would cost too much so we are
going to fix that by making the software a complex beast and having
someone else solve our problem for us" solution driven by a hardware
designer.  That's not acceptable these days, you all know that...

> There are a few design points that lead to the preference for OBMF-ICP:
> 
> The front-loaded configuration mechanism means less state to manage on
> both sides of the protocol; the channel set and channel-specific
> parameters (like individual GPIO descriptors and flash geometry) being
> stable over the lifetime of the device means simpler core protocol
> support and channel driver implementations.

What state needs to be managed here for Greybus?  And given that there
is firware and kernel code for greybus already written and working for
10+ years, that feels simpler to me.

> The simpler channel communication protocol is better suited to
> lower-complexity interfaces that are needed for the pre-boot
> environments (GPIO control, uart, IPMI, flash access) than the greybus
> targets for mobile device runtime, with higher-bandwidth communication
> requirements (camera, audio, display). For example, typical platform
> management functions generally involve a lot of short i2c operations -
> ICP messages for these are around half the length of greybus
> equivalents.

You don't have to do the high-bandwidth devices, just be a low-bandwidth
device.  and "size" of an operation doesn't make sense here, it's just
bytes in a buffer that you have plenty of on both sides of the
connection.

> For the platform-boot use-cases, we would need to provide a bunch of new
> channel definitions for greybus. This certainly isn't a showstopper in
> itself, but the specification does not appear to be in active
> development; last change was 10 years ago, and the spec repository has
> since been archived as far as I can tell (and so is read-only).

There are new proposals for the spec, see the mailing list.  And what is
missing for your needs that isn't currently present?

I haven't read all of OBMF, as obviously that isn't what is being
proposed here, I was just complaining about the madness of attempting to
create a device tree representation for a single USB device that wanted
to be carved up into different virtual devices because no one decided to
learn from history.

I have other objections about OBMF-ICP, but that's not what this thread
is about, sorry.  Please propose your own patch series for that and I'll
be glad to criticize it there.

And all of these seem to be OMBC answers, not LSTP answers.  There's
still no excuse for LSTP to be designed like this :)

> With OBMF-ICP's super-minimal core protocol, and the use-case
> appropriate channels, seems like a suitable approach to me.
> 
> The USB-IF has a class ID allocated for OBMF-ICP interface descriptors,
> with the intention that we have multiple vendor implementations of the
> common protocol; we would like Linux to be one of those.

It's always fun to make a new spec and protocol, but getting an ID
doesn't mean that usb-if says "this is how it shoudl be done."  Anyone
can get an ID :)

sorry,

greg k-h
