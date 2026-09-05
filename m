Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D6242910
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597552; cv=none; b=ojlum1AE1rnhgZ8ddL7xJTS4TdwlYvfwx1T3aVVOe+gsceI0gGJzFJJRAsPcQjY+eAGUf0zDFVFywy2HepEJoLIdpmCkMeAjv+gZ2ACue1F7R9VyYuM2j9/NaUjOFl3ReaGdbWXpccEYoyBi/3FEzCJX8h2XuSota/zPsFurbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597552; c=relaxed/simple;
	bh=mJSm2InVyUtdgvl4FxE0B6QsNVdR+Z4q3pxHZuV0yKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtrWSbSfn6bXy0+3TByc+HqFQp8IZRkI3BLvnSxKQEN4aTrJ1gXnXaIXTjR0z9KPUVjRrMzskKlF6ZkJruPjR8f6MplpKHkZxZWlIoGMZaTYaYKpQgdg8Evxfazy6mKGDx+Ff10EZiXvHXpIQjMFKHFx9NaA+a+VDaWJsTW8U9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTTrkA7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTTrkA7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA81F1F00A3D;
	Sat,  5 Sep 2026 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788597551;
	bh=mJSm2InVyUtdgvl4FxE0B6QsNVdR+Z4q3pxHZuV0yKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTTrkA7ilkzy9PN9Ddn7K4JGgz//sQmUcs+HxVfxAB9zuCHWtQUDSDDM8hUd+GwI8
	 MBr6qwZXBlMJGFPtgD/4X/kpWRRbNN/hzMn42oX3/D6kjxEIyOk8rKFQZDf+J7lFKH
	 yb4Ud88hi1P/Hb+wDZN9sedpxF52YeocGfOjdx9MtbHnlDtK0ql0av51Pk79kV4XhC
	 ySQrzdMDxztTiP2Zfoem/gzlSHSV62OCw8ZT0qnCbpGvkU/zvJrfkOo5CH4wd2Og30
	 L6nCAy8erY8Hw3zfRCiiFIDl941X7ylS+O/uT4MoGgdSXtEatCXCANxVGGb4lqb5Jl
	 ShM3bZhfZXf5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Documentation: rs485: Pull uart_get_rs485_mode() from
 serial_core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260905083648.39026-1-kmehltretter@gmail.com>
References: <20260905083648.39026-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 08:39:10 +0000
Message-Id: <20260905083910.EA81F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> serial-rs485.rst asks include/uapi/linux/serial.h for both struct
> serial_rs485 and uart_get_rs485_mode(). The function and its kernel-doc
> comment live in drivers/tty/serial/serial_core.c, so the directive has
> never rendered it and the section shows only the structure.
>=20
> Add a second directive for serial_core.c.
>=20
> Fixes: 0f4648a1a6d3 ("Documentation: rs485: Mention uart_get_rs485_mode()=
")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905083648.3902=
6-1-kmehltretter@gmail.com?part=3D1

