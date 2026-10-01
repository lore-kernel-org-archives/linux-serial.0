Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09692377EB2;
	Thu,  1 Oct 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858856; cv=none; b=NkEaPLsd+V+YZBNo+kSU9pADz/g49vocBM62VuG/2NLJzkVF9FH88KMFU/oYd1H6bCyp5pPPO6PkIQh3/6iSgVP05qvMMtNMRzmU+hvNbSuRhlMg357NykgNSabrkJ3e0m1JPJXDQOTcP1Rvn7BYcvWetXU4VWTkBnAkRvkpcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858856; c=relaxed/simple;
	bh=v+hjNEtRij/mLZbdhsPM5hhgWFIR9luae2jxOGnLNGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qd4kcg2DB4wmQW1gKH44foNOWhpDdrX64FLA5d8xM9EZGuqj3kGyVJRvX03FN1EBnrgd6Yx9tZ0UYYRsz83yjyHa5F9cwRogYfln5VVj6oa6UQjHQXEzidpD9lX46RTdxJ4vfwdXWQGXB7Ga4dhfz2TlK+V1qcjCXK5aaJExU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwYZ03Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwYZ03Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512231F00898;
	Thu,  1 Oct 2026 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858854;
	bh=v+hjNEtRij/mLZbdhsPM5hhgWFIR9luae2jxOGnLNGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwYZ03NbbUvJsne/eEA32+jYegeFFa/uXKp5kAzdkcEZw78/dCFyaddo7TggWaDiH
	 g0Ib7LQSjJPRr4N2wlRuIaZ1xJHWZL27WEBsuOwxbYagEFTahHGQ5bs6hYBuYRTgwn
	 ItyW5etYMJ7wqzHXPrtYQ8eCMuH1HgGgCxic98D0egiN3yfL7sMC3iNt3u6tijWgU7
	 x+bsV8SrZ42IlGfoxqx8ECZmkFL1B65wCBw7DKSdpqm5ZbNqhybs1AhswcZTvvNYwz
	 uc9Xpb1MWem2Km64s28hoc5irTo1+dnRc96q1LzYKvwBHSd6mFZs7atHF3kxrNu4v6
	 hec6Se5jfOQlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/15] gpio: pl061: convert register access to regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: linux-serial@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-8-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-8-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:47:33 +0000
Message-Id: <20261001124734.512231F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Replace readb()/writeb() with a MMIO regmap while keeping the existing
> gpio_chip and girq irqchip. Use a raw spinlock so irq_ack() can run
> under the irq descriptor lock.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D8

