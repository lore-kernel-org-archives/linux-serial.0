Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727884;
	b=Ee6Y/pnxf0OPqKIJE0pj61po17iJWJHpk6BB3n1m5CUFh6KQDHAjW32Xw67rmMywAV18
	 tRXSg2qzrZE7C766N/9iEKyuDnP8jIx++Jz4UCDfutZk/WeOZpupoN+fDtdjvN2cPaA8i
	 NMykBT8oazJmQhEg+p/YLMxPfPMEOdNgCoflnHAL7famM/o+GHwRKJvIGiiUlLcgPYpB/
	 o6Ux5DO/oX0xE2vuSPNQz/1rwgVsPTnr0Zz5Qw3xTyeMHYIW58IPiYOasxr7xFlexrG0b
	 84Nw7nCtDnmzY211HZGjQBnRmdYCwxo/S6AbJYw5K1HSlguM9RgHhw4HCl0wpzEGkDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WynRRL9Uml/XNQgncsB8n2P5xLLnt/C194hS1QRY5A8=;
	b=x5jE0HYL0FKjyxr2JAWZ99XUTaUQcc/7B+MGHRFMduHhelR4hC1vP3qPZuNBItctwuco
	 lyXxNXQd1ao10V4SBWtWvV+nPHEtDCvdov+9XjHeu4nJl013fxKWUSHFvavdZJyccjnIp
	 ueHJkqYXN4IXUS+LKxFpXheTCibFIt2iwiBHz1opLX93GQawkknnEgLylz9i/gWmfzQkx
	 tXHd0TujoWdYbTLzBi0d0Ulnvs7mBXo6B743VLtjs8v1kOb3lgVLf9vrd+c6vawWL3boa
	 lVBBxIW1KFTuuTwbZY5xuFXZit8sCQwY2B39rnhg6J+kPiJ35wS1LQBcURvxXueyJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4H304uw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B64606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4H304uw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593F51F000C4;
	Sun, 15 Nov 2026 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727883;
	bh=WynRRL9Uml/XNQgncsB8n2P5xLLnt/C194hS1QRY5A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4H304uwf4cNFBxF91chr6admTicJkpCheiU0iOniYUNsQORmZ8r/TK+aMny2+Jzn
	 6H/01gwPdX1Nl3BzSUalKOgcV8joUAjXaHIDr2a1M4a3WQOgEZY9bkR/VECWzj3rfP
	 7vPNfNALUqcsTQNFz7vXatBUJgglU7AsaH+xaNVLRXl4bdsCBIovDjhOB0BTE3SQ6W
	 c0AUB+1F8ySRwL/HvyEjw3kcOsPcIWlhdjbXVOB8cGjGSYBznys2XNqTd2iGqX3LHZ
	 Hdq+ipZYBT3QgtTreSVVoP3q3I1e3N77e5lnID+9xI8iH8ncV/XrFL4jxdIGmzu+Ye
	 OheVQxXUmrQ5g==
Message-ID: <sashiko-outbox-215261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] dmaengine: dw: synchronize completion
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-9-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-9-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:31:22 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D9

