Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC183115BD
	for <linux-serial@vger.kernel.org>; Tue,  2 Dec 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764679102; cv=none; b=kTvFhxxdd0+WEQsBQM7Te81o7JdygNW6rUwRBpxfagnfK6ne2dttBxrByrEe6Dt40aSbGQTSx6zopygE/abpLEGjXYMnaefvoNP23nDvO+dCqeUtXwTv5DXxuQo+s98/VzzaGk+YVQFtzoyuxrDJGcpSP3CRVp7JSIwgu6G3lr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764679102; c=relaxed/simple;
	bh=EfHExrxEg0cIOw3h5w69AHPdthNWgUXm2BS7DIYB5sY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/oIQm4P1fVS4dRmdCxhoGxLDsIg7DdP8526/M/sSb+QNCcIsTFdmesU8g2ZQCWuJWDUOWsHM82crV1XcyP//FVSPUHt3hITm1W1Ge/cb1LWKDUSl4vqp8prdqBlXKtvG7IzpP6agjGlp4d/IBwUO5AjEc4annvSjPhdGyIo9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VUm9y9jB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VUm9y9jB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so55114415e9.2
        for <linux-serial@vger.kernel.org>; Tue, 02 Dec 2025 04:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764679098; x=1765283898; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0lqY9mOmO7vBZP+j/0cPPoI59xjbMbnncr2dGQDMFw=;
        b=VUm9y9jBMcm7x8DpxRXF95Gqcs5S5lDp/Ah5MTVejYD2V+TkF1YWq9q//3l0dYtXrJ
         +JIWH9zdwdbUx8qTe75QXxbxfzSsEl0EFsSEG3zC+kwUSh/ZumtkGbNLwbv0BtzZDnpq
         jiCmvsqIxUVC0HivSdrQW3TuOBSAFjVkCfzPEp/r6j9AcX4iWgd3z+rblMiwlDamxFxv
         fyaDMHDuiugw4/cyOr1CXxF2bkgSXDRD1G7M6NBhMPZ6Te5MeOtV2aUknO4E5QBB0dLE
         HjF4tmHECySbEY6DuT+rqxrTgeB1hDDV9t/mXxvdNK0hNkmzcPyCXHJmQomePmc3e7l+
         ey7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764679098; x=1765283898;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0lqY9mOmO7vBZP+j/0cPPoI59xjbMbnncr2dGQDMFw=;
        b=NuDP/6cmPPQHsITtxKVK/9F/+nCinvAMsL+8f7meEamkqcbRHz3QroPSTwxA/UH4iy
         3Ksz4+RC/fHoc+wcG4zBbaOa2fwIvzyWQq4yXKQdiYh8xe71htNgkILroLuIXfit5Bv2
         e5wmybejWWknuDt0/4b9rNAFOmSQpdVi+Fk9vB12Kum6F0OrzeZX3WnNCjGc9StXkNkd
         HTh2lfrBzFj4Hk0Rf19xrVAiXMUOBmvExQ+1LIGLMe5hzKQpW4AylbmIqSxRTQwhg8SP
         +O4WOtNXqcqb3mMdZO3rDE5CmwCa67Wf2qWzrkvGZZEAmUCx3lxNX1u4dWux0CX7P8BF
         RXSw==
X-Forwarded-Encrypted: i=1; AJvYcCXZf3sOTDpUkqdfQ/ZoTXnBen8wvITdu6/0bYJiixFbN1ZL6jJBwTtaSPDT+rsI1OgOmJzrc30Yx9EKBGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwX9cGNYo/XW4rtxTyDIPWHAxtG+QJz748541Z+uN0zug+j735
	fNzYTDPqzeIoBbN5YnXXTbbxR1ubGpqF+Pyu/nVoszKoW94nSokqGhGbB/oF2mf7kig=
