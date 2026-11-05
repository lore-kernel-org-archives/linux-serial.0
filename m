Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912607;
	b=QORJPqPNtgfWWa/R5Bv12SdFJ+SB6lfJkUI/UFdsivsFcM6rkLCOZBh4LwPzI/hju4Qj
	 pQGQXm+qF9hd3ctvtSykDY/tQzlCtxCYdQSyhJRWvXy0H1jsVUosSO62jHMwAwJdcT5tE
	 injxxmBvSLJIOHLUOR6D0aHwxZ3UIjrHiU20vLK8lp7klaubwU32QxETtg5XUw9CUfvK4
	 YDu6WW5cIBEJz3n52PpxqVGu/LoaZ0zPMUtYFf1ShJqJjeWA5+XAThRiK7BVXDF8+HtYn
	 KTri5x+/Fvpdv3RWo9Dyz4096KHV/g1enDwm8Lc1w27FykYH8YpSDE7HJqTS3v7zcgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TCurcnxXoS4QUIzP2ICxGa0HEW8dxLBtQ45R5ce9sMs=;
	b=q0lA43Q48P50Yb0u73UcImSao7Y2+TfHUSTI0DQ3zW0Mim/FAF1XltyGgX9BN39G/WTt
	 8wOdVP9HwKjsoQGHYvgEcisydYUWhaYOKluQS83Udz05YfA2vH/J238Ud8yPSGooTdBcT
	 +a4rjKqPy41YomQwDT9wQcv55WSQpGj/hcfjJSQxILUfXhW/voV6yc+RnFaW5FRbdrao1
	 1Syeb15P7MuLf/VFyWXwjHVDAaFZGjpOf6xAtIyFBWhCJsLqbx3ueJ3KLufjti/V4Y2Uf
	 haRxQmVbb9TdXd54Qnm+b9DS687drAH4K9hRLzXNwLytkVA6RbxiOhEaZkClsCjbnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9m9rj27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1E606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9m9rj27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2733B1F0089F;
	Thu,  5 Nov 2026 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912606;
	bh=TCurcnxXoS4QUIzP2ICxGa0HEW8dxLBtQ45R5ce9sMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9m9rj27AEi/y/hAtcON2J2GtslT5tRraA89VBG9Cfxc/A/Y/B6n2jyAs54YfiCrs
	 mXi2foyrdQE5wEHN1YZIwnXv2pf5tCVKeN6l7rcWTmMEe0BObaP08ZmD/ew5QxE41h
	 99sZlq4wcS3TrcOXvf/9X12W6WaMmCUS7BeVOKzH1s+yCsoKxsSWp9MV15SUc+J8UP
	 iNIeJ2yNoCPxsoIXyvm70H0W3mPvnEmJp0LBDJ2hWzTZwRaOXC0hB24DhV4/geCR8s
	 28FagfzAF9j9C/kb19Xf+5h98gJu5A1Md0PPgv2/WKkAAgSgu3o/6IxfAmdGGWjOiK
	 muBdU4dkMpf8A==
Message-ID: <sashiko-outbox-200179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/11] serial: 8250: widen RX trigger byte counts to
 16 bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-3-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
 <20261105-submit-h616-uart-fifo-v1-v8-3-14024d2b184b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:03:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> DesignWare UARTs can have 2048-byte FIFOs, with receive thresholds as
> large as 2046 bytes. The byte-sized threshold tables, setter argument and
> sysfs parser cannot represent these values.
>=20
> Use u16 for the threshold tables and byte counts throughout the 8250
> conversion and sysfs paths, including the uart_port callback interface.
> Keep the FCR encoding byte-sized and preserve the existing threshold
> selection. The Moxa setter continues to validate against its 128-byte
> FIFO before writing the byte-sized trigger register.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-h61=
6-uart-fifo-v1-v8-0-14024d2b184b@gmail.com?part=3D3

