Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217A494A10;
	Thu,  1 Oct 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858810; cv=none; b=L4Fvnr53eSLk7kOL7aFREGTsF5spNpChHzNTOmkvwX2O3imc2lJMGl6tI6RpXKx7N3DG5xKGDoKntbJoCd1GzVsCTRaHthVDn+FRn2sZ6Mcg41E6cKrkN5/WHAObd+CeiwOXgF2lNln8LulFukdIb2rM1g/wWk9gYuA/kV+9Otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858810; c=relaxed/simple;
	bh=nKBV424zCyHpIkOzdOGJYur5jRPkF3dkxTcj//j5n40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gM5Gaj/7+35jRU2BX8h96RxTg6OXm8TWzbjbP9dJE5FzK1JYnP7BamzXtrtv39sqd7DCD/hmcm3vdDJ3KTo5F6rhZsSjh5BxljduJ05yilp8nMdSkPsQKZ4yaJLDbTT/hVr024MprSwyMEpUmNrPzt3Pju9DQ/dqEeFY7yb3A8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSj402iS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSj402iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E541F000FF;
	Thu,  1 Oct 2026 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858808;
	bh=nKBV424zCyHpIkOzdOGJYur5jRPkF3dkxTcj//j5n40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSj402iSURtXqmCVdey/F0g/GSAN8YJSR7YvGU96yJk8D6rRGtDeWZKbFrTJQgWDm
	 lWpChbjPZQE2weDek0K6etdidC3Q2F0FuSmvjMg9gJcc5d8e8ZyXX6QXtTqlYsjLvZ
	 oCHiCUedJlp6m1kvgwsnjcb8VT/0VSF85lXRBOOujd6ztUMJaiJ5bBgEhKS+CCIxJd
	 IKN+BsbmVl67m0HrrVtyOjAucRz4gEB/EKujIRP6AWH6CWYU1/haJ16K5zq7BD4fQs
	 wPDsOLJK8C4pchWV4hqFzCMxe4cyhRW6E8q/M2OF3xZ0wcahqS150HgwwK4WuLNC3P
	 b6QWT2j+DdeCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/15] gpio: pl061: use cleanup helpers for locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20261001-cv75-v5-v9-10-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-10-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:46:48 +0000
Message-Id: <20261001124648.74E541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Convert raw_spinlock critical sections to guard() from cleanup.h.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D10

