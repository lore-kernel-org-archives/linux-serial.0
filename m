Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D93CF1F2
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143868; cv=none; b=VkPd35cTnBn+GL4L3XAghvKwwi8FPOde+uUIPhrNM9iEg8gvba8ptpRu4YBfZC8cav0Q2TEOLiyPVyjL/841qHo1lNS8ugFLEfS8d9ffRMFOm34ALX5IegAuuGXpMC62b/7zbAUUrmDo8+CpCakhjkV838Aco6XuJnc4SwyceX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143868; c=relaxed/simple;
	bh=dsLhpRgNgRMtkoi91fP+ueO2DvpRvOysISElHSBN6RQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HY7Df4HhsdJYEyNeW8ijs9LnYlQj4/tCQS0jfERUYA1ThfD5iV00YlCQ7zgza+Hb+kEMdLrJ9rMV/RXy1VR9lqHgSE9Dj8LWUR3tweKMLfQkCjSsjE+WdeyScFs4Gh34T6XSDPC+rMTHJVas4tumqFWpzhbN35lU5KCe/npUIRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3NkeIg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3NkeIg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568DD1F000C5;
	Fri, 16 Oct 2026 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143867;
	bh=MTfCCHXo5xCwRiWLV90j41hiUVf2OsDWIAq5QfGKQX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3NkeIg5FVW64BXjUkr82nq/HVfa303D94ppcqO1ciQwkGqDdKQRlkOtI3UdhHNEZ
	 A17nQ+QHNnR+zf/RAePBHZoDp8iK0Zhc48hy+Xe/USoLzN5E5uTP9gmF+oy/5VKt33
	 HsrQmLlc8b8kOBXivpEfi5VQ9wlp6FFIsoay51z0/s3GeG5vHXN+5v5lRRjyNK6H5I
	 X/x0VaklRvP01WSRwICnOSEQOVeL7aefqxWjuyKnd0nW0iROVhycp3GBvY/x+O+lwh
	 q5wsI5jmExeOM1u8fJ7bgDgiLsCuCOQEe7uk1ydhnymI0Oij2zPnuKHgqHX7vBVY+U
	 DfS65uoMpevjg==
Message-ID: <sashiko-outbox-174092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] vt: Add con_unblank callback to struct consw
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261016093357.33294-2-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
 <20261016093357.33294-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 09:44:26 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vt: Meaningful commit message mismatch regarding con_blank vs co=
n_unblank
--

commit b9997468d0018b5c7f81e52b909c357d93d38641
Author: Thomas Zimmermann <tzimmermann@suse.de>

vt: Add con_unblank callback to struct consw

This commit introduces a new con_unblank callback to struct consw as
the inverse operation of con_blank. It updates console blanking and
unblanking logic to utilize this new callback when implemented, while
falling back to the old semantics otherwise.

> Add struct consw.con_unblank as inverse operation to con_black.

[Severity: Medium]
This isn't a bug, but there's a minor typo here: "con_black" instead of
"con_blank".

> If implemented invoke con_blank to turn the console from blanked to
> unblanked.

[Severity: Medium]
Does this description accurately reflect the code changes? The text states
that con_blank is invoked to turn the console from blanked to unblanked if
the new callback is implemented, but the code actually invokes con_unblank
directly.

Looking at do_unblank_screen() in the diff:

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
[ ... ]
> @@ -4756,9 +4766,15 @@ void do_unblank_screen(int leaving_gfx)
>  	}
> =20
>  	console_blanked =3D 0;
> -	if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
> -		/* Low-level driver cannot restore -> do it ourselves */
> -		update_screen(vc);
> +	if (vc->vc_sw->con_unblank) {
> +		if (vc->vc_sw->con_unblank(vc))
> +			/* Low-level driver cannot restore -> do it ourselves */
> +			update_screen(vc);

The new logic successfully calls con_unblank(vc) instead of con_blank() for
this operation. Could the commit message be updated to clarify that
con_unblank() is invoked directly when transitioning from blanked to
unblanked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016093357.3329=
4-1-tzimmermann@suse.de?part=3D1
