Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251747F3CA
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863281; cv=none; b=P960P0VqECQJPN7rUXddB2l20QvGBRlN80Bz82Z47UUTVatIrfbX6DysVFVhCcd46KA39wWEyq7fj+u3iMePSSXJPWdv2QWDKAX98VY+0xQtIgn3jF4NMUxIihYfpC3P1NUJUKGR4UbXC1+kU6QeDUv5HY9tdb1IglfKr6a1ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863281; c=relaxed/simple;
	bh=zA6go1eTC3WNoV8dwFX675u6+mAGf4w5ftzNgCh60rk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aaHHmUsZMfK8QOdGYGST1ApM2gWwKJfqg/smpEqt4sr1ND8BdgMcpz50dWJ0qJp7f/AIlLMyzC2LWY1NLwggg0U+ec16rdbuVHclm7/kWjCikKDvRPz6G8Q1igMNFSru30nC9VdHs/HB0OAQ0nrlmgf/7yDeNdN4H/M0EeVkLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coXey/xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coXey/xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE9F1F000FF;
	Tue, 13 Oct 2026 03:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863280;
	bh=zA6go1eTC3WNoV8dwFX675u6+mAGf4w5ftzNgCh60rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=coXey/xeebBZBz8vXWP8VgjvB/ooQLzg2oqoF/FzU1v+JfVMvLnPZAPL0nW07ihzI
	 Ulu9sQZTQOYLSJpX/p8iPUR+yXpK2sSYuQrMLzpKXL5e4ZxO5ADHjNnbpdOwAKkuLL
	 35DEdph9qgdBVMuhLzDjgWfv0N0Ky0CXFMbmgpWetH+isXl1RwG4qaHQFOl3bLTgRl
	 NKK7RhHGiUMpyXpqm3klcezxWHChNdo+aJcvxjUVr8psUYlgHUy3NMNVx0ngBEbNUn
	 uGsoRXWcyXyRgc6m6hieS5Wjdn5yJl6C5ph/zXZSzZzrl71QCNKGO02jt8mR0DXehN
	 fFXtN3NTYxL2g==
Message-ID: <sashiko-outbox-168918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-2-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-2-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:47:59 +0000
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
v5-0-4e72aa383d39@gmail.com?part=3D2

