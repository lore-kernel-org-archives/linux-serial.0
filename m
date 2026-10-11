Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41C35676B
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749140; cv=none; b=QVU1q/HRCT4974BdYuj3VySIpBTRS6RbVJNTdCYoxy2DUgEaxUDKZDzAoIlYu5es8SCpWArHK438aC9bCvPhcabu1rNcPeSYncDrjX2WZCt3X+yjjiJSw4l4t/fZzUaWUAQI4lD81wkU4vgiXxkkOm3tUJEtj87U3rO9jo3AonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749140; c=relaxed/simple;
	bh=OKzVgGcuwFRIir2vOtXDW3erswa+lb+o4KPMsNbIBQs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YniW1eRKh0WCzpGx9p/mCDxRRva0a47HE3LbdDNhot1jDUpvxNJ8WKU2/GTybAt26VSCUWTnc2057xrU5wkYcaZY/FoC7OegypqlYwpHu560pkg2adFr0btnAmMFsjnCwLuKzjSWnXa+tk4D0kj3vHHoBfYE5vLE1nsZNl/DTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDT3lw1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDT3lw1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59821F0089B;
	Sun, 11 Oct 2026 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791749139;
	bh=OKzVgGcuwFRIir2vOtXDW3erswa+lb+o4KPMsNbIBQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KDT3lw1Uwmkn96n6i+EhsvB1iFI+Qf0AGvu5+ADikcRY2HhLNgk6+MZ8/hXsAB9MT
	 bzmcbCJOtEsi9gpeSBy1iZ4hEi/P0o3WCv17o98BcX+xqpp/JXW3/G8ZqbIDMhkmol
	 RnKZQYsqlK0NB+/bQ70ROUBrz2ctE6HMqy8tdSwGBIDCAf0+M8DLystS56Oi+iEAsY
	 y3r+leRR9qFwLJZp5L7y0/ylCqg7ZAmcZrg1+f8LVR8hFFsFkXDtVFd577SlUkuM2t
	 HrUjs0WS15qjjrQb3DcqGLV99HkPyDifrKJLuY5zt8R36+1PvNIgX8B3uBXu/Kx9Z1
	 TLGBMODcVt2MQ==
Message-ID: <sashiko-outbox-167442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] sparc64: honor queued spinlock layout in
 secondary startup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011195729.981243-3-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
 <20261011195729.981243-3-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:05:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
> not its locked byte, because SPARC64 uses big-endian queued spinlocks.
> Acquire the word with CASA, release byte three and poll while contended.
> Retain the predicted-branch barriers for Spitfire erratum 51.
>=20
> See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.
>=20
> Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPAR=
C")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011195729.9812=
43-1-linmag7@gmail.com?part=3D2

