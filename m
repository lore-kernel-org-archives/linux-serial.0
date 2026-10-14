Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787D537E5D7
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989397; cv=none; b=LneuazV5ei5GZSplDTyTF4rHmOK/UN7+moz4WT5/bSEjzOQ/mI8/m4BcXld+iyLwZpVSnBX5vcErFbIIN6P043yqFhluOpmMLcjv0hMi/bqopPPLq6rf9MnNc9f3b6nZPH2Tt9YFBdw+nXi/Iazdn2q6T7pOn6U/0lehBglGoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989397; c=relaxed/simple;
	bh=z7TtBJkrHKUFB7nWY6Z81RWsq6U6VWoPQHrM51vcqz0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rjNsBQhNc9mbc5enbilwmPjbVVKAYPZnqy6iHSL90an5moKha4L0Yn41l+7VMuKsgnEfvo2kV3Rnme7tINucTuk1wQCrb5rp8Y5BgqH3NHRmB3lLIKIrDxKyRvaZ64/9+mP+tdN6dILlROpduiVHfGtpcbKY6ZjVJ76LI7DczkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo7jtiEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo7jtiEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C3F1F000C4;
	Wed, 14 Oct 2026 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989390;
	bh=z7TtBJkrHKUFB7nWY6Z81RWsq6U6VWoPQHrM51vcqz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fo7jtiEk/RpRRN7bDV9ZEOxX6R2OnaCdbJO315nKk4FwDrk1y/5b+uDGCl/8M+nk0
	 2oNOasVKmjvUss97+eS43OD9by0L66mUnICgosjrwGY00SzpgQGJKjCD+XzYCKzKqo
	 M0dHVzLDTul/LXSpCQzp4jwXoeSBbFj1e5U28aN+J2IwpEE5y6moAz95Q2RU5maOHQ
	 o/BnoWKrp+7jgTzCnk8H7FIrMWnC5IZ+oru/bIt2EwEF4TYe1xp1LGFtYeyrc8CA9c
	 qD2PxjQ+ikFAcQHRsu50b4OT7AIACqjmJzvhkmC1D+unx9sdcQF0/rF2fFKzJfE+8B
	 /eB16y6C0l4IA==
Message-ID: <sashiko-outbox-171445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tty: hvc: dcc: Detect JTAG connection only on CPU
 core 0
Reply-To: sashiko-reviews@lists.linux.dev
To: shatyuka@qq.com
Cc: linux-serial@vger.kernel.org
In-Reply-To: <tencent_77968AD30F111278CBAE934BCFD0AF00E807@qq.com>
References: <tencent_77968AD30F111278CBAE934BCFD0AF00E807@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:49:49 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Jiannan Du <shatyuka@qq.com>
>=20
> On SMP, migration can occur inside hvc_dcc_check() during device_initcall,
> so the CPU writing the probe character and the CPU reading the TXfull
> status may not be the same, which can hang the system.
>=20
> Commit 4419da5d5d4b1788568b ("tty: hvc: dcc: Bind driver to CPU core0
> for reads and writes") cached the DCC availability detected on core 0
> during console_initcall. However, this is not sufficient: if core 0
> does not detect DCC as available and another CPU later calls
> hvc_dcc_check(), the check is not actually performed on core 0.
>=20
> Since JTAG is not expected to be plugged or unplugged during kernel
> boot, especially between console_initcall and device_initcall, checking
> DCC availability multiple times is unnecessary. Cache the return value
> from hvc_dcc_console_init and reuse it in hvc_dcc_init. This avoids
> complex SMP-related code and ensures the result is always from core 0.
>=20
> Signed-off-by: Jiannan Du <shatyuka@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_77968AD30F1=
11278CBAE934BCFD0AF00E807@qq.com?part=3D1

