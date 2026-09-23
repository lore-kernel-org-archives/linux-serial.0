Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61233AD517
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174363; cv=none; b=SJfiL/1t3Zp39bXvoJH9pJxsR37Nx6XD81vndRva7awu2fOFszIFgMWtIv9ZaTZxPVslj330TsRK51Cs5RIlfzNWVhbLNlAsmfUkDzHmRq0IoLl26DTe4OoGiudQo1XCAU8e2fPcftpDy7UdpcQ6xxG86Vq0quuI8vjHWJYrzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174363; c=relaxed/simple;
	bh=VFt5QFeL1qyvdUpQVKVvwCAbcdKtX7gDJTZ4RTPKRFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxDJwDm/4fuq4ejM4qoNIJ2a7FUvL9ob+XrQzJHdpu3AZOcxaexn6Gk3VFEaSd9jWJsw4shmRkVxYG20NJHuEgC9BiA4SeR0m+WOeIqZz6OnY/3bXNHo6Gslp+CNbrKFNjq7aOCTCK3l+QzOl95B2+0vncz2yOz18sePMr511w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YVVQkkDk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YVVQkkDk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so5730685e9.0
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790174360; x=1790779160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcGfrVG5c5yPpAOOLi+CwRHdzd99wiF/Zu4kVwYdMqw=;
        b=YVVQkkDkn14qIcIPV1C/wFmEEpUtc7fQA7C9IXfwqrZ3Zo1GuiUBBZejMHKQsepG4P
         F12+/nZZzJrzQTedePjZKFYRGMKb/IwiUhm5UI8QV/LWBQ/iLk9XhZ7a0IGe0wCLpkGO
         Lr5bpvoFWf9bZhpRmCGagT+fSMbEmXJNdb+MJQ5URIGZoqFhoBadomUGEUPAMLuW6j2D
         T5f5r9Btgx43OWzf9PYHc6CquxW090JiHthuCOwKTlSX5fh9UBTOIxx0kUB9NxzyMWgM
         yRRm3bQuFg0AlA7BF1IMhCTh6r2zx1IRMSNErVhV9rIezSNU+99VPDJjzy7pP9W4EiUZ
         ifPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174360; x=1790779160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcGfrVG5c5yPpAOOLi+CwRHdzd99wiF/Zu4kVwYdMqw=;
        b=pEySF6ETJ4t/nvLGU3NIHzvhjeKnMhC6XE6JHUX9zwZNQjlScM5t6iP5EG/4OhoqU1
         gm0CS5AcQXiQnJ4aXXBDpKVbGLN1XZvV9JtneV0IPLk1aWcuIg+8GVjdjcStgsQkTZy9
         mixQn86Awk8TAbVnGCjKNpyM2bhMQzwaDwHDp3i0Xyk6Q4sEiw8xxHmVgkb0s6dLG60q
         Km9Bj/VdAeR7NsIBEpCN+mHPXyBvWLI6JN96ZsqLBx0VtxDLi6LBWZR/APuTrn8apV4A
         EkCrQds3yoyw0Ec+U3/YsaK8XIS3bhSIrBnN76S27MytUzWqNI8n/rdJt3ztyluFs4Od
         rqiA==
X-Forwarded-Encrypted: i=1; AKwUvBySKXimBsLHuKz+bHlf+jXShSx4FnURhEopdWWVeiD52QXQNgVGa0e4DMKOWyKYo6qdcRDFtia9A18JJs4=@vger.kernel.org
X-Gm-Message-State: AFuF++likM3R5KdPSzFxOortbHs/ERQXKSYuvjml1a5GRCMLd2vigJKx
	DfFed7lhC2N2TNZrn8i0ir9ofckFSMhvFqgsnvNexTXsYG6yrhmxSr4UGeN4Jdap5BI=
X-Gm-Gg: AYBFou3LeHKR4R4iSEL9BZw6SwApdNdnA2CbiOYVdZURt2FHuq7jFw7sGljzxWKU5Ao
	HH7EazqUa2IbIMeoAEmTo5cfUF1WJVjNqrzoHWIjdMq8pfgrw68uLAgu3v0JVzld59D8iD6iM6d
	2dOs/Kg1c9zGzYBOHj1G4H21T9+nUfQnswwFhoagaTO67ph6ibH4PTtpxwvMOlBYBT4jx0lFaiM
	Cgx6DNZuc6jLVO7qAEWwhYpMPBFvsFMCsFa/Hvt5jMt3qpCLjcXNaUAmuWi9Q53XFhOsTZ61MR/
	klrHHisrwAwkAdOJX1Ym2xBVPFX7uooUySPvBVbPANIGd1iGiK3Bgqa35Vaf6+iluL1P+/pwCHg
	MASYqFgzySfjGneP06KtF9iWQ0pj9Hm0uDt7hWATkIyO6wWYbdwQAVXGGg5FaJyKOtFj3NEHDCS
	qpRU/bKPdk5tWboRS64iKuu8dYkphe1RwZHMrBuZVMMwjFjhpI2Qnn4n1Mh+En4VSccXMbQMfNe
	h2qBu7FsOK6+lM=
