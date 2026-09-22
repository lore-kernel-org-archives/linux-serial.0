Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821473264D2
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041138; cv=none; b=VL7KwCmf5YuEvgLishrWGCniipWjVjH+4n6mMtTYh2u2EINTQ88dGLHEDG8KB9rsdTh3X7evYO1QvN/8+NobN4i7UxvdDH7b+P0AC6odvqa5uMx4JVsI1+WTqZiCpDjiqCD08dmzcFUEDavNxXDZ03Xgth7O3t6nTtp4BLgM+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041138; c=relaxed/simple;
	bh=o5hvSsiPIlPEMsFp4pen8XoLjOm2r4qblXU05tM5ygU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNx6TJ4rbh2xPEtiL3I4hkweh7rYYGwlD3s51g+VbliFB6WxRM7U4bNnH2gsNxMzekg1mualQQHRd741IUn3ZJ9P/CyPSB5ADHIiTwDJXc/K7GK6zDxBGqgXjeEWo5EdF9V7v9njZdPozEtivv4BCKT3dWPT5AIbDFbOidcOvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldBiVBnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldBiVBnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AB01F000FF;
	Tue, 22 Sep 2026 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041137;
	bh=qSDLqZfyXYF8DKn16FuCluAjgE6qqDQxKp/UCjWgvBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldBiVBncSCI8yjCj7c5ePRVadPwqxxBW7RXSTKZZ2bFEZp5pjy9IBtwAWT4WFeJ/M
	 5PYLfjo8EctxWk8gXgvcptqnT4/9evihDCwSgCRC1dmkm8QIvNeaaigDfGJjNhfeEZ
	 NiPuThsJnC55A8ScJVLp35UZyV3zHWn16ToYgHaVhQRiGQvmfh4EAq+UBvicAbSsUl
	 K/lWnRj5LTh8gj1BanGUsrT2Tak4H7ES2hbbv9etMpETFAjv4gPtjdwiAxJr7uNy6r
	 Mkl1BAl7ms24CEmlfmB76gbizxTLbYitmBbcHub+UhGusNw409daY0X4j4Mkz2Ufx9
	 nKUtlBRds3XNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] vt: order console_blanked between blanking and
 unblanking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921-mb-vt-v1-2-71b7990c26c1@vt.edu>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
 <20260921-mb-vt-v1-2-71b7990c26c1@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:38:56 +0000
Message-Id: <20260922013856.E3AB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] vt: redundant barriers for console_blanked under console_lock
- [Medium] vt: smp_store_release placed before protected state updates
--

commit e185177321eb3b6f0a4a6c836f482dfda649b14a
Author: Jaidev Shastri <jaidevshastri@vt.edu>

vt: order console_blanked between blanking and unblanking

This commit adds smp_store_release() and smp_load_acquire() around
console_blanked in do_blank_screen() and do_unblank_screen() to order its
updates against blank_state and the console state.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 3abbd6cf9bd69..7264021672baa 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4683,7 +4683,8 @@ void do_blank_screen(int entering_gfx)
>  		hide_cursor(vc);
>  		save_screen(vc);
>  		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
> -		console_blanked =3D fg_console + 1;
> +		/* Pairs with the smp_load_acquire() in do_unblank_screen(). */
> +		smp_store_release(&console_blanked, fg_console + 1);

[Severity: Medium]
Are these barriers necessary for synchronization between do_blank_screen() =
and
do_unblank_screen()?

Looking at do_blank_screen(), it expects the console lock to be held:

	might_sleep();
	WARN_CONSOLE_UNLOCKED();

do_unblank_screen() also expects the console lock to be held:

	WARN_CONSOLE_UNLOCKED();

Since both functions are fully serialized by the console lock, wouldn't the=
se
barriers be redundant for synchronizing between them?

Additionally, the commit message states that do_blank_screen() stores the v=
alue
after blank_state and the console state have been updated. However, the rel=
ease
store is placed before blank_state and set_origin(vc) are updated here:

		smp_store_release(&console_blanked, fg_console + 1);
		blank_state =3D blank_off;
		set_origin(vc);

Does this fail to provide the memory ordering guaranteed by the commit mess=
age
for concurrent lockless readers?

>  		blank_state =3D blank_off;
>  		set_origin(vc);
>  		return;

[ ... ]

> @@ -4705,7 +4707,8 @@ void do_blank_screen(int entering_gfx)
>  	/* In case we need to reset origin, blanking hook returns 1 */
>  	i =3D vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
>  				 (vesa_blank_mode + 1), 0);
> -	console_blanked =3D fg_console + 1;
> +	/* Pairs with the smp_load_acquire() in do_unblank_screen(). */
> +	smp_store_release(&console_blanked, fg_console + 1);

[Severity: Medium]
Similar to the previous case, the release store is placed before the potent=
ial
call to set_origin(vc), leaving the console state update unordered:

	smp_store_release(&console_blanked, fg_console + 1);
	if (i)
		set_origin(vc);

Could a concurrent reader acquire console_blanked but still read stale valu=
es
for the console origin?

>  	if (i)
>  		set_origin(vc);
> =20

[ ... ]

> @@ -4737,7 +4740,8 @@ void do_unblank_screen(int leaving_gfx)
>  	WARN_CONSOLE_UNLOCKED();
> =20
>  	ignore_poke =3D 0;
> -	if (!console_blanked)
> +	/* Pairs with the smp_store_release() in do_blank_screen(). */
> +	if (!smp_load_acquire(&console_blanked))

[Severity: Medium]
If the intention was to protect true lockless readers such as tioclinux():

	case TIOCL_BLANKEDSCREEN:
		return console_blanked;

is the protection incomplete? console_blanked is still updated with a plain
store later in do_unblank_screen():

	console_blanked =3D 0;

Would this plain store remain exposed to those lockless readers and leave t=
he
data race intact?

>  		return;
>  	if (!vc_cons_allocated(fg_console)) {
>  		/* impossible */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-vt-v1-0=
-71b7990c26c1@vt.edu?part=3D2