X-Gm-Gg: ASbGncsc01EbSV8dQXaL6YU2JfiKZlmt5talHeq+bp9N/K/rxYl31qR5kWRNwcebwMy
	2nF1jk/AQ5pjkv0CdaBp45P/NxeqUxbUM6Tbfnh2FvPUVcvlagUYKY1MvInXYB/ji9aSRVaoyHr
	CX510fnJK0kT4HUO3buVn4LMnWdS9PjdlqWW2MKOlv5wvB0hSgLRvYmppL4YUM+49XoeFEAtQ6z
	a8NFBb2EOwGK0yo1UtrpKMuSQ7m2FJAAQdCYGcGoPS6zFFNsTQCkx2VOlEy76UzkyFn9igUigfe
	Yy+YFkktPhvJeejImqCQWQ584CJSrB8JjH9L2J1LrarMpRWIzCys6Wc58isLgA5ZqMKCKTTSvc+
	7+iR87kaTSsZNhnGucbt7tH+RnYXDe+NbVEJgr9KGFocTeo2bVUgdlcoJBPIlKyLBNJmuJ8ETd/
	wQN1mAQQTCcuJU/PJdftvNgAQSxDak9FOvek7OttNyjkcyNXzSAw==
X-Google-Smtp-Source: AGHT+IFYA9HtFTaPtmDX/J8zy+pw+S/2dgUciCfneZZ/7Mv4h8ftHyuxzTWpD/W8At5bEF2JmNLrlw==
X-Received: by 2002:a05:600c:4e8e:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-47904adb12bmr315424995e9.12.1764679097764;
        Tue, 02 Dec 2025 04:38:17 -0800 (PST)
