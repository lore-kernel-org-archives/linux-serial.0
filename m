Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF43FCB07;
	Thu, 12 Mar 2026 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341769; cv=none; b=BoCdZ7+fTU96ERgo+lhW3LKjzyBXEDIQDgBFdlH4y7SMrJgDWDo6X9ABjnwvd7YaTK+RyTvMjhJL0iQcFzXyPPYfXlvWbN26IujaqO3oR4a5ysMvK9z0dxb0Re2XaPXP0MSukigduT1Z0oIid76TdizGTD2qf8NQOAkh8DXzLX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341769; c=relaxed/simple;
	bh=aqU33rUION2OniS1CYtg0LyLi2UyMuyrS1wtWzF68JA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XEB+PACXdHLrbHPYMaxOkcB8/T3rdq8dCFi059qZY5VV+KwGR4mA3/Y1kxuOYyb+/7oNRVYP8HlEhD4kkDw7J2P/QOQM3H8XzsXVWR2O9SYKm3WO2wn8dB2ejcY03cvJ6SK8Zifp/dGf2f90UXO8Rin5oBOQ1HQSE6r2MwxWTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=BKyLKcSV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0T3PEb1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="BKyLKcSV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0T3PEb1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6645F14002AF;
	Thu, 12 Mar 2026 14:56:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 14:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773341766; x=1773428166; bh=CVjPzeQ6nW
	pldrfRcT/sgyx6nbJYJGmeX+hX+j+l2Wc=; b=BKyLKcSVcZU24diRX4/jwmVAda
	74tBUdlimfdGUD97p1lJRQ4DbbXzRWMJtX0kPxkf7JGhVG96iWt0Z5suzHmt7Hd1
	QZx8O2fiNbcOzR23mGqIeR78ocoeorqM/AzPpYsoE4IQ/50IRGcSDbesrFxTo6wy
	5yndoAIvTW7BtLBIUJzk66pOM/xiSD+S/ojMC2WsF6hbtxjHThfcY2hPHPhAbV4E
	KjEXkzl+Si2f+RDSeG1At6CzHw4uKtVwzPrVw11rZCXBT8c2bPWiLgwzei3no96b
	b9Ie0/iSd5xDrUC9UM6A3oGiLKPBGH9yyVaTL/KGRgtevarZsTiaF6fJwg/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773341766; x=1773428166; bh=CVjPzeQ6nWpldrfRcT/sgyx6nbJYJGmeX+h
	X+j+l2Wc=; b=W0T3PEb1VAPkVoQkO8pYMKwBFVVwi7c+3KkCkpu+ny8MEWiuWIp
	xdVAX/ROwKPy1h3eLCnWD88O6suDBjA3+LOY8rHcvUanJUl5jtGrWezEQUAJ2fbg
	TePgAiUeX25sJ8ybCxTofuqWU6L+30oSq2dV22OpLP9qY+QefJRbod0nFVJr/qcO
	bwXjiUnTwdNWbFD3xd1TVw4sFfNFS2854+UlgsEK3AZrZiRKxeNrKAuGPgJ03q+O
	nVY3B5PdOwuwsefEqegEoK7k77axjb/OTU2YDYE7AeAAeO1ZqPTxp2AlE8rnVTow
	Mn9eEtuW0Uh/lSaiHEy5nFFkXZlIHr3giSQ==
X-ME-Sender: <xms:RgyzaZGLYhz-05QoFEMK3sZDj_bdXm3x6Pb72PLO5b2GbYdM24rq1A>
    <xme:Rgyzaf3cpow_iw3ai8aT6Rig11gruUVX-fZyyBcA3w4x4O5VTAbZPqNXfHaYwUZlU
    vmyp2S1KiUKEuwik_x55MOHzQ2FqlPujLZXetjiepVtm4xGKaaKT6I>
X-ME-Received: <xmr:RgyzabMi6SFzSdX5aAyVa5695677Gu9gTKX80bk8GDtmVAD5j304fX7X1hQH8_eMM08RFmtPuUVo32KDXRgbwvljVXAQmgfkrqumz-3f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Rgyzae7xcCBPkegP-HR-ojQHrQMhH4wAHEI79AEjd4UBd_6t1xbSQg>
    <xmx:RgyzaV0eFAsqJDhuyo5ZvKcVsrP_TJ6ApFJXYNRFF7MTgM2bR6kpcA>
    <xmx:Rgyzafy8BWbfO6SA7wJZi15Z0sOyHXSBcvefDL4CJ4icZEJugaLiKQ>
    <xmx:Rgyzafs5T6GT0YdarraLtPfnLgI2yF455iUiRRUAkKpQKcoVuN4MlQ>
    <xmx:RgyzaaFE-fhSwbvIhCFc3os94AS4Th9pcbAqrj6ZARxByKm1ZFemhxKB>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:56:06 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3D9B11576BA5;
	Thu, 12 Mar 2026 14:56:05 -0400 (EDT)
Date: Thu, 12 Mar 2026 14:56:05 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] vt: add modifier support to cursor and navigation
 keys
In-Reply-To: <2026031225-daylong-uselessly-1821@gregkh>
Message-ID: <69o09136-13nq-41sr-s3o8-s6sn68rq1s8o@syhkavp.arg>
References: <20260203045457.1049793-1-nico@fluxnic.net> <2026020851-bullhorn-glitch-0e37@gregkh> <q19s9nr3-6o47-4pq9-7r49-8q25p0021o1q@syhkavp.arg> <2026021006-reenact-suave-c86c@gregkh> <p6r658p5-4q55-8pn6-q78n-107599qq653n@syhkavp.arg>
 <2026031225-daylong-uselessly-1821@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Mar 2026, Greg Kroah-Hartman wrote:

> On Fri, Mar 06, 2026 at 01:26:56PM -0500, Nicolas Pitre wrote:
> > On Tue, 10 Feb 2026, Greg Kroah-Hartman wrote:
> > 
> > > On Sun, Feb 08, 2026 at 11:22:27AM -0500, Nicolas Pitre wrote:
> > > > On Sun, 8 Feb 2026, Greg Kroah-Hartman wrote:
> > > > 
> > > > > Argh, sorry, I saw this patch series too late for this merge window.
> > > > > I'll review it after -rc1 is out.
> > > > 
> > > > Too bad.
> > > > 
> > > > But please at least consider  this one now
> > > > https://lkml.org/lkml/2026/1/27/1886
> > > > and queue it for the stable tree as well.
> > > 
> > > Sorry, that slipped through as well, I'll grab it after -rc1 is out and
> > > get it backported to stable kernels.
> > 
> > Ping.  ;-)
> 
> Sorry, am catching up now...

Thanks, appreciated.

Also please consider the patch fixing alt screen support linked above.
That one should go to stable afterwards.


Nicolas
