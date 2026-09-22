Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C48136351
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041092; cv=none; b=W+r19QSpJS3gvuQ+CAA7qaviMsRqDNFA9nmoCfHyadSO8ZBJXDo7d51rE1QqR7Q+RuqyBY+vIc0au8F+1j70ZDqCfGDhrBcvhLD4VdTx9hf7+SL2jhVqBILNXyWrVW4EhiSMrZEdU5qEVhSXlYG4tT/iR3QsAl1OguvLr+6lSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041092; c=relaxed/simple;
	bh=JYOeoqoP4Wn9WvdDlexwj7BdmdYmX15bQcYA7B9jjzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qrMohSgmMLVBCBWV33axv+FGUUI15n8jKaQm2fiqgdM1YgglIafb+iTMPxzGGlSApPArLYFbdSPuZOH7NfmYDfZE1YbSH6kMUxZdAG5Jqpp7pfCyptYn0d/gfNzc7J/qWAeht6bOY1IOay2uU3dXZUjysz7Avu92jEX9CxnsCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auHKUK6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auHKUK6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B71F000FF;
	Tue, 22 Sep 2026 01:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041090;
	bh=uM9putPMjz58RWOQomZZj4/B1UmdqE6A2CpIEqHHACM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=auHKUK6V6pv/5u1nUsilSA7pKwIcA+GIXuBXtWqQjWfIDqz5qFGNqXzFUMZQlyJb8
	 XYqY8IeindAJkjCNMNflO6rXbbEI5u80POksmgmPQO+gUm/6zSxhOAMbXx9mAT3/WN
	 mmSnPZU3nz3JXcolLC/JZxgygXeKmaX0gPXAt+z9Rqt1kiK0GSOkwpsZ1jrJ9Espn0
	 wlTrc+hkxqsI7PNnuD8+5cA+dXCJMMKP168OV8Gl4Q9cseFVE8hLj1RkAlUOV1ME5B
	 Vwy3JsKPOdMUAY3HlO0HRI/YQ5vdT1CJLFfuxR0BfCpiZc39d0wfNZO7KnLBQ5L/UA
	 wjBBPhs1UBTbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] vt: order the vc_cons[] clear against
 console_callback()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-vt-v1-3-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
 <20260921-mb-vt-v1-3-71b7990c26c1@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:38:10 +0000
Message-Id: <20260922013810.6D7B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: vt: unnecessary and flawed lockless synchronization under c=
onsole_lock
--

commit 49da38d5b190153cd048046d7ba8249893ec05f7
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: order the vc_cons[] clear against console_callback()

This commit replaces plain stores and loads of vc_cons[].d with
smp_store_release() and smp_load_acquire() in vc_deallocate() and
console_callback(). It aims to resolve a static memory consistency checker
warning.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7264021672baa..66aa089bff43a 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1369,7 +1369,8 @@ struct vc_data *vc_deallocate(unsigned int currcons)
>  		put_pid(vc->vt_pid);
>  		vc_uniscr_set(vc, NULL);
>  		kfree(vc->vc_screenbuf);
> -		vc_cons[currcons].d =3D NULL;
> +		/* Pairs with the smp_load_acquire() in console_callback(). */
> +		smp_store_release(&vc_cons[currcons].d, NULL);

[Severity: Medium]
Are these memory barriers necessary? Both vc_deallocate() and
console_callback() execute strictly under console_lock. vc_deallocate()
asserts this via WARN_CONSOLE_UNLOCKED(), and console_callback() acquires
it via guard(console_lock)() at the top of the function.

Furthermore, does this unpublish the pointer too late for a lockless reader?
Since it is unpublished after freeing resources like vc_screenbuf, wouldn't
this create a use-after-free window for any hypothetical lockless reader?

>  		if (vc->vc_saved_screen !=3D NULL) {
>  			kfree(vc->vc_saved_screen);
>  			vc->vc_saved_screen =3D NULL;

[ ... ]

> @@ -3368,7 +3369,8 @@ static void console_callback(struct work_struct *ig=
nored)
>  		poke_blanked_console();
>  	}
>  	if (scrollback_delta) {
> -		struct vc_data *vc =3D vc_cons[fg_console].d;
> +		/* Pairs with the smp_store_release() in vc_deallocate(). */
> +		struct vc_data *vc =3D smp_load_acquire(&vc_cons[fg_console].d);

[Severity: Medium]
Since console_lock is held here, is this acquire barrier needed?

Also, doesn't console_callback() still contain plain loads of this same
variable that bypass this acquire barrier? For example, earlier in the
function:

	hide_cursor(vc_cons[fg_console].d);

And later in the function:

	notify_update(vc_cons[fg_console].d);

This appears to leave the lockless synchronization incomplete if it were
actually needed.

>  		clear_selection();
>  		if (vc->vc_mode =3D=3D KD_TEXT && vc->vc_sw->con_scrolldelta)
>  			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-vt-v1-0=
-71b7990c26c1@vt.edu?part=3D3
