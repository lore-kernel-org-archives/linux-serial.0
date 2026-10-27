Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142713;
	b=hnVKQ9i7InfXtSEu+qioWo9dKztF0W1KjlGnB4zLjn8dKrnEQCNMqB24g81iHOg/i6gc
	 mC5QbyWNnEcwwxMmgrel00Cz0TfVq/ACYfQTtwBaitpRj4rjfQ9bNU4mt7OQRW4n+18FZ
	 3o2VsSi/Ixc7fsWdPWUYmZX/Ut5u0Ln8ld8nctHYJuhJO70pA1tXWdMb3LSerN0L9lyQT
	 yPV5lKGsHMNd++kop/8H0p71JtRR4VbeM84XGjUua0FSxu9Eha2avZM2hWs+7yAR0P7l2
	 x5wSErvuuVGU1brw/duU/lIEMo7tw/jFw+uBz9qiRKiXKILspSA3bX9jljhKEF6pJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+pJa2BmNa8emHV749MgO0dEXmky6XJsHW72xrDnPyEU=;
	b=mqQCNgpIkKZkGK663dqWsT6VuX45P0GXzTl0aEBf70uUWe1hCudYssorBEAA+Zk8bI7M
	 yD07JACPbIQnxtL52trY9FxmwcJZRaRQeugdftuEew/x2pIDGlahqbvu89fGcbWpCpOug
	 HlGle6OK2I4sHwPfJ+O44m9a7K/f0rKF8Vlr/hw1/MtmHDcvFTZfmN7cYzRj3pC420aSA
	 caFQIMOg/H22+zHz9gBvIeE2tw0Ss8LToLnDBZXwYILHiRmrJQUnG7Iu58z0XZ7MlGLYY
	 Mn9yNqnG+5cxYsptYcRW+pkxaHZ69BICaEG8WMSu1GGe286tsGUWBrhSw0D7G8y0eEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMB5USPg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC632606A321
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMB5USPg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2714E1F031E2;
	Tue, 27 Oct 2026 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142712;
	bh=+pJa2BmNa8emHV749MgO0dEXmky6XJsHW72xrDnPyEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMB5USPgAJh4nVnwWRa7MCYWESwxvk9knUdKYDSQ0sh1Dfk68tCPqs2kdQFNUbEDo
	 JvHgydfpgcdcppn/ddavJfTOJM4TCYQbeMZNlnbx6UaDEG0obBxcOX0Ef/BUhNUQ+m
	 0R9RG9lPITMzX1fpuj9JwnDhrYJjC9MP0PJhqG/AWtWa9C1Hozir6AICNn8RBG1zYS
	 flxb/NT1L2/XxRHJzGywKWJBH4Lvd8wtGWarmePRyIOcmJutteKb9yopWXjqr1uFlm
	 av4VNT+0YvXeFJXdn4uoIMUziUa5dfpjiIXq9j/7zsoGC4dH9apy3bFX1RoKGe38hT
	 Y4n7LN83oS78A==
Message-ID: <sashiko-outbox-187196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] serial: 8250: share the RX trigger conversion
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-2-d37e018fd0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:11:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Extract the receive-trigger threshold search into serial8250_bytes_to_fcr=
()
> so drivers with per-port threshold tables can use the same conversion as
> the generic 8250 implementation.
>=20
> Include the unsupported-table check in the helper and preserve the existi=
ng
> nearest-lower selection and highest-encoding fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-h61=
6-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com?part=3D2

