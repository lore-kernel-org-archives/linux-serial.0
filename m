Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618086;
	b=NKmhv0GRZ0UICVquuZ9mQC/3EHbbubYVGGXDWH/Y3lRDrDKBnYC4w8+EqO4FF1Xmy2BX
	 guC9qesFQ4d/yhvWf2zt9mn0aZSjYDMkwENf/GximkG9WfG2RFTKtiiBfQ18Jr2vlrJiW
	 CT8kIcXXk4+IMqd2V57kgpE9cFpeANWq5zJ5k6flqReBxIF/PW4hyoq6JNhy1zSvNgkFW
	 3RG56b8CvBqeuOh8LgL+5kAj6KLVfs3DKXuwR4hcIRt6GGUkfGLGtKe6s7+lJ5g8cyBWx
	 UQZ8UEOzyZMLVZWf1+7gNW/NP6teb+7ZcmxFCORRL+vTEDAcISbBErJQrDkYsjERDCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SLzlZ6zz4HF7eg/jbb1gyd/dSLCMiI2jZSO6D4ltX58=;
	b=bfDOgMLQLLsZKb0YDQlGKjWPTNOpvtmkuG8wFRMDcf6y+hg4t7NKezL55Cnar6JJJv+2
	 QJUmdr8LvhQgiXdn0uwEFbH3hA5LzK9dOIM84cQmAt3STXtm7EtFLEO8mU27uPpdvQJpU
	 /r8WPD3FJLITAcQ2RYTYpIbQkbF3+XYCOTg9iM7pTK8DST4huwDRoW+V+q0Tl9leNw/UB
	 DNmbsH/Aj6JEkoEwS2igTpoLoSZLfuX4mGH3920Wzoo96C/8PFO8x6bge1hfm3XbhsHDm
	 VrYhvXL9+6k+CWihhCIi2EDc0QccvYtuM6OPsILhYAWR0J4O3P44UtsO7VeoelZWtpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E5Jjw/DU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805A606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5Jjw/DU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F671F000C1;
	Wed, 21 Oct 2026 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618085;
	bh=SLzlZ6zz4HF7eg/jbb1gyd/dSLCMiI2jZSO6D4ltX58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5Jjw/DU6ASNSz9Y1+mtQ6ZHs6EP6wP8/LWNrHoY52o3/AdXUyPooOBmDvBokp3K7
	 vL4L3UKRy+4+JxQ2Ff/R6jYFLpkTq5LkOTGW/0qfl6nAKqNvmTQFUIt+ksXCfSj1yQ
	 oULG1mOkay6ehTTtZQDOZx5DB9VRFQmNPXPXXRTYLLI/ybgeMdLaT8AqMQccmATFNk
	 WmI6NrOdltQOMMfvZC2IyKzICS3bbbb7HAqXDkn/C5MEFW4/bwpp4pNEpl7dup8ZEr
	 kshQFE348XPZbMJC2Xt+NIQYrox/IvzSz3YWWnQxd6+6oURhohF/ESduFg62OlRexQ
	 CqFlO83O1rHcQ==
Message-ID: <sashiko-outbox-180699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: check DMA channel configuration errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com>
References: <20261021-submit-serial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:28:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_request_dma() checks channel capabilities but ignores the
> result of configuring either channel. Those checks do not establish
> that the provider accepted the requested slave configuration. If it
> rejects the configuration, startup still selects DMA and later attempts
> transfers on a channel that was not configured successfully.
>=20
> Return the configuration error after releasing the channels acquired so
> far. Both the common and OMAP startup paths already fall back to PIO when
> requesting DMA fails. Check configuration before allocating the receive
> buffer or mapping the transmit buffer, using the existing unwind paths.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-submit-ser=
ial-8250-dma-config-errors-v1-v1-1-c067587d1ef2@gmail.com?part=3D1

