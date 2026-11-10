Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280598;
	b=PfGBdAJBFSqdCNY/aW+BENkmNRcOyOSy02qN5T2DdUCotHf7I8slX4rW7oY8t1xAD8gt
	 YQnkW006NfK8OOE10Og2ANE0AjhwwogVS9whi3IGVtflWjiDQQ86AurN4t++yNSMpMeUH
	 Tqoor2U3HTlZlW2ymvy4zqhvNdiwVxfrAEpBDITaHjrKXdw6WipMgjJJVw/zULXUslLCe
	 mWUjtdQ4PlMJO86H1hX0zwQzUkVL/scY73PAFGV+sh88/Q9CS9ZjLMUJKkDo6iWmhpd4y
	 mDVUMnzWcsCPujDJiJXxOH0B9uBm7HVgmDWGtbnznaNdFWQl2678rNd6mAZw+Jf/B0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLfH3ODxjrdieFnRABzzAlCPUkzq784MWeK683gbek0=;
	b=KztacX5he5NHpqJF4TEMwILXJCYZ+2wPikKo5zwX/CFcXDgZSYAgCxA2x4HED3NoGZxE
	 BrMorTZ07+kD2GZ0k5S2cGf1+jeLRbQBa4J3DmPheTfVhu7AU9oTA2VA8QBWA95wTFFXb
	 RB08Rbr4aaF0ozY/L+7zwBtTduaIx5o/hXKnSHLyO+dbfJmqkZIoNb0519yqJbYUpd9xH
	 N1lLh/AytTjedK25FZ9ijFl/L0BYn86TMW8Tu3NLeYI0k4jEzuF7UGntavSLdF8BBMIuh
	 42YbBDeXWErZuzYZwSqEbU8m7GAWgHqMQtDWG58yySWdzRzvriwOIrvwca3QFcmy9SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFNZ76uK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71884606A321
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFNZ76uK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B2B1F0089F;
	Tue, 10 Nov 2026 03:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280598;
	bh=pLfH3ODxjrdieFnRABzzAlCPUkzq784MWeK683gbek0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFNZ76uKKo4pLMoH9hlrpz/z6SHaMpRiD6LKa+lk+u+aRXuo3POzCuvuPNUIQoBy6
	 Gud71RxlT8fsPCQcMFlCg3SeMI+UPYHmhBKYWrTgEKYCgNnoMr4AeEqBquIYAawocQ
	 k72QMb4lszrl46AMg2/GsK1frZB2iCiPMWsWBDbNNTF24V2MsKOED4KqrUA8Wii4Px
	 KQ7UvHubAbnEhF52a7i9OUeSFdTfoxs4t5ysLe6U3fTJXi+5yPVLrzdJofNNpGlX8f
	 MF8zCz7Kn+BIC4+S6Icwio2jMuiLhUskoUxf1jODlr8BdUaaF4+OqBnL4bckdbf4iL
	 NRlIYDBAfNlWA==
Message-ID: <sashiko-outbox-206098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-7-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
 <20261109-submit-h616-uart-fifo-v1-v9-7-3f03961dae8a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:16:37 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
> component parameter register does not report the FIFO depth. Its optional
> register layout also differs from the generic DesignWare integration.
>=20
> Add a specific compatible to identify this fixed configuration, retaining
> snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-submit-h61=
6-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com?part=3D7

