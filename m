Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD73594C;
	Tue, 20 May 2025 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747712569; cv=none; b=IdTRXJY1i3he3YWsq4jeMltoWMPHzJwBM6FNtSppJbO4pR4cfHf6SM6K0pMYDIdhevMW9ornwI/Rc5e2JCbJ+nQRAuOaGh6mGE/3Iad5cVYE/girdeqF0ZATONiiB1CLR+5FtUjFXzxU835ciG55qZHNF8iSNtzkKKGEdfjwAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747712569; c=relaxed/simple;
	bh=oLyCXWWUMKIsSeoPo6Z6kNZwKj7A0fJXyb8s8tWPUlU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HS3N1dx9C6++JkJPRSXhB5F19SxkmS2ORKpVzRTi9mKFXQ8Or0eUSRPpmLU80iLuhs31fUaYboeSBA1d1UOjYXIt3HyWW/MimF9Zc9sWMssclsjOWh0NeIwpxo6GHeZXpaN+dLxiuXSGPuLax+Rez9sOFS+Uh+t0ZZxOXIL+SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Z9u2ixnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJIdq+s7; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Z9u2ixnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJIdq+s7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id F229A200311;
	Mon, 19 May 2025 23:42:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 May 2025 23:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747712565; x=1747719765; bh=ypLGYSRPxg
	zJ/f1t6oKhgJlVNaEgTfXoS9qN+1k4YEk=; b=Z9u2ixnI0fxOltK49MQux2neXq
	WqEkfepenD5IsFmdCE2WAWOKf9MAL9qzwWl88GSw3qLv08ZRWFZehV5ucdR3MSc4
	w6FQW9rhycI5ZqhllQXNQMJ8hD9G8NgeEXY+/pjg7BFwoD0sb90p2Amq+ztvtgHa
	vr54ADkXQ10UnX3PFhZuJtWAyBnBVYNdYrZnZUqH2aS3EqbXE7usOIg43veMXS2q
	vZa2q68k/7Rq9aEExn69NfLO05j0pKpf60Fc+TxRdAWNKMAfCr/qpeYEE3wT4W/U
	jxVColg4os+Qsjlr9n+0x3ZH4iuudbzPSPAZRwUQ4ovVOJTd5gBD1HP4fEsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747712565; x=1747719765; bh=ypLGYSRPxgzJ/f1t6oKhgJlVNaEgTfXoS9q
	N+1k4YEk=; b=dJIdq+s72I84Knx5Sd7Q1d9OGNszwxORc1n6yUuvv5w0fO8mPK9
	y5z/maIOksNBPqtGPrZdmE7xdAOdKxfW+xYacPARcwZ0Iqr1DzhOmd/XTtXzFJt3
	218yRA+DSGBHJsS4L3OMB5LdCwLIKwln4O1YDclMArS3fnp3i99d0NO9wL6MDc7i
	eZhswum3TyzY6doUgM0a/4ADZ9lo8g8vdeTV13C1ESFab/sOLff1KhrSpei92wOs
	ISyfghOpEf3G9X8nPySGW9c0dMdLhZayRbVJDfrT4OBNvqk3JKd3EzkqS+9bLBsK
	gWXJ7+dbBmzlUm/KKpRYxNJ86u22UImmmhg==
X-ME-Sender: <xms:NforaMFLB9foMQmJ7eU3WrB8-DGaFO9AVvH_q8JQBg5LbGjU3WMtwQ>
    <xme:NforaFXDDJgYyFmcNSNBbSKKGS9dgTBg_xEp6hd-bESOUNE2Dt_pFeGYQKRxYjQQX
    lfERAvwGgPw44tC3LQ>
X-ME-Received: <xmr:NforaGLhqfQRnUFC72ptqfvqq7a-ND9hzVD0umrEQpQg0lChlwVwblaisCmr0WrzSOSs-d1I5Q08Di7kP2dSD11xGXBGOUv79URn_YxKiY3wqfONnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmneetughnkfguqdgfufdqffettdelucdlfedttddmnecujfgu
    rhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghsuc
    frihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrhhn
    pefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohes
    fhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NforaOFuDtR8uz0ZC3TE8Ngkh4EDl8rm4GGKWrXCohQcLRoB84PBgQ>
    <xmx:NforaCUgc9NWjI5TlIWWFyVthcHwrFR7CAH3S4dvID_V36ilJVh-WA>
    <xmx:NforaBOK6K9rjgkL3QI6h6nOJL9yBYFi1w8UhT4mv8gMCCEwIuE36Q>
    <xmx:NforaJ1tMQj0PFL0WZuH6-n9WcmHsQklrh3Sugp3hezAKEb4lcyiUg>
    <xmx:NforaAgTP0BEiPeT0TfcE5c1A0KKR790toPpTszwI0sfqrtfSNHocQKG>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 23:42:45 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0F7E911B007A;
	Mon, 19 May 2025 23:42:45 -0400 (EDT)
Date: Mon, 19 May 2025 23:42:44 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console
 size and cursor position
In-Reply-To: <a5463522-1fa8-4ede-aec9-73f8a0aee196@kernel.org>
Message-ID: <508npq7p-46or-n703-3725-r5649qno371q@syhkavp.arg>
References: <20250514194710.6709-1-nico@fluxnic.net> <20250514194710.6709-3-nico@fluxnic.net> <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org> <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg> <a5463522-1fa8-4ede-aec9-73f8a0aee196@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 May 2025, Jiri Slaby wrote:

> On 15. 05. 25, 18:02, Nicolas Pitre wrote:
> > So I think that such a change, if it is to happen,
> > should be done for the whole file at once and in a separate patch.
> 
> Let me bite the bullet and send something. (Likely on Mon -- now queued up in
> my queue for build tests).

Do you have that patch ready? I'd be happy to rebase my changes on top 
of it and adapt them to follow the file's latest code style.


Nicolas
