Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FE14A619
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591526; cv=none; b=W9iQa1F1BpMMwATPs5YOifUNYq8CbfyaHXZCaovBxfL7M9EgtX1z1SDDAg0DNuVC6pXxA+L+6SEKQcNA7m58pQ8yS4ug+WPtrWLTaHUxRZci4N4pgOrCIDD2jpQmDpJv01Of6vTjPUOe/AKP48ln4D9zbSTKfO5SxvJ8UmVIbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591526; c=relaxed/simple;
	bh=nSUKkqsjQVtB/bQiLkXOnmnrmmnDpP1aVk7lMxRIc5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gauMKWD/JNdsblJ6bwkLKAS3nKSR7DVYoqm2CVVlM0Ikj9JeqRIPN2854w0CPEqJDr0IIU9Vcuh6XRUskyuj0v7wXzn8wvhzhueNichxp/7XZfc6hmF4OuLA6O0rKepN3NFwDsMH6Wyp+i3attWo8UuwKW0gBBBiHitegLfqCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5ugoqAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5ugoqAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0CC1F00A3D;
	Sat,  5 Sep 2026 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788591524;
	bh=kpke9IVvm8AOwC+uiY2lk7MVFhtBnJAzJpK8iLGFEgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5ugoqAcXFE6DACdbAKHoRyXZT9kMzh4EKpCcp7xSLLZToG2xWjEXGtr9JSVUyVxF
	 zqO25bZ1FYbtDRinNgodTIpcV5y/5ehUoJ0phXpA3K7t1zhWHFscJqZUdqkn+/3HXP
	 r0hkf4oAe+iqB4siVFe6V9bLlzOfe5eIn8VR2UGnupQoMNVWauzVu6EdXwt+IDfoay
	 F/mTmNdli6umCRT9vjxbaM6rsCFZ5Q4idBshRrTKcUAm1JdYhq14cvHuDyfGqXRZe2
	 q/ao/pYNAZYs7tGzu0U00IqLMdKqa4JMUP1b17GNN8XsFYnIYFln6gZHCsAZ3TSR/l
	 XJNUsDdY4Ip/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: skip screen update for DEC alignment test on
 backgroup consoles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zizhi Wo" <wozizhi@huaweicloud.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260905064337.3083103-1-wozizhi@huaweicloud.com>
References: <20260905064337.3083103-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 06:58:43 +0000
Message-Id: <20260905065844.7A0CC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Zizhi Wo <wozizhi@huawei.com>
>=20
> [BUG]
> Recently, we encountered a KASAN warning as follows:
>=20
> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0x11f/0x140
> Read of size 1 at addr ff1100015fd9f6a4 by task tty_fbcon_oob/1239
> CPU: 7 UID: 0 PID: 1239 Comm: tty_fbcon_oob Not tainted 7.3.0-rc1 #100 PR=
EEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41=
 04/01/2014
> Call Trace:
>  <TASK>
>  ...
>  kasan_report+0xf0/0x120
>  fb_pad_aligned_buffer+0x11f/0x140
>  ccw_putcs+0x86c/0xa80
> [ ... ]
> the con_should_update() check in the do_con_trol() like every other call
> site of do_update_region() (update_region(), invert_screen(), ...).
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905064337.3083=
103-1-wozizhi@huaweicloud.com?part=3D1

