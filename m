Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83293264D2
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041167; cv=none; b=GVwg9auTrCSbN9M1HmvRIkiqY1qyt9m+IRvnSGDczVwP042k2K5X00LKZ8IlDOmKxFF9fMX3bFYOox2tAz0UJxbQNX9t32Uy9Agcbo4FR46O3wRx1jMzu9RpEMgTYVI4UdU+rFhFcCYV3UuOd9YkR/BhD6L8u90bhIP3qRYcVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041167; c=relaxed/simple;
	bh=xYJDkm6D8i/CsCR9V7Y4N1/TRKr4QH5C74uwGMbPXbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XdhBOv7mVV291DBIgF5VW1SW5EfmM14fXLvjWX34THOio7YJxe4JSgPhUR4xpwHZFwSvsQAnX4V9OYX+flQhrKMyxoFTQaWOjDj6FY+5fAWsSibT/NFe3/PwpkTJpm6tK9Eyykcn3Brwa2Y50H1E0Vy1uphtMxt+QakVYoyXnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DewMDaTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DewMDaTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26191F000FF;
	Tue, 22 Sep 2026 01:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041162;
	bh=Knc+LhHWDBFbIdYTFAQVDjL3Soep9r/la4bRC+BkLhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DewMDaTrkD3W2KoeEMD6HXf+PeFBghzW+0vNQ3/wBjDNbCtakiG9qb9oSOUK3STDz
	 5UuiEJTnK3qejX2AWCddABQj8W/eULbVobkbkL01E3n3LAV5uMTg9oglsFwguqtEVA
	 9fynXeMFJ6eif79UxrQc4gaKGo5QzpSzRQAYfSbfn8yHkP5ucqNfRquoVNM5sJiKdb
	 owtZOY06d/ThuozmMTjJ6L8uUBzHqlgIp6FRvKXWscnQZu2AKh8A3JkuFQZUenMUrc
	 kqUdseb4xXq/XPLJ5PgX9YjA2vzWfhpWtkRLEIuxFIfpk/rqeIR/+xMYVVnn5zNWMB
	 3DEiSru2jHc7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] vt: keyboard: publish dead_key_next with release
 semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-3-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-3-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:39:22 +0000
Message-Id: <20260922013922.B26191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] tty: vt: bogus memory barriers for dead_key_next under spinlock
- [Medium] tty: vt: flawed acquire semantics in k_unicode lockless logic
--

commit 8306184a36f96d0dec76dd629c6b568b695fecc2
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: keyboard: publish dead_key_next with release semantics

fn_compose() arms the dead-key state in dead_key_next and k_unicode()
consumes it together with diacr.

> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 6f3472cd4f24d..d7db5e226d7dc 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -618,7 +618,8 @@ static void fn_boot_it(struct vc_data *vc)
> =20
>  static void fn_compose(struct vc_data *vc)
>  {
> -	dead_key_next =3D true;
> +	/* Pairs with the smp_load_acquire() in k_unicode(). */
> +	smp_store_release(&dead_key_next, true);
>  }

[Severity: Medium]
Are these memory barriers redundant here?

The dead_key_next flag is only accessed within fn_compose() and k_unicode().
Both of these functions are exclusively invoked as part of the keyboard eve=
nt
handling path originating from kbd_keycode().

kbd_keycode() is called by kbd_event(), which wraps the entire execution bl=
ock
with scoped_guard(spinlock, &kbd_event_lock). Since all accesses to
dead_key_next are strictly serialized by this spinlock, no concurrent access
across cores can occur, making the lockless memory barriers useless.

[ ... ]

> @@ -672,7 +673,8 @@ static void k_unicode(struct vc_data *vc, unsigned in=
t value, char up_flag)
>  	if (diacr)
>  		value =3D handle_diacr(vc, value);
> =20
> -	if (dead_key_next) {
> +	/* Pairs with the smp_store_release() in fn_compose(). */
> +	if (smp_load_acquire(&dead_key_next)) {
>  		dead_key_next =3D false;
>  		diacr =3D value;
>  		return;

[Severity: Medium]
If this were truly a lockless environment, does reading diacr before the
acquire barrier defeat the intended synchronization?

The payload diacr is read prior to the smp_load_acquire(&dead_key_next)
barrier, meaning it is fetched outside the intended synchronization domain,
which could allow stale reads.

Additionally, dead_key_next is reset to false using a plain store inside the
block. In a concurrent setting, consuming a shared flag requires an atomic
operation (like xchg()) to avoid a read-modify-write data race where multip=
le
threads could read true and simultaneously clobber diacr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D3
