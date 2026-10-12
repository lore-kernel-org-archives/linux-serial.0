Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976A23C51D
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784952; cv=none; b=RLYiGjsNvGy29JHFp7b6gjR5jPToKweVEebuF+cM6q2ylsW/p/sgSFjAu2dkdgvl/NrmIsLNNxNnVwVuFJrtJZ9DSLYBZbL38ukPhJnpbkIZWjRLO4nzlo81qLc7rjNsHYoN1JcIC4wdBmeO7A8Jh9QcEFKjm9Kj8YUOCS7pIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784952; c=relaxed/simple;
	bh=fdTNu9I64q1rPz5PtG2mONYFYyzHK3nqJyo98oljOhY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aX4Tmx1ZcvOUEN8Ynpyu4wLyPUvzX79Yg3+bWH3C6XC9xBf+9XOcpsqLWNKTrSohGL5HL/h5qjIjfJIndoFNEaiLWLhrhNUMzcIX7C1f+2MHmsSDm1jgiBCPIDhi+5MhKoOujfEaulFuRPuXqr9cnZiPMie2SyXPTpkOf9Fj4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6R7OhPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6R7OhPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F441F0089B;
	Mon, 12 Oct 2026 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791784951;
	bh=/ZDZtpKoS0wSLtWA7gBXCW9c06QJJ334/cN7Okyt1AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6R7OhPzpwdQsErnI00/gVlyyMgi5Gnypii7tr9/e++XbzUeREzhJcvIJr++KjGaH
	 B63/AStHpuBcJo5NEvvCExvzrW+d346K6nUIg37ySdHEeuutf3lm3zNHYyfeGRyxSW
	 H1IhCwHk3GeO1JqA4CE5nJVTTouQuzElnsLNlvr+/mNzKgBMzqY0MmY++NPJVKPwJA
	 dU0m4VDf6A4gVtlQTXO01PApy58pbS4tQOFVog+rny4Oa727sisRyHcLosfxjmhu5Y
	 VN6LWMz3BUlzycmMZiziwgdZhTEX4NAkewpq07qPIIsKWWEwSBaelp9TAoPPNNj2bx
	 tGQEifbl9toXA==
Message-ID: <sashiko-outbox-167697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: ma35d1: Do not force-enable an unselected
 console
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012055340.16719-1-kmehltretter@gmail.com>
References: <20261012055340.16719-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 06:02:30 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> When another console is selected and there is no matching ttyNVT console
> argument, the core accepts the MA35D1 console without calling its setup
> function because it has CON_ENABLED set before registration.  Its index
> remains -1 and printk repeatedly reports an invalid port, flooding the
> console and preventing boot.
>=20
> Let the console core enable it after successful setup.
>=20
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver suppo=
rt")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012055340.1671=
9-1-kmehltretter@gmail.com?part=3D1

