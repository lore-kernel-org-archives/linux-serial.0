Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E03F1071
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453879; cv=none; b=NNZD3vNcuqjgJJh42uX6G5a/iWUW77Zo6FhAvBw+EjPFm4UeAt6D2P+PCmRQfk83tMUJyCpb1m3J4+69S5ZmFjraJRfzq1IxwlcRSDcA1pCYmPU6NhkyKlAbOF+RL5QNsb0O0n4BdYk6giZA0TMBD5bcYKvYvoWOHobudLd9Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453879; c=relaxed/simple;
	bh=zUSHjnhsf5dUtsYY2ARxIaT05s0HKjP8f+VRZEJQldM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qbsDviUar0X7rIH//gvNppP24A9ceEQi/lq5rOq/7qWZM0LsPIizl49hMR/EreXldDbe2T6GVPKaekT/WQtu6LctGTueGK8B2b6n58uiIG++/ZNRVwL6rgWv4YmgBnNF9JksX1hFohpQFQGZBYbc3xH66Y6pggtLQhyy+Et71qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5jxY28m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5jxY28m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEBB1F000FF;
	Thu,  8 Oct 2026 10:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453874;
	bh=zUSHjnhsf5dUtsYY2ARxIaT05s0HKjP8f+VRZEJQldM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5jxY28mvpwO4X+XwWhjI7vCZ0Qgny4DZXIBwaVbxWG7ccxeyXmFjm/wLJlYbsFkv
	 MP2vVIhV4x4NRv47WEE4HcxFoFF1W+pOdUuQRqwZ0W/pc/0DKLTaFjpum7j7d32dIA
	 XO9SIOXsmEidDGPMfUUoPVWtCJVNW7+++K3SZ4D7/QEHSXBMzuRHR6WxFi+Fw2Z6Uo
	 f3PGP4XJXW8muHKaKNq6QulGZjYDjkY9RElaLdANrW0pKxQqUJWqvXDe2efCCH5Hqo
	 uQHUBKezIPIS+Y9ZplFZG5jmkTW0uw6lMAXGOch5TuCdJqplkrHaEfoGJD/sLbNSGk
	 VVbu6jkS3QzWQ==
Message-ID: <sashiko-outbox-163988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/9] serial: max310x: centralize the RS485
 transceiver programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-3-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-3-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:04:33 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The HDPIXDELAY RTS delays and the MODE1 auto-transceiver enable are
> programmed in three places - the rs485-config worker, startup() and
> break_ctl()'s break-off restore - each with its own copy of the
> register sequence. Move the sequence into a helper,
> max310x_set_rts_ctl_params(), together with the tx_break guard that
> keeps the MODE1 write away from a break in progress; the break-off
> restore reapplies the current configuration through the same helper.
>=20
> No functional change intended. The copies differed only in that
> startup() clamped the delays to the 4-bit field while the worker wrote
> them unclamped; the helper clamps, and the difference is unreachable
> while rs485_config() still rejects delays above 15 ms with -ERANGE.
> Break-off additionally rewrites HDPIXDELAY with the values it already
> holds, a no-op on the wire.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D3

