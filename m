Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965C75809
	for <linux-serial@vger.kernel.org>; Wed, 23 Oct 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715778; cv=none; b=n14PNlzmWgTgtps1CcUKzolCvJtoUX6+8ymsQTIMKifCSEOUFJPBa0DUDMw7PoIfVpURJLXn0LrIJQJuLt9vCTqnZQwOYDEy5zHyE3aHAW5wMsFVFEA3Taj7ptXOrFZJRXp3nxlvpBKFrQ7T66L/GS05DNp0+9D58Q+4NJtUef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715778; c=relaxed/simple;
	bh=ImpcvNwf9+ua7BFJtbBufY2KH5qLmceGY0AN2fY093Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTP/e9ToLQS1f6VONFlqi4x/h9Zwul/voL2H1ItarYPggoT98njpVGfak2k3B3KiM4uik168fS4keLoXlfAnzjTDmITZDmEWoX9ZyhUtlr69zQvlaebl65iQHBYd548+NvMEzduewUmLxvDq5vdISKg070n1Uh2DJQR136rDCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRCwCFVt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRCwCFVt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d50fad249so79532f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 23 Oct 2024 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729715775; x=1730320575; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RbvnKbX4jWcPN4YvQIkbquOW0N0DaIfS55eb9txkjhM=;
        b=aRCwCFVtAT1kGGOzXnAqvxSp4CMAsToTMczGLdN0d/+jIKN+biboXDcAHqHalKgqFF
         UQlgDtm8Xo0ZDdCo9t4T6kuLnDxVgPBPLJa33p61jpjqiGJOrqXLXcDc+MKeBqjk9UWx
         gYp5oH2WvZKWNrtqYTPl+oea+5MZel+8JXe0tTfNey6M1AFM/83J7GNmWLBeBHzkRkop
         gSLGsLQNC9XAnLsweeSCzLnQOnIzEh6ylTEHsNfsJGzkfljdITmJ4yfia6+8gfT20IUi
         0fuxwQn1EMEyA6NDykiepBXnpks1joRyrdZptuBDyu31U2CMyZOmwrJtOptBc8tduotA
         dyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715775; x=1730320575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbvnKbX4jWcPN4YvQIkbquOW0N0DaIfS55eb9txkjhM=;
        b=BD6gy7j56OOtoOX74mRwIEnhRZJeH1MO06if6YzVO1XBHk1TFioidfXnjnJCYzFAp1
         mUfIHwCRU8A+IHFrftp9MgbYHSmWTgYQ+ko4mw5NV5uAnvapqs6AD7vKG5e47ubi4/pX
         9OmSbsOdKjxfNiPp7oh4h7Ezbm7EqawigByW24QifQMpqwvGgLe3gvGBc2NaAcrUgYvw
         7TXOIoHwcGLQ+fIailM8aXKkWnvqfQ8Wg0QHaRdNHELgM1DyzGJgPoQbG/c4E4hyt7nV
         mZdk1rotdNhRu86jT7CBKpE1GkxYfOz2zNa3CCL7RoVU7quuxbZdxImNTwhqZw97VAox
         ip3g==
X-Forwarded-Encrypted: i=1; AJvYcCWTCakSNyBJ9+gz+hYL3vOlhbTfS8nUvN1TSMGCjpiHwpIIjij+vl6dAyadIEURRR22GYTdtS/g0ZbTk/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9SUWZmhxnJIOP4+3Sk/NfNiyXMH6UEWpiGOfPBqvrZK/AA/V
	Dv5Eh46KxhlKD/VZUbAVkERz3xZvQqtm3uxWLWMaHWioO1UJf3hukReBE2lKCRM=
X-Google-Smtp-Source: AGHT+IF0ep2UZrcetqT7EJ6Rh54IsLdUp+XzoEyg+qHkYl1gK0DR2Sna4p2w0BcP02uf0tBGVgzDrA==
X-Received: by 2002:a5d:56d2:0:b0:37c:d162:8297 with SMTP id ffacd0b85a97d-37efcf8ec62mr2440958f8f.47.1729715774871;
        Wed, 23 Oct 2024 13:36:14 -0700 (PDT)
