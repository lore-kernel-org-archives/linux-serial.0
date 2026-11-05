Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914685;
	b=r/sOpG4s4kFQ5z1Ckac4EFZv3x0Adlv6POuKFhSsB8VPDUFnCQiKzY0wezsX1t3WKWC2
	 TKh5fhiSHe19fT4ou9s/gaNsPGf2mLBCeRT4DSqmUteKCE33/8yAT3rKmXOWN3ERgxrq0
	 NevD4iUBVQoCST72X5ESNvdAa/Etl8HKnNBwO2uO34njMdjSk5zTLBlTBvBx9VR7vBAgT
	 9oUFkGRdUqwSn9+buBO8fwyLerhqq2W+q+7LHv6SC9UAELsqhgv9tNNLslnVC2G9xwOQ5
	 ahfL+ikj8i44tqVy/GKpr/VuMaEcg877tfoQQm86BITpByUnt1q1oxlbYZEpKNBq4cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b0K9FwD1NDLUBHU2SgSfPjHJJKQ0zualF6s6M+DzyYo=;
	b=MqJJob1V1rzhT6locWnwYywJWV657e+XWZIcwgU6B83/YcKgrzdpWNl8SDh/01y1Oki4
	 qJ9PUqyDmfLEshjcZ5s6zfV8BIAqJihN/54VHc5FlKZND2tfJXExKHRiSlWXSBebgsUHn
	 RqS0WvPA6EcvaMg3kYqgz1MCwL8XQs2f4wxQWrKYYTrUsTUS4UILMRjgki6cNK3X3yTST
	 OL3R3RNgOlGMGAqkUXvcH6+/KvHZCkVBeB1aZXZoIuYu0l2uAx8kCeP7PMtt2e1tOZ/1G
	 AF7h51IbDwJmd+/aSZhEcgAE5hP2Jd+1m4az+3Dg8/8btPAwmQqEnImTnMSOjL4z+sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="loyLM/HZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE7606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loyLM/HZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8731F0089F;
	Thu,  5 Nov 2026 21:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914685;
	bh=b0K9FwD1NDLUBHU2SgSfPjHJJKQ0zualF6s6M+DzyYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loyLM/HZTjuAKEre9fI62+/GEPfhJnuBxt8HeRV2FoNmub13331tYjCgu0kCiLimO
	 z/WeYA/vVCRJUy6dO5tmyBzTuc0VPnrLv/o8JVo33b6vJw3dW+mEaKl7aPmWGtIpta
	 4nzp13vDz1CP73UZpxyRbuAubCvh3lwtW+uSsFIxSzo4jp2R6evZLs3o8930mMdurp
	 ie8f6jE156tGNhk4Y61qrvYuiouext2fLM8ZdwVKxplH3Nbi4gBzLYGGAFzVZiapUG
	 IBOnCb4M4tvODVfaiHot/A6Oy1TDGqfr1B+60qg7AcylJdCxjU04cnVlY8OYKsrSMQ
	 bwjP+TOw3Jt1Q==
Message-ID: <sashiko-outbox-200244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/11] serial: 8250_dw: configure RX trigger
 thresholds for Octeon
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-11-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-11-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:38:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Octeon uses the DesignWare receive-trigger mapping with a 64-byte FIFO,
> giving thresholds of 1, 16, 32 and 62 bytes. Its setup bypasses
> dw8250_setup_port(), so it does not install the common trigger callbacks.
> PORT_OCTEON also has no static trigger table, so rx_trig_bytes is not
> exposed.
>=20
> Supply the fixed depth from platform data when firmware has not provided
> one and initialize the common trigger table before port registration.
> This makes rx_trig_bytes available while preserving the Octeon port type
> and register accessors.
>=20
> Select DMA before filling in the default depth, as before when the 8250
> core supplied that default during registration. Thus the new trigger
> setup preserves which ports attach DMA and their existing burst sizes.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D11

