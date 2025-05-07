Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891772637;
	Wed,  7 May 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626662; cv=none; b=XZMwv3Y+ATuzWEPFZceLzw4PLj18vFi1X+TvZhUphoq/HYiqseRVefhB0dp91g3Z33mGP/j+mSPGTQZvCRcMQzcp4CJmUq9tC0x2juyktogu2K2c/9mcPDqEhTHbjL/axZtXbnokI6PEVDUIVODX3/TSksvwLe0stHqLIIlPG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626662; c=relaxed/simple;
	bh=isVRjAVTnJdLXP9eMmF4E2ceEc9sRy5hZKwW3gaLap4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KcGV2cUPfWohdutXt3FRx8dM0TM1p4b0GOXwrRs3JOWvuAwwUx2SjdXPY5n5aYE82Tydd9e/v1FUbFj8Zee13Rw1fmycQ3Qtg2sDclNS1UB6zH/rOaeufD9P74EzRXGk1VxRFAPEn4xEWTerWNGDS7MF8tma+1nQLAEDkqY5ljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DZgvryuF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6jl+Ik7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DZgvryuF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6jl+Ik7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA7021140163;
	Wed,  7 May 2025 10:04:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 10:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746626657; x=1746713057; bh=RpZ1wH82Kb
	3RQvc6BvVGwJPwQFc9QvFjJH3aSsmodhU=; b=DZgvryuF04PlAcWSoY3uCG/aZb
	+mOefJTMh3Yrak2SHS+kCVkMDB8nYv2pVNTi1bOz3Ves4XpdoMOXLuBjsyc8dTWb
	Z5WCg7/+HxQoIvPVdYi06kURxyf1K4sR4lkz9VrKter3/2zjzQiMKbUqKDqbjcjd
	ioSQE4W69cFIQlDAvrpSqaZxWBPIYeQnuNSJF8ViHlsj91WAVwogWyWzRslNqldA
	dIXtr2uvmXs3svCaNaYS2bSTMVLSxz36rTbc16SFLxk0gaarcE6yP913SWmGAG7r
	hKVU5zl2pG310Pdz9ynZGRAphlXeOQH8foqlHg+tZHqWLyOxQ+o7YAU4h3Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746626657; x=1746713057; bh=RpZ1wH82Kb3RQvc6BvVGwJPwQFc9QvFjJH3
	aSsmodhU=; b=P6jl+Ik7G4QUrVnZuGPjBNsZ6VNRqmrZg+XZJpmyPZo+WkBSgpr
	dwkC4B7kDR6fpQZDiNJVqg05DuVNZe2ESLKruu2/eNV7Vnm0aYnXFQfaMAiIZpRp
	ShfisieB3KQNryN6H7eAMP4Z4Eaigls2hCBmLYPNq7vEzJEmkiMzkkmfc2NhjaP/
	zv62PIvxhQZXlEHCohav2PsyDfedQSZbTQulTBJ8GiHHmLNtgBZpipyuNePpsB9g
	jT+MNsS10ggCqVnMXGHVQso9ttxQvHm2XewsmaIE+SV1KBuEcHyCF9qIOHyRwpGV
	WuOHyLTpGtjIU/0TzleJVQtjQkVKNx5BSCA==
X-ME-Sender: <xms:YWgbaGvKQTCKpvnTp4Xq_BS76pVCRmtAdrURSM1esVpCQw4WNnpeZg>
    <xme:YWgbaLdteVQWKQbGxu8353C0NAZI2fXdcA-Mij2sVuuz4KxtFkdw8e1dHthz8bP_E
    6WXjVAK4KjHH-8QJ38>
X-ME-Received: <xmr:YWgbaBx5Wt7FfVTv28drwVP09NLSO7SwXAFgWbgPbve-gPE1vSZhVWSel_EZOJc6oyGZ_0GQAtZ_N9eNXt6q19kby7HfSzwqxUm3ow9CvyneRCLL1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdej
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpeekveeftdfgkeejhfejleeigeffueehieetvdei
    fedvhfeluedtkedvgeeuieejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirhhishhlrggshieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YWgbaBMlCCjSUCrVIr5BYQHIo9_bth7kMLVMC_gEoWa5xaD_jNftQQ>
    <xmx:YWgbaG-fjkBrzPueprtC7ML61AVhONjGwX-4U4IRMa9THmV5gVwRCQ>
    <xmx:YWgbaJU4Ml0zjlwsmWODIFU7AAn9OaPCvS0vMZ6jfefo4fMfFDDKkA>
    <xmx:YWgbaPeGMZ98iJ2oTLpfuNLpF8OPWKFjVlKw-7EqCV21cieqdbjShA>
    <xmx:YWgbaJRzEe3T75DSapInXBaOXofc1V3qaM0NgzttO1CzvZned2P1sw7s>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:04:17 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 96E611189E49;
	Wed, 07 May 2025 10:04:16 -0400 (EDT)
Date: Wed, 7 May 2025 10:04:16 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] vt: process the full-width ASCII fallback range
 programmatically
In-Reply-To: <58ee071e-b2d9-4e1a-b150-c2be59827676@kernel.org>
Message-ID: <ss849930-nr48-q998-oo41-3qs64or91670@syhkavp.arg>
References: <20250505170021.29944-1-nico@fluxnic.net> <20250505170021.29944-9-nico@fluxnic.net> <58ee071e-b2d9-4e1a-b150-c2be59827676@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-782106772-1746626656=:8235"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-782106772-1746626656=:8235
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 6 May 2025, Jiri Slaby wrote:

> On 05. 05. 25, 18:55, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > This saves about 258 bytes of text.
> 
> You mean .rodata, actually?

I used the `size`command which lumps .text and .rodata together. In 
reality .rodata goes down and .text goes up a little, and the end result 
is the combined text size.

> > --- a/drivers/tty/vt/ucs.c
> > +++ b/drivers/tty/vt/ucs.c
> > @@ -222,5 +222,13 @@ u32 ucs_get_fallback(u32 cp)
> >    if (single)
> >     return ucs_fallback_singles_subs[single - ucs_fallback_singles];
> >   +	/*
> > +	 * Full-width to ASCII mapping (covering all printable ASCII 33-126)
> > +	 * 0xFF01 (！) to 0xFF5E (～) -> ASCII 33 (!) to 126 (~)
> > +	 * We process them programmatically to reduce the table size.
> > +	 */
> > +	if (cp >= 0xFF01 && cp <= 0xFF5E)
> > +		return cp - 0xFF01 + 33;
> 
> So do really »+ '!'« instead of »+ 33«.

Uh... why? Having both as numerical value is more meaningful and clearer 
here IMHO.


Nicolas
---1463781375-782106772-1746626656=:8235--
