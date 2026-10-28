Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193967;
	b=FWIG6hfElvhv1J9qV65tNi9x/LzeT9mshyo7+wcx5n7Ez/Ina+1Ppw1560/lh5/PTKhu
	 7Tz2wArT33nIUSStXQc0byNhwvotJ4V9/dnI5sMhftkfHT6B+LtgdfRZGUApuUpNyiQOo
	 Z1ORbTB9484qKFLdzWh5JxiM7NUwrqEEUtSXT5+M39MbcaE2fjkX+yJE7T0C14s/qbFC5
	 rDLtxFi38NHor0g0I56GXcGlOWuy2ty1qw9y5Mee47mGGwC0ydMIV1FtooU0Vbbxpw3eA
	 Cse0H0kiVzracGDtsx0RkvoN3Nf8yGPbHqlbGXGdZkfyJtJgC4zOxtzU5V8DREY6ISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xrum32E3qbWebDt+IgnN2hplWJ9Jesx8oLmN3LzLD1k=;
	b=SH8/xeVRN/CNA6izG0XkLOl2cW85P2OPCzWwzkDsw9FybdITHD1WnK+n3391R0aB9G7k
	 71wsb1WHCIADq6j0QXeEXA1oA89Gh6x8WHhp3qV3yFvHcdXB8dMl4lJc7sRoJ/8mv3AoS
	 aPpl57W9KDnqsLNoRJXNmgU+/ebSyJVqkDFAspsVOsHFOZEHyZkPSdUFWygOTZebpDGJl
	 D7kpiqEV+Eb+QFfZK7hHstU/RpqZwj8jM2FRO56p04onR7xkSruXvnV/3+2GwgjeL4k8v
	 PfpBxad4vchMr4rxI1EiZtdeRnN3+n6a4xeov90Q3lAb9Qp2avbNtM8L9St8MaYoaqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6wCNkjv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD544606A31A
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6wCNkjv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5911F01828;
	Wed, 28 Oct 2026 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193966;
	bh=Xrum32E3qbWebDt+IgnN2hplWJ9Jesx8oLmN3LzLD1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6wCNkjvL9NFI7YpYqjy8v75DQvR7NWdGM88QQueg3PMyZXS//0pE4Jq4BuEWLws1
	 mn1stfJAg74I+2wcBygbNguuQSZVWzqGl4ruzePkQvbHkTT+C1n2NCEY/zcXKB8OHU
	 oym6QfaobUqf6VWL/cGossiZYKVl1AnJznEF4lO3KuoWs9szvARwBk5hLSqVLR99/Q
	 gjyOB9xONpsUAtAKSlqxQC0XKNpfp5WI7LJjt0UomI+Lf0xdhjbIF5mF/Sx2P5S8GP
	 Yc40gzRfk20LK7P58gijw0pjkID4cltBXyLxCHwJ/kWyKQXr2fnpyAcx0mVIDRxLJK
	 QM15ZC+rSIyiw==
Message-ID: <sashiko-outbox-187910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] tty: n_hdlc: fix read() hangup race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261028132049.728457-3-johan@kernel.org>
References: <20261028132049.728457-1-johan@kernel.org>
 <20261028132049.728457-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:26:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Make sure to set the task state before checking the break conditions in
> the read() wait loop to avoid missing a racing wakeup.
>=20
> Note that before commit c96cf923a98d ("tty: Don't block on IO when ldisc
> change is pending") a racing task hanging up the tty could get stuck in
> uninterruptible sleep when there are blocked readers, but since then
> read() incorrectly returns -EAGAIN instead.
>=20
> The false-positive stuck hangup issue was flagged by an LLM.
>=20
> Fixes: 1035b63d3c6f ("n_hdlc: fix read and write locking")
> Cc: stable@vger.kernel.org	# 2.6.38
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028132049.7284=
57-1-johan@kernel.org?part=3D2

