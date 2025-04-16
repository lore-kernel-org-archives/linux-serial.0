Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267818A6AE;
	Wed, 16 Apr 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808964; cv=none; b=TtdLf2a2FH4rwyZzUsOHu3VTSEJGhCnz+Fn4SebLkMTBykwWIlrN2Ahiem0EX4goo9iTNamd8MkikYAknCKsvqqsbkCv/mh+hCZq/kgi7UQHTowIIe64RDzVOnM+bI43Nc3cz5q/pN+l9PTzLiUGPC6rHsuPQbSrlCb9yQOoIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808964; c=relaxed/simple;
	bh=gDvLnOvCfVSyAinptyO15tUxBl7lFEc/y0+/dcEFDgo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jBaSVMEhxvYIKU7C5kS1yHU/oE0CI1/PT4pnoHMZ89pznQQKnDl7axS8ZMMj3+UVhAOC6YXP4nU8YNeNPbIzoZY4axJWNIwngwYldf/QfAcAfR9WKrGOdVZQPlUKKa3EP3qQdQM4djwe+8O5q6HgWEmwE00u7uMRHEx4dlK7nNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=UrtzcOUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLggXF0z; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="UrtzcOUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLggXF0z"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B81D1140135;
	Wed, 16 Apr 2025 09:09:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 16 Apr 2025 09:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744808959; x=1744895359; bh=RT0o9ESgA1
	IOg2dSl39PiMpkDYcmJ8fSsA4gzhvlJ78=; b=UrtzcOUsHD+648RtY30UiBD3e4
	3PiGpE3rVGuKVQ7KS9GUfuZioM0UclQoEVRNieaa9c3u8nEE2b84ukpn5HMPJXbm
	Jk9oMlqOAAqM0ah7yGKqlrqdUoegCUCTfL7s2STQSx/cZqQPA+gQ7PxqM65T1b/S
	UCtheRgdlLBbLZy0XOdZYzyPnhBiNoWp8js0m5IiAz1tvEqtgrp1ZX95GF/jiEw0
	x0DQIaeJXv6JQ+XBLPRWs8ZAXjfrX8avTaWkt8KrHJQMUwKOmN92JjTCYXCaKV6X
	9Q9SA534CiqY4X2JdfYayNdOwKvhJAjgBD+MbR+rclHnzZ/OOWdBeTFws4JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744808959; x=1744895359; bh=RT0o9ESgA1IOg2dSl39PiMpkDYcmJ8fSsA4
	gzhvlJ78=; b=MLggXF0zWvc25GHBc+HswrLe7VvoXW86plHGnGw4Ndkcdm+krbX
	RDpdfkLKbBM925GA3fWO51dK4nwgI/QAZLpI8iEB0KdGPmVJgGMLHT/KAGWOH33S
	EIXn2eYEd1Sw7Zh6i/2WhQ8nepaY4OoG6TVi0egJa7rk/gxREnLcn1Q4MdMO/sOH
	yeKFoG1qamkMw0dOeWYW98/U6crdA6wr6vo/XIOd7LC66cSha8YORWlkC/tzBmA4
	HNVIFb7Z+7My8hDMRErs0b22nf8RW0i7Y9OJeYxLmXYrSV2c1mtbzMjKtMuQoUiX
	Qq++cAgMo2Eq1+EoPmLrPGP1MvJ8eVKts2w==
X-ME-Sender: <xms:_6v_Z5X0wtmoeEVMshvwAYjjRJcjRrdbJeL0-bufPnOBmMw4Ykw_lw>
    <xme:_6v_Z5kdEtdu0_N6569N5rFqaGIxi0EE3zU1wqHUoT2yVpR3KtmJETeEMzIJaqUBj
    qZAc2QVRk1DhooPwXo>
X-ME-Received: <xmr:_6v_Z1Zousf7bv9FQUQtBA8OysnrA2nvU-ZMf2KdO9MJvEY2kkSpeWUeJB9GNNf0YbbjmAOwiLwSXLxvoAJ1kju7-OclwAOLRvP3dul8cwKRwSHTjA>
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
X-ME-Proxy: <xmx:_6v_Z8UcR4w1nNcTc-3TrJAN9gxn5n1NwBBxX6UGZKnCmlvMhn79Vw>
    <xmx:_6v_ZzkCADZ1N4qfMpCZ27f4AtFXzBeVy9hvzH7VNbLH6dpcCAcb5Q>
    <xmx:_6v_Z5fEcvtmf58ahSKpEmmq9LjwcW4XHvve2u6jL8t7Pm3JOYpVuw>
    <xmx:_6v_Z9HvTsx4YAV0JKeg00CAYkjyunAQOio_6aWgVw1kkNi0-GG1lg>
    <xmx:_6v_Z34hJbhSUPUAergXxkQTrNccO0Qf62vyU49RCpxzI_mNTNewmzXy>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 09:09:19 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 7AE45111853E;
	Wed, 16 Apr 2025 09:09:18 -0400 (EDT)
Date: Wed, 16 Apr 2025 09:09:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] vt: refresh ucs_width_table.h and adjust code
 in ucs.c accordingly
In-Reply-To: <7c3a13ce-c5df-4ea7-a3b1-32a13ab95274@kernel.org>
Message-ID: <9ps0r788-qo06-4893-7753-4n3oo1238q23@syhkavp.arg>
References: <20250415192212.33949-1-nico@fluxnic.net> <20250415192212.33949-14-nico@fluxnic.net> <7c3a13ce-c5df-4ea7-a3b1-32a13ab95274@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Apr 2025, Jiri Slaby wrote:

> On 15. 04. 25, 21:18, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Width tables are now split into BMP (16-bit) and non-BMP (above 16-bit).
> > This reduces the corresponding text size by 20-25%.
> > 
> > Note: scripts/checkpatch.pl complains about "... exceeds 100 columns".
> >        Please ignore.
> ...
> > --- a/drivers/tty/vt/ucs.c
> > +++ b/drivers/tty/vt/ucs.c
> > @@ -5,17 +5,34 @@
> ...
> > -static int interval_cmp(const void *key, const void *element)
> > +static int interval16_cmp(const void *key, const void *element)
> > +{
> > +	u16 cp = *(u16 *)key;
> 
> You cast away const. Does the compiler not complain?

Nope.

> > +	const struct ucs_interval16 *entry = element;
> > +
> > +	if (cp < entry->first)
> > +		return -1;
> > +	if (cp > entry->last)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int interval32_cmp(const void *key, const void *element)
> >   {
> >    u32 cp = *(u32 *)key;
> 
> Apparently not, given we do this for ages. I wonder why?

Because we're not creating another pointer that could be used for 
modifying the referenced memory.

> Anyway:
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> -- 
> js
> suse labs
> 
> 
