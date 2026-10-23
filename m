Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773316;
	b=lKEB06br/JPECTBXxXq9NMcsLUiX29T7Yd9CMtffmV/STTBRoOLReRjKRk6SsvI2DEyb
	 b8pYE8QmCGB1oAwbQAhzXvBan7/bw3SK6MFt4sXUj+uyzrAeQklrFb+DUN2pTcJ+mnvOD
	 YzdE6cKSHMQqOqPK0SgKcEissrDeMrxakHIU8r8jBb2Zqnwpm/tlHbqgcYxeWChqS51eI
	 GaaucKoKmMrL+fJCWh9vvnbdlbqAneYUhGeDCkp34SxTMT4ZSaHs1y6OUqk2dLRbSj+6u
	 2YG5zwGXmufRhWlXyVDYkqb5NrQ50aozZSuHJgedRPqlbj45MEyEisOCRBD9CJwpNVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8M5xZu58hKbx7Q5RPJXZu7WjngKX2jJxH120irvVdig=;
	b=DSp6ZyPgvURxG1ty/7n25LDAOe6zGQM7ecuecAxVoNzznLNS6mpXI4DAZIEvhWKimMzP
	 dB0ZEJb4aTQ7ozNE2LNSsoZu5dkij3MP9fWGnqSA1wtGt+/mhw+1wCDfuFEAwDx2th+Xu
	 Rj24uMGJ1AREs14pQYICGLGwkxaAAY1WrLCV9PVmzCUKuUIZOBzlipNbhp4T2iBc61z1W
	 otJHANP4lICZaU5IQHyG4EHFiVOFjfY7hI7rO57bwLNj/kjCTVi48O2xkLSDTIlyhR4Ed
	 YqwrV+RHMgqtVPQOeO+jc3kN11DRrT0k25FAxnNyIvK2VkA0pz2MkurzSJUkCnKZdIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODnF6fRF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39F606A31B
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODnF6fRF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BB41F01825;
	Fri, 23 Oct 2026 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773315;
	bh=8M5xZu58hKbx7Q5RPJXZu7WjngKX2jJxH120irvVdig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODnF6fRFJwMb48YNCwlfB24D5YuOXgpW9AcyPYWN61Qzwg/WpYVTDaCG7gFKxCvOT
	 d2H9Oo7bcky6xpmSitcvVrXXzi0fLeTMfoDfDgkVCTcsNud60+Z3i5/3foYBRrwyK5
	 zXhhskw6Vwimxqq/BDLynqaKse7y3ffposEbnZJ4jlfNSy53AblOx8MTz+hSMap1t9
	 J4VdU0ZtowjN9tv10d74L9F7LCzU8hyp4qNY1v/cfs7cAE+aPc1MQ6bjlN/mOYl77v
	 +pRXVXpc9WZjlUrySxGLDXiXKRJZ81/PCqFRLSc7s5hqcZ2gsdw+W8djS84n+blyC3
	 Smv+k+tqB1kwQ==
Message-ID: <sashiko-outbox-182954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: dw: synchronize completion callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:35:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The controller tasklet can detach completed descriptors and invoke their
> callbacks outside the channel lock. Terminating the channel does not wait
> for those callbacks, and there is no device_synchronize hook. A client can
> therefore reuse callback state or release its buffers after
> dmaengine_synchronize() while an old callback still uses them.
>=20
> Disable and re-enable the controller tasklet from device_synchronize,
> outside the channel lock. Disabling waits for an executing tasklet,
> including descriptors it already removed from the channel lists. After
> termination, a later tasklet run cannot acquire another descriptor from
> the terminated channel. Clients must continue to exclude new submissions
> on that channel until synchronization finishes.
>=20
> The tasklet is shared, so other channels may schedule it while this wait
> is in progress. Preserve those pending runs: tasklet_kill() temporarily
> owns the scheduling bit and can consume a concurrent scheduling request,
> leaving controller interrupts masked. The disable/enable pair leaves the
> scheduling bit and pending tasklet queue intact. Other channels' hardware
> transfers continue, though their callbacks may be briefly deferred.
>=20
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization=
 support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-dw-=
dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com?part=3D4

