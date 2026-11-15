Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727549;
	b=fyPh51bunoS33ffLiPSZiznufcq3NtH+BDyX4h1aS5TOwmhJbZyCKR1K+Ul4Rjm4Z1bq
	 70WVzwENcdCVt9vprTqqOTK6CRVdYAxNwTSUEi6M1WS6b++MfCAO8i7GAvBICQ8ykjJQ5
	 FQgTkfZXqn46kxaj+Q37DVcKFvzi22ZVZ/OaY8Idnff0ipyguzNDJcLDlujfhkXzITwDe
	 d326bT6BKYu1KLqNXhddToxidIVhJC+RZaTMCvtJsi2vM/qKeRVT+VNqreuk66VtgTiIG
	 gCDMGh6Zk598AM7UA70g7+7dm6ZeZN5C8o0HIFNgHhH/1hsV7h6+fLXULPKhLgOgcjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gm5OygrLFGAK5GKEZfalo195PtfxxDod4B2XULytxJE=;
	b=RmTxkojVn9MdGmwwNdB6k6AFA/IfzKshTKqut3yyu4XJUEitam5xX+C5NvZ4mcuG8Zjk
	 yEdQwVcuo6F8ioH/OvRHwTALah4qtGy+5KlUznrPJo0zo+kT0yK2Z4fCa/LWHAu5SYPlW
	 7kZCNtTgdlaF8IrMWv3FV6Uqr/cMrpfmVEoUFUx8qbhgPMyv/ZTdFCGVTPbrISQfL9Cq7
	 ihKKIIpOOMrKQUhsMnt2D5c7vwUn4ueP5akUQJ+JaJHrsoU9CmXvC2LE/FTWjCd55ivDL
	 kpcJ6lg9z7fEz/GIMOremypqYkK6XrIilTyWWDJH6OqK+E/zmPgtj0F+EeszVzwGfqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/vi7o+t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FF606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/vi7o+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F751F000C4;
	Sun, 15 Nov 2026 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727549;
	bh=gm5OygrLFGAK5GKEZfalo195PtfxxDod4B2XULytxJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/vi7o+tUfNTsTh/M/KikORSnpfIJRBpAwGpoqTh6r6ZCTeITMo8iUwzdQqODQSlb
	 L76u65xVhvPWEg0XC//dFvkIT8lIFViAflqmz7YcDv5J2c3k0ATB90Yl0U3aZ1kHc8
	 G4BF+xLnY7F4rdAhL+NR5qzs3hNalGbflZfEnZVuv36e6McJx9ANfrndgRaSBgmdYD
	 fMfFAGM/20y7V7NKzplJ9jGQJLbFkdwa/wbn984QrreFljWg8LOy2CtxXlsXWTXxM2
	 jJPImcXRepWqWAsSCeBeOxOu4lfHoaVum827NpsIwdNBbyaLS46sakyZhdbkKXbd2p
	 yPf6S+WTbPGwg==
Message-ID: <sashiko-outbox-215258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-2-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-2-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:25:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D2

