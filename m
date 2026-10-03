Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268632B111
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063713; cv=none; b=r9rRbhGQ7PuHc/fahOEQA4pIyqeMCeCjkacZlyz9tg4/HwWU4CqvWC25JD/fZKToKvCWdOWm2/Ajc2EH/9N876SapJAyMxv8WqfRCWfujcViBBgPZsLVOfw223NhLh0Eo7LZrQ512uKGfq9r8JDFLr8eQ6KDr45LbBH+Zbrdfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063713; c=relaxed/simple;
	bh=YaCdttKSUfELO5ZCWEMPsYJxD24Dz1bQH7L1nnJqAj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iIhERHazTW7ZMkQFvQ/ej+Bs6yqXEpP+dk1etjwBiyT92ox6+z+APsM0YWnvdQPHzD1wOpKnDSa3lcdQMMCgRdv3BfKYSpZjlxWu2CpDQd6+Nwm0/MWzLuK+PIqvmzx0UaKLKIAuUcAd6eb2ghVbyKcEYdR3h9JIPS54v51BETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuD4Cl39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuD4Cl39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425BD1F0089B;
	Sat,  3 Oct 2026 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791063712;
	bh=YaCdttKSUfELO5ZCWEMPsYJxD24Dz1bQH7L1nnJqAj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RuD4Cl39JzD3KUuZ1/5o+wRUu+NilBS9DwstRmwSSyMoKTw8kGNl863fqUHNHNlbK
	 frkknkCC9xni9k1FjEAizqAWUYPmzYqZPfG8brLvGTmAckkRvmYjfpDMTlr8l+gFdp
	 JEi6GJxyn20DSbYULkGGSgGc5E9Dsg1Fntm46GgyAZlR0iyNp1PyTAs4DqO7/fLZq2
	 CzIB8HvsL+Lwqa/WVeumja+g+Wu59Yyg++GNiFcbIQaXJlxyTxSGdQ7znDlu20XWG3
	 Wv8tRt/HtPXTN1gc2z669NBTQPdD47hL4r/lTHNG9NZOBbd/i1buinFcAthe8svUTz
	 qSPIeWKMoiH1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] serial: hvc: use modern IRQ acquisition API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261003213148.137206-1-rosenp@gmail.com>
References: <20261003213148.137206-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:41:51 +0000
Message-Id: <20261003214152.425BD1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Use platform_get_irq_optional() to be able to handle potential
> -EPROBE_DEFER and other errors. Move it earlier to avoid having to call
> kfree() on the global array.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003213148.1372=
06-1-rosenp@gmail.com?part=3D1

