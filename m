Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD80234964;
	Tue, 29 Sep 2026 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664125; cv=none; b=MkHJGgpnBTTtVdQGPPd8rDvuS1BuYjpfCC+Cci+2VhMeL7R/5OjPXz6zg+FvLpbY3BbSbOGaF4m53btnDlLQ4tJpG9lJYCmPW4h4H/ggKSAa/rQ2e6z6s+6oztqOsmjpF/4oleim2tIORCQhxDC9GkVRNVnYWGPKZmaVZw0CO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664125; c=relaxed/simple;
	bh=2N7jDM+9hFYnb48ukyAiHHWnpDNVGGJi1n6b/5syDm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFKiyLQdWFDdhhh5SeErNcFu3pBshEVk6HXDByzJNg3FXHQZYPSksLGtO/sep5bK+wIvLO+0EoUF+mI6xNbYCrhSDCipU+0fRMRmWzu97MgTtGRomBg85B1r8ezu+NJVxYInyxb4HF83DEvTO+DOS71DcDBpjvATvgxnhx6KTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6UJ7g4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6UJ7g4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A2F1F000FF;
	Tue, 29 Sep 2026 06:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664124;
	bh=2N7jDM+9hFYnb48ukyAiHHWnpDNVGGJi1n6b/5syDm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6UJ7g4OgPgCm0SpXm1g34MxjN7OH8/r+0kD2ipg9qc2zyWqMXJu4+3mthplwY6Mo
	 KYmDZNK3wGCA8KtXqtIpvEM62SYHa4OvzPIIcYlIbCoVLFGePizKfYuBET7sFvdGeP
	 GY2JnxG5lvSyrKAG7LLoMHBnB37S/mOowCUdr7UXToiH0ey5fOop+QBullSE+4aWUc
	 fNJD8l5O4Gw12ndv3in5qBWsDP5yXzOjxhBmKGGOO9gD7uFCIYvgphsQ4XAQfOZxwJ
	 xo6KktMyMXQnyqUojrCcRad5iC+FWvs+LZUc/Bxtwblg6KtJWJAEXP3WeCWuKod74C
	 wqc2+fLIR9pWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/20] dt-bindings: reset: add Synaptics SL261X SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org
In-Reply-To: <20260929061417.20733-9-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-9-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:42:03 +0000
Message-Id: <20260929064203.B8A2F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add device tree bindings for the resets on Synaptics SL261X SoCs.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D8

