Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16E376BC1;
	Fri,  4 Sep 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504585; cv=none; b=TxjGrO5DLwnHR8/YJup3Nxc2dy34QDOG/g5VRUGrae7Nph9Oomv0gi7KH8lOU4YZWv44L7ZZXGns2qNddsdUfw1wWlYUxTzLi6rfGYAmpyBP6WhuZnsvIi1H4BgCiWU1UuywjqQC8A29JsHU0IU3rf8ykwUI1c4hSxNPTxHk+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504585; c=relaxed/simple;
	bh=ZBpG+wfHYpn1XE10aS2uraxaO3T41Y3FXfoGbHpWA3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsHQmtv5GIBjPAyJAeyEYXsY3+g5FvtcaIFZj+3jsPDrMi5leLsk46Jy3r4vHvej+3IqFDNdTg3hDxEpmvwGpez9ktOmAA5y+fdXw0eAsswzvjifFwp3kA4CVcKW0GWpDAr2/9c6UYB+e5omY6eP1O/OxQ1cNJw8IaERRVTZRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foVEGee6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foVEGee6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37201F00A3D;
	Fri,  4 Sep 2026 06:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504583;
	bh=ZBpG+wfHYpn1XE10aS2uraxaO3T41Y3FXfoGbHpWA3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foVEGee6jSTLqpEzThiX8AVglRTvH8R/QiV2vmAuariSib1/bZOiGaGWy0InlFqyq
	 fuLEUMogMTd7zhaCjBrsJd8l+hYohZuDp/EGk9NBjlyuDMYbTjlIIVMQug9u1rro7E
	 ds1A3NMGrKVH/6X5HpmdGRJ7fRhQvFceFVUKa/lqTD3ccNWXpCiRn9ZQyHSfAXgNm+
	 hkatAzSgMWDUA8zH8nb6Al8DLZQH0366KcS1CqdGCBB4oxJpkiQhLUec/y+H1pQ6Or
	 KRFFqEeBd+cjKf8vRh9G2hEDEUzhcJ0oEn6zJDAmMCP8KpX+JjC6dgRIrJe6lPQ+Ys
	 A0ShedVTy+y6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/13] gpio: pl061: use gpio-regmap and add Ambarella
 layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260904-cv75-v5-v6-9-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-9-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:49:42 +0000
Message-Id: <20260904064942.F37201F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Convert PL061 data and direction handling to gpio-regmap while
> keeping the existing PL061 irqchip path. Add an Ambarella CV75
> register layout variant on the AMBA bus, without claiming unverified
> GPIO suspend/resume support for Ambarella.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D9

