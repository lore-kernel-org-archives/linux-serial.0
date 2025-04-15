Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF722F383;
	Tue, 15 Apr 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743966; cv=none; b=rivT00X0CT9i9y3zwZad64m9EIpWHSHIKj4JHImTmlpUpHzqDn5EEaDxSp6reI2nm6oaRqnleEq6nDiv7P9wdhsN3o+pJCZ2Myx+KJSDt9vuDoqBLFKYI8eZfW4YijS2qy4CLwVD8RFhaVe30frvHFvpVfd5hHwQ7PQSeIfw1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743966; c=relaxed/simple;
	bh=NaCLBzVri4TtY1LekMPJOWqyj9KV0VJ6q3JwG6h6i3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H0bAnNY6aJW7JIdB6EfUmOajLRU08llbsoV3TZxeVcZBac5an9LOrJkGeKdXUPuIw6nK0Es2ecQbVtT5b4yeIPFWJKU/5rLzrhiLvLBA4ZE1jt6B9kPDyOJsNjXGM7ixaC9xzAPQ80C4J9QY83+bFZFkBsXjJCFzgI9T5ADJeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=V5n2hMcf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YljagF4l; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="V5n2hMcf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YljagF4l"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E1FB11401E7;
	Tue, 15 Apr 2025 15:06:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 15:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744743962; x=1744830362; bh=Ka+OnNTozB
	YpV8VCDL83XWJLMlywl/dvc73p6OwIdsQ=; b=V5n2hMcfrbjCKmj6N4jEwJYGP9
	4hjHeT0AV4EqX9kc88mQW4R3fn4ZKBlL+LRbK+3xA2Tk/gnGHjHKV46L/q379s05
	M15z81GKBXdx+th6cr3xk16AZ0StGLbxFcgZgThKXpO3ETCCldKyPJyUXRTCPe4C
	iIxywBOEvTdfj/FRhWCLllb8DB1Al9qnhSL4OmVfXxmy2XpW6CEKeyd2MlvHYaP4
	QmetObcJxnQ084FXSghqx1NWPQjrj1SQHlH28DniubQ1nySmQEnqPjAH94ob2U+g
	/W04d09hxgbaFZ/ID6rXMSlByogIhDTlkUQ44Qh1mFOZHbXc46/ndj9LC8Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744743962; x=1744830362; bh=Ka+OnNTozBYpV8VCDL83XWJLMlywl/dvc73
	p6OwIdsQ=; b=YljagF4lDH9Y8tzqe7P788PfP4NsL7GkTwgvq6l6at3yVwvHNLN
	BhSQyB/f/GIR5nNZnnDPevz0lHZY0fH0Dgr0VFlVXZOS0YkITVE7h2OhSM3JxxpJ
	A12T8rGJpWGi8tiNbOV7v579GqiW7he/FNctOv+PYv6gwtMMAviLA7EwYF+ia21w
	ixp0ztUIq1ZlUHDV3aTVYZp92M4/OZG4C1yY5JIy4cOu0N31NYstJBKy1Oa1v/JN
	kFv99NQt7xnLNCXac46VAMaHhUeA9fwPt2Rwnk/XluGZNq/DJ+PfOQHi6VRRQYHS
	59JT5BGrGcvwsVq3b4UJfGYoXSiyI0cehjg==
X-ME-Sender: <xms:Gq7-Z0dxcHb-xVLHy-VT0YqmkIvusfGy6SFQm7A-SOnJxh9NH3aI7g>
    <xme:Gq7-Z2MhELtCWJOl_GNHGj-Qlg4WnnsjFWPCtxgJWl60uKt0LO8fQbRsmwlLOLjX6
    qmDS5cdjrf5BxXllQo>
X-ME-Received: <xmr:Gq7-Z1iBgbyliC9o4FSUCLj5bFTKog6-r_i0r24n1i0N7w09lleXVgIKfI0tDGcz-mRrTpXw1PCttcPUfy7or69WOG0KBUMmN2suqJ9ZPaukm7rCnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Gq7-Z5-OXG8cq7wBSiwATlPmv5GwjxpHGmHCfM7u4IQVu640CgnvHw>
    <xmx:Gq7-ZwtYYyvgtqBPAOq0or8JVenV_8ixz7iYl1wLbDXu4Rt4oGfvCg>
    <xmx:Gq7-ZwH7cO_uZceqphlKCaP2RfMzFJhSWgyRJqbkQvXct7hX-AQ_Lw>
    <xmx:Gq7-Z_NWJyrmq8ZX0763SNP2FhGZVlbRNE38WWvYgYwYCzb_Wm6F0g>
    <xmx:Gq7-Z_CkdFJVWaBbxvNNekc60qF5OnM6ehMtZFdKbNurYL9vZ-MWD-ZW>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:06:01 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 754F1111659F;
	Tue, 15 Apr 2025 15:06:01 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:06:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] vt: properly support zero-width Unicode code
 points
In-Reply-To: <7fce92da-62d3-421d-9cd1-f9167c05d2b0@kernel.org>
Message-ID: <5sq93805-27n3-76n1-ps76-n41o22sn914o@syhkavp.arg>
References: <20250410011839.64418-1-nico@fluxnic.net> <20250410011839.64418-4-nico@fluxnic.net> <7fce92da-62d3-421d-9cd1-f9167c05d2b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Apr 2025, Jiri Slaby wrote:

> On 10. 04. 25, 3:13, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > Zero-width Unicode code points are causing misalignment in vertically
> > aligned content, disrupting the visual layout. Let's handle zero-width
> > code points more intelligently.
> ...
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -443,6 +443,15 @@ static void vc_uniscr_scroll(struct vc_data *vc,
> > unsigned int top,
> >   	}
> >   }
> >   
> > +static u32 vc_uniscr_getc(struct vc_data *vc, int relative_pos)
> > +{
> > +	int pos = vc->state.x + vc->vc_need_wrap + relative_pos;
> > +
> > +	if (vc->vc_uni_lines && pos >= 0 && pos < vc->vc_cols)
> 
> So that is:
>   in_range(pos, 0, vc->vc_cols)
> right?

Good idea. Didn't know about that one.

> >   	if (vc->vc_utf && !vc->vc_disp_ctrl) {
> > -		if (ucs_is_double_width(c))
> > +		if (ucs_is_double_width(c)) {
> >   			width = 2;
> > +		} else if (ucs_is_zero_width(c)) {
> > +			prev_c = vc_uniscr_getc(vc, -1);
> > +			if (prev_c == ' ' &&
> > +			    ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
> > +				/*
> > +				 * Let's merge this zero-width code point with
> > +				 * the preceding double-width code point by
> > +				 * replacing the existing whitespace padding.
> > +				 */
> > +				vc_con_rewind(vc);
> > +			} else if (c == 0xfe0f && prev_c != 0) {
> > +				/*
> > +				 * VS16 (U+FE0F) is special. Let it have a
> > +				 * width of 1 when preceded by a single-width
> > +				 * code point effectively making the later
> > +				 * double-width.
> > +				 */
> > +			} else {
> > +				/* Otherwise zero-width code points are
> > ignored */
> > +				goto out;
> > +			}
> > +		}
> 
> Please, extract this width evaluation to a separate function.

Done.
