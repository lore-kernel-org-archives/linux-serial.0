Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F02D7398
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506283; cv=none; b=M11Xr/Qdywp0nEyClL9DXBtUIn/gDGcnUpqkxV61CzWC++Ro/NfkMpQmSwH6gfTvgz1Qc8pR98gt+27rrSLgRsW50vwm6qr1/JpcqF9hrgqjbDxGOZsi/hxEk+eEOmKRmCvexUIlce1Iyg1wN9VhQK3dLC00maUoV3B/64EekTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506283; c=relaxed/simple;
	bh=xEHKitfRtsGOzKM4WNOvMYRB80RXT7RgzKVfqWpDa0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMdOrV+Wd/PYk16TC95qQgGWU457jeRkw+Br9S85O/2AHdiTq37jubYWLw2BxrKV75tUXsmvDCV3L7duNyUQ8oGNnEHTp1VuvoTPXSPhaH9GzjmeBov65FMt1fN4qtOyjWC1yF81hCGBtzstP3BvP6ZUNzQBy747M00H8VrfK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8IpKUi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8IpKUi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E21F000FF;
	Sun, 27 Sep 2026 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506282;
	bh=xEHKitfRtsGOzKM4WNOvMYRB80RXT7RgzKVfqWpDa0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8IpKUi3lz393u0PGUR1aUZnIsgFdOUwEbPFAje/bI1uskRMpUuYm2VgphVta1syO
	 Iybj/mLg+sx9nJwUrCWiCPdlk0E9Q91zO9PJeCvH0h/a9tE9PYGcFeygJnsSWcklH0
	 bLXW8qHirbzOsW+5u5v14FuSWeUdGvpDNbrrycflIevstfJyF347p8/LvQElLHOxiH
	 3ZW54G0vXAszAqsNtvVS3+AhXCJNGOwoM/pBiry5zVaX//UbFM0vPQ7Bm1g+3I3MSi
	 wjxWCqKJo5ZqtHewit1V+cf/HRAvGoPYduhwP1cKQu8pA8hcQS0c4b20RDTpugxORx
	 Vamkq5yoVKLng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] rust: block: gen_disk: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-serial@vger.kernel.org
In-Reply-To: <20260927104528.103881-3-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <20260927104528.103881-3-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:51:21 +0000
Message-Id: <20260927105121.BD8E21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard instances in the Rust block layer generic disk
> implementation with DropGuard.
>=20
> DropGuard provides the same scope-exit cleanup behavior while using the
> new Rust kernel memory API.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927104528.1038=
81-1-mohamed.osama189110@gmail.com?part=3D2

