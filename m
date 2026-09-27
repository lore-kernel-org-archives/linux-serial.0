Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234313BF660
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542430; cv=none; b=WXDQ/Xg5mRFnGLWqno0XHbcercsDjnIVT3SbrHDsgRNNmv/cuUbzI5JRorZp85QyAn4XtLuuratfrSgzbTwyIYUjT3ERQ7rPmeovZ3127EevkWQ5E2Ev+76Zxkdz+Q39RzCaUtdUvy8nLgvXUsRBpzwvccbhgSOu2bTp/Z6KKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542430; c=relaxed/simple;
	bh=Lxfl8Y6OFhwt6bKheB7sJfm+Yuic3uUZx7nyniT451E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hyVzNx0Kg1U4KuHHaC1QD8akcR4pG9POwgxIz+CBdfaXSJyzIqbWo5A2CFNxSG4x+9z9csfRqjagJkhfU0AToKsIo/uL35tZNMe13eZ4OvhbxCYLyqqVLo+0CQSzYez8V8S9Q7/CT4ezGfedz5dBROP4i6tLGGCXQ7R8/KLnmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwayBb6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwayBb6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911F71F000FF;
	Sun, 27 Sep 2026 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542428;
	bh=Lxfl8Y6OFhwt6bKheB7sJfm+Yuic3uUZx7nyniT451E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DwayBb6PvF6rrZ5wqB1YpFshXn4LxPirq34HwnY88x0YBRSQCNyw2cp5ZszO3p134
	 yzKZ99ytfVNC1doU+bYXiYTWIFx3U/p4Dn/rgC/EwRYlUtmuk9mBVq5J/8Cf3bXupN
	 bVQFDQdYsn9jEMxTikADmCd/Yme5GfRxaewi/r0zt1X1fP6ZMfOFZQ0s94t0uBZXO+
	 ruWtpRtMTjUMRKQM0NRXrQC97HXX71SoZcaTz/oKx98xDKrZKorsLpuP7DyruTEvh7
	 3QeEVnSKNf7Be4YUJ30b7fCIj6cmesJr/ZLYDVKvSYkkP4cJoOUuP6bSw6pPq0g4RW
	 W7A2AAtgp7oUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: hvc: use modern IRQ acquisition API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260927204658.24338-1-rosenp@gmail.com>
References: <20260927204658.24338-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 20:53:48 +0000
Message-Id: <20260927205348.911F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Use platform_get_irq_optional() to be able to handle potential
> -EPROBE_DEFER and other errors. Move it earlier to avoid having to call
> kfree() on the global array.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927204658.2433=
8-1-rosenp@gmail.com?part=3D1

