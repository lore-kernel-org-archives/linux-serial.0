Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745681;
	b=tBLWXvLLySXlE0dkiZfgggc54xQuNeYi8e9v8dhDYGyUbHXLqIx5riKu2a28cW5nZhrs
	 khFJiNGpfjIbd9kHz0Pe7TM7ptvtNy8D1g8PREsPIVZeq2+5+9l22+dFpbU4RoliBH/Db
	 krYD+EJreb7F73xwgqwq1lt95ASkr1xoYhvvdNI4dU7o9V+AuqVTBA8rAhrotM/CeynRj
	 3Ns8YVp7mcswCdJAS8pJusEUIKJvjZluz+OShLQceaoQ8WfEZqzzrmGbxIzKOZYWKralK
	 IbZoNHmkTpSbIuR3CVsBzJwkyy0KGPciwXpvrZxvTgV8UlD8scC2ewgViS2atebNG/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7EKuGoJiaBQ3DCuZKCKxOxS05U8SLqHM9M9VKLftl0Q=;
	b=Q9d6TYm5DY+FgUVsAVLEzJ3Kew46WrebtKjXJnujbOaZ93BLteuwugrkSA8BDvMyfOjv
	 V6nY5bTE8hzzhVaI1d7rLQaB0BluuIc4q7VFmrkqVheFR6KmMPPH18DpeFhVx/Cgkppaz
	 xYn71pr/y7iF0+zV2lFU2J9farTkpd3/CZvLzg/9k4oPAW6BrP4aaqIKza+b5CZJqPja0
	 rAGtmF3n5RdJ0VrLQZqDXj56sFFUdBIP1wPF1207KfKSsY9SvuMX/ycSthKAuv6k0Y2mK
	 S9LgqIVDeHswjXBijuwL86f7IYA6vvs//hoR5wXRwZhKFan+wFYU5TH7sjWJJB0SpzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7q2iVy6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37C606A329
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7q2iVy6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4AC1F000C1;
	Tue,  3 Nov 2026 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745680;
	bh=7EKuGoJiaBQ3DCuZKCKxOxS05U8SLqHM9M9VKLftl0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B7q2iVy6hcLDTc2DrQ3GKw6su3w513LvUSd0gJCUWFHuHcJutVdViNjaKI12mDP29
	 1A/M07vZPX/8YQpH/ju4R4ifWKv0jOuJujfE5C5GW1TuHB2KhQVq5U/8KNKMg2Lz15
	 3YF9Uul4N0mVMoxRNeBzEGnjKSRocRjw+jWaytY7nxFii03zXLDZQl+RrteX46Kb6o
	 1MR5HDYy+NrHVruYQ3x5fhcS2FvPT3sR3CrrpcZSMzvhwfbUSgabIAqFvF9J5e33PX
	 PDftnW2HIUS/yn314X/oCYgBWA+k2ahiAZW1ULHIiwIoAPeki5erq1y2nYwb7kFAds
	 0bRvwgvVSk2gQ==
Message-ID: <sashiko-outbox-196147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] dmaengine: dw: synchronize completion
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-9-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-9-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:41:19 +0000
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
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D9

