Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AEF4F405F
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893651; cv=none; b=NhcKRkvXermNrL5bxmwwF0uIkxIG04MedMoGfjFfmV0GFpTX+QCbI4syLUJKgXFhLRtJ8BqvYPvy9ZjK/CanBoZgDA+jp23D4mn8wFpDhwYg63OxqrG3cAIA3gJhCKv1VA8nQtQZa4gQejGkLj9pQXq3M3C2p6Po7wJ0uojnPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893651; c=relaxed/simple;
	bh=FT8fQf6FKjUUtKKqO/zRcLE/YysBiD9XauOLPT5weI8=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=OuksVEewmLpmgVZTmaCpzRs+Pguyf+LbNk4a1FOikTVxYBSCVlHoNsUyxB/UnLOloBOh0s1XlWkfRyWJzm3v0Bqhj6NBC3ZJJNdBzj8Htzrx2QdSxZXX02XZPAMdQTHhe9jB6PdljIw6s0qgVKwUmCCMUDSaAWaJAvU4C94DHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StT82SUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StT82SUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9037E1F000FF;
	Tue, 13 Oct 2026 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791893650;
	bh=FT8fQf6FKjUUtKKqO/zRcLE/YysBiD9XauOLPT5weI8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=StT82SUF91mPFb3kR2UnaNlZ+5G22je9PdGKmb+h8dm5WOHfO3kDUWhu69/KgwMFd
	 glQPZce6ouJoqrJ5ajvyoDAK7RVdNXa4ntIlyaALgwmk3BUooTjEFOwjK2ryv7b568
	 KSb7qWXxsPEor6rn+42yNKbapVCOu95NND5ko/Pln1IgVBwooVdi4KZOx6fckZ2/18
	 8/0ClYy1vTcw9adcuOYoyV3cY46w2YVW4pa8/zZb2vFQ+rP32icYnt6eRkUOGawSWS
	 gjJQIrqXzufh4bgCHxCUHj4oO3hfNcBXX0M9Xe4KPIDDnS1lGiPLGER4aUYP14cSHo
	 q/0hTlsfwmnMQ==
Message-ID: <sashiko-outbox-169683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] serial: mcf: update author email address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-serial@vger.kernel.org
In-Reply-To: <20261013120831.1046590-2-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-2-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:14:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The copyright and author email address of gerg@uclinux.org is no longer
> valid. Change to a current valid email address, gerg@linux-m68k.org.
>=20
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120831.1046=
590-1-gerg@linux-m68k.org?part=3D1

