Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000835;
	b=MGQ/VnSqQCavZXV7EvhS7vTGH802PNS+WkUPmAuFqep8c7e+DQ81POG72AU194979q+U
	 6K4CS70c56jtuWkGQFbLDK5WPL6/cR696rlLe7AAh0RcDNZfwe+Bqh0up3K8iz0oSeAYW
	 h8nT6aXbTI1hsXyJ1VdPTLsI8BRQwc9QMfeom3OM8yL2i/AEM5/2ORNqdEEinSjASSd0n
	 n6DiuO2yKuV1zixJixr9kaMKlCBQjWRx9I7fygeK2o1ujOSe8a8lvZfMdids1KLtpgCwe
	 unSik0/ksiSnEdjuCrZpTUkmeqSHLjd0bVJsOjZ/XVj+xw4XbksRpw7Ngl5EWsa8MNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JiQB/QQ0U00w+3efxb0f/DJRwT4zGergIKjS/djXkEg=;
	b=mlz590SCtZSyLLU6rb0uNovB7zrrcPB9ce6yoiF/zgstQLFK5CddsmqJqMMWD45Nt5fB
	 dzijqUR45KTdoYNKr7JZVbOINeElAsbbmnzBNm5incwI5WR0bk/ePN1UgoUQt5zjPASQI
	 utgvLU7uIOKqASxJsmEa4ihtIf9RCzNrf3X4W/vKv++0Yl6EeTraR3IesDtSmialf6SN+
	 5A7/cfG4SR0oD4dYV93MlmkyxRoleTBMOiMTcVbQA3ypVccVd5TKo60F9wO+8Ifb9gVET
	 i/mbdSo9B8HMahaLx3jmV/uwee5R9aU3QP+bqNHrT9fXOfSAWaCcK8SU2WUhMKpxjzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUx6f9n5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F02606A332
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUx6f9n5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E931F000C4;
	Wed, 18 Nov 2026 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000835;
	bh=JiQB/QQ0U00w+3efxb0f/DJRwT4zGergIKjS/djXkEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUx6f9n5YBVcZKgFd0eWhIvmKNlI1W6AhO1zPXCDW6imOHqZgV2AOX3+reWdSpk4u
	 KQIA/z7QZXHEpYK1v1/NXFryC2cfke7w7LGwx3DBz2WfpZYGyOBhVBmdE0sw21s3Bg
	 +nm+w7S3x1dmjQppw1g3eUWv9ISKqvVNrPt+Yk8j/Sj6BlW5W7qclXKGRdFLeMgebb
	 LrDTOjkKytwYA/gKjbGRAcsYU5LX9HJmRYSqVbbLf45pGsCPZmP8TPw/s9nVy60ot4
	 VcUstvBrMn51Ym74onoqHR9Q/aMZjqTWZ0fWKoqPTxPTdWaUchxN6PWBsf8SFV+5nb
	 eHucjBxdVS1oQ==
Message-ID: <sashiko-outbox-220817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: pic32_uart: don't enable clock with interrupts
 disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyunjung Ko" <hj351016@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261118111521.1003717-1-hj351016@gmail.com>
References: <20261118111521.1003717-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:20:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> pic32_uart_startup() calls clk_prepare_enable() with interrupts disabled
> via local_irq_save(). clk_prepare() calls might_sleep() unconditionally,
> so this can sleep in atomic context.
>=20
> Interrupts are only disabled to serialize the UART register
> initialization that follows; the clock must be enabled before those
> registers can be accessed anyway. Enable the clock before disabling
> interrupts.
>=20
> Fixes: 157b9394709e ("serial: pic32_uart: Add PIC32 UART driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118111521.1003=
717-1-hj351016@gmail.com?part=3D1

