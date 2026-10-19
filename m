Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441442;
	b=I5OoMaV1zmy/Gcax2UgOf9PKfZEBEC9F0JRt8b0vxKGK75Zb7USEgdj1vANqu0WrYbdw
	 GParMNBYqVenUUmdyFLVkKutI12YlY5/cThkTLnR9yxazsKSbWNyJB9jyaGNMxSUnOBOU
	 VMHynssu6GCsNT1RGl7/vI2GywdKwS2BMk4fULk5N9/1f7FNWHLMfAmxDOJIBy/PMJI1K
	 wZ5Ri6OBZDH2IHrfISwiES1tzTvgS5uvduosajp3UR2E6h5X+s62KL5ZoDOCJyg/t2USE
	 pzOYljAetBDYgb1hxvHhnzDasr3fBJv6EnpnP4xIbPCtIlXclh0b6bU5GC7/xpBVozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zd9aErSWmmBvNknLzEKxN8JZZX0liC9U2oUJK6wJQdw=;
	b=3gv2Ii/dArXZ7sBWEVkUFuHR3A7KBdXplzZFwmEsh+RVmf5SrM38tq9LoxW2auHPYzUI
	 zrtFu4mQmlFn4aqOXrRFtoRprWMfi7vriPixMvL1giEkTKXGfXjIf4ARUsU3aTeJLSNda
	 hOrgWv5jcHrPF/3z9XP/CkqqAMVwfRzyYm+xo3OfGVRUNX8/riJtwfHk7Ve7b4ypZpxxA
	 NOFHM7cVvHaMA+9vJvqrmrZvh+mbvnx1/f6kKteIeLk9Dbttdv3/LcXOv7CkzWC/oAOE7
	 TXST1goNDP4CQRhn70WlJA8KUW95bAL4qirq/8gIKlQjCSW5MCNulpMteQ1w1i0R07Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UM1wpjEk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B36606A31A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UM1wpjEk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC351F000C4;
	Mon, 19 Oct 2026 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441441;
	bh=zd9aErSWmmBvNknLzEKxN8JZZX0liC9U2oUJK6wJQdw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UM1wpjEk15SftkPvi0EJQAvyXVZlrSIIMOWhJlnOkr7SB2nKZ0hqT2YjCo3NyPOCc
	 yD8g9yb3qo8BnA75DZMnUiU7ZbxVX1XMR6QzJzfck/cA41K9+iAkuwP2pg3rbZOskJ
	 g/rUCdx+IwIYUpxb9GimAMMTA/iWmKg0XF8jHomYb3LNNuwnkRYQRbjZBmuINZWc/7
	 ZFvQ7cKFn/nD92MdiPsMeMK1cskLC3tdihhLXxcydOhsixsbO0k/Mu6E7pFpcLSybm
	 +oKXoswseTfAUn8CClbuvTpw7fKT2bGE1cKM60AO6ZGvRFKVW18lu5Kwdz4VNvp27/
	 iYjH9Kx0pT1jA==
Message-ID: <sashiko-outbox-178165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: serial: snps-dw-apb-uart: Add
 Allwinner A733
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Pedrosa" <vinicius.eduardo.pedrosa@gmail.com>, linux-serial@vger.kernel.org
In-Reply-To: <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
 <09f3a181436e6f19317224e583c2fdaa787797d7.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 20:24:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Allwinner A733 UART is a DesignWare APB UART, but it needs
> SoC-specific handling so the driver can avoid stopping its clock during
> termios changes.
>=20
> Add an A733-specific compatible, with "snps,dw-apb-uart" as the
> fallback.
>=20
> Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792439398.gi=
t.vinicius.eduardo.pedrosa@gmail.com?part=3D3

