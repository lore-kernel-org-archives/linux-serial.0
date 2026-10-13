Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277015665C
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863255; cv=none; b=td40I0p+Ti/LpDPUqeH+oANtq5wrfJgyH1LbWjoGnRhDcbezNIA2LTbxCixnJO+vgy7LajH95FuMw073y7kF8LVr6Gs2u03YdpSviJn9S8ghvnxyjk5ObFe1968JpmL5uIwbK4MzdEvDY8FuCc0lR3anBjArEApLx86ZxVkjzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863255; c=relaxed/simple;
	bh=PnA8mXK0f1xsTrgOB9gRluKG3kk4GXYvFYmHKcK/KrM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NT2tPNPs0S1+CahwZU6wsNY4zDDFLCLnEB+leXlmgSmf2mmTus5gshMYUkLrP1MylNoWGFa7QPHloqe99IicGWMyQBXVUNvX2Ap/ZuA4L8QQqQzI+uTbH33w8d5DfisHWjKJqQFcEcjqfduBliivJd9voL+84Kp2yw25ZwsG8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC3pxgCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC3pxgCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A64A1F000FF;
	Tue, 13 Oct 2026 03:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863254;
	bh=PnA8mXK0f1xsTrgOB9gRluKG3kk4GXYvFYmHKcK/KrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HC3pxgCN+RTGc8wmOxp3Jww7j+8ORxRsUGo988cxuUspmjlOpIu20bblCXqb7YRUI
	 DzTmxKPAdvAGr0Ku4j+9ucNIDmEzVhWG5jG84n/GQ7NRZk57wmc1/fDMS1/HFYBcY/
	 mNC4bh4LbgO9ozU+rgtmb/9Jm0HKPXt7u5QdiiIrRj0Ufewg1En0aIVOtj46J1IBoi
	 L2Tvx2UYeA3RzOuQXsSA8Xc1pSJfqPMV20upuPSSEPJMxIa1maTvDZTYgXDRt/Sy6g
	 xhSWuBcwKsAM7YwiNJajW31/3RgSbAeuy8pqt3UanAhMU673QzmtOpTlKK61JwPHiF
	 NnntjKGrHZlRg==
Message-ID: <sashiko-outbox-168917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-1-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-1-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:47:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D1

