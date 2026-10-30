Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337684;
	b=CPV1tj5BT6kKO1kHH2hukRFCtEioZmw8OFm6lZW24161wj9EzBHyQ0yePJaFgFkbsRT0
	 kEkM7J1YxajJfEjQ8z35z8JKGHpAyDigXCEJ9v6x1cEjzsQx1K5mzlcrQ2RZiARVfMdie
	 jJAuCOmYIMVDsSBjV4GSbsyRkGNFh8Pljz1PnMuxADBCPbJY2asGeSva62DE4DdmmFpM5
	 Q+VXYN3Z2nAovB4pDS855A+iglgRTQA3w7qypABzovffJL4wcdfQaEUZ//mKXl9wR2ak7
	 AKuk9gytjpAsJ1bucY4004ttQDxCA7aOE1iN24nLCJAke38MKBjFbUv3yuwuBC1Wlvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SNbO/UqV9rBWwcbsS/EM0ySBSINc0ApdYfNxpcSbmt4=;
	b=kF2pUj1hgDZjKcoJzIuaIVhngWodS4INQG3oQ9Qz0cELTWf12PoQtwMcE/+X99uX8xAm
	 p53dRj708PWEUicHQwj14cYSBbE3qre2F69lUESS7ZCKlsommy51kTV9HHdz9q9/1GX3Y
	 64IQIUqeLR4eaxPeTlaCr60TXVhPmSpCr8aSWaP7iBH68LBOX17yquCaVhtYVf5OG4Nu4
	 zpIFo6/L5kSTrtgCVMW25/RQa1CtVTb0JROj+K5FrAdh57rJ1Kza7LQT6P95olvmFBvfx
	 0uWTSk9pHBg8rWHfN5lMLMQvSMtVQtRO0nLH7mRlg/J6t62hc0jQ3FbWYPFfzINShZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfNogEu1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B10606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfNogEu1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8E31F00A17;
	Fri, 30 Oct 2026 05:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793337684;
	bh=SNbO/UqV9rBWwcbsS/EM0ySBSINc0ApdYfNxpcSbmt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfNogEu1NSpHp+fJXJZzSubcL5toa9Jpnt5a6qzF+nTC6kUNX7O2Q7U+UcJKEp2P2
	 MD8Mbv5xNsuVOuJbJQVD16cOWnIk8v6vTRdWwX3OaWS6IdRqgubanx8nVnr7p+51I7
	 RXgAhgRsmNniFLrOotqpHFYa9/rB/cUoeDs9C68eLanF5UVOYNQPehRVSsApqhJFNl
	 hNL7OOOJDjGswjGqGwuh6ieqC/skEhnICZnAqFMhVhrTgvNwNbBsgKvlqD8CLByWt0
	 zCXFxRHK+s6YWy1RiiSP+nP0nUgrGgq7p6b59IO3GcXBJ79L8dLZpm6+nQfdXULrNn
	 Fp8Lh2Cm3z0Pw==
Message-ID: <sashiko-outbox-190555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written
 reset_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261030045854.153556-2-zhanxusheng1024@gmail.com>
References: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
 <20261030045854.153556-2-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:21:23 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>=20
> reset_seq is a module_param_array, so param_array() builds it up one
> element at a time: it resets the element count, then for each element
> calls sysrq_reset_seq_param_set(), which stores the key and bumps
> sysrq_reset_seq_version, and afterwards increments the count.  Every
> intermediate step is a self-consistent sequence carrying a fresh version,
> and sysrq_handle_keypress() reparses as soon as the version moves, so
> writing 56,29,111 publishes a one-key sequence and then a two-key one
> before the intended three-key one.
>=20
> A key event that lands on the one-key state gives the device a one-key
> sequence, and because the parse runs before set_bit(code, key_down) the
> count is still 0 and reset_canceled is false.  The same event then reaches
> sysrq_detect_reset_sequence(), where ++reset_seq_cnt matches reset_seq_len
> [ ... ]
>  - An element longer than seven characters, such as a zero-padded hex
>    value, is rejected.
>=20
> Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset seq=
uence")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030045854.1535=
56-2-zhanxusheng1024@gmail.com?part=3D1

