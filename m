Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386987;
	b=lL3hoOb5T0sm4VOwwMaySAYpbJX8mMTf+6MAlIMMn5jogA5RJxPP29IqDSbPOEO/OIMB
	 rBHMDlgNIJ6QhCtq/RXWvjhIdXo2CTPnULgMHi29ghMjYQPHnzEnVKgvgMSw8V9socdoO
	 EMgHsikvvAldwwuqxwDRTDu+RIe467HnFNu4NmN3h/anuVuC6XhzI/k7vpmtGi0hivabb
	 htEgDO8+4zDuuXZPMFVPGxvBEvGKkEWB+LQN5fcxn+ztFfhuZQygRB90X4aaQq0IXCI+I
	 cAATXcabcGxEnobrTubwgBbjIszaqrWKecekSWTEwBtw9BHUpZoN8urt51up9YvWExg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6al8Jm3E6mhk0qJw3i0NxAfHn8a5rd9VCCJAjesgmzs=;
	b=F3ULV31qfPruSVq27s5vGD7t7uapdoDMq3xOeIVsRV+MHX7Z2lv6LTnWXMmz4W9Pv4sV
	 rGE21a5uhHuJmG1+s43QstjMjOIBWcHahhMJNxZX6FtwHvV3SxZqajPLGlYwdx5nd6MIH
	 KGit4FQ+QM4spmm12Oo+7TVcIS8fv/aVvXOOFBWK/zghZ+PXLo2yuaDaQMsff24Dmd8cv
	 TWrDPL3Y6GYCjtJ6NLPBqRfNXZpQTf1qv3SuiC3dAeafJxkLSFpxdHy1TwytlJWtBRGsy
	 MVLdSglpxIM9/LdmVDdF2nLX2ChiIs/bNyCo9Wo4dP2VvL6+7MjJoASEVNaPU7f3NwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CZLJJ/Rn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8D606A32E
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZLJJ/Rn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA371F00A08;
	Wed, 11 Nov 2026 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386987;
	bh=6al8Jm3E6mhk0qJw3i0NxAfHn8a5rd9VCCJAjesgmzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZLJJ/RnBtbtQKl3qC/k5+CiGhWSNaIKm56GO4ryE+YoqCTqpO0iEx8nLW8kqODhP
	 0Hjdes6FLHyP3k2OkmTtajBEcYei5+5xS4Ra8dHf/u6w3it3TPD0i8u01WhKX1bBSj
	 ylREmvZpax1RmjllIQENKCdLka/NJzlM6QuKzWaQgq5U7AtBvNpQ8XYRVkjqH//wq5
	 xNObu5t2FtRhmcLikkwy6wyp1C/lbNsZCYHWD9ukK+D8189uWnaQIY6E4DHbGjV8Nw
	 4wOAFNsAK1nib4NsDTLQ0VSYqEJt1W1QIjMbN7dgNRyuQs1RWZTN3nM+0qNBlioOSj
	 FDMGZOQcb3ajg==
Message-ID: <sashiko-outbox-208634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: n_tty: Protect poll input checks against termios
 changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261111084116.80897-1-zhujun2@cmss.chinamobile.com>
References: <20261111084116.80897-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:49:46 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> n_tty_poll() calls input_available_p() without holding termios_rwsem.
> It can therefore race with n_tty_set_termios() changing the canonical
> mode and resetting the buffer indices. In particular, the availability
> check can combine one input mode with indices from the other mode.
>=20
> Take the read side of termios_rwsem for each poll input check, as the
> read path already does. Release it before flushing the receive worker,
> since that worker also needs termios_rwsem.
>=20
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111084116.8089=
7-1-zhujun2@cmss.chinamobile.com?part=3D1

