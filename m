Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827248;
	b=5Th8TAgEGLf5aj93XsSet2KRcB8/Nea/ifsPxGklgejESaOss4MbSv+1WVbx6EZv0PeS
	 Cy+9v6o/YL41mNzLhpIRV+vQhEZZB+j43SvQxbzYoUQgvcBWij2Ley2A5B/zsrKCHQqtd
	 UXHPVgNTM/ILi014c+AzOQziSgM4p9Df9Nahjy2568caZMcgMXxN5W3qMMF8pwglGtMwj
	 x7NKard3gCgm+eBT6cdwjuN2Rmdetw2920kuU00shJAW0E6zSSYgu1SsWRcrJw8bx13Tg
	 OMARJkN4CLv87qXb3lz9VAC5U09AoNv8WEd0xsezHe2wb/RMT6y6QQR6j4AMFmZofbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q9swXDNw5AZpui6p4Wk3wqUy0I4vEwrMPfkhtduryTA=;
	b=m3KlgSIKtgNVdvTi9Z5QjZPiX8G3R8qZGqsOxJn5bJytSYREWmtqo/AsaTHT34XVgkRJ
	 2LuIEJ8q8jZTePH4MLkDzwTSn+LpkIGPe4C+2g9sofW9AQD0lO8YyKWd7AGpWkNuO595L
	 1eV8GescjXaeY67IhivBbcsgJQVVc6/Wf+aXFdh19f3cEcW0BIXKlu2+DXPOfGPIFwB2e
	 vmYnucMDlrgAnXo0D4A5QIPOCMUtVQTyRPG7FpKzjIIADe8MZWgw9ffGOkmZeKC47Axee
	 ZHMpecw05VLoHvpaDoZ4XvhSRAoEtRWuSOX29BGJwvoowjHexehS22afQL6V5oo469g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/Kgqh4Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020076073C62
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/Kgqh4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FB01F000C7;
	Mon, 16 Nov 2026 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827247;
	bh=Q9swXDNw5AZpui6p4Wk3wqUy0I4vEwrMPfkhtduryTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/Kgqh4ZR9BoOWjBNfeSW5VsxeweiU4WC1DQsBdFEpWp2Z0SafSrgU5zMAD99ja+2
	 7hWcHN0AeikZLDkwxmdJpBfV4fPcSbv29vhC3VSLNUHpF3R+yBoTJj58EtGVIdwCq9
	 AoO/sbHzmC/RFee6f+jg2Eiwt3mNaJ8/cpX06OXhuEEPLYGwjzOCdLTKItHpG4onLN
	 nsE0w4B/7dyHDtiMH+Bhav4xBVmDWk/Tlns8zG27ckmW5TZ94++m9b9cwWNPVLG7zN
	 fjW7npmAJ0jMvZOhHhRhEGq5LZSmZyjjSueBtPPky4NCA/hiHMg9Cw+Fp0m9syKOkv
	 mRRlUSmMhYFYA==
Message-ID: <sashiko-outbox-216839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-6-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-6-4a82d64fcd1a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:07:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only checks the active descriptor, so a status query
> reports zero residue for a queued cookie even though none of its data has
> been transferred.
>=20
> Search the issued and submitted queues as well. vchan_find_desc() covers
> issued descriptors; submitted descriptors need a separate lookup. The
> status getter already reports total_len for a descriptor that is not the
> active transaction, giving queued transfers their full remaining length.
>=20
> Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-submit-dw-=
dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com?part=3D6

