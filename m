Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF534A799;
	Sun,  8 Feb 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567750; cv=none; b=c6BmE61mHVQOcRjTN/hQznWKPadbL2tAICjPQ5j6qrnMmbFgla5xHOTyo1FFN2WXkTPitfoxeSsmtYN2lgUeXxZJqhWim5m4PR9ztGc6TQ2L61M/EeQ5aO9DNPtF8YIjaSLTOh6QQNpn2j7V6MBD6DXK/DE/zmlLbzNP0OCzt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567750; c=relaxed/simple;
	bh=0Ng2135im9CnL6tNVbvIJFFPNKpuQLPyWfARWjCCZpA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4WmTG3uxDkKSbsvLf+DInmo2ywuqQ2Gih4lPO96zHOGkM8ZjfD6c8VEmUGbgSOEgdFzF0kWQJh+M6+M9nO2ktwxiAJ3H3uktMe5Ux6hRKqe5rMZhyQyLC3wC79gZvBsW7qyzGKHFZs/fQN7ue13IeE/8OW72kxlb6WaKsAXgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=gb77iJrk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgs6x9KC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="gb77iJrk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgs6x9KC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4E32140005A;
	Sun,  8 Feb 2026 11:22:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 08 Feb 2026 11:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770567748; x=1770654148; bh=Wm6NvVg+gn
	xxaq1Hk52rBwHo1IVaA2ekD7AD5doJAdk=; b=gb77iJrkhK7KRZWKuwak/PLUkG
	pBAuV3PkjLZ1DBXhGn3VLKCx8RDkqsJs5sJRpmlHFIAm2woKbNEdjj22H5y6JSS1
	aKQlvYNHU0DoUHEdS6Row8CpGESgiYWL/46lzfhEcO70IudEenPphbpcFGxOEbAQ
	afzQdKAp3DSXZ+7fqKTwouMI6MMm2vsfhWTuQeglu2ksf51zhbnao6qOBgIWXuIg
	KV75Fzx55ynn7g3MBgwQOpYmzDP7PHuLEzm7LZDne0TU2Zmd7znGfhO+YIxFLC2a
	i0dSttbwD0283xg218skPbUHFmxHjYi1mbEIuA+iUMRXIflc7jKPA9aViBJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770567748; x=1770654148; bh=Wm6NvVg+gnxxaq1Hk52rBwHo1IVaA2ekD7A
	D5doJAdk=; b=dgs6x9KCgspI84Pw5wTC0QXu4IZ3HyrVki4LF9La7OrSx6PHZdj
	t69J6GKixt0hmW/8fU9zb/0S5+a3UTT+9Z2yA05c/1/16BTcXL0ly35dBL7DiU/E
	5oOhMKKF7+E4d2VD5wC5fWxlDYE4p5AGq0r5arPeQeAijS+VQ30PckL7sLEcDDOb
	KH1osn6fqGTByTLXjLKogRVkWq73P/5rnX+/NkUqVMRocrTY0o6iDcBZGraOzv5R
	DFkBpcaecjJjEfY1AEA2WL6p0qcMpE9km4SzUsF4zAeTDvVc9xNIXm7nDJajqayk
	MQ12qAVgpbO14xMzWsLT7x/joR3PfZnfZSw==
X-ME-Sender: <xms:RLiIaRuKOO5CUU41eufGmKsFsfzp0vBXlNx6BMBXPdQzMRoCZtcchA>
    <xme:RLiIab85rHoXltH_qyoB9tw2hF9SkCFVbPNlFMRHM9Ydd1UH3RqwaA1A24EnXNhU-
    xjFMuZ6p3aO7Lf1nUvFjJc7SiQRv3h0xi2ne__lwTf3n3OLCRS14g>
X-ME-Received: <xmr:RLiIaU3tXwoLXdBESISRNBNJF_McH3_uutg9yq__xFuXVUDErf57aL5RlvT4xivSLrLT6X2t4s6RrsRO_CP3PZW-oORLwjDrq1qSZbIz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeggedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RLiIaYCRAyfCeMN27CyAHQ2eJhSKOg-fX0goWGIPXDE1j1XLEx_UvQ>
    <xmx:RLiIaYc7d0n0VC8deqCXRWwzuvPX9SBzRzN-2Ak-GjwZGKFhsE1N6Q>
    <xmx:RLiIad7jJFHW4M9q0d59PHGdUwaMZWjVfjuIgaAqlo7w_jQmGPLFbA>
    <xmx:RLiIaTXU2Y7s7brQOk078lM6Utt26Hs-hec4-qR-MklvedELCND0nQ>
    <xmx:RLiIaZPQms26c7IBoQzjha-R1UCK75RdRpAuLcdLBkXqpjNqci5rJTg->
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Feb 2026 11:22:28 -0500 (EST)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8CEA71524223;
	Sun, 08 Feb 2026 11:22:27 -0500 (EST)
Date: Sun, 8 Feb 2026 11:22:27 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
In-Reply-To: <2026020851-bullhorn-glitch-0e37@gregkh>
Message-ID: <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg>
References: <20260203045457.1049793-1-nico@fluxnic.net> <2026020851-bullhorn-glitch-0e37@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:

> Argh, sorry, I saw this patch series too late for this merge window.
> I'll review it after -rc1 is out.

Too bad.

But please at least consider  this one now
https://lkml.org/lkml/2026/1/27/1886
and queue it for the stable tree as well.


Nicolas
