Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C6485947
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207263; cv=none; b=HdBLnpwas1ibBQJORfYGYkAP+vENm47emalx7UcOpBa4/jDWNfM37713Jent9ojfkYY3MA9g5SvtdB6vSQkdhzjJWCHZvAorxYy9OGmmHjqzQ1fbVyLFg2H2tzvTPEyOUpmrEsJBz0htrht+LqPa9tisz/ZFYWdpaIWYsCNdijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207263; c=relaxed/simple;
	bh=pPXLqgdeldR4L1AxacBcZ0geTXG5pdtm08exqN2P3Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gUTGj5j27kWu5eqd9BhD7vmzUQ97pK2hdTjID45iyZKT/yFay0/ra4hVt5Y9kpWG3tFTJmxybkPm/pp1PW/y2kcG/Sr9nA5GicCZy+vttGMAcTgC+nVfN3d0S8UjIIQnSR7ceyGRpSjgPevhP99QcdY6zpJ8SJaxu3eJIVuwi/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3wIdCij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3wIdCij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B21F000FF;
	Mon,  5 Oct 2026 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207261;
	bh=pPXLqgdeldR4L1AxacBcZ0geTXG5pdtm08exqN2P3Hk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3wIdCijbCwkpkEKwRMwl48EEK4Zc6C9sRj9Q/k/RocbdMCny90Lbx5dNxQrSCxwg
	 hW/QEKc1yjVKv30p/Nns/P6vvyxMDjWfiEFicOzjKRlKQWJR42KXcrh4kAT9wjFpC4
	 CUgaeH0TuT+EJnOXZ95lDHWQ5FAdR6op9AhD+b9EEQizNKHY1vAPSHfGT5rlQ69sEL
	 6bPfPj5jtbr3/QTrTz4kiiF5/amVsp6EASm8G265ZHCX0rnCpUALdVMYjr77eS54H+
	 WTyDJ2KWwS2Pymz9ISKlhF5zjXcO6yZn04vkNM1JgBJTSMNhUpxax6b/c7Skjttj5Y
	 OSbJ/ZPq6cZSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] serial: max310x: stop the transmitter before
 powering down in shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-5-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-5-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:34:21 +0000
Message-Id: <20261005133421.9D9B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max310x_shutdown() powers the port down regardless of what the
> transmitter is doing. The power-off stops the UART clock mid-character,
> truncating the final frame, and on the auto-RTS path it freezes the
> RTS output at its current level: a close() with data still queued
> leaves the RS485 transceiver asserted until the next open, which also
> emits the interrupted character corrupted.
>=20
> Waiting for the data to drain is no better: the tty layer's
> wait-until-sent is bounded by closing_wait, configurable to none, and
> a hangup arrives with no wait at all, so draining a full FIFO blocks
> close() in uninterruptible sleep for seconds at low baud rates - and
> forever when CTS flow control blocks the FIFO.
>=20
> Instead, set MODE1 TxDisabl: the character in flight completes and the
> transmitter ceases with TX_ at idle. Give that character one character
> time (the chip has no transmitter-idle status), then reset the FIFOs
> so the auto-RTS engine sees the transmitter empty and releases RTS
> within the configured after-send hold; wait that hold plus one bit
> time before powering off. Abandoned data was explicitly not waited
> for, and startup() resets the FIFOs and TxDisabl on open anyway.
>=20
> Measured on a MAX14830: a truncating close() at 50 baud takes 0.23 s,
> RTS releases one character plus the hold after the last stop bit on
> both polarities, and the reopen corruption is gone.
>=20
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-max310x-rs=
485-sw-delay-v7-0-6ae392eca08c@vaisala.com?part=3D5

