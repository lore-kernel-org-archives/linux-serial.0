Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7618C02E
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786269; cv=none; b=kAqX8BXdR0WZFeOHtTLswLJZzsfTbxRF/39KZiiXnHMwBG5haMqAAVm0LbCCyBPdrKX9mXtWmld8PFUO1jP7WbB0Tj4Wb5cLG0lzvAlY9wLyl4THT1Tdue4NDkmbrFu14HSx+U9bzj+GNYSdACvQOGuIhmuJgi8ailOrKKN7cLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786269; c=relaxed/simple;
	bh=SMeKbHqzDN6Y93uUCRWk7BnQzLkmRWkYn20lhxhb0NU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l//qVpbgUo9/5IEzzIb0w76e4hQFL9V7LjKebnvxowfFia3zDWxUFS5MXd6pdFSJkd+ViP2mnDW1raE6AO7t+6T4jBCKgt0xtSCERb0L9tTJ4zYSft8Nq7zfbxJaPZXq25NF+uC/c/UqUHVmPGbb5MGc/5kKPeWjssKkqtCQ1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/D1ANOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/D1ANOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A1E1F0089B;
	Mon, 12 Oct 2026 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791786268;
	bh=SMeKbHqzDN6Y93uUCRWk7BnQzLkmRWkYn20lhxhb0NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n/D1ANOEa/VisflhF/iuWbiZAPV1oG6hUlaeN50I3STo4a5iXvH788lpVKGfBUwuV
	 BsBvqMJNiBwfKKZXhzA4/wEYzEH998WJ9aYXzLOJid2jMb0ebt40dsU+DhnobcBZ0T
	 YEPqV5b0UobAeK84C5ZTNYtY7XyDxuRjjQtuqS6VBnY04JAxkmleXrEmopsy+pe0d8
	 cTswh8lGjaZPGyWg0GgDcUFj5GQxScP4nG6j70JT0PQUSUVADWTl0iV9hMXMV95byl
	 PZuH4dcXxeXOHQbFXJyLQsTgE6N3SEkCP6S4MlkCbFdkRZUfpKZbLulog6VuWBSxMW
	 2GNZACyxKnXvA==
Message-ID: <sashiko-outbox-167730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_dw: retain programmed timing for BUSY
 waits
Reply-To: sashiko-reviews@lists.linux.dev
To: khaliforce <kforce@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
References: <1791785420.8010663.945898876521967.uart-busy-frame-time@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 06:24:27 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Baud changes update frame_time before the programmed divisor changes.
> A switch to a faster baud rate therefore shortens the DesignWare BUSY
> wait.
> The wait can expire while a frame at the old baud rate remains active.
>=20
> Use the programmed frame duration for FIFO and BUSY waits.
> Account for UART clock changes.
>=20
> Fixes: a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
> Signed-off-by: khaliforce <kforce@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1791785420.8010663.=
945898876521967.uart-busy-frame-time@gmail.com?part=3D1

