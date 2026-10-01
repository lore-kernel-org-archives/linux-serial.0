Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D43F4DCA;
	Thu,  1 Oct 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858707; cv=none; b=d/WGjI6YNbmUqZ4Sr/EgWt49B+cw3ZC1XSzr/TpQkyaHrmILEEGgbstnYvr0H4hj8x6L0EE9K7VjHspSyyqXmK/yJk26yu877xvmP3qzL8oiy4yD1bswTKsDm0FdLv4SKW421Gv2kGDzUIYVVLk+5qPewL7X5FjipUhf4Hera7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858707; c=relaxed/simple;
	bh=+clXDYPOMFwTy9tyXYrby56bDF8/YL1bEG1/W4xiC+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0bmMAOkmwIpxgtWiWImvWF43hdXxUcppEOU1ng6eXGxAZuA/KOvE8JcJphDhNwng3/pacZF15kUxEpXMBTAQmVAE5bJ4AUsvH8dItvsoWzpFdrtQQMNtbH0tnolodXhv4gbOY4IiwLh6Jo9yojmJaWWF1wodGJFlFnzT3ckFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myuSYjRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myuSYjRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249241F0089B;
	Thu,  1 Oct 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858705;
	bh=+clXDYPOMFwTy9tyXYrby56bDF8/YL1bEG1/W4xiC+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myuSYjREPcxwTHbMNUnWkJGm2lXNRSLzqu39NtFmnIYKWjmMfs2mh8seL5nqc5J0g
	 0UjFQ2BUbUlESeRo25BAMcp0zxrkyZLzbsH5VlCM5i4F+EKL6k+zHJ3O6J1CN37NJ/
	 qVB1eUE36zvw17ah8+QbOByUpGSUnQpdxHVumP4f6Si99zR+uQuBuH1c13gvQQ0x9w
	 ICCLYT4FPzYy/L+MFxF280AlVhSbZFoyuymwUZGbuHdM2ao5LO33N1LSi6svHMzvJv
	 UGmFm3mnR824r0xaFRhukOmjgXb7/N+Mj06ceykNm9M4tpCWWh+hi8lJiepr8Fp18N
	 RlBRM7L1W6yfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/15] gpio: pl061: use IRQ_TYPE_LEVEL_MASK and
 IRQ_TYPE_EDGE_BOTH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: mfd@lists.linux.dev, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261001-cv75-v5-v9-9-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-9-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:45:04 +0000
Message-Id: <20261001124505.249241F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Use the standard IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH helpers
> instead of open-coded edge and level comparisons.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D9

