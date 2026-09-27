Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B8353A7E
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542212; cv=none; b=TsnY6xBjkoC6MxnjNTl3ds8v2v9Lfk0wW8GvjffTVwO98cchjSP9EgjnZAgtulXWSqoECdEofoW7EIILd2SxIxzUKbAqVD6dl7odgPvJNC6byOyCj6x9Puwxx5NQXrO/h//tLxECv+l7Iy1pcDFxo7zkf//Q6/wguYKbkrF5ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542212; c=relaxed/simple;
	bh=b3CcXSn483MghfJnCTSGZJqAmNGpvXznewfvKxFukgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIOtAkW+zdXUBRf4YzCFzKIJbP6vsCeaBHcOpDxD34TqIptALLz/oDp3Y1iPFolKvK0i4OSdvSGCAiRhkpnCYxD/VHmmEAV+Jqe6z/LYnBj/Fo+VeJj0gqDdSLxGPMZMScnXVmBXJHineHAIglxcce6LAnRfsQR/Nde3Q7phIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLw8YSdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLw8YSdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA131F000FF;
	Sun, 27 Sep 2026 20:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542211;
	bh=b3CcXSn483MghfJnCTSGZJqAmNGpvXznewfvKxFukgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLw8YSdhMarnGpJaEVNhqoI1t7aMnGE7p5teAbE83kYhzJMVdKbyPMsVtEuieYA+e
	 MoAexR++RmVHo1+kiJFpCQ4oYuZLCFWptfHovueiMDcfASsLzNMG5+beWvkUe96evE
	 Ctzz6bxe6+WwDccPhB+vXd1tSQBJ/pDwzzdFg+otEqucUll9AKGxBniRI9Q54rloks
	 v/2fCbYjxFjvAZFceQ1G58J3t8Ncjc0TvSU3m5m1/f/MEvjeR5sqDtZ5uA6JqfyRbY
	 NEI20BDd8qRj+l78Hkw7Poj7o4HBL95o/GQ0/1mYMLEN85BH4wDrZSA80fFzgEkWGR
	 D4VZWEuC1wa+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260927204317.21546-1-rosenp@gmail.com>
References: <20260927204317.21546-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 20:50:10 +0000
Message-Id: <20260927205011.3BA131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Avoid calling irq_dispose_mapping() by letting the platform_device
> machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> and other errors. Handle before any allocation or anything to avoid
> dealing with gotos.
>=20
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927204317.2154=
6-1-rosenp@gmail.com?part=3D1

