Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC491B5EA4;
	Wed, 16 Apr 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809466; cv=none; b=WTyIv3UHnx4YQ/26EVo6RNRkTn7zUActe8cOzoldv7o35rUaL22h12zaItEnjDXHOa0ZJHigkhQ7VUv0oFbyqK3z4b7tKUoLX6cGYm1q9M+ZE99oLPPLwDNXlYmUNTCRxPBa0Yu2j2KYfxGunECvU0rCMZ9fjCkGb0NKEHzTZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809466; c=relaxed/simple;
	bh=gM+Qt/a7kopGR4V05RRDgd/dcyhhEifAMadfuSwfwGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I44N+DomETUeW87nlhAvPP/tq8y2giRrZSwqLhH/OpITEBaYLZi/sLYCAR+aYUpWQ9PNvQlFGe9a1COKD2x7SfE9xC8gmdmn1ddrZOyRl5RMgVy98kcns2Ajdu+2ORvDr50V7FLJYAb4RAWiGKpHAnzgNoCCe4jF//hP3OA2BlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ngLc9+U8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJgaeytE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ngLc9+U8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJgaeytE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CF8113801A2;
	Wed, 16 Apr 2025 09:17:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 09:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744809463; x=1744895863; bh=I+LCZnsoAG
	cr8Lu8YNiAW3gdtOZDYjGpQICJr5W6auc=; b=ngLc9+U81tNuJI/z3JMRcQQtSL
	V8qy55M3+IIMoRwxQXrL1DqNmxzuLi3uy7emLnDTxQTCbYx/fKGf0g5pORDn3Wqo
	XudpUsoU8J9vcWk4Nc5fzjE0jHO248cjM7rZbcLiuY/RK0DKKt8x6KoOHO+vAUSp
	XqYlwyvNtxgW1qy31C0JPZoXtQAFmyQ0JDO8lNYXAXPdAk5Cr3uA1FZ/tyPObfBq
	Swq0LYYMcQn6iY58X/i9AiNvmR9WO7Yzsd19Sj7rkmP6jalttidyPg3VkTi0+cuG
	5w5JUKIQtSQCwFQvFUzDnfdHui7Qf6tOfmO1V1UQ/mDlUc13WZvC2doxUa6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744809463; x=1744895863; bh=I+LCZnsoAGcr8Lu8YNiAW3gdtOZDYjGpQIC
	Jr5W6auc=; b=VJgaeytEB9G80kqmB7/ydF8to8pPoPCaIGqXXSVJ/QLf/jQMQ1x
	G3syT8Q+/AvcM+QtnV6W/AdzboXy5aIE1RsR/BCHd//QpPxlPyNpaS/OgLRj/QtD
	WgLFNIRQXSVadViZu+mB3ykXK0LENRnwH5/W+vSz70jQPE3qVBuydx/fyZZXHDIW
	+G+X0mZJjOdlPFx5d+01mOOxZAxDsm70KdBLmscJoeRtgD+JSoV/1SUo+o5fr1lW
	eXepIGgi67FnRTT8mJ8TgkCOtnKRp1ZBnKaBN6PLgaXgrxI2VdYGQaTK3/LlwACY
	94sJS97Cd/Rlb5bqlztf6PL1gAG9TMzREXA==
X-ME-Sender: <xms:963_Z0i7nJj3lY3OgY7UErC4ZVJrKqZuk4HzHcwNSy6aTZ14YakwyA>
    <xme:963_Z9CJVCm7NrN0-FtF0CWY4qH4Bu-FGGBHZaiPgYPPxU7fszyhlBfxZ0g1BiNIk
    duVzaCuB4cwZueqC-c>
X-ME-Received: <xmr:963_Z8Hl7-_HR0AftmAcuTgcUTUeRMkWFwU_YjFZc_RaQN-mAjNRNdFMXS0cOI8-EadPqYKCnB9o1AoeJj-6JQki7cguKyTDfDiqK04AsyYKi-jCCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:963_Z1SlXyJ8a7W-zoDnTaB69WCgdlNtndSoe9kuDvkWEljOncOXjQ>
    <xmx:963_Zxyh9g6AHlBxdUuErbFl3L6Vy5pky1VXaqwCdU6jqPhEn82_PA>
    <xmx:963_Zz5deEKjh9gmDJlLpj_RmwBvuutxtrwrpDtd398BUoCdeuD5Qw>
    <xmx:963_Z-z4ypyWJM9bXe7VwelpR1qPl5kx1RkT85WOeHfEY_Beg_Na0Q>
    <xmx:963_Z419ru_WCSgPUwzDggMGPsLVZNQkZqQP22qwDBw-TxULZsEj-A8o>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 09:17:42 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 576E01118575;
	Wed, 16 Apr 2025 09:17:42 -0400 (EDT)
Date: Wed, 16 Apr 2025 09:17:42 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] vt: introduce gen_ucs_recompose_table.py to
 create ucs_recompose_table.h
In-Reply-To: <f39d8b9b-c160-40a3-80d0-62f880122f2b@kernel.org>
Message-ID: <7nr6809r-74n3-6noo-8qos-2o504r3849p3@syhkavp.arg>
References: <20250415192212.33949-1-nico@fluxnic.net> <20250415192212.33949-8-nico@fluxnic.net> <f39d8b9b-c160-40a3-80d0-62f880122f2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Apr 2025, Jiri Slaby wrote:

> On 15. 04. 25, 21:17, Nicolas Pitre wrote:
> > +/*
> > + * {out_file} - Unicode character recomposition
> > + *
> > + * Auto-generated by {this_file}{generation_mode}
> > + *
> > + * Unicode Version: {unicodedata.unidata_version}
> > + *
> > +{textwrap.fill(
> > +    f"This file contains a table with {table_description_detail}. " +
> > +    f"To generate a table with {alt_description_detail} instead, run:",
> > +    width=75, initial_indent=" * ", subsequent_indent=" * ")}
> > + *
> > + *   python {this_file}{alternative_mode}
> 
> This should be python3. Or no 'python' at all -- I assume the script is
> executable given "new file mode 100755".

On my system, python == python3 since many years. I think it is safe.

> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> -- 
> js
> suse labs
> 
> 
