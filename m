Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648974;
	b=n1H6Y+obx65ymJJ+uOdYwKVY1tqYMVFUvQPnGhud3Up9CANfEqR9aKL85Ino0FUeQ7j9
	 J7Cu3GIoVrfDmAKYHhTa2L8QEo1XflPAXMRZmFUhOjO1nz+hwn6e8pMWNa52gM+Osm7Rr
	 MY7+E6Ow78IXfDKXI7E+fSmesnUBotQvlWHBAGXuj7qo8uSkhpgA0hWZ1gLJBLAsZGHPg
	 1tNlScbWIT++dNtHjdmye9iU0abvLoVYO25TV24RBQNb2s+2zh4ne2Nbhnb3aHVgMFjld
	 9PRDlqECLXt5hhVuKJwvFxmwMHKf9lI9vnavejIjtqnfgkcsViUC4oS2p2k9L/tgDcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648974;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9b6IqD/xEfbSDE1yiPPADXCbKoWTJ3gOYDM3aWMSwi0=;
	b=2YhtK5AiEBaQF4YYT7svk14Wg3dy9JUtiCjRSIXWE0/W5Cdgl4/S8uSBry5ve98LawjM
	 vFuvHIWGQooaQEnOd5RpQ2+QF4vjYpp385jitTky6SjI0iyRCKnMT/7TsKZezN4RhEShe
	 HhLJNkhmE74QQbAORuiYkjZt1P9iSSAbghMgoDQ09wrYHA6qoStrLCHpIVIoVfk7PCWdj
	 fShKs8VUDGqsLP0Xu0R77qThXbo8lK46ztYDNyttlE4hh7656jJl+PB1wfMMg6TZXr72v
	 JX/782g4rVueDvdQV7bgQC9FAU3OUkrmAfG1toN4BPolb/HsxhtNbqEi09wO7VLI7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS1V3wVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA767606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS1V3wVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469BE1F00A16;
	Mon,  2 Nov 2026 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648973;
	bh=9b6IqD/xEfbSDE1yiPPADXCbKoWTJ3gOYDM3aWMSwi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LS1V3wVsntfGza7dMXp/3LqODRpvW7xuVhOLI427muR5AHTtygYlR4Yi59CeBfxrV
	 pHKxjSziMUf56S2SllQbl8hWqc+oc4Hx8KbnQocPYNcjMsI5PsLeHTgLvylVNofNpo
	 FRN6SMbDNjFtKF0ynKjpfNBgb95S4IlPN78LyT7IA/hnrHWrvsTl2nPgyVPiDP9s9N
	 c623SQjfMJkN2iAM6Z3ybfzB59aUPB56/xwJo9YVmuXEe+El8DNCZ1Qm+ecucxARC3
	 dc/LUJyzru0DHhCVsJuIhIhVgutxX5Rmq5vJ2D6Cw+v3KuxgeEYh5UmVcPRJn1w2M/
	 1/XSJwQWCOMew==
Message-ID: <sashiko-outbox-194022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] dmaengine: dw: synchronize completion
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-9-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-9-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:49:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-dw-=
dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com?part=3D9

