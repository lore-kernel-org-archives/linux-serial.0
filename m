Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956270;
	b=H955oOJ9cZk6bSOCiTlBiZuaJKkedGq4dPVT2LOtUkI6aMaGBqXNg29vbpzJCPfPpN+D
	 QJ6i26BOu2wZgCBnYFNAuDzfib/B9DZMV2ay/MEJXf5ygWjSWRLRkqELmfPhSKS5lNWvR
	 Xff8ghtbfDOzkDUwNnZy2f27j9+D/0IGie+bSB8s4uFRvIX/mxY6OBq5ZvRh/6qjtMYtg
	 g+uDcyxpcSlDa1GcGZNW+s5k+yaV/c1FUHnNMYcHp3bX8RSqVQKG0C28+WOElcPrgmLWQ
	 gEzO055mI7k9wiUGAa4m6JqDo0Lwmi2Kchemk603dKXCVl3vVvxc1pt6N/4FOlFyUCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U7GoczybHUXvRsQMB1hp4T7xOTWdNepYSarzWaN0VPE=;
	b=M6hZpxDE2hCRdhBUIbYgjRfSw23i/rto6m+MOcVCm0taS1Pbb7ZRU+vmTzVH8O47n9dc
	 3u6/L+iRQmoDNoF0vNFQ1Wxe4jq1VgcLPt1WCA3OAf9llB5gb1/yKzaSnRmwrk/vS425H
	 kT6zUiICM2BWzp7gz2zqMd5kdl2JPfJMdB29Y/KiBBspXO/93BvD8ylaVMrntJjQrqEyb
	 uXF+c6vM/BF8da/K3d05J/7hqF/eNYiSFMRP0zPmlpissA9EEHhbfaMIZxvxd9gJeNQYq
	 n1VKYLrCrfMWL1j+fIT50Jbr+Y1meX0iUQ7KJaEIL07Az1G8gWFtjyttymdJlMIwd+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM9Fw1Vx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC6606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM9Fw1Vx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19841F000C4;
	Tue, 17 Nov 2026 22:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956270;
	bh=U7GoczybHUXvRsQMB1hp4T7xOTWdNepYSarzWaN0VPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mM9Fw1VxyW1yBiYsmOjMgvnL4NrzkfQkk0TF4ru5L1Yax+ttokXzpV5muW4giI5/5
	 rlQz+KmGhbgWDMUhyRuUJYJhnMGSU05WX+6+KrA5oGgU1nBRqSlHzUCI8sLphkeSn9
	 C9yP8Ew3/QNpxcWX27vssIhMHbSo1CNWgSbLJe5kqzSqCfTiuEvYgX875bCK0/P+ob
	 LYIsoawAkOX1V1us3maUjS+xhTtWtih8MOHjcPAPO7oHUXGbiStw0zTlUClQnta5WK
	 5e9mFWfqymEK37KD2+js2SNWYEMBhmBMe7UtwJIopXpKXp8/bkdB1YUc8LYmxlkpGZ
	 vSt7lMoiKrymQ==
Message-ID: <sashiko-outbox-219770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-6-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-6-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:57:49 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D6

