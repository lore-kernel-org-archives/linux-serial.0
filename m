Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258B443E54;
	Tue, 29 Sep 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663968; cv=none; b=IzA78l2v8EL2lEOOw2jEpeCu1h/mGA5q3zvqfbRVnf5Fm3/CoszL48wFgV90fV9SDcsf6d2DMwYwdoSRLCtyvqpPWlWulRtnXIYUPWZSSrmGSmL2MzITYKU7m631HyP58sj7t67Z35PqqQmPPOn5lCQXnKEAiwW7OmTyQ3MicBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663968; c=relaxed/simple;
	bh=rNQlRtzBuc9nB/Oiji7QMERCSVn/U7DUZbcCi5GWpvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uMiaNb4eRLSEVs+2nP8y6rnca/lry8rW55jNlmLqdOkMcrIoJ70thyQkeRG4p+X0TrdvMQY4qOmrts+P6iltsy6wb4hWxzWNSxAyTbAUcF0JpfMHTjhJ8qebQyXjc0xGChuZ8eU0USkp9NJOkJ0UkMs50hKTwLeVQ6g3dzjq9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si0PlknN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si0PlknN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABFF1F000FF;
	Tue, 29 Sep 2026 06:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663967;
	bh=rNQlRtzBuc9nB/Oiji7QMERCSVn/U7DUZbcCi5GWpvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Si0PlknNX01G60lGjeaTVwv7K4pVEvFqHxd0bOg+KhjTMHUTkfKQ+iP7wL1s/H2KV
	 cv9eGPVoiOPdDCArgOnje+3rnA5ygz2Fjq4dMu2ZEwTyws8/kMWzHfcXJkUZ40CnE3
	 coZGg+/hjGeS3YFNRF9zaYX290ZSrgVVvUSG57FgoqaU9dHrPt9yWhlsbo3szsAYLS
	 da9Yahxo9BTLMw3ZisJ+cSOP5ye+V1egfYiMxaX55MGCHQtFrMJsHS3sR30/D0AsnA
	 DGt4H3zuHPi8MWYIgjz0LsPuKN1hIL3/wW0/n/JDIGQPQR5qQZEh15rbkAwQOCJ/L1
	 EgCxfEhdTrJzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/20] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics
 sl261x spi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org, mfd@lists.linux.dev, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260929061417.20733-4-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-4-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:39:26 +0000
Message-Id: <20260929063926.AABFF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add the compatible for the Synaptics SL261X SoC SPI controllers, which
> are compatible with the Synopsys DesignWare APB SSI.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D3

