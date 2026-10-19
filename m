Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434C50E59B
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419017; cv=none; b=gUI31u59W0VhUwOmPhdD8vq1WjzGoGzCqFayJ6UXwEXeT9CwuV4Xdbk1dekfaEvKF+HmLTfTwH3gRoadbNNN+tEQnKnxePqXJDmcYNjEWqdFRh3A8Tz/3SZf/f3cca870evgx6yoPAtqLAjlMshzfw23aV6r6Mwe1UwfNKPT4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419017; c=relaxed/simple;
	bh=cUunhoH2O52jTJWEPh6GdkcneLFPcV6KnmROpd+u4rU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P3EtGahzYLRZHe43b/6dUh2aeml9WXrg9HQz9c4n8JMCH4Dxcup7XMrJiLyVh112w8zmeW1kTbSdN5i6UDC3XRYA6D3W6bpNiPSuSaKtxBq0a8YrLG+SYMcowOaxUiw33zEHSHoKlfJqexVrByGVx+sHG/p6XLeay3eF7r05w58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fse/kgs1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fse/kgs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A561F000C4;
	Mon, 19 Oct 2026 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419015;
	bh=fsmCzF9wj/+zjAVQAILRWVqMuR053rXc7FdkIBMC2uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fse/kgs1VKOc99QBrOmY0wp5Dju/VEB7xrNdiXPmEqhI5acEdfJKvSGJj+iT5AlfA
	 YX994hDaeTKtKtaymGGh6T1dOSS+MvEy/SwTFI3U711NHa/2pEm+A72Hftz97eJ6Rs
	 1LUTEhjpIRf1zT+DxSjCPkHco3Hx3K16T3XAbK1bPdp9QHf1HmCXdCj3n66OvV1V8u
	 Il2xNUfKxpEi7hSTD9ktHcriK8xyrmzFYt5ihIC/gBBKe8fjKfL6vMFMtRBwBc2HxS
	 il4YZVERiItK09dbhnxFsZR1qrQ6+w5hRSzaRyBQvfjv9bG/A8jrs/3NBsNZ/PG4gE
	 cvx8UR3R0AFyw==
Message-ID: <sashiko-outbox-177309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] serial: 8250: force synchronous probe
 for the ISA and PNP drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019135441.1420968-63-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-63-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:10:15 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Rahul Bukte <rahul.bukte@sony.com>
>=20
> [ Upstream commit 31e11af34e2c7cc61e25533ab877b1f9cc3eb528 ]
>=20
> On x86_64 defconfig, booting with driver_async_probe=3Dserial hangs in ea=
rly
> init. The 8250 PNP driver is put onto the async probe pool.
> serial8250_register_8250_port() runs in a kworker concurrently with the
> ISA registration done from the serial8250_init() initcall resulting in a
> deadlock or NULL dereference.
>=20
>   - Deadlock: serial_core_register_port() holds port_mutex across
>     serial_core_add_one_port()
>         uart_configure_port()
>             autoconfig_irq()
>                 probe_irq_on()
> [ ... ]
>=20
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Link: https://patch.msgid.link/20260610054130.2825182-1-rahul.bukte@sony.=
com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-63-sashal@kernel.org?part=3D1

