Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191351C8614;
	Wed, 14 May 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229113; cv=none; b=VKLO7ud51bumdnzTzw44v5JHn8mv8YBU1ZZU1xDn/uW/fFZ/ej6UldLgBeW74i04/9odA5hEHtUzp4iLwKuG0OAgEm2yOXxCQma4BSy5otuyBngcXDnVxIl7wHQzGY8eoZXEagr0T+o7XsU73Sx7+2SYhqT739hzAnTUbwNlu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229113; c=relaxed/simple;
	bh=FHZjLnY7W27IEf2+VjX4uQsQZkVk/pBi6brwGxlVUrg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PqCnlvy1Q8ue9jZMLxrj4zOCUrfLVHgO6wTrQ7xt107hhgSGsNiu0MfRvoBOMJx2OjTmCpG5YjTx2+XXEHGTJqfgpOq9ro64cANOkHUk9XmhTzZRRKAoSI9P0QBIef30/IwyOUUWxdByel0IsA1eeYziwFGzZ0LZshzpBaCZsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OC4Rv+LS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUVoXcsf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OC4Rv+LS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUVoXcsf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DD747114014D;
	Wed, 14 May 2025 09:25:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 09:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747229107; x=1747315507; bh=KY4x5uYcKe
	R2Zrb4XpFO29Ku7+SP/Uz+11yK8XHY5cc=; b=OC4Rv+LSrvu0m83SkicoX+Xzr0
	8T2ob3IjBkST+mtcXvGqrom2AIOgl5ph2hCNAvSYp5sYPiwXMTrSckahkBpQRkFM
	EoRNlgL0VLpoT6K0BmWe4cs8ikgsxgutsxyJxR7gDNgo5ubh+JtVPAM/x+sFziSW
	wzbbS6IY9jA7cwAlSahPFuHkrgvUPKoGEUmxAIcLuGkBogQ8GTQ5vkHwlqprTV+I
	LgLCFht6MZDNv1cG6mP7i2dTR9dxlDLl8fgn9QgK0U5uGGr/MOW9PFY10q/fXOG4
	R0Zl9JQN7ffZb9MwRj6V5/PBIVjUBYKO0AwpgCYDAKNprnhJSdfXzoTy4MxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747229107; x=1747315507; bh=KY4x5uYcKeR2Zrb4XpFO29Ku7+SP/Uz+11y
	K8XHY5cc=; b=CUVoXcsfQJrUHXhpQhVu+owMY4Q6YYCGZlLhbjmqpJzsUnj8ipM
	ZI9Rtia0Y+UszwNNkHfKd5qo7Hh1ogRQl+6Ah2NEPrL5Dm0EQ0SjFb646P3JVquQ
	Y0TQYr++u9dTZG5XpTX66ojd5KM4ZjK8GqqPKNc5OFU/EcHWK8o8xwIYJXLJPPAA
	6ymtJ3nJ/fiptvEDZrtFcgeXY1DhLpfqZQDhRmoMlGZqYHYB3k4oAF3T53areLJf
	5nbWfk+QuyUJLgyPp2rKWppDT7tkPTV39fZw2WTcQ2Ynzt/elh2+5LJSTvPRSqwC
	+re/4P/vy63ejscNnYamK0hMFprk5v+87Og==
X-ME-Sender: <xms:s5kkaNRnIFyv2O6pxShW38XXRbM162v04LX69ZNH52305KmwuY00dg>
    <xme:s5kkaGzJei7LTGUuMNsKLijUD65ipwfCDimirsXOrYwke9cbggfk_6nPZkcQ0TmN3
    NlqzUtzaUwyA768-9E>
X-ME-Received: <xmr:s5kkaC0jL2qYDU2NX4Lo0wfTifLJykuEqBjrLS5klg6CKGuyUD9TTlNiEYsn_K6mCEOp10QHFcOKZc3b3oIYJ703sc5Yb6Ani34rA24EmTj3fJmmlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejuddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:s5kkaFDUC0juKpF5WU1ojhXikmj46qbRKmf9J_ZPzb4mc1sG2_RiGw>
    <xmx:s5kkaGgKzaMD7BR7BaJEJ3Pn_AZpjKtcrmhhSUKmGWXKNUS5Z-4bCw>
    <xmx:s5kkaJp6bT5eNcCNhdHx6j00J-TUvGptbbOviivh12y7QOHncrXdgA>
    <xmx:s5kkaBghWfXVQw2LPjBOIjwAUCYQ7VwHBcYjIdf3EqjIzB1c6i55kA>
    <xmx:s5kkaF3aaUUQ64pmhGu37qmW1P5JpKbGiHlsIdeMHaHyN6R_d0D0uCoJ>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 09:25:07 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C73D411A1D43;
	Wed, 14 May 2025 09:25:06 -0400 (EDT)
Date: Wed, 14 May 2025 09:25:06 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vt: add TIOCL_GETCURSORPOS to retrieve the screen
 cursor position
In-Reply-To: <518b6620-bca0-45e4-8c1f-6cd9ab18bee2@kernel.org>
Message-ID: <878p78n1-864p-1q01-qo8p-q3s56rr544sn@syhkavp.arg>
References: <20250514015554.19978-1-nico@fluxnic.net> <20250514015554.19978-3-nico@fluxnic.net> <518b6620-bca0-45e4-8c1f-6cd9ab18bee2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 May 2025, Jiri Slaby wrote:

> On 14. 05. 25, 3:52, Nicolas Pitre wrote:
> ...
> > So let's work around this limitation by adding TIOCL_GETCURSORPOS as a
> > fallback method to get the cursor position when /dev/vcsa reports 255.
> ...
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> ...
> > +/* invoked via ioctl(TIOCLINUX) */
> > +static int get_cursor_pos(struct tty_struct *tty)
> > +{
> > +	struct vc_data *vc = tty->driver_data;
> > +	unsigned int x, y;
> > +
> > +	console_lock();
> > +	x = vc->state.x;
> > +	y = vc->state.y;
> > +	console_unlock();
> > +
> > +	/*
> > +	 * Clamp x to 16 bits, y to 15 bits. A display larger than 65535x32767
> > +	 * characters won't be a concern for the foreseeable future.
> > +	 * Bit 31 is reserved to represent negative error codes elsewhere.
> > +	 */
> > +	return min(x, 0xFFFFu) | (min(y, 0x7FFFu) << 16);
> 
> Hmm, I would do a proper struct instead. Like winsize.

I did that initially, than I had second thoughts about the extra 
overhead implied by such a structure and the separate put_user(). This 
coupled with the ambiguity around alignment with argp usage. In that 
context is the structure really worth it compared to a simple return?

For the record, TIOCL_SETSEL is defined using:

struct {
    char  subcode;
    short xs, ys, xe, ye;
    short sel_mode;
};

but the documentation fails to mention that the structure must be packed 
as there must nott be any alignment padding between subcode and the rest 
of the structure given the kernel-side implementation.

> > --- a/include/uapi/linux/tiocl.h
> > +++ b/include/uapi/linux/tiocl.h
> > @@ -38,4 +38,8 @@ struct tiocl_selection {
> >   #define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel
> >   messages are restricted to */
> >   #define TIOCL_GETBRACKETEDPASTE	18	/* get whether paste may be
> >   bracketed */
> >   
> > +#define TIOCL_GETCURSORPOS	20	/* Get screen cursor position */
> 
> The same question about man-pages :).

Shall do.


Nicolas
