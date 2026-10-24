Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824333;
	b=tBgD/9u93FeWx0dCvAYTR4Stmg+FT4Xzjngk7MB+yqUOA4gGOFhBUx66uIP7jcirIl7T
	 d2XSlHPcnu23YT6I4IVdfiBIoZyv4gmvF42g6B2BUyC02unXOgMF6YsQm107g4EN0GtV/
	 GE3t68Elmka38qPktvL0WUcrsgq4JJKFAcac+yjv2UkW0Fdo+E8UkCpE6SGpBLBsEfFTB
	 nLPewOVASDpatVrb4RS03fT9pdto4c0LaNVNjGvcXwIXnxLjAOWiKJk7+HcSCUC3HDlbp
	 wuvHNGBbCg2zTVKvhNMx77jClsKOAqWntvnl7lILstipKyf4IwlphhyIxqRCefWUUAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m76ok5z9YcggRtNjGb/1qSMJc2ABGJN2nQcmfmeU2JQ=;
	b=S9/xMhY6dOXmzkAZcg26nN8yBqn2xGhB2eVDu5oy5bnVQh5Rg9FnT6w/HNGxGHo6l4KO
	 676NRddUfiwOOADFRj6+Iw0ZCmyG/RoUapMytZ77r7d+BMrahiKoRmOPD2fhif9PULM9D
	 D0p3kAnl7c8T0gWAmBlEbKK32hfRA/715zTYai8E7od8/fiI9l54ZAOX/Ae/NJkmnEKys
	 f3JFhD0uZix/5iWwdszZSnrGUOm/vKIk1iQj5jKhTlrJh1qleoK6DEtySUleRnoZrPwTo
	 o5Ak18En/NE5hsMOWCJad1NnGPskiIZBSVXyuu2mSe5lcqnZZ3Hfa8cimkdig5M/Vsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz2zkeom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56072606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rz2zkeom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F8A1F01828;
	Sat, 24 Oct 2026 06:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792824332;
	bh=m76ok5z9YcggRtNjGb/1qSMJc2ABGJN2nQcmfmeU2JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rz2zkeomFfsVCqN91M6uxf5ijGOZHawgGrmakApk47mV9+QQmxLYNi4SP22L+klpy
	 EyxsVAbygVjMNquGHr7lUypQgtpcEsoWvUdpKXkmYQyUSZKGDKgdysX6Nln9VWhl67
	 TecoO1eOeBpJOmSRSwrW2fyAp7ixcMIzRqJlGOO3QJqAeaEWvKBafCDE3cVbmthqHN
	 QyVWRhZfdQGCgtcu61YbWrGzwfMfUHJmmtlDbbSnJ9uCWUeh2ZeRT00nw+apirPVd0
	 i4RJxKMtJAFwwvx0pjzKTV4FcVLzEGq4s1oZlm1WygrVOXWpPtHub/vq7NCsDSHrtb
	 E24BotOW0GaXQ==
Message-ID: <sashiko-outbox-183572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] serial: 8250_omap: separate locked TX DMA
 completion processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-1-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-1-9e52968928d2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:45:32 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Separate the port-locked completion processing from the DMA callback
> wrapper. Keep the shutdown check and locking in the callback, and retain
> the existing FIFO accounting, delayed register restore and THRI handling
> in the helper.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-submit-ser=
ial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com?part=3D1

