Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206287;
	b=eDex+q9XT2KNKWy97HbsMNI7lilF/OC6H2LvZNjxGAy6hR8x/YxPWfqXO0MX95QQTZ+Y
	 vwPJvtAsODAYL3mUYh8X6iBDIaQ3WEAL56EkE+FxAES2eD7Z3GJZ9YrkZUpN72jWPpRIL
	 AbT1kclTLWheSsU0NiIansLhOZCXDAYw19I095K7Jo65dxbBH06Aq2VLS1cR2FSvkWAYL
	 EPolAmx6x1tsm411kUpLW80ju3Z4TE9dOZ22Z9EVDFArPFn2i/WC+r/Dl6iEtQmi02tbY
	 wF41Ny3C62f82Z65BpMataMICi3LPL2uayhprUnsOblHwi1xpksFSHCKkpyWBhRXPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ewaHwRz+ZlTzfjhvWX6OXEzO2AC8kva4KuCin7kNE6o=;
	b=TQnH2O4KlzP1U/uaZmuOKjeWzZu7qv/dO4v+8neqNFc/BconocXXH78ZXmF9wRV1rUj4
	 cNJiIZhgkhE8CsS8TNSYw023kkno9NAGyAtt47ucDKMC72pUwuoWHFdAbiwxq0025Z/bh
	 tnZtSzqW1S/eBNC+kVzuedzh7ekmSy7sneaTccTCxH7e+A9NITGkVJ1O99lRTOzehLmZu
	 Xcv14MC2zOrS2iMuhDgdqwmYGEXLoZ98Fo+NFMU1ZgTtFw3LmpamijCmUTgL+PztaXpOq
	 ci6auCkjw6A9po/1b4lDnDh3wc95Jik5qojf5wuhir/JXSE5uasCncVZW3ZqBqdEY1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zs+EJoM7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9025606A6F3
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zs+EJoM7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507131F000C6;
	Fri, 20 Nov 2026 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206287;
	bh=ewaHwRz+ZlTzfjhvWX6OXEzO2AC8kva4KuCin7kNE6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zs+EJoM7v4YRLYySNCGIfHa2VDvVHzMBWeY+ozs8NBrYEeijOLhZUvE291/x16yxp
	 pZNWD1NYx0AQ4N8XBPvkgIGs61ySYaoE0tcr/ga/fi71F7t8RoyZ0WmYwoZpqMBWeP
	 aKBK8vtLw9/q27iR2I66Pw3PFEc60ArYnYQntBYaqtJul5vwT/uRl/AP+u9ihWPeEe
	 +DTtE7O9ze4ABI1iyUtHi7U9lMyqnEtSLPKolr1kDZ+cySK8PU37ExpQcJRDwEwKvf
	 cQDp6tQHvvmkO1rmPHLF6pDHPxta9T4qj4z887p0fdXwWnnS8uxxU5eHO2jsmBxAot
	 7GK9LP+9PhBtA==
Message-ID: <sashiko-outbox-226064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 0/7] dmaengine: dw: serialize completion and
 termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:24:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 7-patch series:

- Patches 1-3 and 5-7: no issues found.
- Patch 4 ("dmaengine: dw: use virt-dma for descriptor and callb..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-submit-dw-=
dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com
