Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A32DC791;
	Wed, 30 Apr 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024765; cv=none; b=a30GkhikXIJVtBztRGH3XkIxET6aB8R/1pVHrrEJ2QovbpNCEwXmcHIAqWdVuW7AJKxQsjD9epk8pTIATx+NxXwqXKXeHHy06toFVtMbyki+06pSzi/vwJs9NO37wQwC//uySrvFgdvFq0Akh1KNJ2iFcvJlQcgGnuPyGoE2N+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024765; c=relaxed/simple;
	bh=DqfSgVABBGrSLDg2s1B7t16DNFFluwHJ8LLyzrEjwUI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dziXSlyLAgMxqD3Ldd+YZYJKdyt6rdhiOtxMi6G0dmJtBTB2Rl48Xh/qxk++VixoIzJoY7skx0SD8ph0otyZcKjrbrfpZ7vNIba0YWWYlzSntyIBAOfi/p8Aw2O5MruwW28nRmdvXwsKlVg+F0CcDIQlK+k0xmgtSTnkn/7/O54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=HhuEzmMB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzC7jZdI; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="HhuEzmMB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzC7jZdI"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C40625401F3;
	Wed, 30 Apr 2025 10:52:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 30 Apr 2025 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746024761; x=1746111161; bh=KoXlEHKE9g
	NyoZYWrnpH30uGodhBmHO2937ZdEmrIPE=; b=HhuEzmMBrx9bw8IglEthSj47lB
	mmsq2thCawGpfP6d5cOGh7VET8Oi+OSE41K1SqPoBJSAb2Z6Q/RUyFCSZOoSYsNo
	vcgHFhxsdt5bAwoMevghMr/JeDC9GcFdjgKuTYmlLCVit9vh1Ed07qFHfY9xEGUJ
	HkHIvTSWuFBUlQhSgxXkXQKmkTapCD62EuM1gDQ8GdmK1FZnZVE0dmIlqoOanSeE
	LM1NkD2BDNG23RT0YLCPU9cWz9CIQRiEi4ZmFIfmGZLE+1/fCaAzo3T0/mlBAbfp
	jXNWr26o+HpnlAf+7bWqRkGyilcYwa/osBFQxv/MPb2TqKbQZEeCi9iptpmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746024761; x=1746111161; bh=KoXlEHKE9gNyoZYWrnpH30uGodhBmHO2937
	ZdEmrIPE=; b=CzC7jZdI2wowZjH8Uplkb+2IxovqpFSQNvDvgTkDhxiWpp0V0UW
	H6oeKkTJweavclaRwM7Rzia29PVdatBmRf34kT5BDggbUfSTucThlMKH3y+NenES
	5na8UlFyBBU6gTqfbj2B4Czcso74ntQWxqh//1rSsBuZFTOcldokCauJ8+Yz8NZe
	0WMBGAAbv0LzyD3saU5iuh4Fj7JiKS5o8nwxQuuAAvHXj/XRoIOtDKisNWh//dsp
	gIAjgig+LID4hBMPEDpE7Lvvy/+OQC6aNNhJwiXv534ZlNJLdIH4+SRo9a4Q9TkR
	fK46/NUlFWbTda1sjcU5mtnjjX2l6/VyWNA==
X-ME-Sender: <xms:OTkSaNoZKYbTPyscDZbYBUXLdURncUYxUnIsdP-o4WHKEduos9NlQQ>
    <xme:OTkSaPr5pzVHtvfwP1MgW_23mbz0y5c--hw-tkHGTk6DvyXLpsD9LRHDXsqRT4p6X
    zTC7P9lkHG2mKm3oIQ>
X-ME-Received: <xmr:OTkSaKNj9Pjivtqrv7TNzPleidY4oonOjeVMIz2BR990Wd6W4yTDf0WAtHuSh3YWdC5iaBxk8Xa0zkSOALJ6UQ0XtBPuL7xsfkjnhsX8nKEodQlPVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpefgvedvhfefueejgefggfefhfelffeiieduvdeh
    ffduheduffekkefhgeffhfefveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrghhlsegsghguvghvrd
    hplhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsrghrthhoshiirdhgohhlrghsiigvfihskhhisehlihhnrghrohdrohhrghdprh
    gtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OTkSaI5Kugqnlnn4MVAEs1rIHM90sjuTScGsqkDSTVVblZv7fxRyfw>
    <xmx:OTkSaM4WeQuMjyV_v4jQfGTUrAbRoOJc6LgAFNEmtelCH0iJgaO1-g>
    <xmx:OTkSaAhm2tfRfRYRbiDPnlfXuyTfIjafABL2M_l4O6av0XPYelCjNg>
    <xmx:OTkSaO4yppF62XEMYkGsnTpU6cRI_yoCfyDjLq6cZqJ9t-_7jKJsUw>
    <xmx:OTkSaPIjIvoZ6EmjHhAAPOyHq-AtMEYzDrRPfFK-jwGlfxFLalmCojlb>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 10:52:41 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 961EE117534F;
	Wed, 30 Apr 2025 10:52:40 -0400 (EDT)
Date: Wed, 30 Apr 2025 10:52:40 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: add new dynamically generated files to .gitignore
In-Reply-To: <sq7527p1-9218-r845-605n-2p419s2650s5@onlyvoer.pbz>
Message-ID: <47np2on4-875o-21r2-p707-rr3rp30s82rq@syhkavp.arg>
References: <20250430122917.72105-1-brgl@bgdev.pl> <sq7527p1-9218-r845-605n-2p419s2650s5@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Apr 2025, Nicolas Pitre wrote:

> On Wed, 30 Apr 2025, Bartosz Golaszewski wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Add new dynamically generated headers to the local .gitignore.
> > 
> > Fixes: b11a041179e7 ("vt: introduce gen_ucs_width_table.py to create ucs_width_table.h")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

Actually, the fixed commit should be the one titled `vt: move UCS tables 
to the "shipped" form`. And, unless Greg pushes the revert of the 
initial series upstream, the commit hash is likely to change too.


Nicolas
