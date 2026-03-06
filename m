Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E03A6417;
	Fri,  6 Mar 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821619; cv=none; b=QzohwrgvKAvl1eXex1JZnI/jpiCBD8589JmaGV68klue4rE5EGffBCzs/uRn5Ml3JMK/i3vTpeyt4GhVHo0YSSKVUn5KSuVyBVupdPMKFYKxMB/518634xjcGvIBL/9vBE2az9j5MMdMsLzL+q3ICl17YclHQ1Du3vxkP5ecbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821619; c=relaxed/simple;
	bh=Xic4JScc+HczYdVeIJOJ5z8RqGlXg19AXzcet5qEv+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DbXM1AwCPNNFPq7sq5MDfuMmtHHJ2gbhzb1VoDvuH4Eu4GIfX8TJV2Z4Jqyx+qwToCmThdkAFDJWy+Aq1hhMTpRmNK1XAi2+X2vtS9KbjC12cTyAPn4RaYDv7dHo8CGz2rKdJRonwYGTycVazt2kIivCii2H1dIY/wJRkojSC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=QlxV9oaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zGTby8DX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="QlxV9oaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zGTby8DX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D127EC0B09;
	Fri,  6 Mar 2026 13:26:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 13:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772821617; x=1772908017; bh=d2dBi7+JXs
	vxBUP4ILT5DEfKBiIKi9m4rSdVWFxncJY=; b=QlxV9oaW/RT3c7ZqYfA/8lLRsZ
	eDUaPNcJ8y5AUWI1oFHYS4/UEu8szsZ11cIQSeBNOeNTnbg+mTY91wcbQ7IbjEvr
	tRwYc0Bqyf43/CTr0HmdeXtohXfyKxJv2BpEw2vp6DwsxZRLY+RvIGfb2TC4NPey
	vhSFpdpxlMB+hUTgB+BcW39ot1c0JqKfPg84GVIqMEDGouSeyk5V0Sc20eF+xaUG
	0dyMq1hvNVocuDhTUtGJbrMoTN7zA9nI86HRI1DKBXkSjza7e8IHDwufvX/Qtq+E
	AHIXO+zTlPrRnFuqqJ9VDNQDLFEjly7o6x197IWzIdX+aku2QUxwyC/HCRSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772821617; x=1772908017; bh=d2dBi7+JXsvxBUP4ILT5DEfKBiIKi9m4rSd
	VWFxncJY=; b=zGTby8DXFpFZTh+6VXMxhGg6K/FUqyfbpVz3qvZq8tehpvSyyd3
	dbhLvAXxuUORVZGbjcM9wST9sZ5rC/nGntKFFGoQ2UQLdclHzTlxW9X0InHIPfqF
	26U7BWTqgjCcypdSdvGVkak7xBJZJnxu7wtnpDQxtKf5kiUU7MYcQayPP27qHkE6
	egjvWW/OIQPk3VUHlxSM758vdCO05ohjuOtil9xksatuQq60ZnXFiHumWrsBrzCm
	rBysrKYfiwaC6H7SGR6XJs+x7LbELIQur4Y9GBnoZ+BWHeb5AZyIdziLoMbkel7c
	85vRpLKGYBB8d/SbC30DnsCR8PoCCDTI3Dg==
X-ME-Sender: <xms:cRyraRyg0ypju4KqKPL4enaPiapToK1eftPmbkyGgzE65Re9ZLP3Lg>
    <xme:cRyraSx-ZcVgUZzcFmoLUnYK1qEaADFBOHXZZiPw-tGJhgfcP9KQ0fZ7jBsVhNPWC
    f091LB9bh9FtkkBYG-LDyJzPT5bkndjec64OZAPIpjnkRM9XjX8OFQ>
X-ME-Received: <xmr:cRyrabb9N-kG6VpceB_K8h2tCSiiaHjmBoVmAoY5-G9NbPsSUoQW0yhKRsnY_UJ5LkS2_XBekhzni_14Rbhnnt64Q7RAniLcCyYIlLrD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpedtveeileegjeeihfehtdethedthfdulefhjeffgeelledtteejteeiheeljeefueen
    ucffohhmrghinheplhhkmhhlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihhrihhslhgrsg
    ihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghgihhonheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:cRyraTXkjFa5aQFxCP0Vn8csrIrBGh0CPt4VhumPi4NnTDuuiDwlZA>
    <xmx:cRyraZgQGhwhIYhW07mZQam2PMP0sHGaBXjooC-w6sv6GjcWZ5n3rQ>
    <xmx:cRyraRviknU1UlTF22-kAb__dRCEc1RtOjqReT5KIiKMrNt9sTbLUQ>
    <xmx:cRyraS7iVSptifxQUyStPazkVmSoXzajacHUqEOp1JKH2SHbiFhSiw>
    <xmx:cRyrabjrPqBhkOyJPTqw0WPN9bIed_tkXaxzh1YH8SkGUlGly4LnUDvb>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 13:26:57 -0500 (EST)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 501211568C08;
	Fri, 06 Mar 2026 13:26:56 -0500 (EST)
Date: Fri, 6 Mar 2026 13:26:56 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
In-Reply-To: <2026021006-reenact-suave-c86c@gregkh>
Message-ID: <p6r658p5-4q55-8pn6-q78n-107599qq653n@syhkavp.arg>
References: <20260203045457.1049793-1-nico@fluxnic.net> <2026020851-bullhorn-glitch-0e37@gregkh> <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg> <2026021006-reenact-suave-c86c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Feb 2026, Greg Kroah-Hartman wrote:

> On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> > On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> > 
> > > Argh, sorry, I saw this patch series too late for this merge window.
> > > I'll review it after -rc1 is out.
> > 
> > Too bad.
> > 
> > But please at least consider  this one now
> > https://lkml.org/lkml/2026/1/27/1886
> > and queue it for the stable tree as well.
> 
> Sorry, that slipped through as well, I'll grab it after -rc1 is out and
> get it backported to stable kernels.

Ping.  ;-)


Nicolas
