Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BC35E1CC
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118240; cv=none; b=delitOkhAMo4BJVJ8IoLr9VF1u7EAJrMZR8D9gSfSElfk0826ef3/KgmLu2Z1TTHP3KzfEPLVn9K4os12hIrJXx56GkEx3amNYEb+lcwH418+GlXEOjZGawf9Wzd7JcStveQdyY54QMb9fmLuzX8jCG1JwxdKJKgZm91aLTVQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118240; c=relaxed/simple;
	bh=47/4qdSnvdfe8w+++/bMLsfcA72JwI2VgKODyPLVW2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bROoUWa4TVXDTcElXebQl2EhsgFIcAEMK6rDkyEY29KqtKT37sYJYFCtcXTLwMxm5RlXMEscFg6Ct3UF9TQErciVUeiiWh3WVOh49ONfpmExIYHpuW6xrBunC65SCqOayxET+wdA8SyZUub89lOfrIQ4yUir62aZABUDCPt4GqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxsIpx0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxsIpx0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119821F000FF;
	Fri, 11 Sep 2026 09:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789118239;
	bh=37H6eOy0P/Sbh+IBIQcJIbIMpSJrV63IZCN2Sj4PDQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxsIpx0YiezofE8+Yx4xKjuJ0s4Q2idhBX3AfF2Fstf6HhEqrrOIbhuLXlxRrOywA
	 1cTwaOvI0anBp7zALKzyet5SDrwnuYE3OqH2ZWej3xis7RJ82qdgAx0RyHzRCTopfi
	 Zo7tlbn1Ju7/uMjAJ2ZG1XRuOhs6XsxZd/Af8HWuRXdMpFcg5bD24dC5gWRWQobTMk
	 hj4HXTAAn78/BvtK4Kb3wh2OjmfKdL64pMifMzH2P2T79+QTJ8y2UmeOYKMfHsjQcj
	 0Gm4/qEBbSW5WzHDDhWREHMiaJhKlss903sDCJt+hatN8s7ThjemSeL+BWVk9Ok0xj
	 auaPaFs6pi4TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: amiserial: fix broken TIOCMIWAIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johan Hovold" <johan@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260911090132.723531-1-johan@kernel.org>
References: <20260911090132.723531-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:17:18 +0000
Message-Id: <20260911091719.119821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> A change replacing interruptible_sleep_on() inadvertently broke the
> TIOCMIWAIT implementation which now immediately returns -EIO (unless
> there is a racing modem status update).
>=20
> Replace the old hangup (and signal) detection with a check for the
> TTY_IO_ERROR flag which is set on hangup.
>=20
> Fixes: 591cee0a3563 ("tty/amiserial: avoid interruptible_sleep_on")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/20260910132029.D80801F00898@smtp.kernel.org
> Cc: stable@vger.kernel.org	# 3.14
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911090132.7235=
31-1-johan@kernel.org?part=3D1

