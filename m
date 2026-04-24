Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9B2E7621;
	Fri, 24 Apr 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016952; cv=none; b=uaYrabemuJnaMMKHVKZSlvKfYqDjUkvdzdnKgGdU7ehKfpnmSvC+3lcoUYhf91Z6QHiyTNRPEvAoFnjQf4M5qO3XrKVtdFTde+DIiP+cF9WUuWl8pyXlpILLESboh98KmcMbveVP6BB17HMnzbMDpJG3nmQ3joHQsvjuQSUj4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016952; c=relaxed/simple;
	bh=r7RsJ5sb/MT9MYCLg+vdD1uZXXVKVItyvT+VGFvHmQ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DHTDh+irf59Rj028SMEZk/v9Ze4XfdAZ+xk8O5GcwV3bTZ7EI7pXVAz4QXLTcfbQEZ7nqBp8HagIpzW01S5FgczL8eVo+x+ZGG73U4aT30DDFb8GyTWpt/jm8V82y47/8xPfpad+qMrGqRzuGmK3ZN9dO7JMx6in+HN5MD9Wi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y+Xr8a0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQ4a1GrW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y+Xr8a0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQ4a1GrW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C12AB7A017A;
	Fri, 24 Apr 2026 03:49:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 03:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777016947;
	 x=1777103347; bh=EozbsZSSP6ZvwNKdXdLdOn0pJH1icPbrx4/xWiYmdR4=; b=
	Y+Xr8a0QQxGHHqJy/OgQOHxQFESwA4zUTbhC/HkusRADPE5EwW+7COmWCjeURh5T
	PT136/amna3mF9wANGJ81ARXIPnMUbpZHq0x924VURstLkmss+grd93UbtLOUrrf
	EirLZTwd/3SmDsucKMBaO2LDooVZW612X1ciJpeQWfuhddnR2Akw00xFNkdoUoe6
	Q6lQ7RU2kqRNj5+l11Ca4tCX1kBliAHrqDT8QdkYYzQhx6M9o3O/Q+cKpmmcK4Jn
	wh0P3Hc5LCHQmhW0vkQlODCDqLTq9CZW0whkeYRb8lTNbinD7B7BsfG85E7Pd8DY
	D7w56A3VH9OzeeQdJoJQ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777016947; x=
	1777103347; bh=EozbsZSSP6ZvwNKdXdLdOn0pJH1icPbrx4/xWiYmdR4=; b=o
	Q4a1GrWoXC/RVqBTfE4T7SJGPmZ3okUD3z79m0kipmYdewop39P3l5ACoxeoADD7
	4HxDyP/3kiCW+A1gbm1gOTaJMoUszkwLJ5d0fcNSlm43wGw2Ekw8kVLMxxO2GZuW
	Z4MwlzZ+H1+eodKker1xUUshsLFVhu86vbvw6lt8O/PhuZ9bSoOCvrAGZTXhRi3h
	6ts1FVirIgjeTmDCqDdzKpTJ8gIC6cd6mTh6rChGRLfD8LvoNhOjrY3x4E66REgx
	dL/tJ1SjMSCZLGbVsM+QXscHMyheX2NM8C9pfxxv3BwhRmGKvhR7MRkvx/bOkJpe
	blYNuyxutY0oiVf9GzyAA==
X-ME-Sender: <xms:ciDraZWOtV9alUZEXUzTVZXIhm-bh9CmWC1jnQm9eJWKVLG1gmIT6A>
    <xme:ciDraUZnUmFlfNlOhMGPVTuajnwafaMu4fIXto2oZsyuAQxOk2hk8Aejs_x98dPtH
    SqEBCwZmHWmZZJGF5EGjlEFnbrWRVCCohHoVAfYUlFfgIfii3rLZ6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghp
    thhtohepshhtvghfrghnughovghsihhnghgvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhushhtihhn
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsfieskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ciDraea-vSscag4fGeHgcCHabcqfv3vsu-RbyG5kcmk42VxS47pQ4g>
    <xmx:ciDrafzVx9yYCRunIwi8PmBU1Sn6LlktqJ2L1Aq339LpZXDs0ssCEQ>
    <xmx:ciDraU89EtN2tYSfA8j-K59LF5QKOazX2j5OOalrv6BBE-8e0aQNgw>
    <xmx:ciDraTyrCAnA3FKHHhd7ObJmljUlMQs4qe9mJIKbeg0gq_a0_8AkpA>
    <xmx:cyDrafiQyOa0uHLc46Aat8vxgHAw01vftTl5WUtSzu5JqQSZlHR92dwY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91B02700065; Fri, 24 Apr 2026 03:49:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Agn-P3jpxnXN
Date: Fri, 24 Apr 2026 09:48:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Russell King" <linux@armlinux.org.uk>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linusw@kernel.org>, "Drew Fustini" <fustini@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 soc@lists.linux.dev, linux-serial@vger.kernel.org
Message-Id: <61452117-0cdc-4ec2-83eb-dc03ccbd410b@app.fastmail.com>
In-Reply-To: <20260421-send-v5-8-ace038e63515@gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
 <20260421-send-v5-8-ace038e63515@gmail.com>
Subject: Re: [PATCH v5 8/8] ARM: defconfig: Add a zx29 defconfig file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, at 22:23, Stefan D=C3=B6singer wrote:
> This enables existing drivers that already are (UART) or will be (USB,
> GPIO) necessary to operate this board even if they aren't declared in
> the DTS yet.
>
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>

I'll reply to Linus' comment as well, the defconfigs are generally
not in a great shape across many platforms, so we should come up
with some better policies there.

Either way, the patch description above should at least explain
why you think you need your own defconfig, as we don't normally
take those.

Some comments about the contents of this file:

> +++ b/arch/arm/configs/zx29_defconfig
> @@ -0,0 +1,89 @@
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_BLK_DEV_INITRD=3Dy
> +# CONFIG_RD_BZIP2 is not set
> +# CONFIG_RD_LZMA is not set
> +# CONFIG_RD_XZ is not set
> +# CONFIG_RD_LZ4 is not set
> +CONFIG_EXPERT=3Dy

What is the reason for CONFIG_EXPERT here? Can you avoid this?

> +CONFIG_CMDLINE=3D"console=3DttyAMA0 earlyprintk root=3D/dev/ram rw"

A definconfig should normall not rely on earlyprintk, just add
that when you actually need to debug the super-early boot
stages. With "earlycon" it should pick up the right console
from the stdout path and work almost as early.

> +CONFIG_BINFMT_FLAT=3Dy

Are you actually using flat binaries? I wasn't aware that this
is still possible on MMU-enabled kernels.

> +CONFIG_BLK_DEV_RAM=3Dy
> +CONFIG_BLK_DEV_RAM_COUNT=3D4

The old ramdisk boot is going away in the future, please use
initramfs instead. This should also save a good amount of RAM.

> +CONFIG_DEVTMPFS=3Dy       # FIXME: This is specific to my initrd. Rem=
ove=20
> before upstream

stale comment?

> +CONFIG_CONFIG_TMPFS=3Dy

Typo?


       Arnd
