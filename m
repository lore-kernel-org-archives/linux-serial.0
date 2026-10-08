Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F54BD346
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472597; cv=none; b=AA4qOeHxfzrwp2VjJabkTrf8maiIb3e4aA5sN/23ntfKy44BZR0o+jooCIz7yQpfyj7Qh+dl4T+fP7naQhT203Qm3GGx5V2NXCjsTh+JHKhqAqyPi4ot649f8MiF3DwGpGb1rvJcS8UKd/uj0hF5T53Tc9xiULDiQXST2P/ldns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472597; c=relaxed/simple;
	bh=x4dpvfkwvrnHR8Rzm0Q7/Ifa+pA8HrExzMJF8cfeklI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Wa06G4Toj27VCQk7oRCMY2GZst7JWaBlXXSqcy8oiJCdeBWCu5KsFdGSfKHoNAL/I/Y/6HWxBNHrjeyrU94J8881G2fDrQk752jJpcoUm2ok6HzROjXyOU/p1ds8V8p2PUiJV1dIp5zrJsgFNa0DJtjH0cSPDxIwiDcNulQBk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HetVWDFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HetVWDFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4181F000FF;
	Thu,  8 Oct 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791472591;
	bh=x4dpvfkwvrnHR8Rzm0Q7/Ifa+pA8HrExzMJF8cfeklI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HetVWDFiji0mXEpjDM5vES74o2JQeCSYgfoN3pWshD4MlGC2i2eJy07Q9nxnfXic5
	 IGhuRr7AfVIUlUy/+f2GmZ/gTXzx6Q3fBEaEunr6P4/I1+fecSEmXVnsemmNVP9asH
	 kIhwhmZC48Q35pGBnXg2Qf1mEWvM0VNpR/WYqQ8nwv13/B6ti/t5aeWY/D91DboBDm
	 GrWlPrAzpzIBW2Bz83QKQPV6Hp6RLGTbmFQptVNnng9bER+3UW0yutd9MaaiJkyO/F
	 waBlh1ao0x1UtJzT3NNaglSO5lZsPyw12Baa14WiDjxJlEIpn9mTg+rd24B/YioXx4
	 q3XYwWjC1HhCw==
Message-ID: <sashiko-outbox-164332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on
 reboot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Mladek" <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008150852.8286-1-pmladek@suse.com>
References: <20261008150852.8286-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 15:16:30 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> NBCON consoles emit messages in a dedicated kthreads when the system
> is working properly. printk() tries to flush them synchronously in
> explicitly marked emergency context and in panic().
>=20
> Another situation where printk() could not rely on kthreads are the vario=
us
> reboot and halt code paths. They can be detected by the `system_state`
> variable.
>=20
> Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
> printk() will automatically try flushing the consoles synchronously.
> Also do not rely on printk() and explicitly flush the consoles
> after these states are set.
>=20
> Note that suspend code paths have already been handled, see
> console_suspend_all() and console_suspend().
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008150852.8286=
-1-pmladek@suse.com?part=3D1

