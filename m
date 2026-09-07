Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89343AEB4E
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762601; cv=none; b=YQy0gFsbjUPMfykX1pmGAvPKz7fO2gRPKgQigl6kKxFAZlNUEmzXumIbuyKde0POACfw7RBfX7o5JPu8NcA4TqQDdbiJzDrYtLtokHF88iewoKwuRAUGDz5lwHSc3xbnvLsgbCl9pynIEdq/NcApg9d3QtZjyvd8Ze6OEvmMHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762601; c=relaxed/simple;
	bh=bkf9+QuAscqzM+4WrEihLZaChGHzWLbOSX6ESCd84fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrIpmmRzOBHsLiHUf6cJgtmjeGHLdNxY1AAY3rLDOtr50IqYWHkovw48ddxfoqfBZMcsswZim7otK7Vv3QH2HJWnynTyDm1IwpMStSP6EQVOPvKDpm52H35/9YPLpyTqbSPo0xENUyJpzLp/vJvuYuTgADdN1+D+TyuzHsTHmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUI/OArL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUI/OArL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B741F00A3E;
	Mon,  7 Sep 2026 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788762597;
	bh=oY/2g8x7e0zZCkspb290tJZx+xFVkd0RVA3uPr/0ORo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUI/OArLyf98In0QYR5u7eJMfskrC6ieTz/K8T0gIFTpq8t82w5/o+h+ANB7+HkaL
	 VPavSZxEnzCCWfAG/d3dIYbkQznOKhzkyUVmoC3UpS9bO9XE3ZLlLytODk1ovV0aj9
	 PFWmOCnUyu0kJwNqBNuLDUDOMpU/Xwm25vLyQVKz9NEnflXQYhVvxe7qh8jgdjtB3k
	 12TWUAS5G8JUGF9bsfVzAY3lVnkjVXY6ev1lgsrgv2TnevIoEPvNs1r6I6I7WM45Ix
	 r2f7tMnpTdlUCkMi/BUdhiVFkDni8yn/ReHhElxT9neDuytaaT4sOTI3RhmjkRDMBg
	 gJm+z1riRTlgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: serial: fix typo "satify" in comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260907062840.17276-1-hemanth.selam@gmail.com>
References: <20260907062840.17276-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:29:57 +0000
Message-Id: <20260907062957.A3B741F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Correct "satify" to "satisfy", reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907062840.1727=
6-1-hemanth.selam@gmail.com?part=3D1

