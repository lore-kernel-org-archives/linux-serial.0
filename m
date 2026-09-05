Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4633ADAF
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634410; cv=none; b=W0IQPf/djlp3Bt80993+DF3TSDBUR9ThcaNvj0h0hH0c48Jg2sA889JgeRRLpGhhf6AnzIAlN+ukrmLxuWPWNTfaEYW2J23vSBCYvQMWDWZ7KPFXUrZiLpIdBQRO+pzxKIdZVuPeNtP1Tk7JdRcZNx7sJ5IlV5CrMSr4SJW2sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634410; c=relaxed/simple;
	bh=76pLq/mb81gcD5qGgzzfB/Dh6i+aaeztwxGB5RcTNOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JOPWOdEiYTzWAk5iyMFZxfdLJs44iT6E3+bZCw+yoMGMeW67jMzuVlmsXtq4Y0SCL6zkON9OvtYrHH398os+XlIIp9in5q/pf2iMYlETK5TACcJl7JVMIFSX7pdT7nNnREuTfar745rCgz+ncpUhMBSLxwgUjN3Q2HNj3y5dYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDIl8Zi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDIl8Zi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9885C1F00A3A;
	Sat,  5 Sep 2026 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634408;
	bh=76pLq/mb81gcD5qGgzzfB/Dh6i+aaeztwxGB5RcTNOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dDIl8Zi6jhW8ATrfl1+XqcFq5F5Nzbs6OsI3SsIuyA0OtDHuxvxSu6FuCwoPgMsZn
	 kHnmWFOGJEEdBjBHIX4q/SPP8UrQpGQysGhXa2Tb7E/5S5aPkn/X+IuQz0OA56lgbY
	 K/uNgmJZ7nwbNdSmaVUC0+3FCGDcKF3Dqu6TUHxZpAvrwDj2lFW3lG/6AQ0h4+t7Ri
	 Cv8y29kAZaJQ2iO87Dwe+8ugfH/+d3GLEgg3+4hARf57AC/4yi2ZJEJ48POR8We6TU
	 1lnwJrLJw6NEM1r1OZJFCezOc2xZH3LeIOXHwmFYM5zK6/jToGgO+EVXHa0b83jyUT
	 B3xyMwlu16HmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] rust: serdev: Mitigate race conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
References: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:53:28 +0000
Message-Id: <20260905185328.9885C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> There are currently 2 race conditions:
> - in probe if `Driver::probe` returns Err
> - in unbind
> . In those cases the driver data will be set to NULL before the serdev
> device was closed. If data is received while the driver data is dropped,
> the `receive_buf_callback` might try to access the `active` mutex on a
> null pointer. The race conditions can only occur if `Driver::receive` is
> implemented.
>=20
> The issue cannot be cleanly fixed without rewriting some logic, which
> might introduce new regressions.
>=20
> Temporarily disable the use of `Driver::receive`, until fixed in the
> next release.
>=20
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-rust_serde=
v_fix-v4-1-31e1bbcc0c00@posteo.de?part=3D1

