Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CFF4A2066
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819058; cv=none; b=Hmhg865nDT4VPpBr6Gy8/eMM8f7UVL71CA0dT7QhUdQDU3aTAfTmbe+ZkGjw9TK/mKY6WTNONGk6QpWaSgck6DMauiF/O7Q4yIdVBuhQ12mYAVn9YbAaF/SpJOfvQYk2s04e47+kDKsyA2uMuXo8768ydAgINNi22uS7JaGm3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819058; c=relaxed/simple;
	bh=WB+qqlQn1AJfa+/vqmASRAcpIQr3p1b5gKobOKMtuTw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Op9ezGvRNwwnjIQX4dvDZBx/5Hh7JYIHQIzOwkj1nqUc3Hgi2MT05H5LyoXVnf+E6q/09ijk4VNLxMOs6OtcJgNCDasvT0j5m1SzsGkPypMtdN2D0CpWzoxZxBc3wrvmZrOH/UTT5dllblrXwqIUaNiq9kjEpFY6bqgiffYTP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guSwJLOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guSwJLOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D8B1F0089C;
	Mon, 12 Oct 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819056;
	bh=JAaKhuSSYBE/WibNIeTnUd832JjhiBUFDMnro8TMaFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guSwJLOFNZ82297XuC3SQoV8KnnvPOLa6oe5o0iv6gro9jVETYblYp0x1w/SBgN+a
	 LXdCvkRDaY2ZgLVi4Mn/oGMy5CSweznLF33tAz0kPJDnb5aIg0RJuPeRwqdJs1BJci
	 HDCoqYUDGYlzCs4I1om+WE7gH1aBMdxYfO3jK9zP59QOZ665YskRKkw6prh10hT1fj
	 YuCeq5WQoXHuAfTVXi/lRy5ncYXtUXf817Aj+CSzKdQLERPpo6hlrwCK4kS65galec
	 tZRD/spl25GzVG8VoUTOpmTGba0TESN42+EX7T+EfgImF6fyrqi2e4syjbMZuefDeY
	 WfLxZVnXQLcDQ==
Message-ID: <sashiko-outbox-168336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: hvc: dcc: Detect JTAG connection only on CPU core
 0
Reply-To: sashiko-reviews@lists.linux.dev
To: shatyuka@qq.com
Cc: linux-serial@vger.kernel.org
In-Reply-To: <tencent_323D31BEC6A1CD2A843E2E48242C774ECE09@qq.com>
References: <tencent_323D31BEC6A1CD2A843E2E48242C774ECE09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:30:55 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: hvc: dcc: Meaningful code and commit message mismatch
--

commit 0189cf9a56296b2c974669020e309b13432dff40
Author: Shatyuka <shatyuka@qq.com>

tty: hvc: dcc: Detect JTAG connection only on CPU core 0

This commit aims to prevent system hangs caused by SMP migration during JTAG
DCC detection by caching the availability status. It simplifies the logic by
performing the check once and reusing the cached value.

>    Multiple checks are unnecessary: nobody is going to plug/unplug JTAG
>    during kernel boot and expect it to work. Cache the return value of
>    hvc_dcc_check() from device_initcall and reuse the cached value during
>    console_initcall. This avoids complex SMP-related code and ensures the
>    result is always from core 0.

[Severity: Medium]
Is the direction of the caching described correctly here?

The code implementation seems to do the opposite: it caches the value during
console_initcall and reuses it during device_initcall.

> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index dfc5c9c38f074..fc8dcbce9b5b1 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c

[ ... ]

> @@ -265,7 +250,8 @@ static int __init hvc_dcc_console_init(void)
>  {
>  	int ret;
> =20
> -	if (!hvc_dcc_check())
> +	dcc_core0_available =3D hvc_dcc_check();
> +	if (!dcc_core0_available)
>  		return -ENODEV;

[Severity: Medium]
Is the return value of hvc_dcc_check() actually cached here in
hvc_dcc_console_init() during console_initcall, contradicting the commit
message?

> =20
>  	/* Returns -1 if error */
> @@ -279,7 +265,7 @@ static int __init hvc_dcc_init(void)
>  {
>  	struct hvc_struct *p;
> =20
> -	if (!hvc_dcc_check())
> +	if (!dcc_core0_available)
>  		return -ENODEV;

[Severity: Medium]
Could this be the exact reverse of what is stated in the commit message,
since the cached value is reused here in hvc_dcc_init() during
device_initcall?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_323D31BEC6A=
1CD2A843E2E48242C774ECE09@qq.com?part=3D1
