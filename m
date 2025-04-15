Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78135234970;
	Tue, 15 Apr 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743826; cv=none; b=GJRgPZDdBryRNgIAIVlR9qk4Yvlp5g3mjBgVAjMpa8jEmsvpNAz1zzVERzY4v19DkfVHJVs5NMsCSLoxJ9HB83S7DTKzrFmfvVARmUSRLVFdtAbx3LEdak35VThR+X9Hj6Emyfj6ASKXnYZ2NyM1FNCroMCRlg8/4V3CN9B1T0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743826; c=relaxed/simple;
	bh=mcjkbAoHhPtKJlOUpUxmzztxSinoGMClBv6xjBc8Ftg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tw+0kUx8MK4UomAw4GM5ELUnYtEXaSUxEl4KbAq0LzWLoDjpZ8qtRZZmTH9j2vIn0joT++VGXCoUxH/HhUiGQc6vsY64ilSczzGb+4EarTec4bM+KSQQTVrEaSB9CwPyhB+vG39fzI9lWFhHJhDpGSKBYsPPGuTkVxfT/kF0a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DhUzGyr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gwOgZ7bB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DhUzGyr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gwOgZ7bB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 720D611401E7;
	Tue, 15 Apr 2025 15:03:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 15:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744743823; x=1744830223; bh=J/Vz+ktTWE
	j58NA7jhTm3HQEBVtzcjFWdfCuCMkRR2o=; b=DhUzGyr9sGyyb+BeTG3IsjBox/
	7Rmd5s2icghxbgJMpyw2eWGICJkDOhD5IjZcr/97JaHolHrAJOCMh1BID5RPnqQA
	sUGelzOnGUpYCqD/lzRCCeTZZhdlbwiG+NCWCezpjY92dNurjUrGT9d+FYv4e2XC
	utFGnTk4y4YLq7VluRdTEeqPkuI+b5dhsKZlHL1UG5y5hPVqjghOCL98FaafGzU6
	kmvs/QH0rDg8TFZZ7p91Tk9hiVAUpbndgW9Ox9+1ZAPZxUEdyKokeD8Ox/4qwkuR
	PiEnkLTsDcg6ikQzVdpnlUmuQBpG88/nvn2CxMcNaX5/C2Xww/j5XiRdbe2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744743823; x=1744830223; bh=J/Vz+ktTWEj58NA7jhTm3HQEBVtzcjFWdfC
	uCMkRR2o=; b=gwOgZ7bB+FKqNJyfNQOu3H9gu+wDOy6B9kJs4VHEoH3QlOLObQ+
	TtOtq8vL7hbTIFAVR3kgQq8GV4Dv5zSKd90ioTApdE0ao5/nAjrfO59t+st502Sj
	/L6KpQmQSrgzCcQvmSQaGeZ5zCyY0NIkafCbt1wSekEJbFs1QPJ+aO6Gi2t/SB48
	nqYxQDTIljzTvAC4/h40gm0+f19iMwa2u8Jtub8cokks2KxGGyIPRc73vTlzqX61
	l+5EAHb9LPg3VP5O42Bhslz65DQXdMDFr6m6rOGzCvR37avTovfQ78bI5KzsdDpD
	EAv7yQ6t3OawHZh/YgDJff3IsksYmMDYwlQ==
X-ME-Sender: <xms:j63-Z_n_MfPNtqI4gCFQJuikptOBRyjyhbYG6z3XZwQgDcrNzcwHlA>
    <xme:j63-Zy3PxacplK-Zecgn9szYV5couLSnzx6xVN0a2sPwvtDq8Ac9mmEPI_M7FJot3
    q210Cz74zY6-DWVT8c>
X-ME-Received: <xmr:j63-Z1r8NyKH1um36zOVj-6k6a_8nrvWT4TWjWqh12QaDenCMRS32mEXHt15h5m9Pxd34B4UXZ8XoJj5VlhrxSa4Td1g4qsBB7oCoqbsAoqDo4A_wg>
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
X-ME-Proxy: <xmx:j63-Z3m6atK3gmdaBFt9wlYoBpvpxyKuSZWBQemNozI6z-uuHqAL4w>
    <xmx:j63-Z93fyYyiO_pQhBVu8H1aYr2PDSg1QKXjkru0_wfjr4RIbEC-mg>
    <xmx:j63-Z2t7t9dsqrC44dwkFxov-aBbJe7YdqaLquGyMoWNVr6Y-uVsyQ>
    <xmx:j63-ZxVAQ7XfcQyUlLJ0Vr9QR9QfRKSAfagRVpysiL9DsYpqHTaTHw>
    <xmx:j63-Z2L6YhBp-Bm13ZWsZtwHcWxoItKD7hslK6YxYfd4_j_bODGm8X-G>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:03:43 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 503F01116595;
	Tue, 15 Apr 2025 15:03:42 -0400 (EDT)
Date: Tue, 15 Apr 2025 15:03:42 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] vt: move unicode processing to a separate file
In-Reply-To: <033f5e95-3fef-4f76-97db-2f68a023f74a@kernel.org>
Message-ID: <98528n67-80p0-25p9-o7n6-4r6n707n2p00@syhkavp.arg>
References: <20250410011839.64418-1-nico@fluxnic.net> <20250410011839.64418-3-nico@fluxnic.net> <033f5e95-3fef-4f76-97db-2f68a023f74a@kernel.org>
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
> > This will make it easier to maintain. Also make it depend on
> > CONFIG_CONSOLE_TRANSLATIONS.
> ...
> > --- a/include/linux/consolemap.h
> > +++ b/include/linux/consolemap.h
> ...
> > @@ -57,6 +58,11 @@ static inline int conv_uni_to_8bit(u32 uni)
> >   }
> >   
> >   static inline void console_map_init(void) { }
> > +
> > +static inline bool ucs_is_double_width(uint32_t cp)
> > +{
> > +	return false;
> > +}
> 
> Is this inline necessary? I assume ucs_is_double_width() won't be called
> outside CONFIG_CONSOLE_TRANSLATIONS?

It is, alongside the other functions in this header file.

