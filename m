Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486413;
	b=ZCFrgnQNPeo8XRjW5exfcDNABqQWOXBrGoKGRAWTwqQ7exc58cXh1Vpsg1Hel/VBAsrv
	 A/pGMOUIQcLehgawsTAGTuUbYrjgGLMkQuHUMXSVti4REKeMlfRPoT5gcVzOWM3d/uA5L
	 oPZUlPH8mYI901ONR2QKwPalGC7kUlaJA3FaQtLfiyS1JdwTf98L5wQsMxBblnFPthoWr
	 LuPPxNI1QIwy+egSd534nl51JS/0amHtEy8ZI6M2erZ50b3AVvOWEPwCpZVxzGkerMtpc
	 xDcKnuXdZbC1AInWbZyQfs8fqEO9ff3ATo9YqLI+PjKe2DjYstqaRvu+P/RUyYniz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9nqKCOWHuqbHt1ge54dVLv/+N+1NKGzHu1fz1S22TLk=;
	b=JyP46k9s193BNUUHRYVlsz3Ed+y0tj9BB/342Qq5HW2HuQKDMWmAxPF3i5O430N7Xvla
	 cZjxW18yBOSa991EE5bxvrIqkLEb7khs4LvQkKN02mGVkKQ31iO3/bVzuFr2IiN7w3Gma
	 0plyxXQaJ4hXlhOO8g0neflM/pzLBCc/Lc6VZN7HHu6nSOnDVkyfT33CP3xGg/9l8Sicv
	 wP+EZseaToSWKJSeNIlkSIh0OvReOHRvCGqf1wqCL4ad8asiHK0mZc69xoqv0L5X/1e6i
	 RGvHCjW+4Fcfrmb0qTPNke+Kr90oLNgmBkisAzjVEhUYbWpTDXr78kOYwciWROGxcjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeEnQ97C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272F606A31B
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeEnQ97C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF411F000C4;
	Tue, 20 Oct 2026 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486413;
	bh=9nqKCOWHuqbHt1ge54dVLv/+N+1NKGzHu1fz1S22TLk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TeEnQ97CXd8IKkfQDoAnkEbt54HnYa11waDMv5RGxyHgKL98ToNxRfFTilkYhOzVP
	 KImF2UKK34CwAvaedEpdgN7LeYTgDh8URtH1aVInfStBfBf9i+f9HpGlKZuYKNDHm8
	 KubadwcPF0UaD8Zi2b7w3XhUWy6tGYvyA1l+gf3vNUlrtJRA8S6fbG7XpOVC2x8C0T
	 Bd0pm2VRVBEo2QbCyj/Vle/QcQQSlYPCznsTTtvK8ZlL+tYmLDIJaD24Y9KQcMimtS
	 DstoAAYCAITI8Ks+X5mdX2X6XStiCxr2LZKDrJPZSQNO6OkRUIzdbXJav2W6HWKRT/
	 E50rFQaRvFJ6g==
Message-ID: <sashiko-outbox-178643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>, linux-serial@vger.kernel.org
In-Reply-To: <20261020084113.853878-1-lijun01@kylinos.cn>
References: <20261020084113.853878-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:53:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.
> This also drops the __maybe_unused annotations on the suspend/resume
> callbacks, since pm_sleep_ptr() inside the new macro already handles
> the case where CONFIG_PM_SLEEP is disabled.
> When CONFIG_PM=3Dy but CONFIG_PM_SLEEP=3Dn (a valid configuration that
> enables runtime PM but disables system suspend/hibernation), this
> keeps a completely empty dev_pm_ops structure -- all callbacks are
> NULL -- as dead code in the object file.Modify pm_ptr to pm_sleep_ptr.
>=20
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020084113.8538=
78-1-lijun01@kylinos.cn?part=3D1

