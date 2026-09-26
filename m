Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019B345CC9
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463998; cv=none; b=TKoiVdp3UpVTgmm6ynZLFBfVXtbc/o/HdtP4SnxKXykSucnBQQVJ6R9x/5woPE2I6xAxCtzaDTllU+qYHiI5iQ/g0NCOhI9x9Qa/2zS2Zkw3qIBY56NSzo3Th4ir4GCShGCbsyR9m+4eUTEQrSGu+wNENt87Ufci0IDV4eqZbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463998; c=relaxed/simple;
	bh=bTk669z5Dg+At222jqb9UlxSN2Ce1mZ38+2+SWC5zwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OjdClsWXwngg118C+CxDgbad3Qu1N0gdCFdh6pYwjMLjCw+XjZi2FBudZsB5cNoZCeVRBoeB21+R4Fg/sSdlGA9l3WSbebPtSUkcZRUZBHAHFkquy5aAAKxCuxOexLSmx6mWuNa2f1+iS5U9rBHNG7Z7fLLCOL3vmwzr7I2eY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvbWzBQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvbWzBQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D92B1F000FF;
	Sat, 26 Sep 2026 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790463996;
	bh=tiQ7Lv7UHrE35mqjzbs4MYt/SjmmKwTYqXkf5Fq4GBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvbWzBQCZcOg/QKyKETLzi8iPlELs7Vl7l8OCbjFCrzW2MfkVTGHs3RDGU/y4uWv4
	 EJk7y11AXKTO4Ny/v/vGTfVEwih2s8tlXM09363synx8j0f2RDGIUrGmXgoUGN19Vk
	 xSawt5nWPFXS/wWkgnhQMs+xjAjjzoZUl4KCAX41UVLZdaZ1v6TH4VG8+IcIxx+Jcq
	 qnVmye7XFMudDZKmCyTCgwN9POKCyoD+aX0AU/HXAUKf62/rMFOTJOXQjglMS7/cBQ
	 8IjAF+mLi16SZG63dBjcukWAxLXdqRytrTlkTyehO2oaD4tR3E1aYjQ0paZpDHJIq0
	 7pTKAImmjm/qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_mid: Add missing module namespace import
 for SERIAL_8250
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260927-tty-8250_mid-ns-import-v1-1-84d0482e1c5d@kernel.org>
References: <20260927-tty-8250_mid-ns-import-v1-1-84d0482e1c5d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:06:35 +0000
Message-Id: <20260926230636.3D92B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> After commit 1c305d5f1daa ("serial: 8250_mid: wait for LSR tx empty
> before setting termios"), modpost errors (or warning with
> CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=3Dy):
>=20
>   ERROR: modpost: drivers/tty/serial/8250/8250_mid.ko: module uses symbol=
 'serial8250_wait_for_xmitr' from namespace 'SERIAL_8250', but does not imp=
ort it.
>=20
> Add the missing module namespace import to clear up the error/warning.
>=20
> Fixes: 1c305d5f1daa ("serial: 8250_mid: wait for LSR tx empty before sett=
ing termios")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-tty-8250_m=
id-ns-import-v1-1-84d0482e1c5d@kernel.org?part=3D1