Received: from ?IPv6:2804:5078:817:9d00:58f2:fc97:371f:2? ([2804:5078:817:9d00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e084b61sm1914443a91.52.2024.10.23.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:36:14 -0700 (PDT)
Message-ID: <533f6a578d8489c1107ba83ce1e49b6e2d5c84ce.camel@suse.com>
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jiri Slaby <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Wed, 23 Oct 2024 17:36:04 -0300
In-Reply-To: <8434kpfsvr.fsf@jogness.linutronix.de>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
	 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
	 <84plnz29zv.fsf@jogness.linutronix.de> <ZxDl-VcVAI8DGM40@pathway.suse.cz>
	 <847ca5rigk.fsf@jogness.linutronix.de> <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
	 <8434kpfsvr.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 16:17 +0206, John Ogness wrote:
> On 2024-10-21, Petr Mladek <pmladek@suse.com> wrote:
> > > That will not work because migrate_enable() can only be called
> > > from
> > > can_sleep context. Instead, the migrate_disable()/enable() should
> > > be at
> > > the few (one?) call sites where
> > > printk_loud_console_enter()/exit() is
> > > used from task context.
> >=20
> > Hmm, if I get it correctly, we could not use migrate_disable() in
> > __handle_sysrq() because it can be called also in atomic context,
>=20
> I am talking about callers of __handle_sysrq() and/or their callers.
>=20
> For example write_sysrq_trigger() could do:
>=20
> 	migrate_disable();
> 	__handle_sysrq(c, false);
> 	migrate_enable();
>=20
> Or a new wrapper could be introduced for this purpose:
>=20
> static inline void wrapper handle_sysrq_task(u8 key, bool check_mask)
> {
> 	migrate_disable();
> 	__handle_sysrq(key, check_mask);
> 	migrate_enable();
> }
>=20
> A quick grep shows about 25 call sites to check.
>=20
> > I do not see any easy way how to distinguish whether it was called
> > in
> > an atomic context or not.
>=20
> There is no clean way to do that. If this information is needed, it
> must
> be tracked by the call chain.
>=20
> > So, I see three possibilities:
> >=20
> > =C2=A0 1. Explicitly call preempt_disable() in __handle_sysrq().
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 It would be just around the the single line or=
 the help. But
> > still,
> > =C2=A0=C2=A0=C2=A0=C2=A0 I do not like it much.
>=20
> Not acceptable for PREEMPT_RT since sysrq is exposed to external
> inputs.
>=20
> > =C2=A0 2. Avoid the per-CPU variable. Force adding the
> > LOUD_CON/FORCE_CON
> > =C2=A0=C2=A0=C2=A0=C2=A0 flag using a global variable, e.g. printk_forc=
e_console.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 The problem is that it might affect also messa=
ges printed by
> > =C2=A0=C2=A0=C2=A0=C2=A0 other CPUs. And there might be many.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Well, console_loglevel is a global variable. T=
he original code
> > =C2=A0=C2=A0=C2=A0=C2=A0 had a similar problem.
>=20
> If disabling migration is not an option for you, this would be my
> second
> choice. I assume tagging too many messages is better than not tagging
> enough. And, as you say, this is effectively what the current code is
> trying to do.

Thanks for your input John. I talked with Petr and he suggested to
follow this option. I'll prepare the changes and send them after
reviewing them with Petr.

Thanks,
  Marcos

>=20
> > =C2=A0 3. Add the LOUD_CON/FLUSH_CON flag via a parameter. For example,
> > =C2=A0=C2=A0=C2=A0=C2=A0 by a special LOGLEVEL_FORCE_CON, similar to LO=
GLEVEL_SCHED.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 I might work well for __handle_sysrq() which c=
alls the
> > affected
> > =C2=A0=C2=A0=C2=A0=C2=A0 printk() directly.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 But it won't work, for example, for kdb_show_s=
tack(). It wants
> > =C2=A0=C2=A0=C2=A0=C2=A0 to show messages printed by a nested functions=
.
>=20
> Right, this has limited usefulness and might miss the important
> things,
> which tend to be within helper functions.
>=20
> John

