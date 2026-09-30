Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BB37AA95
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742120; cv=none; b=jsGmRNaInjKdSRdyjgSSPu2wWRtKqO2Tp99O8us79GtOXoFg1QW5PAjsk8g0qkSX9qFi3tPXtgj2cBTAFg0nQxhNMDcKYBY1XSDUMnXzTSZQr2vwQYLQq0TodvckgKINZODFL9QCEUmIrWMfr6Oa+5n/PnZ2RdGihk9gvsMHUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742120; c=relaxed/simple;
	bh=udVpdmlwY4/8IURdRbdteLScex2xSwHFnneYNfNjHZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4btPnPg1Ooi5nqhp5ReBaZbYisA0tlrmz/TOV8XK0JIpV8Ek89bJ/69riRqAjsMzUNxcI7xh4N5O2/1Pu6WA3qBXfL8Gq/X9TII1CnAI5wzKvT9mdnQCFBiP0VlXtC7EIccDpzcVLmgT9qw0V1pIyWLICtAweYLtiey7rwvcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9WQjNkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9WQjNkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BBC1F00893;
	Wed, 30 Sep 2026 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790742118;
	bh=udq6V89QmPXqCxFyET+zjydmbR1Fw6R8c53G8By0xTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9WQjNkVKfCrs17NNOR3MeKt0Fks4gE9Fv9Kd+Qw/rWEzRJX45Cb53f0PLZiuYgOa
	 R7jN+O1tozftis7jCi8bQAjZVBSQF4cwbeqYkBva2lKMnmAgGQphd2nEAVneUq1d3K
	 Tr9OPjak/bUlxsIV8O7tiTwDr2fTzjFQxzDZLVoyFSLFzKUmsabEp4vLMPhY4mSRi4
	 0f+2L5MD0AFaQgNu4dOHVl1W7foaJfarj/FV9Zg94BTJPIm8vqed0HgMN11PeoteUu
	 zE1IRi100M/1uyV4qQaAjRO5cGidCzqFGJ6/O6t/K+/tn/+LBmklO0AEZoNDIAjRuM
	 Z/q4TgOUHJbtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930041216.155911-3-benquike@gmail.com>
References: <20260930041216.155911-1-benquike@gmail.com>
 <20260930041216.155911-3-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:21:57 +0000
Message-Id: <20260930042158.50BBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In uart_get_baud_rate(), when the requested baud rate is out of range
> (try =3D=3D 0) and old is non-NULL, the function copies the old termios b=
aud
> rate into termios, sets old =3D NULL, and continues to try =3D=3D 1. If t=
he
> old baud rate is also out of range (for instance, after uport->uartclk
> was lowered via TIOCSSERIAL so max =3D uport->uartclk / 16 is smaller than
> both the old and new baud rates), try =3D=3D 1 clips baud to [min + 1,
> max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
>=20
> However, because the loop bound is for (try =3D 0; try < 2; try++), the
> loop terminates immediately after try =3D=3D 1 without re-evaluating
> baud =3D tty_termios_baud_rate(termios) for the clipped rate, hitting
> WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> (Oops: divide error) in uart_get_divisor():
>=20
>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x1=
36/0x260
> [ ... ]
> Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always re=
turning non-zero baud rate")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930041216.1559=
11-1-benquike@gmail.com?part=3D2

