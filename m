Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEB183098;
	Thu, 15 May 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324951; cv=none; b=qbUgVBOeusHsZQRLomaWrQwIDl/NRwgEIuNUvOqT5x8YMNt7WXot9LXKArLNTgJEpGztZ1gOnxulXvxXzwpeUSAx5tlBbDUZMNAfBtKgAqaKZG41g1P/ZNSuje5SeIgj1iHkEVmBxYawITX02FUYFkpzvifNqNDkb8VQfUjNSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324951; c=relaxed/simple;
	bh=+jxh/91ZwYot/rXXPUFVYzOzUNIq7OkxuhyfAyzTctM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g80oQmCRrEfQ1IC/CLOcXLE6eeZqgpQbTvI4kV3ICU9TMxCaNwMSb0rUWJQhTcTHzmGpQ8U0vm4O+bqV6yBmhONFNF9ZBJvg2p8+mM7krswoS8o1J06yjaYj6CKdqRsTuzGc5inP3U1Ks3JcW+LUBQqXUUWeDZ6wyv9Qssh+uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=j6fltvUL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBFWU8NR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="j6fltvUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBFWU8NR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F253311400C3;
	Thu, 15 May 2025 12:02:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 15 May 2025 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747324947; x=1747411347; bh=Kg9Ufp9G3T
	sDGFSWQj35v9C2rVqls6ZUXGXJZJegDoA=; b=j6fltvULKV/9epxHzvKhVFFAUS
	TsEKXzIFuWCba5vOrAPqtgOmVL8lt3ylC/MIWNEpVvxv+/2e5kPy6TEA8bWNHA2n
	VAYwitA01iAT25NR1GxqdaoFUqhbuLj21pJ8Ou4KwHNYM+k7ZgDTq0QTYWHufnqI
	jekM8Mx0sUQ+QLq5uK6IaDPTJf2bu1kR0KEjqWNu3pYzUvK3HzyID8PPRJZmjSjt
	q2Q05YCx2GiEwcZAjQO8KO1Wrs9XUnOqtl3YkMP7rS/hDkideEU6AmsqxY9gPd7l
	dOkF5DMtqFdGrBnkKE4LtvZMyhRcqWhv2rkermhMEJlovctNQpjbLdByOTOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747324947; x=1747411347; bh=Kg9Ufp9G3TsDGFSWQj35v9C2rVqls6ZUXGX
	JZJegDoA=; b=jBFWU8NR25g29+469fc0iiueuuDvDV6RaZj8rxNZH13TLV1BMLE
	+iZi8wI0a0r+otjjOJ0pnf2pYhSD5+oUBDq8g/c/6+wfLdLSDvfkl7CshPNMrDaD
	iBanTqHsgx5cwbjmUOCTLEveT4mbHYOHBBJMG4vP9zSh5xYr+8z6e+nd7k0cimMJ
	l60WaQ7E3QjI5jNuJO9HzjRIGKykpBn+jf2JYpoNy4UJDfWmzOPwHkklGTAjws8x
	3V+eHD+cJpSVK+wA4c2asCcnxdiN1Ej66qOKJPNmQNw6oY948MKMrVEs5CI934LM
	lOfNvhWqfpnidbckeopVQkb9aGxBK8Gsunw==
X-ME-Sender: <xms:ExAmaPpTtlY4t4Y6YCcI-Amb0cdfOw3vTLA8awgQyPvLIt8uBedZ1Q>
    <xme:ExAmaJp5gjnMj7xdprH5RG8GmKyaYoz70bDHDJAcDJEqCRJ_fJv9nj75RrRvN9Tu-
    czlpp4KsGA-CqHU2P8>
X-ME-Received: <xmr:ExAmaMN6JlMjZ8FxeUU31_eP0HdJWIlju1sZuDdMyp92xLncXIh55sQOIK8TUdlw1ugGHiYJMqBEAQIyolvePf7JSeiApPD-GsskNmXva3weM3dAiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ExAmaC7jVITjekgX311pov3FJmQvY-UGuCprTcQWe34Hstshdgcr8A>
    <xmx:ExAmaO7S6ypU9MFyNbAGT2dcBOoOr8dZdSTfOCQKRo6EQlZEfh8__g>
    <xmx:ExAmaKg_OX4k_Y2gvEJnZyKYPCriKT2X7KcUahqxrmZEX011J1Wu4g>
    <xmx:ExAmaA6cDv9rU16jg0j-yi0qIieX1OFqr8loVquqZ4IEj-nxDf-aEg>
    <xmx:ExAmaBdN-vk8OTJp5nJrs1Yz4pktT-hswXntocoGgcKwsSXqoDFr6z1y>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 12:02:27 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C852811A437D;
	Thu, 15 May 2025 12:02:26 -0400 (EDT)
