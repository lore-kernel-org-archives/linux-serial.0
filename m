Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E818BC3B
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041112; cv=none; b=WuPwPt3F7Us6O7KbijC0srsuEdfpC/Yrs6m24fXcJL8qAzbX441DkNwI0/v4apAYg+Z/bDnM/XbaHscqrP1gwLE3sXA3mJH97m7vamZwiCj78uzi/iooM2tuEx4QTzIYHVQsBxm0Y7aRub8FVyhd0GOwCFYSHdjY/4bU4zXEOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041112; c=relaxed/simple;
	bh=76jgE+rFvnuJsxvecbwvdfD104OBKzWxKOlGDIe0XSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2QCg89G6kfIt6TamvkFfZU3E7xdykQMSORrHtyyXoANWoHuxw1ar9cnNZ1C/JYft4xQ1DFc4XB/qa60T4GZgGSlrWGCxp5AZRFEnP11+QrLnuQ5lueZkxibvhHznaiN9E4aiB6C6zlmf/iX8ti6P4meEMJRabF7PzIUG46pM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXdYGJyO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXdYGJyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257961F000FF;
	Tue, 22 Sep 2026 01:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041111;
	bh=1VDbnRPOYUagkskPf4fzQJWdDCJ+LrimZ5yiI9vJUyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YXdYGJyOY5oNeLsU6Q5j1rN32y/vQTeiOLDZtooLtS+xVD1vVLk3hnYGawcPpH8Rq
	 6Aprs1AhNpdPaCG83D5nBHQ7HtOcjB04OamHXYPkV3yOz53WCaqOrpLy93itZNdYP3
	 szjf6qLL6+C30aERR/wf6DrBkNeUVCbesansrcOvsRS4Gy/MH0G6gjEeBlZe7sNfaM
	 aJwRmKTHjVJmzdH+IKSEw4gw+R0z+tYeuopfAGIBO5eQlnnTmiaPiDa7svLA3I2VIi
	 6UqJrNza4OPikymzUxv1N7+abrT3O/neat/zkLUZBI37cQeymBxau945GZfFu07QvW
	 n1HTaLLvDQjkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] vt: keyboard: publish shift_state with release
 semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-keyboard-v1-1-d170228b80c0@vt.edu>
References: <20260921-mb-keyboard-v1-0-d170228b80c0@vt.edu>
 <20260921-mb-keyboard-v1-1-d170228b80c0@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:38:30 +0000
Message-Id: <20260922013831.257961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] vt: unnecessary memory barriers for lockless scalar access
--

commit 97a82ad73b6718204026d341ed2e3831f7cbd52f
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: keyboard: publish shift_state with release semantics

This commit replaces plain reads and writes of shift_state with
smp_load_acquire() and smp_store_release() to specify the relation
between the counters and the summary word.

> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c41d850b29c6e..089f3b048beee 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c

[ ... ]

> @@ -889,9 +890,11 @@ static void k_shift(struct vc_data *vc, unsigned cha=
r value, char up_flag)
>  		shift_down[value]++;
> =20
>  	if (shift_down[value])
> -		shift_state |=3D BIT(value);
> +		state =3D shift_state | BIT(value);
>  	else
> -		shift_state &=3D ~BIT(value);
> +		state =3D shift_state & ~BIT(value);
> +	/* Pairs with the smp_load_acquire() in vt_get_shift_state(). */
> +	smp_store_release(&shift_state, state);

[Severity: Low]
Are acquire/release semantics strictly necessary here?

The only lockless reader is vt_get_shift_state(), which simply returns
shift_state directly to userspace when it calls the TIOCL_GETSHIFTSTATE ioc=
tl.
It does not read any dependent memory like the shift_down[] counters.

Without dependent memory reads to sequence after the flag read, the memory
ordering guarantees provided by acquire/release semantics seem unused,
adding memory barrier overhead to every shift key press and release.

Would a simple WRITE_ONCE() here and READ_ONCE() in vt_get_shift_state()
be sufficient to prevent compiler tearing and reordering for this single
scalar value?

> =20
>  	/* kludge */
>  	if (up_flag && shift_state !=3D old_state && npadch_active) {

[ ... ]

> @@ -2212,8 +2215,11 @@ void vt_reset_unicode(unsigned int console)
>   */
>  int vt_get_shift_state(void)
>  {
> -        /* Don't lock as this is a transient report */
> -        return shift_state;
> +	/*
> +	 * Don't lock as this is a transient report. Pairs with the
> +	 * smp_store_release() in k_shift().
> +	 */
> +	return smp_load_acquire(&shift_state);

[Severity: Low]
Could this use a plain READ_ONCE() instead of smp_load_acquire() since
it does not read any dependent memory?

>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-keyboar=
d-v1-0-d170228b80c0@vt.edu?part=3D1
