Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295969;
	b=O5i73axsNnxPYvIZya0D3+VKebMekj574Tw1eT1t5LOf3vQxsuToYBPxCq/S9gcB36tl
	 cJ5XUpqQ8Fz3NwpnJrYQ0QIiv4/hmQY7+hLVwe48SYEby2jyCtd0HeDg+IQe6Wz/1B9AM
	 wAJIC4hlKhUpsWl0qm+lucY4FHSQ0JqNzi+zCWE7ouw8k1pfK4IyC97t8lBT2oyKHizKK
	 buanKiCDybKC5LzXkwQg4cPAFO1Tee9lUwuSjTmVk0PwRH96lNZAZqaklEFux7i6zJ4iA
	 mTuPSnWXy9DVN2NBDRibQGSr2ibGBFbkewcwmB4HHB0x94oLFMjFLsOU8fz/3p1VCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EaNd5Ax6Ypt6+G6aHMQs+sbcni5hz/0qTzQc6Qtp/6M=;
	b=eVhWKUi+G9b3R20WhmzLiJXkQZGroskJSx+V/ImOaVM/EyOi/jlqnbt8MGe1KaPaClCT
	 L+uGcJCGTGfIqx8GegVpQj7g4zMhUQnsgSCbtKW6c7D66WMu8+QW5fupoY/frnybmJIUQ
	 p3qtw+9gIK7rg6AeKsookNtbpTJD3A10l9fRceunTurQMh2F0A1YyGanxND1BSMaLJOqa
	 nsGvQj5D4YQcrPUgIKtRlkQ8G0oXEsGq4dgAaisLFEdPyj3z6N+ojbqV5HaKoQggQ0Okp
	 hMCtw7GPJmLfc/SO4BrqiVdikKEIbtRJoB3P+sOnIL+RlCdGCoI5MnI0TShlzLpPcmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbxfRbRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214B606A320
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbxfRbRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4871F000C0;
	Sat, 21 Nov 2026 21:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295968;
	bh=EaNd5Ax6Ypt6+G6aHMQs+sbcni5hz/0qTzQc6Qtp/6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbxfRbRLsHLz/CV2oWZsp9t0OOXYbO385LUuAxJx6dn8dJFL88uWczyDMrV7x7tn0
	 Qtc2Omsvk0z7P79BZLJHvySCJZkIHY//kN0YssNqjOzeeb+kS6Dt+9B8jwN0dzUfdD
	 0ccp62HG9RAN/Q5dZvJi2dEnh+spD0eIVwNF8ztPzEfoLl46NuS8Dn5NMZzFoOV+IG
	 VPH8qUc5LH5PetKvYWy5vfq+aKSFMZmbtLUnEw7dUAjYzansRGaGO8WoEOVvO45JHD
	 j6iJoH9CMqduNVTvWeAk5tOQbr9ZiikWTE754wjBdMEIFrAzVmj13Kg7mHWQ9fRnXt
	 ptZiFHEKg1U/g==
Message-ID: <sashiko-outbox-227394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 0/7] dmaengine: dw: serialize completion and
 termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:19:27 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 7-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-submit-dw-=
dma-synchronize-v1-v12-0-f51eb635209d@gmail.com
