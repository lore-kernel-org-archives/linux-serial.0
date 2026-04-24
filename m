Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F62E1F0E;
	Fri, 24 Apr 2026 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020896; cv=none; b=nazWpYDX0cwAck1/6WgfYIlwZ9nWTwrn7xyOMGoc1BMIpJw1G3GE5t9Hev3IA3KlOBqXh4hRSTY1BhmtIJf4ilS+tsDOYa/wCY4vsOLuycPSBsr2HOeDrRBa6Spxu0Y4O+y53Xa8X692RgMCrGwF2htc0zHjKCqFXMSwPTImZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020896; c=relaxed/simple;
	bh=Ut8QNhBBEel3DXviCPKsyQ47X/HsgXFi/0/Zh+EVM/0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Cqmzlc+HDkvxBfUcHy9eIecr8qO+HsNlEB371bfJXRwkNKaIaKwyVqv1w/g3P5YbTGJhefR8LNDWIQnrB8w4R9QzYjTVIAVQq0n60xSr+XLAYcElADuwGwyvvL983aRQmVLvAUnPQSV9gLInMRPSP/4zSJwPJgNfkU5Y6ErC5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Vxhoj+jD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucGkRF3d; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Vxhoj+jD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucGkRF3d"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66AC47A0129;
	Fri, 24 Apr 2026 04:54:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777020892;
	 x=1777107292; bh=hDlP8y8oJfAzwiriWyNXaxF8PNjiFivBJXX2WXCxPWQ=; b=
	Vxhoj+jDQThNaBN3A0wYJrBZQVfAvaeIBhrBatMkWC2/kkNDZ7eVboZribHL84Gk
	Z2II62yW3Z154p5LcRS/EBPk6XYqESbvuxjTAE/JRGg2chHaWsou4YXt5gwd9akH
	rg6g3+TE2uTRoKAbK7nP6YUj/Vb1B5Zru0tD7AWsrYcYN9jxjun7aui9T0pM9oO+
	m4+67c4kKp8WAwmxoBJFJGvdhX+OF2tWKLeUfnXydOvJRvzbUPXJoXwLnUawtUrL
	1ioe+Qq4H0cj8el4wvuck7AVBVIEWzDfJaTYgtFyxZ2Q/TiGpdMHjscJH+GBjI8L
	GYkZftPgpcDVtrXn/A5W/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777020892; x=
	1777107292; bh=hDlP8y8oJfAzwiriWyNXaxF8PNjiFivBJXX2WXCxPWQ=; b=u
	cGkRF3dtcivkq7R/h1UtsQ3V0Rd3zT5GxWqVEt5taeGENmTcXVAnDIo56Ss/A1Mt
	svvOzZ8pPoMS4G00FDbRtXQEGvN5PNG9R+2DF/WIkCmORfsCxKtiG5AXDzeytdIS
	i9qTgkHBFSRsaH1A+xB9lfEgVCufshADpXNnYE1vcAoxpZG0UpGntE1dRmKfWiMx
	fpgTYFp9uUhepRfScqD6TqS2KBL96oRLiylytKMSXj/aADu6vROTAT/trTZqlEhS
	/KV6uenyD5sWM8Qm9ObV/Fmqj2KsfoniWs8QOj6GksYlOI737av/jjuu/269x7i8
	L/hlKKwdmYFUVoFJWSXrQ==
X-ME-Sender: <xms:2y_raRexXU55OfgzDqZmFJV1vD2xyDg3RucKZLkm9J_JWf3CZD7rzA>
    <xme:2y_raaDkwZkbg-xZglrjzJ-G4gY5RkomaWh6CQXornCtGwrJtoJDLnvalOZ6uguxH
    tvO3BfeKxXQN4SfBH1R5vSBNJPmv2p-wFwccHMCmvKUQo15SIxmwZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:2y_raTg-oLq7z23uFnT5LQ8pf2PQAxekJTje9QHXbtbBzrhHWGQ5fA>
    <xmx:2y_raea3M60xVRBvsZG6KSm_KKZBupGnMZ8oOrGOYwaRinxEos785g>
    <xmx:2y_rafGpsa3rbSAeUpGn0L6bd-FS74ff7OLTFz9cgYW-pTQ87ANG8g>
    <xmx:2y_raTZ42_tE0JvdJpKYMgNPgJGxqfnwKLSVzb3ORsbfXhpGx8LCfw>
    <xmx:3C_raXpkK6XsJJv4ahSNjJaaJcp19Z3-bcksbi1eu__DcapeCDOv1EOd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F1AA700069; Fri, 24 Apr 2026 04:54:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Agn-P3jpxnXN
Date: Fri, 24 Apr 2026 10:54:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>,
 =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Russell King" <linux@armlinux.org.uk>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Drew Fustini" <fustini@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, soc@lists.linux.dev, linux-serial@vger.kernel.org
Message-Id: <30b96e0d-f296-4c31-8701-a15c568ebffc@app.fastmail.com>
In-Reply-To: 
 <CAD++jL=_eDY_mG_QBreSrZiho0hUrDSciedq=vrxXaTiMwrSyg@mail.gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
 <20260421-send-v5-8-ace038e63515@gmail.com>
 <CAD++jL=_eDY_mG_QBreSrZiho0hUrDSciedq=vrxXaTiMwrSyg@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] ARM: defconfig: Add a zx29 defconfig file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026, at 09:13, Linus Walleij wrote:
> On Tue, Apr 21, 2026 at 10:24=E2=80=AFPM Stefan D=C3=B6singer
> <stefandoesinger@gmail.com> wrote:
>
>> This enables existing drivers that already are (UART) or will be (USB,
>> GPIO) necessary to operate this board even if they aren't declared in
>> the DTS yet.
>>
>> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>
>
> *I* personally (as SoC maintainer) think that having a few more defcon=
figs
> is fine, even helpful.
>
> But I would defer this to the more senior SoC maintainers because I th=
ink
> their stance is something like:
>
> - We have multi_v7_defconfig for compile testing
>
> - We know that binary gets way to big for your system: it's for build
>   testing and perhaps booting in QEMU or systems with many MB of
>   RAM, not for actually running it on products.
>
> - You are encouraged to keep your own defconfig out-of-tree.

Right, we clearly need to do something better than what we are with
the general defconfigs, as I'm sure many of the existing ones are
never actually used for booting a machine, and are horribly out of
date with the Kconfig options.

I wouldn't object to adding another defconfig for a new (or revived)
soc family, but I don't want to have more per-board ones.
Overall, we have about 70 defconfigs and 55 soc families that have their
own mach-* directory (plus a few without code), and the number of
defconfigs alone makes it hard to keep them up to date.=20

> However I even challenged this myself by adding a defconfig for memory
> constrained Broadcoms a while back (NACKed/ignored ;) so if it was all
> up to me I would merge this.

I don't even remember that discussion ;-)

One idea might be to have a tiny base defconfig, plus platform
specific fragments that add drivers. The problem is agreeing
what bits are essential enough to still get enabled in the
tiny config.

       Arnd