Date: Thu, 15 May 2025 12:02:26 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console
 size and cursor position
In-Reply-To: <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org>
Message-ID: <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg>
References: <20250514194710.6709-1-nico@fluxnic.net> <20250514194710.6709-3-nico@fluxnic.net> <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Jiri Slaby wrote:

> On 14. 05. 25, 21:42, Nicolas Pitre wrote:
> > From: Nicolas Pitre <npitre@baylibre.com>
> > 
> > The console dimension and cursor position are available through the
> > /dev/vcsa interface already. However the /dev/vcsa header format uses
> > single-byte fields therefore those values are clamped to 255.
> > 
> > As surprizing as this may seem, some people do use 240-column 67-row
> > screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
> > close to the limit. Monitors with higher resolution are not uncommon
> > these days (3840x2160 producing a 480x135 character display) and it is
> > just a matter of time before someone with, say, a braille display using
> > the Linux VT console and BRLTTY on such a screen reports a bug about
> > missing and oddly misaligned screen content.
> > 
> > Let's add VT_GETCONSIZECSRPOS for the retrieval of console size and cursor
> > position without byte-sized limitations. The actual console size limit as
> > encoded in vt.c is 32767x32767 so using a short here is appropriate. Then
> > this can be used to get the cursor position when /dev/vcsa reports 255.
> > 
> > The screen dimension may already be obtained using TIOCGWINSZ and adding
> > the same information to VT_GETCONSIZECSRPOS might be redundant. However
> > applications that care about cursor position also care about display
> > size and having 2 separate system calls to obtain them separately is
> > wasteful. Also, the cursor position can be queried by writing "\e[6n" to
> > a tty and reading back the result but that may be done only by the actual
> > application using that tty and not a sideline observer.
> > 
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > ---
> >   drivers/tty/vt/vt_ioctl.c | 16 ++++++++++++++++
> >   include/uapi/linux/vt.h   |  9 +++++++++
> >   2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> > index 4b91072f3a4e..83a3d49535e5 100644
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -951,6 +951,22 @@ int vt_ioctl(struct tty_struct *tty,
> >    				(unsigned short __user *)arg);
> >    case VT_WAITEVENT:
> >   		return vt_event_wait_ioctl((struct vt_event __user *)arg);
> > +
> > +	case VT_GETCONSIZECSRPOS:
> > +	{
> > +		struct vt_consizecsrpos concsr;
> > +
> > +		console_lock();
> > +		concsr.con_cols = vc->vc_cols;
> > +		concsr.con_rows = vc->vc_rows;
> > +		concsr.csr_col = vc->state.x;
> > +		concsr.csr_row = vc->state.y;
> > +		console_unlock();
> 
> Makes a lot of sense!
> 
> > +		if (copy_to_user(up, &concsr, sizeof(concsr)))
> > +			return -EFAULT;
> > +		return 0;
> > +	}
> > +
> >    default:
> >    	return -ENOIOCTLCMD;
> >   	}
> > diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> > index e9d39c48520a..e93c8910133b 100644
> > --- a/include/uapi/linux/vt.h
> > +++ b/include/uapi/linux/vt.h
> > @@ -84,4 +84,13 @@ struct vt_setactivate {
> >   
> >   #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a
> >   console */
> >   
> > +struct vt_consizecsrpos {
> > +	unsigned short con_rows;	/* number of console rows */
> > +	unsigned short con_cols;	/* number of console columns */
> > +	unsigned short csr_row;		/* current cursor's row */
> > +	unsigned short csr_col;		/* current cursor's column */
> 
> Use __u16 pls.

I beg to differ. Not because __u16 is fundamentally wrong. But 
everything else in this file uses only basic C types already and adding 
one struct with __u16 would look odd. And adding some include to define 
that type would be needed since there are currently no such includes in 
that file currently, and that could potentially cause issues with 
existing consumers of that header file that didn't expect extra 
definitions, etc. So I think that such a change, if it is to happen, 
should be done for the whole file at once and in a separate patch.

> > +};
> > +
> > +#define VT_GETCONSIZECSRPOS 0x5610  /* get console size and cursor position
> > */
> 
> Can we define that properly as
>   _IOR(0x56, 0x10, struct vt_consizecsrpos)
> ? Note this would still differ from "conflicting":
> #define VIDIOC_G_FBUF            _IOR('V', 10, struct v4l2_framebuffer)

Similarly as the reason above: given that no other definitions in that 
file use the _IO*() scheme for historical reasons, it is preferable to 
follow what's already there to avoid unsuspected confusion. The VT layer 
is pretty much unlykely to grow many additional ioctls in the 
foreseeable future so I'd lean towards keeping things simple and in line 
with the existing code.


Nicolas
