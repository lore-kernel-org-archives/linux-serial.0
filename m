Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194038;
	b=DME6b8MvlFUGt41tNOrWAe2FXyrtcZFqEUx6kfA736Z41En2O4S+8d1m/cFQWB9C00ms
	 NusrdsUSTSzuCcCzhNQwMOrvKozAxf+94lySyX5KmSdRaefw81rwiSa0Njb8AY+BW/K/e
	 nEbLWHeSA+GiVOABIrT/YUCf9N2cdiBjO75wfUoKGVKTJURM+L60E7aeFSq5yswVUIEWK
	 C+fRLPJXEmNuJH6/MVXoeDJQZ9fgA9VnITXUGB+jb5yZeHuh0rvnCVLzz5j2TmmGxkINS
	 ghI4mZOsbuqMvMnSCmnD8iz5VLmDi3PkbAleAQIejyfI/K70v3X4HoTEJwrujT+m9AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L7kI4BPQ/JPOa/ra6FBKjS3d6YQCKkIZ/4xFgmEoaSc=;
	b=BdShh+LSFEadJTFFbZ8p8ACtCjqf1H9PLX3ufOfU5b0PsI41dMMerJaMZ1pjlDknKWlc
	 SP4bV0fyFgaid6kq46UyayFlz88kUC/R2cv0kijKa+Nr00WnQoY61KKnfPqc3M7PK6Jgp
	 OfBFv12v6B42Q0hDkqueZKzmP0ynVZRjyZAGVkGshgpAkphn/vG2muUpMUo72eZcFhzx+
	 Bxn3AD3jmZ41AKst43JmDmHgB/RNyAbAvI+0kObopExDC9948u++i9q6OzaLuJYjf1GW6
	 TFHBNFRCYvJognzLzg5/v5/hLt5+TCn1ZtfyGOS52XttfWBwjY2AulD7cLdE6O7RtzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n7iBIx/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E42606A323
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7iBIx/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8021F1F01459;
	Wed, 28 Oct 2026 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194037;
	bh=L7kI4BPQ/JPOa/ra6FBKjS3d6YQCKkIZ/4xFgmEoaSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7iBIx/+REtfPZJa+6hJNVicd/Tz6kDkpXCCirMHTRuu1gKs/4sdMYBOJK/myTKko
	 kD6wvqQ6k+uz7Pb+KsfS02voAGiBisNravPHdbS4RY8uX/UIVvIaijxOsbJybRG/E4
	 DjkP9debHpIDlJPtM3v+07uPQoLBHlroy2wW2blK/J26tI/pnhxWRWhUSw8rXgXWL4
	 qx78e52jI6Ozmzcs5rwkcBTPULBQfczb3wYUp3qE+lTRlYVU8vIlgR7vJaF14vr87C
	 1TruByNC/S3wtOFY0F2aS9RLZB0UHw2c8Gkf1XcOVN5AZEcCWnSApa1HAiGvhoMmWj
	 oe6oSK93BQdsw==
Message-ID: <sashiko-outbox-187913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] tty: n_hdlc: fix missing write() hangup check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261028132049.728457-2-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
 <20261028132049.728457-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:27:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the missing hangup check to the n_hdlc write() wait loop so that
> hangups are detected and -EIO is returned as expected.
>=20
> Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
> change is pending") a task hanging up the tty would get stuck in
> uninterruptible sleep when there are blocked writers, but since then
> write() incorrectly returns -EAGAIN instead.
>=20
> The false-positive stuck hangup issue was flagged by an LLM.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028132049.7284=
57-1-johan@kernel.org?part=3D1

