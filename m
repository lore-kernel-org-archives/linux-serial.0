Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505518;
	b=KKvILx+GjGa5yDTdJHCxziTzbch5KQH8IJOJMJQKcoZY4dEt8ddwVOoX+hhgpYSdufOR
	 nmV04H3FLF/SzUOFDxGuzuVEDCHbtCNyj0aEVKsYPIR4bEA7bO0EmnGqHepyEqEm+eYBK
	 AuIPlx/PZU8hhNGJndy3QiXa5BlBvJFkyVCB3jAmMpfjMTQNQxNxCiKXvllcU9TkkTqmm
	 ByonylrXaxHr40XJbmTxlCrp2kag92R0oDjIwVMPqgyc49YHbimx/mzFXhPmkBb0Y+/3a
	 ty/r98RknmjRZOzH03eGA9bWPMOwfUVCYu8sM1ucODRwHGsOZas+BXx6kW1tpgB1JnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505518;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OfB1y8hHfSgGwgcI/jaRcJfiV4QbdyP2vOwukoO7jqE=;
	b=DkawlLu0B1hGk2ZhAbK98VplCzAYbtFSG2gFhld+u+KeAY38W2kKNZ4PTeCmR0MsmLrq
	 Made8N1p8sjwnGhsFCpGgOpqoZYEN4keYPdbQ4CWWEqbIyCBZMevnq+OYa4FBvWajlKdv
	 6htIoHfSlArmPB5dYPwE1EvVXVDWjUwqfWCcFV9r+7RUeYc3K+0yOrAWieEbTOeXU5ptc
	 TBAULlbu9xk9YYMlLPVzEolzmjTxmr1XkJ4WGjkL7Fu1+QYfubwOj5O9w0uZENaMr/qPu
	 h8VZ+MkPdgsxs5ccMsNJ3RR+vZkE3mNwsVyOpK8EIWUc072+xyhWTMqK64PLZswlo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQH+jSAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B09606A880
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQH+jSAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C535F1F000C5;
	Thu, 12 Nov 2026 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505518;
	bh=OfB1y8hHfSgGwgcI/jaRcJfiV4QbdyP2vOwukoO7jqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQH+jSAa6tfMHDZ6WU0+RPrG13A2vTJr3cNTtiB9Iszwrl3wbGzxgDcNAWStD2rny
	 mzqO+5LqVHKfHyUuRzg6PQLItGZs0PCVh4m65//9sU+SZM085bo3XhDiQ8fHMPkWVA
	 6ELdX9YR+nLU8H+0aN/Ssces7Gszkoip0a1WT2sVKgxYv6DEgPrQ5dQp4DcaTWB7EJ
	 ZDxEoDi0QqnnPveuKg3/QriovUJBkbxNjKeFKKy99prkmrO61o50zHYz94Q3UXO1Rl
	 uw5ySKbNyAk1USE4c86pxwbJyMtnSXTBKtcCDoEzcOrNYDx22yrVW26MVF0Tyk4+5t
	 eVe3db4bORz8Q==
Message-ID: <sashiko-outbox-211624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] tty: serdev: Export functions to pause
 receive_buf callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-2-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
 <20261112-rust_serdev_probe_refactor-v6-2-3568ed56264c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:45:17 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> These functions will be used to simply the serdev rust abstraction. It
> also contributes to the fixing of 2 race conditions in the serdev rust
> abstraction.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-rust_serde=
v_probe_refactor-v6-0-3568ed56264c@posteo.de?part=3D2

