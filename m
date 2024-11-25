Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3C28689;
	Mon, 25 Nov 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550364; cv=none; b=NJK0CcfDkYj9Dyoxedh+AHS0IfbNhEoSz67JHz2SzFqBcEvsONs4ZW2J1Sbsza1kfwEAcMJnB8qQRJexAR24K4hgFFJ1SEDADmdwNdD3qPvSuQjHfZnw4KbzgrM+Y+uJl0tLZepLLR0nLr3XGgdAQt3dJ6bPx7XFfvA0bvjexo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550364; c=relaxed/simple;
	bh=zws4g4V3731tgjPITUbaPsVN08n0nwJspuqfdFZJbP0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NL6WQAYTmHGAv6TNJrDx7AEYfA48LWAayYXfXoQqESIZCLItsmsJRmdugqMogw33Y7hVR0MXXwtqPAACkPMYsm4WlgQFupYBowExyube0B8UAn8RUH8f4/+HCOVt+pxx0R/loHrc63WEze49GFgyEyjfXVee/JI8UC2efJZ3EeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOGr/xsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOGr/xsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F6C4CECF;
	Mon, 25 Nov 2024 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732550364;
	bh=zws4g4V3731tgjPITUbaPsVN08n0nwJspuqfdFZJbP0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eOGr/xsCjdyRqfOimzvQwdr0QJwtpRdujIkakk1oapGFJDH6yI78DrGX3nRvlTiwe
	 p9TiaRs+Fll22ctBWgGSSxEBBdA2CvNRxMHzOMeMZjHD08fYumT4oDCnx48o5aYYCS
	 ACMKhOW+X/osnxcKoheaE6oPe4W46S93qWOGD7r5kR3FltHa2lnvYaevkrs4Y1ZqHZ
	 WokjPbYHmG/9ENwQ1P6pWVlH0/764znkVjuFuH30bH9lvGWm3vBnMjwWZRJF2V8Ahj
	 w6vqularQatGTsXAlgwOVrX7M54iyD+0ttgTh5VX8gmUPWLV2ULiu/ysX98wC2/73a
	 RtaJRkf64B45g==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1D211200076;
	Mon, 25 Nov 2024 10:59:22 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 10:59:22 -0500
X-ME-Sender: <xms:2p5EZySfbdE3uJABNvDQ9tCSBEOCJgPBJsZ5y_K6644uh_1SqPGGkQ>
    <xme:2p5EZ3w2zd1p9dYiU-iBvwsYoCQAECZ-QKrQg1sL--gMpZ992P0pdzY2-ySH2TUm-
    eG5EOEEepd0IKvP6ZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohephigrnhhghihinhhglhhirghngheshhhurgifvghirdgtohhmpd
    hrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehstghhnhgvlhhlvgeslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghn
    khhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhlphhordhjrghrvh
    hinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2p5EZ_3yA4koQxN7csbRwSud8wTAuCeD9j0SkP9DZFPC0SATlZvtuA>
    <xmx:2p5EZ-AvHY-fvqkZgP87mlBQhh1yX5CfWayqqg2YYFWs850lQH_iYQ>
    <xmx:2p5EZ7hmNMfj5SYSgN8lUicGE2POS60eF-OGnWBEpXvfI4aKUZfBWg>
    <xmx:2p5EZ6qoH6gzs__D99KHPkFDSittrVfCvskO0AqZSDg-ilfpDyHaEg>
    <xmx:2p5EZ-gdWWIpOmL_-CxUUa3WtRY23m2JNhO1edDHldUckdaAR485QqUj>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0CD62220071; Mon, 25 Nov 2024 10:59:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 16:59:00 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-serial@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, "Yang Yingliang" <yangyingliang@huawei.com>
Message-Id: <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
In-Reply-To: <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 12:06, Arnd Bergmann wrote:
> +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;
> +

Unfortunately, this breaks on non-x86 because of the check
added in 59cfc45f17d6 ("serial: 8250: Do nothing if nr_uarts=0").

I still think it's the right idea, but need to unwind further
to make this possible, and find a different fix for the bug
from that commit.

      Arnd
