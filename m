Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5033D1A97
	for <linux-serial@vger.kernel.org>; Mon, 27 Jul 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182024; cv=none; b=Ja9BydYy5nu+60dMUZ5xrsTNv3IOhOXPXa81WTqLoAlNQ3dpmc4cudvjFdBV5jPbJ3AEB9hXr4sUhDq7SxWZLtztpNYOLRLPwVUbw1MXGk+dgP1iNMc7z57PxhOzeiVH5wiJs7nCY9tprnPZgzwjvsGDQgOCiWA+K6Ag8gVwV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182024; c=relaxed/simple;
	bh=gAAxZKIyEcfJLI425yiasOIFzLYrb7Gl9bcvJNvEVbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBFbeU3VGFhsP0TxtGgVcZk4gCi/ZuIYv764T/w5YWRlYykfWTZwFtVYpGQD0wGIAKFIZgrU9MZYhUwzaEhtNLF/sR7FDO2IkVC1ZgDG5Qyv0VZszC65ItfIX25JX/6tgtxQUHr5Ka3CpTbz1SQ4PArdQVSjCZZuK6BX4Fm0LYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DwNykQXz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSGwYQtV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2kGgIS3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wzTt/IEU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DwNykQXz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSGwYQtV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2kGgIS3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wzTt/IEU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 389BF7BD6A;
	Mon, 27 Jul 2026 19:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785182015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z99wmYklWRGyPmK3kx/GPbf3u6YEMTNGMez/EIBRW6U=;
	b=DwNykQXzCOOM/lrk6y6JUIjWm/NI7fJ1OpSMF9MnukZFDAx0jeqNH0p4uO7TRNLqLmTUAG
	+Zhk7SoF//xqVn+7JmlQkkt+TmbT6DOqz+yd7CwHTHbgWvQIz0jc0DTi9I2mqhSOKoCq7A
	bS8LwqaqsN7j7OFnJRWklfCUAhFyWmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785182015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z99wmYklWRGyPmK3kx/GPbf3u6YEMTNGMez/EIBRW6U=;
	b=WSGwYQtVJj7xA5Mz3eX4Wyql5X9mpm49oXrXyHlJBQVBF7oDl8PXPwtHUpenrPDXGrvZre
	jghNdwNPcSnne8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785182011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z99wmYklWRGyPmK3kx/GPbf3u6YEMTNGMez/EIBRW6U=;
	b=B2kGgIS385Lz2A0WB0BmK42bXbH7yLP4sLHx+c7j9K2bLqy/EttUbQ8Put6IrncUQhTVyn
	d9jn+PGkXTi4DNqpCIQu9L/BFGrrcnqqKmNr5jzFo98ftj6tuoMIr+p289G360PhS5NCY1
	FeWnWIxMRHO3JuzpQ86OXtQ/u5u7IT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785182011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z99wmYklWRGyPmK3kx/GPbf3u6YEMTNGMez/EIBRW6U=;
	b=wzTt/IEUaXcALebe33/6g4qwEBl1STDtlOTH+CF2CwCXtmqS+EpTG+YhOoSARRBsiSJQbR
	KLjmKCPP2OHjCNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24FC1779B9;
	Mon, 27 Jul 2026 19:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6PuQCDu3Z2otdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 Jul 2026 19:53:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC01DA0BA1; Mon, 27 Jul 2026 21:53:30 +0200 (CEST)
Date: Mon, 27 Jul 2026 21:53:30 +0200
From: Jan Kara <jack@suse.cz>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.com>, Yangtao Li <frank.li@vivo.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] quota: remove CONFIG_PRINT_QUOTA_WARNING code
Message-ID: <5cxumyfngrzddts3igtfqhogyabpjf5jywabpjclimnzy5pug6@e34tyng6thbg>
References: <20260722060155.1111519-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722060155.1111519-1-jirislaby@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 22-07-26 08:01:55, Jiri Slaby (SUSE) wrote:
> CONFIG_PRINT_QUOTA_WARNING was marked as BROKEN in 2023 by 36d532d713db
> ("quota: mark PRINT_QUOTA_WARNING as BROKEN").
> 
> The code is apparently unused and uninteresting, so remove it all, incl.
> the abuse of TTY.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jan Kara <jack@suse.com>
> Cc: Yangtao Li <frank.li@vivo.com>

OK, I'm for trying this because so far nobody was complaining about the
feature getting marked as BROKEN. Let's see how it goes...

								Honza

