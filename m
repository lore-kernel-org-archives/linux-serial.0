Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597019;
	b=ctwGy7EpclLv0gbjkHu88uNzV4WuTPnpoDQ6vOe4xO6WoTMrHvvyZWNd6rUncXGN+FAh
	 oVbK93nC7Dx6x8PonErvsvFV6qI3oY7DRnp+Wr5R6vSB42nIii0HlWg9+5eU8ExECgrhL
	 J7Py0Sq7iFM8RMOq/A4VhqVhIDAnWNoqvkiVK/ylRRK+Py1sli6oXJOUkZLrjDTeoCSnw
	 ry2+2icH3F0mLpm+78DCTc2VVovUjTv2mZXGwUsj+x2hlOCtxsLIaucqfSzsp44JkPabl
	 zJopHLp9iejJTh1VupMnMxw/1bMh5Vg9wUXm4cDMvU7WfFUsH/B3DQd8AbRrI+HOXTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TYTRH1Wi2bhnkrYaZWtClKu90+KXVguLPjqgsFaVHWI=;
	b=bLPTspyJTWl+8C3xjmSQi/WaH5zbxLRglykdf5SJLcDHFh2ELM8vgKJZNqVQYLGmj9dB
	 28HB8MXoZ8kHUm6ZXGoE6/8enIJY/UkUuHF7xXmDmSfv5Fvz26bIVNePEI3AMXKQwx0xH
	 1Z5IsMynoX/0YKPyH2gFpKPZSj71U8MKYtz0RSikY0kS4cHe+VJWKTX35Iqs2lf5/diWx
	 dd4+bDqlT6+gc46YuBjIkAOC0Ew0tGqt1cU72PFZCzxeoAxa4H7gC5+5P9tQaeF+lNG86
	 EnfSir5i2vYwcyhliE5OV5w2rKcsrark64u92eK8vUJiek763hgUUhrjqeBShG4uQYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAKvDnKA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF660A2630
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAKvDnKA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D01F0092A;
	Fri, 13 Nov 2026 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597018;
	bh=TYTRH1Wi2bhnkrYaZWtClKu90+KXVguLPjqgsFaVHWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aAKvDnKAJ+sPABiqr//v/nWHDz/0KtJ+V0xrqRj+7B2a9qGDRKiSCNhdVtyRF7cPd
	 HurrEPLVb8uB22ynAI/FHhur5C0IKrfMtoqUCxCA+ZGCHW2PcpaUma4zCfEgOZK2k+
	 IAxOLg7gj3gHBnD71xQvIfXVnpHC4ACMg6zZKwBVCvlXL67zGpzIeeVzuDlzevnmE3
	 6VaS7Fjzpn95HWHGyzn02WTGtZfIyg9x6yEzftExmPZubAbhxfI5uugKfKhlqKgBSu
	 7/8jx/DDn3LdfEPUK/TOKv4qt4nlduVHmBD7gqLfo95mkbClPly1f8TCo1/RjTfQAN
	 eofmpPRCv691g==
Message-ID: <sashiko-outbox-213516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mediatek: Add MT6895 and
 Xiaomi Poco X4 GT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Letuchiy" <asalde.le1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-initial-mt6895-v2-1-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
 <20261113-initial-mt6895-v2-1-4ab0aa9fa391@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:10:18 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
> along with the Xiaomi xaga board based on it, which is sold as Xiaomi
> Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-initial-mt=
6895-v2-0-4ab0aa9fa391@gmail.com?part=3D1

