Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF513446CC
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632481; cv=none; b=qTCnYmGCJSn8YK0TnqsJnw9sriTvGOhs69fVDNL43LRs56vSrtNaex1R5PF9CFcd1wPRpO3fWLdN9+i+XrFTWUF9EcfDczOqIs0o2jBcmNrHTvoNDzeIntrc8uI4FIswrx2FhKuQJQ4lTey/gPe1w9l5pGBqSLsMuajOJjqbXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632481; c=relaxed/simple;
	bh=K1yjrCPCVFl+0743TU+lUTmtiKPYTN9GLzv32dfBJ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCSCXsMGnGhlAKbgOu76IzxCpyQMDj2lhkOtoJ6j1vsTNK8fwkSE9tn6S1ijZlf+NBQzCyv3uB3QgtXa/AovGyz9F46C0kDi4wnUxTf7ZQNpM9MTWtiXzAQG+hHsTnhrQilqqTsVStggWJlJ9+gDYePsxP4Wzz3IySfUzEQQFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7o2DAWf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hy2/oYEY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/FplIGj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Wyy6vLV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7o2DAWf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hy2/oYEY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/FplIGj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Wyy6vLV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB1F53E6FF;
	Mon,  9 Feb 2026 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770632479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut5+fbmsktqfIYu91bRTa+2907FvwwEE0Htfc/gw3eA=;
	b=J7o2DAWfW95ct3+X/QHLKI4DHgR5FrT3ecIPdL0DIk8oT7bKf5aA9YVuYuV3wi2N1j7nBd
	+gi6mJM8J84KbZqHn7Xorh1M3NTVmvQSAMqz1OnvoOInZhmcbyZvMdALbhkbyFxJjn6yv7
	tZaHwEXXi/FAQ6l03UBQwUx5rjDRzrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770632479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut5+fbmsktqfIYu91bRTa+2907FvwwEE0Htfc/gw3eA=;
	b=Hy2/oYEYeOOhJWnSEeCP+O5bR3KMDnEIKc8FwUwKZHP6OVQMW1bbqcuVO7wqFxlO9eexwy
	vSspNHZUv/fE4ABw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770632478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut5+fbmsktqfIYu91bRTa+2907FvwwEE0Htfc/gw3eA=;
	b=s/FplIGj2ii/iVmWNZXT7PcdKDf0Ty1v6GQF6F6Mvf9r7Fvqedzex1ILPXr4sTvyGJpLmb
	ZPovULdd43pE11AoQTo8ZfDpvHkNTwYz9k9e+Y3bwzMVzJJhvOpE2GoL5sGlVVCnLn/nYw
	VJagiwOZjX43/khJi+QxCMX4/oWY3Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770632478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut5+fbmsktqfIYu91bRTa+2907FvwwEE0Htfc/gw3eA=;
	b=9Wyy6vLV1ud9JdfgHPYXTpZCeiiTtl3cQ7WeieOrHmmIIAlwJQ0KNB64f9dlM30gXEgf6y
	EntaouYdHTn3s+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB11E3EA63;
	Mon,  9 Feb 2026 10:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uv2ELR61iWnXLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 09 Feb 2026 10:21:18 +0000
Date: Mon, 9 Feb 2026 11:21:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, duoming@zju.edu.cn,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsterba@suse.com, jirislaby@kernel.org, kuba@kernel.org,
	alexander.deucher@amd.com, akpm@linux-foundation.org,
	pkshih@realtek.com, tglx@kernel.org, mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <20260209102117.GZ26902@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, Feb 08, 2026 at 06:25:38PM +0100, Jiri Kosina wrote:
> On Sun, 8 Feb 2026, Greg KH wrote:
> 
> > > I don't have the real hardware. In order to reproduce the bug, I simulate 
> > > the IPWireless PCMCIA card in the qemu by allocating and configuring the 
> > > necessary resources(I/O ports, memory regions, interrupts and so on) to
> > > correspond with the hardware expected by the driver in the initialization 
> > > code of the virtual device.
> > 
> > I wonder if this device even is still around, given that pcmcia is all
> > but dead for a very long time.
> 
> I doubt that this device is still around anywhere where reasonably new 
> kernels (including LTS) would matter.
> 
> I don't think I've seen this device (which was back then donated to me by 
> T-Mobile CZ in order to get it supported in Linux, and I am not sure how 
> much global adoption it got afterwards) for, let's say, past 15 years :)
> 
> I think (let's see what David, ho took the maintainership over for me 
> afterwards, has to say) we'd better deprecate and drop the whole thing, 
> rather than trying to pretend that it's still actively being taken care 
> of.

https://lore.kernel.org/all/20230223172403.GW10580@suse.cz/ last time
the question of keeping the driver was asked (2023). Back then I was
able to find the cards on second hand market but now I can't on a local
market and there's exactly one hit on global eBay.

Local linux related or telco support forums seem to mention the driver
until 2011 (root.cz, abclinuxu.cz, t-mobile.cz). It does not prove
nobody is using it but I think the chances are quite low to justify
keeping the driver.  It is simple enough to be built as an external
module eventually, I can help with that in case somebody really needs
that.
