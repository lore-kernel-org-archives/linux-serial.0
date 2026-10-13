Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07B4A2A76
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871887; cv=none; b=mweG4Xc3Vz0xB0HK+c9hydgCZmSaVNNWn8gxx31y7JJ/wEOfAvCjDpP5EIgBwxbyGGtKpRdf3/pSr2C1qWGutCQpQubseHMe9FFavLirv0puaYobmlgmOYzPhVbUWd9V55n9egDo/zAw+YEFq7xAVdhFJgz+cbr60bIjVVyP4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871887; c=relaxed/simple;
	bh=sTKLmtusrkpQ81VtCKiLStMKqoBEbX0zEiIRwEhQTpc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kGtmfsufimbtSFlx9/gphb32uX7LLhpxvA1SJxoPSHoxI5PY6QFKmLjNSZtENOI7+wclP1YGW1ns265EPA76RIorwyNb3r9LmzRUvyCfv4HKHE93OqdwAPpkHWqnJFBykCVZz6Gtm3m9dOzxZ8kthNvo3ITL3kq3UeO18KPyloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxXV/6H5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxXV/6H5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0AD1F000FF;
	Tue, 13 Oct 2026 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871884;
	bh=sTKLmtusrkpQ81VtCKiLStMKqoBEbX0zEiIRwEhQTpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PxXV/6H5Bc5hweDaRZ0oSd6wJ3/mrgBFvapCM9L+DEwc3Kfr75q3fZQMPuZm0AG1t
	 dSrjiwwtXessZeBtWEWfZZ0e6B5o2I/Pgrut9OmiP3ZuuYm3cQWa1ucnhXPDanlosn
	 gHGcEvSIVPhctf8Qicj/tCJDNAM+p+tR6vy/7r60fDjSyYpHIUHF78mAPBG24WByEu
	 xSomy4KoKunxHI9K13s/ENtFN9qNWA60lNnZYxMIAYsXrzdIQVKfDDG5pFr5MP7son
	 Ck8P/rycH5x44YDA/jBAJDQMUpQ9XXcIj7NL4nb2XCQmxkRrvIFNdXQPIA4Cea1d8w
	 j4GAa4hlfJiPQ==
Message-ID: <sashiko-outbox-169042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-2-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-2-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:11:23 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D2

