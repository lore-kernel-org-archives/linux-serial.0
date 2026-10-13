Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E4B8296
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873137; cv=none; b=Ejl2Pm7CzqGfkcQ/Es1n3qTlU+bNNmfaEXUklDupOd8gFGtYI/tUYCz53Zj4CSZ0pMVcEnSFE1GGYOsIiLd0BT9DwgGatJHxQAhw1V8geJ23Toma5CWEQSiDrFr2K/BSBEQx6QB7RA4PJJUQtZN9SmKdba2HUH7JiHcs0xL32fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873137; c=relaxed/simple;
	bh=uyiLh0HSYxeapSrl62ypsqnJ1aXXLyvVrSfwbkLNuTI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qdXNFdp3XNrPYSKrQxjhrR9x/sYC4ZrhblDOHhhVuy3dEm99uBLoq6UDsnFj4fsOpXObjXd/4m0ZpS5KyzzG7UQ2ojAAyVS14ROMIb1cBmsI4I1Q6LqiADnkBMWJqCqInX+lAB3NdnlsS0oCBVZgnWkhjF13PjlRI+mKUdr6IJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF/7dFA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF/7dFA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6123B1F000FF;
	Tue, 13 Oct 2026 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791873136;
	bh=uyiLh0HSYxeapSrl62ypsqnJ1aXXLyvVrSfwbkLNuTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KF/7dFA4X3GBo6BaZ4JAm0S03kxeqjFKgdwW9nC1B4LRzFWX5xJDwvNkOd9459fVL
	 TvphyML6CAGIuf6tSqHT6NEvfGxlRuZ4DQ87rrC9UGAjtXJBal10VPJVGYGjJAbUax
	 Hy5JNofPHSJkHNrI2KpLSQt/JXqJcrGF6InL2GseDz5F0s6vctA/GWCB93YAke0dEG
	 +5hAla5g+8YuTx8NrQ6v/BLk6tJo0TJ0Q5kvTQmP9+r1+nIq287nOr65r3o3zLu83Y
	 cJ9yzk9Iel7AHlK8k5JXust1h4dsbmFNpT6medIH9R6OhZo8nImK+eQnhJQXaXrxOu
	 6Ph6jq5oJpSwg==
Message-ID: <sashiko-outbox-169100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-6-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-6-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:32:15 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D6