> ---
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: loongarch@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> ---
>  arch/loongarch/configs/loongson32_defconfig |  1 -
>  arch/loongarch/configs/loongson64_defconfig |  1 -
>  arch/mips/configs/bigsur_defconfig          |  1 -
>  arch/mips/configs/ip22_defconfig            |  1 -
>  arch/mips/configs/loongson2k_defconfig      |  1 -
>  drivers/tty/tty_io.c                        | 27 -------
>  fs/quota/Kconfig                            | 10 ---
>  fs/quota/dquot.c                            | 81 +--------------------
>  8 files changed, 2 insertions(+), 121 deletions(-)
> 
> diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
> index 7c8f01513ed2..3d552eb526fe 100644
> --- a/arch/loongarch/configs/loongson32_defconfig
> +++ b/arch/loongarch/configs/loongson32_defconfig
> @@ -974,7 +974,6 @@ CONFIG_FS_VERITY=y
>  CONFIG_FANOTIFY=y
>  CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>  CONFIG_QUOTA=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_QFMT_V1=m
>  CONFIG_QFMT_V2=m
>  CONFIG_AUTOFS_FS=y
> diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
> index 8e3906d3bd70..195cf40cdbca 100644
> --- a/arch/loongarch/configs/loongson64_defconfig
> +++ b/arch/loongarch/configs/loongson64_defconfig
> @@ -1005,7 +1005,6 @@ CONFIG_FS_VERITY=y
>  CONFIG_FANOTIFY=y
>  CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>  CONFIG_QUOTA=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_QFMT_V1=m
>  CONFIG_QFMT_V2=m
>  CONFIG_AUTOFS_FS=y
> diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
> index 611dc0dd392d..d2b18d5033be 100644
> --- a/arch/mips/configs/bigsur_defconfig
> +++ b/arch/mips/configs/bigsur_defconfig
> @@ -140,7 +140,6 @@ CONFIG_EXT4_FS_SECURITY=y
>  CONFIG_EXT4_FS=y
>  CONFIG_QUOTA=y
>  CONFIG_QUOTA_NETLINK_INTERFACE=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_QFMT_V2=m
>  CONFIG_AUTOFS_FS=m
>  CONFIG_FUSE_FS=m
> diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
> index 009e66299b69..09a77e5b249c 100644
> --- a/arch/mips/configs/ip22_defconfig
> +++ b/arch/mips/configs/ip22_defconfig
> @@ -238,7 +238,6 @@ CONFIG_XFS_FS=m
>  CONFIG_XFS_QUOTA=y
>  CONFIG_QUOTA=y
>  CONFIG_QUOTA_NETLINK_INTERFACE=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_QFMT_V2=m
>  CONFIG_AUTOFS_FS=m
>  CONFIG_FUSE_FS=m
> diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
> index ca534a6b66de..8fd863f4f7b0 100644
> --- a/arch/mips/configs/loongson2k_defconfig
> +++ b/arch/mips/configs/loongson2k_defconfig
> @@ -303,7 +303,6 @@ CONFIG_XFS_FS=y
>  CONFIG_XFS_QUOTA=y
>  CONFIG_XFS_POSIX_ACL=y
>  CONFIG_QUOTA=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_AUTOFS_FS=y
>  CONFIG_FUSE_FS=m
>  CONFIG_ISO9660_FS=m
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 6b283fd03ff8..a77bbccb274d 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1032,33 +1032,6 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -/**
> - * tty_write_message - write a message to a certain tty, not just the console.
> - * @tty: the destination tty_struct
> - * @msg: the message to write
> - *
> - * This is used for messages that need to be redirected to a specific tty. We
> - * don't put it into the syslog queue right now maybe in the future if really
> - * needed.
> - *
> - * We must still hold the BTM and test the CLOSING flag for the moment.
> - *
> - * This function is DEPRECATED, do not use in new code.
> - */
> -void tty_write_message(struct tty_struct *tty, char *msg)
> -{
> -	if (tty) {
> -		mutex_lock(&tty->atomic_write_lock);
> -		tty_lock(tty);
> -		if (tty->ops->write && tty->count > 0)
> -			tty->ops->write(tty, msg, strlen(msg));
> -		tty_unlock(tty);
> -		tty_write_unlock(tty);
> -	}
> -}
> -#endif
> -
>  static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct tty_struct *tty = file_tty(file);
> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index 818083a36bef..68eb441328ef 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -25,16 +25,6 @@ config QUOTA_NETLINK_INTERFACE
>  	  hardlimit, etc.) will be reported through netlink interface. If unsure,
>  	  say Y.
>  
> -config PRINT_QUOTA_WARNING
> -	bool "Print quota warnings to console (OBSOLETE)"
> -	depends on QUOTA && BROKEN
> -	default y
> -	help
> -	  If you say Y here, quota warnings (about exceeding softlimit, reaching
> -	  hardlimit, etc.) will be printed to the process' controlling terminal.
> -	  Note that this behavior is currently deprecated and may go away in
> -	  future. Please use notification via netlink socket instead.
> -
>  config QUOTA_DEBUG
>  	bool "Additional quota sanity checks"
>  	depends on QUOTA
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9850de3955d3..204afc5e984b 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -153,7 +153,7 @@ void __quota_error(struct super_block *sb, const char *func,
>  }
>  EXPORT_SYMBOL(__quota_error);
>  
> -#if defined(CONFIG_QUOTA_DEBUG) || defined(CONFIG_PRINT_QUOTA_WARNING)
> +#ifdef CONFIG_QUOTA_DEBUG
>  static char *quotatypes[] = INITQFNAMES;
>  #endif
>  static struct quota_format_type *quota_formats;	/* List of registered formats */
> @@ -1208,72 +1208,6 @@ static int warning_issued(struct dquot *dquot, const int warntype)
>  	return test_and_set_bit(flag, &dquot->dq_flags);
>  }
>  
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -static int flag_print_warnings = 1;
> -
> -static int need_print_warning(struct dquot_warn *warn)
> -{
> -	if (!flag_print_warnings)
> -		return 0;
> -
> -	switch (warn->w_dq_id.type) {
> -		case USRQUOTA:
> -			return uid_eq(current_fsuid(), warn->w_dq_id.uid);
> -		case GRPQUOTA:
> -			return in_group_p(warn->w_dq_id.gid);
> -		case PRJQUOTA:
> -			return 1;
> -	}
> -	return 0;
> -}
> -
> -/* Print warning to user which exceeded quota */
> -static void print_warning(struct dquot_warn *warn)
> -{
> -	char *msg = NULL;
> -	struct tty_struct *tty;
> -	int warntype = warn->w_type;
> -
> -	if (warntype == QUOTA_NL_IHARDBELOW ||
> -	    warntype == QUOTA_NL_ISOFTBELOW ||
> -	    warntype == QUOTA_NL_BHARDBELOW ||
> -	    warntype == QUOTA_NL_BSOFTBELOW || !need_print_warning(warn))
> -		return;
> -
> -	tty = get_current_tty();
> -	if (!tty)
> -		return;
> -	tty_write_message(tty, warn->w_sb->s_id);
> -	if (warntype == QUOTA_NL_ISOFTWARN || warntype == QUOTA_NL_BSOFTWARN)
> -		tty_write_message(tty, ": warning, ");
> -	else
> -		tty_write_message(tty, ": write failed, ");
> -	tty_write_message(tty, quotatypes[warn->w_dq_id.type]);
> -	switch (warntype) {
> -		case QUOTA_NL_IHARDWARN:
> -			msg = " file limit reached.\r\n";
> -			break;
> -		case QUOTA_NL_ISOFTLONGWARN:
> -			msg = " file quota exceeded too long.\r\n";
> -			break;
> -		case QUOTA_NL_ISOFTWARN:
> -			msg = " file quota exceeded.\r\n";
> -			break;
> -		case QUOTA_NL_BHARDWARN:
> -			msg = " block limit reached.\r\n";
> -			break;
> -		case QUOTA_NL_BSOFTLONGWARN:
> -			msg = " block quota exceeded too long.\r\n";
> -			break;
> -		case QUOTA_NL_BSOFTWARN:
> -			msg = " block quota exceeded.\r\n";
> -			break;
> -	}
> -	tty_write_message(tty, msg);
> -	tty_kref_put(tty);
> -}
> -#endif
> -
>  static void prepare_warning(struct dquot_warn *warn, struct dquot *dquot,
>  			    int warntype)
>  {
> @@ -1296,9 +1230,7 @@ static void flush_warnings(struct dquot_warn *warn)
>  	for (i = 0; i < MAXQUOTAS; i++) {
>  		if (warn[i].w_type == QUOTA_NL_NOWARN)
>  			continue;
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -		print_warning(&warn[i]);
> -#endif
> +
>  		quota_send_warning(warn[i].w_dq_id,
>  				   warn[i].w_sb->s_dev, warn[i].w_type);
>  	}
> @@ -3008,15 +2940,6 @@ static const struct ctl_table fs_dqstats_table[] = {
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -	{
> -		.procname	= "warnings",
> -		.data		= &flag_print_warnings,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  };
>  
>  static int __init dquot_init(void)
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
