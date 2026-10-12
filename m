Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203F4BD78B;
	Mon, 12 Oct 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826360; cv=none; b=OU9lvv7Bk3Hsnp9utKVd2aSZcJPfJD/34pfsUxuiwFSUm9WhxldaFcgSjbfQvuxiUFJV+qR3MNlKlXQ99/+HMZ7Yx7H+rIaKW8Q3RC/Kh6TFFIS8qX7gptSlHYkxKUrs5E6CNemwoHwwof7v0m5MavKm5Z3gIt3JnjdeyJze2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826360; c=relaxed/simple;
	bh=wDZXn1pKmCelrzr11wJ75VplmKXCnKnqrCwK0Zhh8FI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V/aBCGeglMIlaLm0KruPVSm3sVzOdCr/loMkrYSIgbgVZ9JQdBJOlAA6iibUQFr1zPa1nBf/UnsNNPqwFs+LzZSxVoTfEVmvlNRH58wFwRSg77UlD8df+s2blanSNjQwbiDdraq5xvwDHQiugnEaJiGK8jsXvdlytdtOQO/3JBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUFbLTJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUFbLTJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3811A1F0089B;
	Mon, 12 Oct 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791826359;
	bh=wDZXn1pKmCelrzr11wJ75VplmKXCnKnqrCwK0Zhh8FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jUFbLTJpuZbkJ5lr5p6aWYWnq+x/eFH4TKuDm5fmessezWuQnB0ofonqQE3IyvJRD
	 TjEswtIkWhrWpOPBgOwJDrVAhzLBdltnn9lKw4F4W9CMaNmxrCWI5BahcxmZ6GwMnx
	 3XYiovW29iorfY9KQIHvg0wr0ygwYmTNqTlSeMNuA3X1F6zCMjwZTVrLoYjMJAvdx8
	 mG081ESeU43Q5VGv4AGM9BnIC0gylzENpOCseKv7sj0H/51wGjYutBRjbMFDB/Hpdb
	 g0k3z7xC21Cw37/EL+4ihMhk1KQ5rdtXOOASj6osU0erwOtBIh+tgjHZ12/Dvq5U1d
	 +85ol3aMcupYg==
Message-ID: <sashiko-outbox-168459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-b4-cs75xx-v4-1-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
 <20261012-b4-cs75xx-v4-1-df250d903682@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:32:38 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-b4-cs75xx-=
v4-0-df250d903682@gmail.com?part=3D1

