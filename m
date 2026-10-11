Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3836194E
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750626; cv=none; b=JdWcjC6VaG/mA/T4yEK2M4hboknnbg7WTynqumm6+bIwTmaHV7YTi6J9k768VfTx0GFLXAuc+PUjAbfjld/hkpA/kn0cgjh/yMyqHGH/+DWQ8vj5EMd/So9EAnGgYWUQ0FEyM95dMIQtIAKs4YdvzBpu132oVWJu/dkbWC/+zMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750626; c=relaxed/simple;
	bh=eRHXhPAfCh8yvbeptToI9/K+EaqI9BXz9a1JzM0c23M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VkMcnCp6mSHu4WDiXaFqo3UD40NDXwL+0ndRUMk2kt3IoSFDyHM1xQfejV/BHWrIboVHiRCe2ZEJBfJPfZLAPErrurz2DZ/HBGvstCrw8LaCROw5wzqFydCP08r6KTTfKoJiV0I56C4vnjvyt8PVz6wXzRqoUUrnEUhhx8GMreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH/vPZVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH/vPZVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A691F0089B;
	Sun, 11 Oct 2026 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750625;
	bh=eRHXhPAfCh8yvbeptToI9/K+EaqI9BXz9a1JzM0c23M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iH/vPZVpXqGmxiWJ3t8DZNRTeJCypT7eKOfs4bWIC3LeB0KMKrceUtLflbYC9sQ3B
	 /0GcNkNSqHzTtooNbmGPkk2YEMEqf7ckkqBRSOqBGH+VXElbuZALLRrJpzNwO0OlSV
	 dvgYZcILSGgr7Y/ni1Ic1qj/zBj92dJo3NmdzE+IQUPBRseF6Z7LCy9dhs/RyCv+yE
	 jcknyf9QJD2R/5jJzBtIYyX0gC+BHOVorhn0TZP/tU2Midv+myzS9OiX8YFl7T4S8a
	 Wy8fLNHPFi2vKEuJ8pwRflabuIg8gEGNhEkH9rpHkU6DUt8WKZYQhqDLE5y5zFGwLt
	 UhNDZx2el9t0A==
Message-ID: <sashiko-outbox-167451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: honour delay_rts_before_send for
 every write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011-fix-pl011-rs485-rts-delay-v1-1-5078e61bc408@tipi-net.de>
References: <20261011-fix-pl011-rs485-rts-delay-v1-1-5078e61bc408@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:30:24 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> While the driver waits out delay_rts_before_send, another write calls
> pl011_start_tx() again. pl011_rs485_tx_start() then switches straight
> to SEND, and the data goes out before the delay has passed.
>=20
> Leave the start to the trigger_start_tx timer while it is pending.
>=20
> Fixes: 2c1fd53af21b ("serial: amba-pl011: Fix RTS handling in RS485 mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-fix-pl011-=
rs485-rts-delay-v1-1-5078e61bc408@tipi-net.de?part=3D1

