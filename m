Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574801;
	b=uy+BYaU5czo17gyHR8p0juRdQhSke47Vfq+jViEXggRiKIeRUahSWT0GIG5siOCvAxTL
	 QbDfXfdcamRDLMdL682dDX79w2nUpT8FtRLAY3I4l4vtqblbgWCkkE/gCgpkWn5cv8q48
	 aoYO3Yy9fM6tqkPG+q3yWBa0l/7fHLyV55DwxayLSM8rzXw7IFLOYdhp663qecSw5qRxE
	 g0Ci2w0gebSfQRpFmJ+y8KDx9+/djJH9VM65BcnTPcPEjXlO1P3HP50+u+nOMZALvlJTc
	 nsyeiSumH4420G1hTRjbKDsmZCZ59rz3vAqlebTBrCRcjWbUvyDaV+EZ/iaBVCDAtVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CpSM3PFA47N0185QiTjHuEaa1gLRY54X3z7flouQSto=;
	b=l+7rR64Ks5Njd1+3xF5BzAU5lOkM0WPmukrj0HkSGg+rPCB2ap8co3CCk8X+FpPCK/a0
	 zxL0V366mx8e/PkUdOUtXGbwyGiDtqy9RuInJEUBwgdiucnpyiLsVKJDauskDxUKzg0MP
	 2s7De8lIfSeybOHgUq01ShnLUGHEDHvqAiFI0VwVzROf9sJ/tbgsML5GfZJk3GK2YqBbW
	 gzbuclPybZwbwL/4QJiVqvzB90RXc6vd8p/Eci8IsKk5VCKDI6wbmhfqaN9QekMTsWj5F
	 m7eXTukZrY1NRD7BHFo1qmS3wdYyStq9Yrm0M/I3gQf6vAbJCQ55utpi4n5YiY46E+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhzHx82k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76EC606A31B
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhzHx82k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA71F000C9;
	Wed, 21 Oct 2026 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792574800;
	bh=CpSM3PFA47N0185QiTjHuEaa1gLRY54X3z7flouQSto=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nhzHx82kscb5eUVXChTEhGu+DlG6EgzB+Bd6XsCx0NqXbh9ocqhqh+OW4l/tJGWWD
	 TdTQ9U5wGHvyOUKOIQbiu8i9cr9mX1mMWjZpZkM8wkImYbp7jxwkBBt/HIfRvZJ0O7
	 MrDj+zUla2GnjKSV+CP20IiLz4lgwgaTc8mPzwyXQdOsZZlfWzCuYDmhA9mHW71bRE
	 ajQOPkvbReIV2o5FR+kvGByXi0vqaLUIYLHbaVmP/SxnZPhX0KF0VSZE/+8IJkKG3M
	 Uun/J9b6qVk44jxyvplyoioHwbHx6IiAm7Pjy9/Lk7qY7sh+Y0kuQG6TL2aegYzCYd
	 FAF5wyh23pqNw==
Message-ID: <sashiko-outbox-180026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] platform/x86:
 lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>, linux-serial@vger.kernel.org
In-Reply-To: <20261021092124.2306053-3-an.wu@canonical.com>
References: <20261021092124.2306053-1-an.wu@canonical.com>
 <20261021092124.2306053-3-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:26:39 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The software-node-backed serdev client cannot match through ACPI or
> device tree and is force-attached.
>=20
> Set its name before adding it so the serdev core matches it normally.
> Deferred probing is then handled by the driver core.
>=20
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021092124.2306=
053-1-an.wu@canonical.com?part=3D3