X-Received: by 2002:a05:600c:a013:b0:49f:ce78:3571 with SMTP id 5b1f17b1804b1-49fdf10d03emr36763305e9.34.1790174359895;
        Wed, 23 Sep 2026 07:39:19 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde185329sm82257335e9.1.2026.09.23.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:39:19 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:39:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] braille: nbcon: Use nbcon atomic console callbacks
Message-ID: <arPklfHCncdWHGT4@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <20260922072558.98854-3-pmladek@suse.com>
 <20260922073728.2ADCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922073728.2ADCD1F000FF@smtp.kernel.org>

On Tue 2026-09-22 07:37:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] braille: operator precedence bug disables braille atomic write
> - [High] braille: infinite spinlock in braille_write() during same-CPU unsafe takeover
> --
> 
> commit a7f38c0383481bd6ad9c244405d8d201d604569b
> Author: Petr Mladek <pmladek@suse.com>
> 
> braille: nbcon: Use nbcon atomic console callbacks
> 
> This commit adapts the braille console driver to support the new NBCON API.
> It introduces logic to acquire the nbcon console ownership before printing
> and uses the atomic write callback to output the buffer. The serial8250
> driver is also adjusted to skip prepending newlines for braille consoles.
> 
> > diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
> > --- a/drivers/accessibility/braille/braille_console.c
> > +++ b/drivers/accessibility/braille/braille_console.c
> > @@ -62,14 +62,32 @@ static void braille_write(u16 *buf)
> 
> [ ... ]
> 
> > +	if (braille_co->flags & CON_NBCON) {
> > +		/*
> > +		 * Braille console might be called from unknown context via
> > +		 * vt_console_print() from console_unlock() from printk().
> > +		 * Use the atomic callback and synchronize it just using
> > +		 * the console context. Disable interrupts to prevent a nested
> > +		 * call into the driver code which might cause a deadlock when
> > +		 * trying to acquire the console ownership, see
> > +		 * __nbcon_atomic_flush_pending_con().
> > +		 */
> > +		local_irq_save(flags);
> > +		while (!nbcon_braille_try_acquire(braille_co, &wctxt))
> > +			cpu_relax();
> 
> [Severity: High]
> Could this loop become an infinite spinlock if triggered from a nested
> context on the same CPU?
> 
> If an interrupt preempts the underlying nbcon console driver (such as 8250)
> while it is in an unsafe region, and that interrupt triggers a printk(),
> the legacy VT console might be flushed via console_unlock(), eventually
> calling braille_write().
> 
> Since local interrupts are disabled here, the preempted nbcon context on
> this same CPU can never resume to release the console. Because
> nbcon_context_try_acquire() rejects handovers to the same CPU when the
> console is in an unsafe state, won't this loop spin indefinitely?

For me, it is not easy to be sure but it looks to me that this code
is called deep in the generic vt code when handling vt_notifier_list
and keyboard_notifier_list. I guess that they already have to
synchronized against each other. At least the vt_notifier_list
operations seem to be synchronized using the console lock.

Anyway, the disabled interrupts should prevent nesting except
by NMI. But I believe that the VT code should not be called
in NMI because it uses locks. The only exception might be
panic().

An improvement might be to use NBCON_PRIO_PANIC in panic.
Something like (on top of 1st patch):

--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2044,7 +2044,14 @@ bool nbcon_braille_try_acquire(struct console *con,
 
 	memset(ctxt, 0, sizeof(*ctxt));
 	ctxt->console = con;
-	ctxt->prio    = NBCON_PRIO_EMERGENCY;
+	ctxt->prio = nbcon_get_default_prio();
+
+	/*
+	 * The Braille console might be used in an interrupt context but
+	 * NBCON_PRIO_EMERGENCY is associated with task context.
+	 */
+	if (ctxt->prio < NBCON_PRIO_EMERGENCY)
+		ctxt->prio = NBCON_PRIO_EMERGENCY;
 
 	return nbcon_context_try_acquire(ctxt, false);
 }

> [ ... ]
> 
> > -	braille_co->write(braille_co, data, c - data);
> > +	if (braille_co->flags & CON_NBCON) {
> > +		if (braille_co->write_atomic &&
> > +		    !braille_co->flags & CON_NBCON_ATOMIC_UNSAFE) {
> 
> [Severity: High]
> Does this operator precedence evaluate as intended?
> 
> Because the logical not (!) operator has higher precedence than the bitwise
> and (&) operator, this expression parses as:
> 
> (!braille_co->flags) & CON_NBCON_ATOMIC_UNSAFE
> 
> Since braille_co->flags is known to be non-zero (as CON_NBCON was just
> checked above), evaluating the logical not against the flags yields 0. This
> makes the condition permanently false, which bypasses the braille atomic
> write callback unconditionally.
> 
> Should this be grouped with parentheses to evaluate the bitwise and first?

Grr, sure, it should be:

		    !(braille_co->flags & CON_NBCON_ATOMIC_UNSAFE)) {

I'll fix this in v2.

I am going to wait with v2 a bit just in case anyone would like to
comment on v1...

Best Regards,
Petr
