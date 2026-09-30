Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACD5304CD
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790149; cv=none; b=f8HTG/wX+hcKn83bAq3erFBRcnytbfftpsslis9A7RYuRcydILGAesIQ7IQAOvKKs+ttXTwVI/piPal2aR6BIreavHUsFYaP9cxVxrJLT34YlohoPdqBmbINKPRFOf6n+qhG5FtfuGkLI7hbXAvHY4BjtmFZ5NrWM0MnmA5dGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790149; c=relaxed/simple;
	bh=4wv4FotHdUha57+EJQhKbFNF6eQN2PwR1WtuyzJKOPo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWjWYEMTb+wV/nGBt3He/BvQHAMe/P5F4puMgCSdWFWzX5flH6ovWVzglND1DNkkliMzc6Tk9gq7fXe+y8ikLc/XO1uXFpElmYEdZ8OifV8xfTxFtQLKpFS42ypgiVOaCTIejUbT9VUakJDq0SZtWB/gV4FOBYDWnjzPqeMIXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEVC0SKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEVC0SKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFB11F000FF;
	Wed, 30 Sep 2026 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790147;
	bh=4wv4FotHdUha57+EJQhKbFNF6eQN2PwR1WtuyzJKOPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEVC0SKcmF7uL1e6jVmtyT7CbT/bVpbiSGLrelHTu0wYVSDSa6EBBgR/kF9K3GD53
	 mTKOeWh9QpKLEuquoGnCQEHwb5n/4V5/eRePFg2chZzqYDngZtxKpRbv3b6sSIgvBX
	 ZxdLI+HvxjhWkY4fxVipCSvC+q3WNyHXzes7bTfgZIabCRxvz80DUhfT/Jtp9SVDrO
	 UolffvIi2AhcS93X7Cekg82r0iKWBJf6mdjhCri+Rot7TMtif6NH+ChmLNwcRbpypa
	 Ej8ij+FTEGpVmSUOHL7OdO9g4MKGLnmt5CwiW32R0WB953/OadGQByxzQKgWYCowbF
	 4LZMQKsZiFwog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] rust: serdev: Replace `active` mutex with
 receive pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260930-rust_serdev_probe_refactor-v3-3-d1b6e77135e0@posteo.de>
References: <20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
 <20260930-rust_serdev_probe_refactor-v3-3-d1b6e77135e0@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:42:26 +0000
Message-Id: <20260930174227.1DFB11F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_serde=
v_probe_refactor-v3-0-d1b6e77135e0@posteo.de?part=3D3

