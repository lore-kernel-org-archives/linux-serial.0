Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A690396D38
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338387; cv=none; b=N1hgno/RRG4S+gtHvaQdXnaly70Io5Mr+MGxOg1xVL7/uBGy0bjp+lpV4l5AkLjCO6lG+48jsbCfpLuon9mew124hvo7qceJ7hrqB2lrx/taK50Widy9HOF5Gk2YJN1IGgRe5ARVhV3GQw1RCzAWxGRZvjDjqGh2R9g7h64s15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338387; c=relaxed/simple;
	bh=nIHDNfe5Bubzs89KZZYj9YjtVjVIQmYd+/VPe3d0u7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GeT7YNAMMZ1SrwbtBu8BTKVMiW/K5vTXH8qE/z2WeHnNJsLXDnlrG4xMs/Pm4HjnktqIOPoFRddRirz+iKEua9C+Jz/5w1ytKSxuyaK/ZHRu+jZSAXOc0vCnBa4fxLEPtGkx4Q7JZoBsQHfkpRxy4b8naTNx0MTPdYpnUO4iwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFc5ndy2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFc5ndy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9351F000FF;
	Sun, 13 Sep 2026 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338383;
	bh=Y3ZjAI2h+tTGRs9SLpjvT6NmFFK7n4qtqNYxXcgGPGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFc5ndy2EsWyAjhdkpYLtw3tSTFZVRHrYQMkEGmDu0zlV1KLmdwoOJDbiHdHdvzMD
	 UHQhM9gCyca9NJCFEMx1iNcA4n67WuYppAcp4crQ7ayJb7+wlFXXU+F5HLqQWS7q2R
	 VQxLikzp6B7UtHOhT5vj2bOz7fTF7lT/JcgH+q0dBF4aRajPqHEoMHODdiXLj78gCc
	 0iTRuWpc5uHzgAI4eZBTQyEEThj6kHGE51Pzhtny5tbPiw8S3axzKRIDPGV5zNDA46
	 z+RErheGkiEnTHedUP0wMs/8cxuJ8Tq2j3QP1dxg7GnUUFvmaYv6vRLVfxxSZtjjEj
	 06JTPPizPwAqg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] selftests/landlock: cover TIOCSIG signal
 scoping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260913221958.839429-3-clusk@northecho.dev>
References: <20260913221958.839429-1-clusk@northecho.dev>
 <20260913221958.839429-3-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:26:22 +0000
Message-Id: <20260913222623.3E9351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a focused regression test for a sandboxed PTY master holder using
> TIOCSIG to signal an out-of-domain slave foreground process group.
>=20
> The test observes both the ioctl result and the target's signal-handler
> effect.  It fails on the unpatched base because TIOCSIG succeeds and
> SIGTSTP is delivered.  It passes with the preceding RFC prototype because
> the ioctl fails with EPERM and the target observes no signal.
>=20
> The identical test binary and initramfs were booted against both kernels
> under QEMU.  TAP reported one failing test on the affected image and one
> passing test on the patched image.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913221958.8394=
29-1-clusk@northecho.dev?part=3D2

