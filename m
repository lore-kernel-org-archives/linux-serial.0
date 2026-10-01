Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D964BA1C9;
	Thu,  1 Oct 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858749; cv=none; b=dFyXQnMc1FBiKW78GNJ84NoyXnOLFo9tWWsBchehLjRNVELyH/w53VovBAlBRAZ0YGx2IvWgljLCS2DeetIXvvUOb1SiL+UZ5On9xA/BAaC0xHJsOAiz0VqbPf2RhJf1KcmMMT6+tbGX4EB1Hx3nNQjIiXtnvKUYz4VBm3RhobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858749; c=relaxed/simple;
	bh=hPAk7LSjheO2wILNMKvkqv0wm7CBW1RQ53mtDcULGp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cY0ixOkyI0Z0GKyLx2YEolTvEioupTT2ON7J2fezXMQ7Uo7QF4S2hhnZinP6MhCjjyYRNiD1mn0HSZrk5QyOZv/ho0uvHmzlD46N2miDYGT2A5iF0YKXWpTAeoXHBK5cteAmQvSmmabkF4CMWHeda37OENM37XrbV3v0wZDi1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kftRGrra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kftRGrra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9FE1F000FF;
	Thu,  1 Oct 2026 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790858747;
	bh=hPAk7LSjheO2wILNMKvkqv0wm7CBW1RQ53mtDcULGp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kftRGrra7DQccZGtqeJSAGW3/EXymcQW1Y8XF5pN41S7pyzxO3INv7ptdqAuv31Z8
	 tjJxH0nj4UR7t49lHRyC19B0yHn4YwFQM+p5LuEHnuRV1/2IUHeU4j6XoR0lsOfiPY
	 7q9gbR8MmnpFoS6mTXUg0icgUa1o4xVqSdhPe8zZu+/EHSHvkFAQsLHr2xOVJGvSgr
	 VzCdgvqj+t3nvO+UD5HSaJcWDLyYzBVAZy1qNu5Hc5voyZU9FVQmbHzeF/JML5Ijk+
	 kM1wE04z0eIeBtMxPQSGCW0G3DAxoKBzTxDHFhe+xMTbDvs/wDjx0dBTsTuNqHP47l
	 C88PiR9tp7x1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/15] gpiolib: regmap: add
 GPIO_REGMAP_QUIRK_SET_AFTER_DIR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261001-cv75-v5-v9-7-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
 <20261001-cv75-v5-v9-7-486cc289a4b8@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:45:46 +0000
Message-Id: <20261001124546.EF9FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Long Zhao <longzhao@ambarella.com>
>=20
> Some controllers ignore output writes while a line is still an input.
> Add a behaviour flag so the output value is written after the direction
> change. This is a legacy quirk. New hardware must not use it.
>=20
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-cv75-v5-v9=
-0-486cc289a4b8@ambarella.com?part=3D7

