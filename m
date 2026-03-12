Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CB23BD1D
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316846; cv=none; b=g93BWp148tfhIz/gFxTTqDPmgSyOVaG2CknPq61tyGGEddJSjSoFDXXPKdGgENEud4ls1ThU2H0h1Rg3tBh5HK2Z8nREsg861xw1v4cMBngfkSGGB2ZFcUsgd6Oo0Mojj1ADelKwYW+ef0tU8MwOwbv7iqXZpxOFJQB5/T2/zC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316846; c=relaxed/simple;
	bh=0ILncCD6iAeaOnaYYfhGEh7wWpvUHAG3i7kHqhki7nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQj1G1Dg6XJhtoEzJldTcJab9LQyA1iumgR19NwqaNd3aMK2sd+ptVcJnRKszS4bLjm2I5//i0mZe33iVB20q1Q8C+v/bJXWXnBuRcUjNjPs7FzlKrccIuTwB4pie351YLbTanLZp7P+4m5944ux72VH/UwuIaYPN47+U6r4Olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vgik3o0Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qjHyFP+e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6X00K1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f2e5iXPy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vgik3o0Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjHyFP+e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6X00K1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f2e5iXPy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 830985BCE3;
	Thu, 12 Mar 2026 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773316843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IwEWt9jm6g4BZDhJf+ymJnu3hCdId0O2UUxkMU3yL4=;
	b=Vgik3o0QY4QlpxiVwDUkAFUjSt9KZvU4zwcq35jLpBj5JRhfO4kapSXC2issCmGR3h4YXl
	0U1aHR8OvagVHaNQR10ULjnI49MdOkR7LOXE4NWQtcoqefj9lysIaY47Ge/SvmsN1OFPfG
	2CuoxJXlO5Dlj1qPlwXSFBcHuNtb44A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773316843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IwEWt9jm6g4BZDhJf+ymJnu3hCdId0O2UUxkMU3yL4=;
	b=qjHyFP+eLNEFmt1kBEkUn3Iy/7S6cd9iXEcU1Z19uXK5YT6ry8isu55Y+vJix/ZODvu+nz
	mrso9KzYLDAb09AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e6X00K1M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f2e5iXPy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773316841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IwEWt9jm6g4BZDhJf+ymJnu3hCdId0O2UUxkMU3yL4=;
	b=e6X00K1MvMa4jSI+h59jCgMR49aDfKWslPRl5HbVEE8bIHCN9zbhBjHYFw6KS18YqKsuli
	0jM/fSNBvQcarTFCg3cPy1gMWg7hcEfkKRPMI+tATwsoU72bacpK42umSeAaHE8HeRtnnj
	zne1SfoBrt0rO2oWeqICvlaASfRGIJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773316841;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5IwEWt9jm6g4BZDhJf+ymJnu3hCdId0O2UUxkMU3yL4=;
	b=f2e5iXPyxBWNMj6hho4dyeTwfSGaN8ScHhP901MF5iV9NZJhsXf5eIE9ZbuiAdQiruH2on
	2+AWPr4YURUUOADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625CA3FF62;
	Thu, 12 Mar 2026 12:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kTvbF+mqsmmlTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 12 Mar 2026 12:00:41 +0000
Date: Thu, 12 Mar 2026 13:00:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, David Sterba <dsterba@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	Ben Martel <benm@symmetric.co.nz>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: fix memory leak in do_go_offline()
Message-ID: <20260312120036.GF5735@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260306034058.386747-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306034058.386747-1-dqfext@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 830985BCE3

On Fri, Mar 06, 2026 at 11:40:58AM +0800, Qingfang Deng wrote:
> The ppp_channel is allocated and registered in do_go_online(). But when
> the channel is unregistered in do_go_offline(), the driver forgets to
> release its memory. This leads to a memory leak each time the network
> goes online and then offline.
> 
> Fix this by adding a kfree call after unregistering the channel.
> 
> Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>

Thanks, but the driver is going to be deleted.
