Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78424729F;
	Tue, 15 Apr 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744615; cv=none; b=UJ5xVIuaqAOI7M/bOzM53eVBHZ/uiz0qhnC0scMUNatxen2I+S0FVh0dyl+gnI88bmfsIgsHmdPfFuUEBRtj8G31Vh2UOu1Y4FpP4H8C/BetG3jQz6Bxs7Eq0emFTz+YQB272pNhJ62IIaseLWSmsOivxhNAM5N26VgUJowmTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744615; c=relaxed/simple;
	bh=7FbUO2HP+oVng33uxir9ExlN5OZMQvyixLWLLllHeGM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SFUxeX9lQUZCzvCA1/WDg2fLmUzSA42691RCIg7Nku4TqKT9rY97bptKocMriyBr7RcK9xSxpYfWI7ytP30l9jUKs6Eq+DhyUx4GCo87KBY5MHg2lWY8JQVP6UIP2Pd9qdL6b0pcDIMI8tC5B8QKVIaItCb23gKlwm0QqvJe/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OhleGdP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYjsNswk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OhleGdP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYjsNswk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45CA011401BD;
	Tue, 15 Apr 2025 15:16:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 15:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744744611; x=1744831011; bh=wKWBw7tFzB
	azlYNeBHUmp7sAO6mkfGaYnxWKhhTdSTo=; b=OhleGdP62z3vMHfQynGIRMZjQ2
	1tgjaypsob+gUCX5p6/Lwi1xxIBNVyMkt/lYksvFUVd2ngr+PBsUkdP40Vz77tey
	rh8C+bSojnssSc0N1lM/QMxMiyVxYk85DtH4SnoeWp34CykpFqkd93e3Tx99qTLe
	G3CdSY0SiS2CwqPOlnKMvCNS6mO5vou9H6FfYwm6Gm9l7Pu6uSYOwNS2IrBrgldr
	FozPB4X6sahsi88RyZE0eegwy9Hv7mKm3y6PSUyg58NEMCTuy9tE/NVNCpcTeuSA
	HrjEBFvPpgz8hfr1i8G1KB+tSyxI6k9wWNNbe6KNUIFIjiEWV5gcif7gSS7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744744611; x=1744831011; bh=wKWBw7tFzBazlYNeBHUmp7sAO6mkfGaYnxW
	KhhTdSTo=; b=SYjsNswkWXkMO7Dqjezk5g06xQ7IYYe3pcLLni4C1vriCPnaEnp
	E0fIkj6ycNSFJc8FXogtMKT7OwAGdX5Iq5F7SIwHs4g5aX/5gUj0BfoSi0WQdADV
	0WreWBefVuQ47Np1UHYk2qJf0+gRSzA9MtBQ0Cn+NlzyqivopPsi+zT273SWMZSL
	z0XROCkJFIruXSK2uW5/OywKptLaI6BObnicCAs3TU3ehkyc+iRJI5qnQSQrzOmZ
	9m0fwYHeetV1pEMPRMiAbZLhFHmZzXmLoto5+tXAlJ+yqCpL/nakKABcy/jgT04c
	2xrbsBW25VaeHb9L+OWFqsvtuY0sKNehcKA==
X-ME-Sender: <xms:o7D-Z1AB1LT7Y_2Is1_ONOhrNafYKZnj6ECzWmiPDPRF9_w371lDTw>
    <xme:o7D-ZziLKFUXQX5Rl9BsrKLuBEVCGurUPwnGOnNK6knCXkcGwGYk86zTByc23-nq_
    PRucjQl7bBA-vc_7Wo>
X-ME-Received: <xmr:o7D-ZwnvV44CFMdPyCIBhSyd2QrHrD0TCckJsPyIBaF4YCP-TB8iS4UtLGqSc16-f3XOOym2CTxiCpX9SVj6MV-7ksW0N4tXdbzTZmbWiJQzc634Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:o7D-Z_xIYguSoj6HH8ylQkCrU3LIj2F6xeCHBeuaOaRYLraR4foU1g>
    <xmx:o7D-Z6Q__zLvw0ddxJSwcb2IppapdUGTU8NSShYA8CmooNfz1BBmgw>
    <xmx:o7D-ZyYN8m00PX7zZveWfUkXncQEpRZxM8ID4BcXNBvuJ3b3BvlR2w>
    <xmx:o7D-Z7ROhc0PSAV1teCMh0xMh8HY_ZMa2Y_RJmAn4txdFTCkPuh71g>
    <xmx:o7D-Z1k6-IilWNtlUxj2-M55E84rRV8o9Rr3i3BGcK-ZhxOFynyO9G1N>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:16:50 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6C2B711165EA;
	Tue, 15 Apr 2025 15:16:50 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:16:50 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vt: update gen_ucs_width.py to produce more space
 efficient tables
In-Reply-To: <f876fe1c-0058-4f96-b6de-9d0a597e1143@kernel.org>
Message-ID: <4rn89r00-8294-092o-1n35-opopo1273qnp@syhkavp.arg>
References: <20250410011839.64418-1-nico@fluxnic.net> <20250410011839.64418-10-nico@fluxnic.net> <f876fe1c-0058-4f96-b6de-9d0a597e1143@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Apr 2025, Jiri Slaby wrote:

> On 10. 04. 25, 3:14, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Split table ranges into BMP (16-bit) and non-BMP (above 16-bit).
> > This reduces the corresponding text size by 20-25%.
> 
> I like this!
> 
> > -struct interval {{
> > +struct interval16 {{
> > +	uint16_t first;
> > +	uint16_t last;
> > +}};
> > +
> > +struct interval32 {{
> >    uint32_t first;
> >    uint32_t last;
> 
> Actually, why not to use u16 and u32, respectively?

No particular reason. The kernel uses both so I picked the one that made 
it easier for prototyping in user space. It is u16+u32 now.


Nicolas
