Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1C12C544;
	Wed, 16 Apr 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809673; cv=none; b=bJh1a2r0cWIazaXr4dozEDkuMQ7T3rw5DZy3IMHfifpAWtY6bVtGCl2vQp5/RpZ/6FgF8J8g4kJHsBxSGwLAum6yVZ1PtgfNg7R4XfS+8rJIMTkzpZaTGg7Rf8rK0gF7a1HvuvjM9NhfWo3w5rI6d4Cn82XIXZOzNdih5N0MAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809673; c=relaxed/simple;
	bh=9OGU00BuIg2xSrPOGkuQ/5fwpOBB91JmL8ragcmbNAk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lsc1x+gpDc3RoIdYUORjpVM1L8almSZITm65oa0y33GS1p6ima0kZ7ZmdZqKXgmjeAIEnwyUYC60bYg3iI3YGFdOy14kBDNQnIHy24SrDHqJruWufaR+ckhU+l9RoUqrYkRhuCYEGyCG1KRyI9ynfGEhbSQ7V87KFxZsmSQZCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=cS4FSn7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBWPrqJJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="cS4FSn7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBWPrqJJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EE65114022B;
	Wed, 16 Apr 2025 09:21:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 09:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744809670; x=1744896070; bh=bmiFHdp0aC
	GUl/sjxmes/f8L4X0PLmmwhNMPyBk+fWY=; b=cS4FSn7ytXTmYOsMtyLsHvTW/5
	7ZZjhwCJPIodTnz01jpQe3RPs0T8zO+kmV7yx04Ov2KIm9TmcanWMS2f/s64x6zC
	rZC1nwNFgAmVqpSJTPYTKlXC5TF3/c+iRSJ71ZaiQYb9eNz2nv1Jn4BizwSrZ/ZJ
	kMsam5C64zdpkNAPNeFOBXW7JaYHzxOCH78Js1BOi2d7N2C59ifdLnMYXvIL3gzh
	sCLinynby8CvmqJ5InFua9c6N8B5glYcT3ncxrxwQrZyODHybcysJDAwslavQq8l
	Gk81NKQUSLdvZz/E2vYCUYdHe426/Ysiq7eYlNdkLZ+v6h6hwRfNfy7y0Zdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744809670; x=1744896070; bh=bmiFHdp0aCGUl/sjxmes/f8L4X0PLmmwhNM
	PyBk+fWY=; b=MBWPrqJJS+tIirxwFTcfcjaldeOKJ1uBB+fO4daSJWRXNJPtTkK
	KD+ARoAE/b5IS6wMD4h4Rq6KwFDWsp2cKVbPcEMHqA8IMFfdGv99t2yV9lGO5WFe
	cHMO2WR5vrAJrUHAsWaAeJQEBUnQa+9FCmVOTr9PGcWzKJhNb4/FUq6QgJQPIhme
	zt0hmBHHeCsIS6Il5Mp74fRYBmszsB7fLrnHLLI7Wt7anUS7NxGt2Cr9fpzil8Xb
	5aGAehBBYtM9eaAkk1s5/kO63yqPr8O8EBZDHdRwnEGx5ob3FGwiMX1TnHvbMWsR
	QSXyQvw4Jr95mMthFzoQ9TbT5UJM7P6jeTg==
X-ME-Sender: <xms:xa7_Z2MKa5iZBQyty_JD8mQ9djpg9ldyMRzj6cCPO1TkarmOiKISiQ>
    <xme:xa7_Z096IsZBrj9zMRLJ_sCgfs7RFkOM4n3mxb9HHxj6cGiLRgxpalzJUGGy2aIuy
    VanKkfrNcXHjRq3t2g>
X-ME-Received: <xmr:xa7_Z9RlxZB6pg1imZ2bZF2h1UdGdGP7cGbG1zds2JlB_gs4_aeL3glmNrS9vPjrkWspbtBXDMXIamWG84u7Ue0sP8L3-ep_T-nGbJ5dfa0iTQpbsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdeh
    ffduheduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirhhishhlrggshieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xa7_Z2s_3PkruazCt2a5khmKN5mBbFrQcLziTTbURS0csReHobA6Zg>
    <xmx:xa7_Z-fmqMBglc-bPkEfwVnfL_1CsJpVfO3Yq8yVhqWuFO_8pC8c1A>
    <xmx:xa7_Z612OHeYGa1RZ8TDJoQUoGMm6o7wfN5qYdzJzapfJThxFPqyWw>
    <xmx:xa7_Zy-Hw11kaCYoGNafC0jP7tsll4XsHmsVnTR5kUUoFex65MRddw>
    <xmx:xq7_Z4wgf5sL-mJ_CtzO-49r8vgj09tLYQuJv6OnXeVVRaFD4gNcvhbd>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 09:21:09 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2D294111859A;
	Wed, 16 Apr 2025 09:21:09 -0400 (EDT)
Date: Wed, 16 Apr 2025 09:21:09 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] vt: introduce gen_ucs_width_table.py to create
 ucs_width_table.h
In-Reply-To: <c3c20d22-4755-4335-a600-4966dd50ad7a@kernel.org>
Message-ID: <qp97so2o-ps44-rr09-46os-148r3pr104ro@syhkavp.arg>
References: <20250415192212.33949-1-nico@fluxnic.net> <20250415192212.33949-5-nico@fluxnic.net> <11e8bb4a-24e0-4347-abea-e200a59a744b@kernel.org> <c3c20d22-4755-4335-a600-4966dd50ad7a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Apr 2025, Jiri Slaby wrote:

> On 16. 04. 25, 6:14, Jiri Slaby wrote:
> > On 15. 04. 25, 21:17, Nicolas Pitre wrote:
> >> From: Nicolas Pitre <npitre@baylibre.com>
> >>
> >> The table in ucs.c is terribly out of date and incomplete. We also need a
> >> second table to store zero-width code points. Properly maintaining those
> >> tables manually is impossible. So here's a script to generate them.
> >>
> >> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> Actually, could you create a makefile rule for this too?
> 
> Similar to what GENERATE_KEYMAP does in vt/Makefile.
> 
> So that you would do:
>   make GENERATE_UCS_WIDTH_TABLE=1 drivers/tty/vt/
> to let the script generate it on the fly?

Sure. I have more patches coming up so I'll bundle that change with 
them.


Nicolas
