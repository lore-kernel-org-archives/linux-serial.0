Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220322FE060
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041382; cv=none; b=RadSRex5IpMPQkqvxSDcxjEdsLk8N452FkX4d7Lx4Ea6JpKzlFhGdLoQ7CxJ9Jg8/wqjZ/abVsILA6DxjAy3rweNU1Ivh8EgooCdhdtdUoyr1EKhiyxS7E3j8050wf+wWRrw8jFD7xhywky9OlsmyuhpnsPM06BjsGB+PLGvkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041382; c=relaxed/simple;
	bh=aCwK7HJbaCMfRfZGRYIe1o2uR7sbKQhkARSdgGqJWDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IO6PnfnqDH3TrQzImfwSXKI/iBUVMHUcUEDRhrbANK73KJbKQPWgmV5EAJzLS1HhF0c0ENL39ShCRCM+ltqzh+x9V9jr4BwTGGiYJ/YnM7PPwNJzpRT3obFyG9XFBWxJMKRorGRokxhnYq0Y3cMcbMEgFPwic5FeGhzFUB3YJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGJIUE3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGJIUE3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA91F000FF;
	Tue, 22 Sep 2026 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041380;
	bh=a2/FPofsUDKDDUWdijC9zc7HNyduVgnKactlc6lxyk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGJIUE3IbN9mMgBVxTSymR8np4zhVyiCrbgkx8zP5cvS9w+9plcAUAvVSYgSKsWm1
	 IwRP8yHUNT93/cWZ9UWAa9qRLSjGzDk17PGsxG0j9Py1kF9jvCEVb08EKTUaFcuJ+g
	 pHprIjdCHiDnOpknI71gzEPW52PMy2MKpELvQakoAUtwdX37qniIXr96ohaYnY2qnx
	 Umta/julevn7mDDwhD8LJugjG5RmwQTgoOh5ngrzlZEnuvo4e8qILgHch/s4jIKuId
	 SSgvyUfr05ikUxfaIH5sdShxw363SPl2VUwj3KzxQO6UVeOwKRbXa2E1RTrZZiHnKY
	 5DIFJnCkV3gSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] vt: keyboard: publish the shift_down[] counters
 with release semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-6-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-6-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:42:59 +0000
Message-Id: <20260922014300.6CBA91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tty: vt: unnecessary memory barriers on shift_down
--

commit 00b20e2546808f30870c343c8e766b47b9bd3b39
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: keyboard: publish the shift_down[] counters with release semantics
   =20
The commit updates accesses to the shift_down[] array by adding
smp_store_release() and smp_load_acquire() semantics. This change was based=
 on
a static analyzer report.

> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 87970415a043c..e6112e0db1020 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -823,7 +823,8 @@ static void k_pad(struct vc_data *vc, unsigned char v=
alue, char up_flag)
>  		return;		/* no action, if this is a key release */
> =20
>  	/* kludge... shift forces cursor/number keys */
> -	if (vc_kbd_mode(kbd, VC_APPLIC) && !shift_down[KG_SHIFT]) {
> +	/* Pairs with the smp_store_release() in k_shift(). */
> +	if (vc_kbd_mode(kbd, VC_APPLIC) && !smp_load_acquire(&shift_down[KG_SHI=
FT])) {

[Severity: Low]
Are these acquire semantics necessary?

A key press or release triggers kbd_event(), acquiring the kbd_event_lock
spinlock. This calls kbd_keycode() which invokes k_shift() and k_pad() via =
the
k_handler array.

All functions accessing shift_down[] (k_shift(), k_pad(), and
do_compute_shiftstate()) appear to be strictly executed under this spinlock,
meaning there are no lockless readers for shift_down[] in the kernel. Did
the static analyzer produce a false positive by failing to trace the
spinlock across the function pointer invocations in k_handler[]?

>  		applkey(vc, app_map[value], 1);
>  		return;
>  	}

[ ... ]

> @@ -890,15 +892,18 @@ static void k_shift(struct vc_data *vc, unsigned ch=
ar value, char up_flag)
>  			clr_vc_kbd_led(kbd, VC_CAPSLOCK);
>  	}
> =20
> +	cnt =3D shift_down[value];
>  	if (up_flag) {
>  		/*
>  		 * handle the case that two shift or control
>  		 * keys are depressed simultaneously
>  		 */
> -		if (shift_down[value])
> -			shift_down[value]--;
> +		if (cnt)
> +			cnt--;
>  	} else
> -		shift_down[value]++;
> +		cnt++;
> +	/* Pairs with the smp_load_acquire() in k_pad(). */
> +	smp_store_release(&shift_down[value], cnt);

[Severity: Low]
Are these release semantics necessary?

As mentioned above, since shift_down[] is already protected by the
kbd_event_lock spinlock, are there any lockless readers that require these
memory barriers? Also, as there are plain reads adjacent to the release
store (e.g. cnt =3D shift_down[value] just above), the implementation would
be flawed if lockless concurrency were actually present.

> =20
>  	if (shift_down[value])
>  		state =3D shift_state | BIT(value);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D6
