Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742232;
	b=4KWBs+DA980vjmNfJW89GyHBhSbZuTCLJ4xjSiEWfsUXmzg0PFNMN3YeF1CfNlRnJNWV
	 6dKY/aXWiZI1DvF9EMNs8s926/piQEDrmciTw1ogunJT6guS1IhcBV9mbKafIq1/ujDyB
	 Ezh4GOGWksdjyMt/Z6ChphXDzUJxFB0Ww5DsFipgfLL4hRVkscps+hdDq3B9q5vJMWZ4i
	 9EXJ+MSsADQXFX8KvqRF1JzF5cRH3IDtqrzORyHH1oYvl4YBMygR764DDwaRe57lmMOTO
	 xADa4TXhMjDmFyp6X28RYkpkWJsEE/JbKDQKhXucce5gx63ZG8ZNoSf22G5vFEn1K2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742232;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rS+VPztdLglHNbPRFoCdq5M5Zev5aSXIdhoXTGBl2CI=;
	b=vDSmtYMc1Gs2shqvpIjLqXpcepiVOd88NwzMyv9ZFQPeQdv5eMtDkz282N+8/gi9zndX
	 yfVd2/BQ+ULhYDvwtVZeKcSvHZwnBTVemXk1KI3L5Evv9d9q3/is9wIRQFt11C6y/56AK
	 xEb6E434G+YSLVy7Kc+DtYh3jPWNu0T84OaomEtVFON0zbac4FTcfbDH3n4Ze77QU9PWj
	 5emnEE//b0CxSxqZJVMccwZg5w/CkqUq+QvMLPGI6xVqURj6H+/SwBRu9xjmHiscQCHU/
	 i3ai3m/fo9JyoxjWOwXQELQOokgeM7YGqt3rg8PQ/wD80k7QAGSOGxG/efhGs11rmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZr8Vb5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE755606EEB4
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZr8Vb5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646331F00A26;
	Tue,  3 Nov 2026 21:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742231;
	bh=rS+VPztdLglHNbPRFoCdq5M5Zev5aSXIdhoXTGBl2CI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZr8Vb5oAkdAJgwdSlw4rJwvrlFsfYiTKTw68BCxsMZPg760qBh69rvneuv4Grfs9
	 fAieTFHfEpuCfIFxp/L1GFG2n+v9XfbL5oq7MSv+YRhSs9o4Q4bGAGl0zI9aamWunF
	 TJvf+JqvwHiEZKJlSUqv0bqPWy7cDMlEmlWamQM4MAuMRPZI+/Fcdsnl0gluIvoC9V
	 tDfE/6WDjkbx69kttFzJyCJZyD6fZ2UXoHVo8k1mjevLsUrGiMxJB5hbQF/xIhNGe0
	 PDedQOIUSYd0i2N9oYymWDBofjPKySaxjQry3ukYDLVxV/iNytp6J2RGi3KezMND0a
	 tLFaxhNj5F5kw==
Message-ID: <sashiko-outbox-196070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/12] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-1-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
 <20261103-submit-h616-uart-fifo-v1-v7-1-c9e248d685c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:43:50 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while preserving
> its existing conditional DMA attachment. Select the DMA setup helper
> directly for this integration. Keep generic setup for devices without
> matched platform data as well.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-h61=
6-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com?part=3D1

