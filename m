Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D12C158F
	for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704804; cv=none; b=l4zunocYWJtCQjQ1K0x+3SWzmBZRs5qJ4KAKcv2N3wBYJxyoxcX1855K7ME7DCHpcJJ/2RYzOk2jttqvv4LkzXVaAqa3dO6LedCYEoNi0H3Buxzsk0JNngJ3wDZk6tU4Ty+r8quKKCUEQF8vm8v6F4l9yBv6oj+7e2Q1qY4H23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704804; c=relaxed/simple;
	bh=nMJQo4OpjNZh+tTS7oPgvQNI+OMhplRpVepoL8H0W2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dD+hLwxHJqZv8NOrb1duYTTecXx9i3IrJeduunorz+0iW1YeV9Z7axVRMmoQg1b6guG61XS38698MTS/3wTIfB8eUFCB47x8xGYqX/Hd3KwfJE2qelXEf1/5Ch1jCkVyJGgdoE5Nw8Sb1/+snBSalGxv4vDK0ihUwF8Q7J+K3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I9QFtqqH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I9QFtqqH"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a36748920cso3450015f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 23 Jun 2025 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750704801; x=1751309601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kP3LfikwJoT5jZxTfYQ53BJecw5PNc+P0zrWLzEkXCM=;
        b=I9QFtqqHylp3gwbIoB+PqXh8IxMHCxdP8IIZjjZHka1JHBTEi7xAZ8PQC3Z6IH7wDZ
         GcW6m/ZmiBUcBHQA7T5y8FF6bJ+sxvCJ3Zxt7bWdYMWkl/ynFuVffPfR4jCXKM2Tq8ww
         7UsZ/8Zo9BODvIONY+ZPLUemswroeTfRVDHe8rCsT5WIqMZDbO2IGokSynFcmnV1HhAF
         D+GcaBhlAUttSZXpcyJ5dij9PtZtSlroCSWWEBvN5ZCdEvlidIxJTiCBBXD6zPmvEqrs
         s0xmE9//w6gNQlCN31YDaDcxs5pDfNle2NMvYmcHwhRIWbDHHVL4THMGuXfBoJ2k9hA8
         53Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704801; x=1751309601;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP3LfikwJoT5jZxTfYQ53BJecw5PNc+P0zrWLzEkXCM=;
        b=HMMx+WmoPAmfvbsr1rDdVF0yNv+7/XLLmrVMhmcHt4SSm3PlU9bgDZNDwfot/9Pz2X
         FOsplcCVZdXPIEE5UuXxwME25IBDRvXLc++OcW2J46PKVTRm2qa8IcWfwL8r08hFeB5q
         lE9OggRd4fxVuRjiuiSbFC/lM9vTz55LQFTS4qe3WK6yHdqwns0iF9zSxYQA12fGrSH/
         aSaCiiW4Ou/I13TugQsBapzuXDiPjF3GdtxC0Tfz1QvD1dJD7iH3GsmOGrc6ZERnKthf
         wCLscbOfooT4qhAJsrH0LgZj5Tyn9JC5FnEllJpXwimFQVJAfpmZQeqq9dCcHzz9lUfJ
         ftZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUM3cgWSkJsIADMl5SzQB9XQq6nc7GVzc3RzRDScfG/eyzEaOXmbSwTu2bqBNsHt63wKBYQNqWIXup2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNyG72Rp2fAskLgiYi5DHLlCV0d1xoz1tCBHNVyMso9s4NOWM
	2hRrbz9Zp/LyMdkQexSFcg6fU069l0PTAm8iYCylOLOP0XzuXbjtBTvFckst7EGikJ5J/kUlsr4
	j97qBkyww0/S2
X-Gm-Gg: ASbGncu2qDKSdqt60rxgUV+YYx8MzDVN7vjZrwoEr/zW3xuGsbOTMRFlnTu7YAnItXx
	Bv8zZmXZ+r/Wh1Xig2qnIQmXEKSZzOvXwykBT4eYbb7/Ja3ilhR4WErQUrj76nPcoqpoLOaQZqP
	KDZSkaktRDa8Lh3O0K1AKArM2JYnb2bAbeXYLsM72LYSUNb+vUe0C45AaX5gBQGkt2qJoAvv0oT
	0RxkMo00kRZ+meECfmILEAyYnuSIx4vwbA6Uzxdjkim968+hW9C3UQJiMJ+nK/r7PR4zHS5NQdv
	lnlrLMfymY/aeYH9/PysxraSOhLfrDEGrnvKzYNNl83x2Je1NHhtzmcfGVdvp+2LpL+KAmlBJ9o
	QJh079a2WURyVqVPL6C/Vr3mf
X-Google-Smtp-Source: AGHT+IHl7WUsTHsArXNJ7BBLS48xIuonfKG5DP3IbYFgDHwpfpJdrP3CunJHC4qeSAikuH/t9ORELQ==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:eeb5:21cb with SMTP id ffacd0b85a97d-3a6d12e5b71mr11313647f8f.26.1750704800592;
        Mon, 23 Jun 2025 11:53:20 -0700 (PDT)
