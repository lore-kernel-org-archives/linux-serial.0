Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD347A87A
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252935; cv=none; b=cIIA3si1YC8rF/NqEIlB8oMiX3WSZ5K7hqh5bxNtEgUOHh8yVvrVd+5LzBua3HSGLWXNi+4aFvk3X+qie484TzrSrh6VSzVxSwEKqrGmdKtZGNSX8vot2/yXZhPk6Co2Kj/xdEmFi/AwbtXHoHODts8bT0TxFrezgoXhQHdfDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252935; c=relaxed/simple;
	bh=n2YHUDMXYIk+zdgt3cFfnGs6bsrC4borMlp4pOTh5PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ba71U9gsBcCDszFRUzsCxdmylnmGAnwNug4JSQ1FmiN6pqZUcgSm6u38f85awxxsEDBHqTxa5FbefmqH48eu8PUFe+R2xDTUkfjZDAum9GswrfLRS8XJn0bnHAo5QKF9/ImPXbvLlhE4oqGZ6tsR2rIQXeVLx1onHkFpdNPCP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO2UqQn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO2UqQn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CA41F000FF;
	Thu, 24 Sep 2026 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790252934;
	bh=n2YHUDMXYIk+zdgt3cFfnGs6bsrC4borMlp4pOTh5PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YO2UqQn3fwo05URlh6l2rqoxC+InPw9CBJ94VCvGlbQfRSn2lPw7um7ZbvZkMWFXr
	 L2Z1N9h5eePHusePsEKr5TPouXcb0RsSHWRTaDjRE2Uw8LUP4MyYvpcRXPZcASOuum
	 NFKi85b6EgePvvpNGJDqIR8RRbMyZ/l2Ie0JinBPfR5uLeF5Lx4I1otuegmCY+12kb
	 YC6NMU5k2K6BFI5Pf2SBLXTY+xQc/YgfSysBJp+qjn82n8YH/8iItQZkUiuo+x0vbW
	 4hr3HLlclCI0wLagZdy5Uc3b8uOYNQccHGVFn+cjUPRC/NkBWf6Hx24ig7x13hLQ+W
	 mqj1iQV/N6Gog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: 8250_port: Remove redundant
 pm_runtime_mark_last_busy() call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924122549.668680-2-andriy.shevchenko@linux.intel.com>
References: <20260924122549.668680-1-andriy.shevchenko@linux.intel.com>
 <20260924122549.668680-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:28:53 +0000
Message-Id: <20260924122854.18CA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The pm_runtime_mark_last_busy() call is redundant in the wrapper function
> as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
> internally to update the last access time of the device before queuing
> autosuspend.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924122549.6686=
80-1-andriy.shevchenko@linux.intel.com?part=3D1

