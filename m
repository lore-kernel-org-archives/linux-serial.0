Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90C3AA9D1
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915178; cv=none; b=BzbbYsh9bSRv9fjwk5RvWBKSnpG0O/bGiYGVBfA6nfLwlwamXUFQU4KYFK0u+u/kPqijadsbniBL1U8U2eq4CIeoUvJPNG5jKvE0WhAwvWNkaAe8P6ainpCeyxpXLqP7tJGr30D0rcUBOXUNP/MAoDQZUA35T3J57gdQk5QqkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915178; c=relaxed/simple;
	bh=G9pUTBTl18Ka+hXJHej/98OEnL8ccmGMrSk68wpNte8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjRgLkujQFvgoyeDn/R5XjrI9l71ia3FRPUWaQBaWnZIs2WTAOQvxzR4XwePTw1sb0pDdpL2a89JFfh4NQQRl6WvWuHzogovPEOAHlDzAbpQZFbG6Yrc7P7+7w2/qa+aSy/cKTbPtQi0k8AoTbgZeA/swhebQXUaoOyqWJlgtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuMl/q0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuMl/q0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E917D1F0089C;
	Sun, 20 Sep 2026 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915173;
	bh=G9pUTBTl18Ka+hXJHej/98OEnL8ccmGMrSk68wpNte8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuMl/q0EgNefaVHjbrAvBJCtO8dnPejG2VriG7pbHmUDEEf3oLxfR9eIcdqOP/N/3
	 Bue744UJDzXPKXACsILu5gdtZJqa9MNi3mdTOyr0xPG8tixQ0oY7aWdpKmp0wFjzqF
	 SWijvlKvgg/mqWLeYFSmg2Ts5xqBiLCsixPd1Bsz7lpUED3eW0tRpyMwDYnIzLEgFn
	 pSN1w8AFnWX/OhzkkVBJrkhfGaMifPRfHl57AFFtKrWFvqMbcY0F4oCDvtkJyMwzjd
	 89/jT+whBMqWvfur4l8TVP5legNr7/gzpYq5wkSjQPG9GiJoPKhaewJpU40SbWHRba
	 5rZcshGhmVF0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] rust: serdev: Replace `active` mutex with
 receive pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-2-43b855162f5d@posteo.de>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-2-43b855162f5d@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:32 +0000
Message-Id: <20260920143932.E917D1F0089C@smtp.kernel.org>
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
> null pointer.
>=20
> Removing the need for `receive_buf_callback` to lock the `active` mutex
> fixes these.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-rust_serde=
v_probe_refactor-v2-0-43b855162f5d@posteo.de?part=3D2