Received: from ?IPv6:2804:5078:805:6b00:58f2:fc97:371f:2? ([2804:5078:805:6b00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f126a2aesm8483866a12.67.2025.06.23.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:53:19 -0700 (PDT)
Message-ID: <d4f7a4dd5bedf288d2011fc9817716b8af2ec032.camel@suse.com>
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel	 <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, 	linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Date: Mon, 23 Jun 2025 15:53:14 -0300
In-Reply-To: <aExBo-8cVOy6GegR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
	 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
	 <aExBo-8cVOy6GegR@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 17:20 +0200, Petr Mladek wrote:
> On Fri 2025-06-06 23:53:44, Marcos Paulo de Souza wrote:
>=20
>=20
> Variant C:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Remove even @flags parameter from console_is_usable() and read both
> values there directly.
>=20
> Many callers read @flags only because they call console_is_usable().
> The change would simplify the code.
>=20
> But there are few exceptions:
>=20
> =C2=A0 1. __nbcon_atomic_flush_pending(), console_flush_all(),
> =C2=A0=C2=A0=C2=A0=C2=A0 and legacy_kthread_should_wakeup() pass @flags t=
o
> =C2=A0=C2=A0=C2=A0=C2=A0 console_is_usable() and also check CON_NBCON fla=
g.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 But CON_NBCON flag is special. It is statically =
initialized
> =C2=A0=C2=A0=C2=A0=C2=A0 and never set/cleared at runtime. It can be chec=
ked without
> =C2=A0=C2=A0=C2=A0=C2=A0 READ_ONCE(). Well, we still might want to be sur=
e that
> =C2=A0=C2=A0=C2=A0=C2=A0 the struct console can't disappear.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 IMHO, this can be solved by a helper function:
>=20
> 	/**
> 	 * console_srcu_is_nbcon - Locklessly check whether the
> console is nbcon
> 	 * @con:	struct console pointer of console to check
> 	 *
> 	 * Requires console_srcu_read_lock to be held, which implies
> that @con might
> 	 * be a registered console. The purpose of holding
> console_srcu_read_lock is
> 	 * to guarantee that no exit/cleanup routines will run if
> the console
> 	 * is currently undergoing unregistration.
> 	 *
> 	 * If the caller is holding the console_list_lock or it is
> _certain_ that
> 	 * @con is not and will not become registered, the caller
> may read
> 	 * @con->flags directly instead.
> 	 *
> 	 * Context: Any context.
> 	 * Return: True when CON_NBCON flag is set.
> 	 */
> 	static inline bool console_is_nbcon(const struct console
> *con)
> 	{
> 		WARN_ON_ONCE(!console_srcu_read_lock_is_held());
>=20
> 		/*
> 		 * The CON_NBCON flag is statically initialized and
> is never
> 		 * set or cleared at runtime.
> 		return data_race(con->flags & CON_NBCON);
> 	}
>=20
>=20
> =C2=A0=C2=A0 2. Another exception is __pr_flush() where console_is_usable=
() is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 called twice with @use_atomic set "true" a=
nd "false".
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We would want to read "con->flags" only on=
ce here. A solution
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 would be to add a parameter to check both =
con->write_atomic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and con->write_thread in a single call.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 But it might actually be enough to check i=
s with the "false"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value because "con->write_thread()" is man=
datory for nbcon
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consoles. And legacy consoles do not disti=
nguish atomic mode.
>=20

I like this idea. Also, thanks a lot for explaining why the current
version won't work.

I also liked John's proposal to use a a bitmask on console_is_usable,
but I'll think a little on it once I restart working on it this week.

>=20
> My opinion:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I personally prefer the variant C because:
>=20
> =C2=A0 + Removes one parameter from console_is_usable().
>=20
> =C2=A0 + The lockless synchronization of both global and per-console
> =C2=A0=C2=A0=C2=A0 flags is hidden in console_is_usable().
>=20
> =C2=A0 + The global console_suspended flag will be stored in global
> =C2=A0=C2=A0=C2=A0 variable (in compare with variant D).
>=20
> What do you think, please?

Much better, I'll adapt the code as you suggested.

>=20
> Best Regards,
> Petr
>=20
>=20
> PS: The commit message and the cover letter should better explain
> =C2=A0=C2=A0=C2=A0 the background of this change.
>=20
> =C2=A0=C2=A0=C2=A0 It would be great if the cover letter described the bi=
gger
> =C2=A0=C2=A0=C2=A0 picture, especially the history of the console_suspend=
ed,
> =C2=A0=C2=A0=C2=A0 CON_SUSPENDED, and CON_ENABLED flags. It might use inf=
o
> =C2=A0=C2=A0=C2=A0 from
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.=
suse.cz/
> =C2=A0=C2=A0=C2=A0 and maybe even this link.
>=20
> =C2=A0=C2=A0=C2=A0 Also this commit message should mention that it partly=
 reverts
> =C2=A0=C2=A0=C2=A0 the commit 9e70a5e109a4a233678 ("printk: Add per-conso=
le
> =C2=A0=C2=A0=C2=A0 suspended state"). But it is not simple revert because
> =C2=A0=C2=A0=C2=A0 we need to preserve the synchronization using
> =C2=A0=C2=A0=C2=A0 the console_list_lock for writing and SRCU for reading=
.

I agree, such a context would even help the reviewers that would spend
some time reading the code and thinking themselves that some code is
being readded for some reason.

