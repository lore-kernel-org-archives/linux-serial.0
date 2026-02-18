Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2F1A23AC
	for <linux-serial@vger.kernel.org>; Wed, 18 Feb 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428214; cv=none; b=FM1+mXuB7HyCyxmA7fr4lTyVNUcxLOUXXSdE057+qfqHMknuGt/rzwXcbLdXU31k6bSOIVLrokxvYoyF6dUWR7grOZTU1e1djOGk+c/kzCKIdxWOC2887nPCs80o6nfNSxJbVsOSkzEjB6LUQavo1mkmnjWdm29RCzDMMCA2f+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428214; c=relaxed/simple;
	bh=mhPqJzI0yWGruJaPBUGh8aE3tGzrtb17vYK7Vwp7/qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/jgYLkQqCCFEe5wha1U0hxtBMGxE+Yeq4m63F0zgqDy9BZnK/vc+wqsVCQ1PTGDL3cTE5CW5hfKkUKpXi4m7b+IARHJ2xioJ6fd4LlBlfawAzwP0kVfps3IhClP+TL9Jr8hlzVS+GK1OMZyrjZVkVHcciteCi9iMZpT/ceqYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hZ2yRAcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UWFo84kH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bOIOGNLX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LSyAukfI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hZ2yRAcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UWFo84kH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bOIOGNLX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LSyAukfI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E99AC5BD15;
	Wed, 18 Feb 2026 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771428212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e87bQUb4+fgkx1dSQyPFUyQC+gAZtu61SMknJ+762to=;
	b=hZ2yRAcVrXrUn/yYQl6MpwWLZUoy+0PPZjUi672Gg7MqOIcEHZY/hSpypFlR/IjB0JREv9
	20FvhhrxNV17S6oRsP073r7PvmvF6boJi38S/3Cf904vpT/ZOtXTpyU/Qu2p0jWVHoRgtz
	fMHQzutbbH9L35e3MgQQtSgLAcInvXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771428212;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e87bQUb4+fgkx1dSQyPFUyQC+gAZtu61SMknJ+762to=;
	b=UWFo84kHMTO4LiYq1ahOlqSIU16znS+wNI4szzjnl4e6OVYEY7y+h+8ZbKs3z1upAtHO3M
	f+qniVEAz/meZiDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bOIOGNLX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LSyAukfI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771428211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e87bQUb4+fgkx1dSQyPFUyQC+gAZtu61SMknJ+762to=;
	b=bOIOGNLXJcxMyi5zFUyHNhPT+Tu8pXA3a6EUH64M8xAJUVEXKoJZhVGkEkMPZIqyb6Ud37
	MnN6ZKHcnpgpeVGUMejV1g7vJ5svgcb+aIayjIHA4EwGzr3aXIGEeBPXrzJKphdBXJa81d
	iyl1sgDC/yESNIScoPA4c84nSva/aWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771428211;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e87bQUb4+fgkx1dSQyPFUyQC+gAZtu61SMknJ+762to=;
	b=LSyAukfIqFpUzqPOHGTNNgTG3+6+Ml4Zyw+YkCPiTNwVkIGAAtcz36v2BB2WgNO3scl8R/
	u2Ca/4swryEamhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B48393EA65;
	Wed, 18 Feb 2026 15:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4qngK3PZlWnQVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Feb 2026 15:23:31 +0000
Date: Wed, 18 Feb 2026 16:23:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	duoming@zju.edu.cn, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsterba@suse.com, kuba@kernel.org,
	alexander.deucher@amd.com, akpm@linux-foundation.org,
	pkshih@realtek.com, tglx@kernel.org, mingo@kernel.org
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
Message-ID: <20260218152330.GI26902@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
 <20260209102117.GZ26902@suse.cz>
 <a77224d3-04d8-4a62-bb48-06fee922013c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a77224d3-04d8-4a62-bb48-06fee922013c@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: E99AC5BD15
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Feb 17, 2026 at 09:03:25AM +0100, Jiri Slaby wrote:
> Hi,
> 
> On 09. 02. 26, 11:21, David Sterba wrote:
> > On Sun, Feb 08, 2026 at 06:25:38PM +0100, Jiri Kosina wrote:
> >> On Sun, 8 Feb 2026, Greg KH wrote:
> >>
> >>>> I don't have the real hardware. In order to reproduce the bug, I simulate
> >>>> the IPWireless PCMCIA card in the qemu by allocating and configuring the
> >>>> necessary resources(I/O ports, memory regions, interrupts and so on) to
> >>>> correspond with the hardware expected by the driver in the initialization
> >>>> code of the virtual device.
> >>>
> >>> I wonder if this device even is still around, given that pcmcia is all
> >>> but dead for a very long time.
> >>
> >> I doubt that this device is still around anywhere where reasonably new
> >> kernels (including LTS) would matter.
> >>
> >> I don't think I've seen this device (which was back then donated to me by
> >> T-Mobile CZ in order to get it supported in Linux, and I am not sure how
> >> much global adoption it got afterwards) for, let's say, past 15 years :)
> >>
> >> I think (let's see what David, ho took the maintainership over for me
> >> afterwards, has to say) we'd better deprecate and drop the whole thing,
> >> rather than trying to pretend that it's still actively being taken care
> >> of.
> > 
> > https://lore.kernel.org/all/20230223172403.GW10580@suse.cz/ last time
> > the question of keeping the driver was asked (2023). Back then I was
> > able to find the cards on second hand market but now I can't on a local
> > market and there's exactly one hit on global eBay.
> > 
> > Local linux related or telco support forums seem to mention the driver
> > until 2011 (root.cz, abclinuxu.cz, t-mobile.cz). It does not prove
> > nobody is using it but I think the chances are quite low to justify
> > keeping the driver.  It is simple enough to be built as an external
> > module eventually, I can help with that in case somebody really needs
> > that.
> 
> So, would you want to submit the removal? Or anyone else, if you don't 
> want to lose time with this? (I can do that, if noone wants to.)

Let me do it after rc1 so I can finish the journey of this driver which
was my first nontrivial contribution to linux kernel.