Received: from ?IPv6:2804:5078:919:1400:58f2:fc97:371f:2? ([2804:5078:919:1400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a96560986csm81614636eec.2.2025.12.02.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 04:38:17 -0800 (PST)
Message-ID: <136fd27eab418f1d4ad008d9591bcc00669e2f8d.camel@suse.com>
Subject: Re: [PATCH v2 4/4] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
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
Date: Tue, 02 Dec 2025 09:38:12 -0300
In-Reply-To: <aSgeqM3DWvR8-cMY@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
	 <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
	 <aSgeqM3DWvR8-cMY@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 10:49 +0100, Petr Mladek wrote:
> On Fri 2025-11-21 15:50:36, Marcos Paulo de Souza wrote:
> > Since commit 9e70a5e109a4 ("printk: Add per-console suspended
> > state")
> > the CON_SUSPENDED flag was introced, and this flag was being
> > checked
> > on console_is_usable function, which returns false if the console
> > is
> > suspended.
> >=20
> > To make the behavior consistent, change show_cons_active to look
> > for
> > consoles that are not suspended, instead of checking CON_ENABLED.
> >=20
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -3554,7 +3554,7 @@ static ssize_t show_cons_active(struct device
> > *dev,
> > =C2=A0			continue;
> > =C2=A0		if (!(c->flags & CON_NBCON) && !c->write)
> > =C2=A0			continue;
> > -		if ((c->flags & CON_ENABLED) =3D=3D 0)
> > +		if (c->flags & CON_SUSPENDED)
>=20
> I believe that we could and should replace
>=20
> 		if (!(c->flags & CON_NBCON) && !c->write)
> 			continue;
> 		if (c->flags & CON_SUSPENDED)
> 			continue;
>=20
> with
>=20
> 		if (!console_is_usable(c, c->flags, true) &&
> 		=C2=A0=C2=A0=C2=A0 !console_is_usable(c, c->flags, false))
> 			continue;
>=20
> It would make the value compatible with all other callers/users of
> the console drivers.

Thanks Petr. I already have a local branch that will reduce the
console_is_usable of usages like to be called just once, so I'll work
on this change on top of it.

>=20
> The variant using two console_is_usable() calls with "true/false"
> parameters is inspited by __pr_flush().
>=20
> > =C2=A0			continue;
> > =C2=A0		cs[i++] =3D c;
> > =C2=A0		if (i >=3D ARRAY_SIZE(cs))
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index fed98a18e830..fe7c956f73bd 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3542,7 +3542,7 @@ void console_suspend(struct console *console)
> > =C2=A0{
> > =C2=A0	__pr_flush(console, 1000, true);
> > =C2=A0	console_list_lock();
> > -	console_srcu_write_flags(console, console->flags &
> > ~CON_ENABLED);
> > +	console_srcu_write_flags(console, console->flags |
> > CON_SUSPENDED);
>=20
> This is the same flag which is set also by the console_suspend_all()
> API. Now, as discussed at
> https://lore.kernel.org/lkml/844j4lepak.fsf@jogness.linutronix.de/
>=20
> =C2=A0=C2=A0 + console_suspend()/console_resume() API is used by few cons=
ole
> =C2=A0=C2=A0=C2=A0=C2=A0 drivers to suspend the console when the related =
HW device
> =C2=A0=C2=A0=C2=A0=C2=A0 gets suspended.
>=20
> =C2=A0=C2=A0 + console_suspend_all()/console_resume_all() is used by
> =C2=A0=C2=A0=C2=A0=C2=A0 the power management subsystem to call down/up a=
ll consoles
> =C2=A0=C2=A0=C2=A0=C2=A0 when the system is going down/up. It is a big ha=
mmer approach.
>=20
> We need to distinguish the two APIs so that console drivers which
> were
> suspended by both APIs stay suspended until they get resumed by both
> APIs. I mean:
>=20
> 	// This should suspend all consoles unless it is not
> disabled
> 	// by "no_console_suspend" API.
> 	console_suspend_all();
> 	// This suspends @con even when "no_console_suspend"
> parameter
> 	// is used. It is needed because the HW is going to be
> suspended.
> 	// It has no effect when the consoles were already suspended
> 	// by the big hammer API.
> 	console_suspend(con);
>=20
> 	// This might resume the console when "no_console_suspend"
> option
> 	// is used. The driver should work because the HW was
> resumed.
> 	// But it should stay suspended when all consoles are
> supposed
> 	// to stay suspended because of the big hammer API.
> 	console_resume(con);
> 	// This should resume all consoles.
> 	console_resume_all();
>=20
> Other behavior would be unexpected and untested. It might cause
> regression.
>=20
> I see two solutions:
>=20
> =C2=A0=C2=A0 + add another CON_SUSPENDED_ALL flag
> =C2=A0=C2=A0 + add back "consoles_suspended" global variable
>=20
> I prefer adding back the "consoles_suspended" global variable because
> it is a global state...
>=20
> The global state should be synchronized the same way as the current
> per-console flag (write under console_list_lock, read under
> console_srcu_read_lock()).
>=20
> Also it should be checked by console_is_usable() API. Otherwise, we
> would need to update all callers.
>=20
> This brings a challenge how to make it safe and keep the API sane.
> I propose to create:
>=20
> =C2=A0 + __console_is_usable() where the "consoles_suspended" value will
> =C2=A0=C2=A0=C2=A0 be passed as parameter. It might be used directly unde=
r
> =C2=A0=C2=A0=C2=A0 console_list_lock().
>=20
> =C2=A0 + console_is_usable() with the existing parameters. It will check
> =C2=A0=C2=A0=C2=A0 the it was called under console_srcu_read_lock, read
> =C2=A0=C2=A0=C2=A0 the global "consoles_suspend" and pass it to
> =C2=A0=C2=A0=C2=A0 __console_is_usable().
>=20
>=20

Makes sense. Thanks a lot for the suggestion.

> > =C2=A0	console_list_unlock();
> > =C2=A0
> > =C2=A0	/*
>=20
> I played with the code to make sure that it looked sane
> and I ended with the following changes on top of this patch.
>=20
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 1b2ce0f36010..fda4683d12f1 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3552,9 +3552,8 @@ static ssize_t show_cons_active(struct device
> *dev,
> =C2=A0	for_each_console(c) {
> =C2=A0		if (!c->device)
> =C2=A0			continue;
> -		if (!(c->flags & CON_NBCON) && !c->write)
> -			continue;
> -		if (c->flags & CON_SUSPENDED)
> +		if (!__console_is_usable(c, c->flags,
> consoles_suspended, true) &&
> +		=C2=A0=C2=A0=C2=A0 !__console_is_usable(c, c->flags,
> consoles_suspended, false))
> =C2=A0			continue;
> =C2=A0		cs[i++] =3D c;
> =C2=A0		if (i >=3D ARRAY_SIZE(cs))
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 5f17321ed962..090490ef570f 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -496,6 +496,7 @@ extern void console_list_lock(void)
> __acquires(console_mutex);
> =C2=A0extern void console_list_unlock(void) __releases(console_mutex);
> =C2=A0
> =C2=A0extern struct hlist_head console_list;
> +extern bool consoles_suspended;
> =C2=A0
> =C2=A0/**
> =C2=A0 * console_srcu_read_flags - Locklessly read flags of a possibly
> registered
> @@ -548,6 +549,47 @@ static inline void
> console_srcu_write_flags(struct console *con, short flags)
> =C2=A0	WRITE_ONCE(con->flags, flags);
> =C2=A0}
> =C2=A0
> +/**
> + * consoles_suspended_srcu_read - Locklessly read the global flag
> for
> + *				suspending all consoles.
> + *
> + * The global "consoles_suspended" flag is synchronized using
> console_list_lock
> + * and console_srcu_read_lock. It is the same approach as
> CON_SUSSPENDED flag.
> + * See console_srcu_read_flags() for more details.
> + *
> + * Context: Any context.
> + * Return: The current value of the global "consoles_suspended"
> flag.
> + */
> +static inline short consoles_suspended_srcu_read(void)
> +{
> +	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
> +
> +	/*
> +	 * The READ_ONCE() matches the WRITE_ONCE() when
> "consoles_suspended"
> +	 * is modified with consoles_suspended_srcu_write().
> +	 */
> +	return data_race(READ_ONCE(consoles_suspended));
> +}
> +
> +/**
> + * consoles_suspended_srcu_write - Write the global flag for
> suspending
> + *			all consoles.
> + * @suspend:	new value to write
> + *
> + * The write must be done under the console_list_lock. The caller is
> responsible
> + * for calling synchronize_srcu() to make sure that all callers
> checking the
> + * usablility of registered consoles see the new state.
> + *
> + * Context: Any context.
> + */
> +static inline void consoles_suspended_srcu_write(bool suspend)
> +{
> +	lockdep_assert_console_list_lock_held();
> +
> +	/* This matches the READ_ONCE() in
> consoles_suspended_srcu_read(). */
> +	WRITE_ONCE(consoles_suspended, suspend);
> +}
> +
> =C2=A0/* Variant of console_is_registered() when the console_list_lock is
> held. */
> =C2=A0static inline bool console_is_registered_locked(const struct consol=
e
> *con)
> =C2=A0{
> @@ -617,13 +659,15 @@ extern bool nbcon_kdb_try_acquire(struct
> console *con,
> =C2=A0extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> =C2=A0
> =C2=A0/*
> - * Check if the given console is currently capable and allowed to
> print
> - * records. Note that this function does not consider the current
> context,
> - * which can also play a role in deciding if @con can be used to
> print
> - * records.
> + * This variant might be called under console_list_lock where both
> + * @flags and @all_suspended flags can be read directly.
> =C2=A0 */
> -static inline bool console_is_usable(struct console *con, short
> flags, bool use_atomic)
> +static inline bool __console_is_usable(struct console *con, short
> flags,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool all_suspended, bool
> use_atomic)
> =C2=A0{
> +	if (all_suspended)
> +		return false;
> +
> =C2=A0	if (!(flags & CON_ENABLED))
> =C2=A0		return false;
> =C2=A0
> @@ -666,6 +710,20 @@ static inline bool console_is_usable(struct
> console *con, short flags, bool use_
> =C2=A0	return true;
> =C2=A0}
> =C2=A0
> +/*
> + * Check if the given console is currently capable and allowed to
> print
> + * records. Note that this function does not consider the current
> context,
> + * which can also play a role in deciding if @con can be used to
> print
> + * records.
> + */
> +static inline bool console_is_usable(struct console *con, short
> flags,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 bool use_atomic)
> +{
> +	bool all_suspended =3D consoles_suspended_srcu_read();
> +
> +	return __console_is_usable(con, flags, all_suspended,
> use_atomic);
> +}
> +
> =C2=A0#else
> =C2=A0static inline void nbcon_cpu_emergency_enter(void) { }
> =C2=A0static inline void nbcon_cpu_emergency_exit(void) { }
> @@ -678,6 +736,8 @@ static inline void nbcon_reacquire_nobuf(struct
> nbcon_write_context *wctxt) { }
> =C2=A0static inline bool nbcon_kdb_try_acquire(struct console *con,
> =C2=A0					 struct nbcon_write_context
> *wctxt) { return false; }
> =C2=A0static inline void nbcon_kdb_release(struct nbcon_write_context
> *wctxt) { }
> +static inline bool __console_is_usable(struct console *con, short
> flags,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool all_suspended, bool
> use_atomic) { return false; }
> =C2=A0static inline bool console_is_usable(struct console *con, short
> flags,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 bool use_atomic) { return
> false; }
> =C2=A0#endif
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 23a14e8c7a49..12247df07420 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -104,6 +104,13 @@ DEFINE_STATIC_SRCU(console_srcu);
> =C2=A0 */
> =C2=A0int __read_mostly suppress_printk;
> =C2=A0
> +/*
> + * Global flag for calling down all consoles during suspend.
> + * There is also a per-console flag which is used when the related
> + * device HW gets disabled, see CON_SUSPEND.
> + */
> +bool consoles_suspended;
> +
> =C2=A0#ifdef CONFIG_LOCKDEP
> =C2=A0static struct lockdep_map console_lock_dep_map =3D {
> =C2=A0	.name =3D "console_lock"
> @@ -2731,8 +2738,6 @@ MODULE_PARM_DESC(console_no_auto_verbose,
> "Disable console loglevel raise to hig
> =C2=A0 */
> =C2=A0void console_suspend_all(void)
> =C2=A0{
> -	struct console *con;
> -
> =C2=A0	if (console_suspend_enabled)
> =C2=A0		pr_info("Suspending console(s) (use
> no_console_suspend to debug)\n");
> =C2=A0
> @@ -2749,8 +2754,7 @@ void console_suspend_all(void)
> =C2=A0		return;
> =C2=A0
> =C2=A0	console_list_lock();
> -	for_each_console(con)
> -		console_srcu_write_flags(con, con->flags |
> CON_SUSPENDED);
> +	consoles_suspended_srcu_write(true);
> =C2=A0	console_list_unlock();
> =C2=A0
> =C2=A0	/*
> @@ -2765,7 +2769,6 @@ void console_suspend_all(void)
> =C2=A0void console_resume_all(void)
> =C2=A0{
> =C2=A0	struct console_flush_type ft;
> -	struct console *con;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Allow queueing irq_work. After restoring console state,
> deferred
> @@ -2776,8 +2779,7 @@ void console_resume_all(void)
> =C2=A0
> =C2=A0	if (console_suspend_enabled) {
> =C2=A0		console_list_lock();
> -		for_each_console(con)
> -			console_srcu_write_flags(con, con->flags &
> ~CON_SUSPENDED);
> +		consoles_suspended_srcu_write(false);
> =C2=A0		console_list_unlock();
> =C2=A0
> =C2=A0		/*

You did all the work :) Let pick your changes and prepare the new
patchset using it. Thanks a lot!

>=20
> Best Regards,
> Petr
