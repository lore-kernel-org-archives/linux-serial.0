Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB14908CD
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453720; cv=none; b=QPcHVhFrnGikScFmsbBq4kFCZBWXRsnpcmje/0TqqaUFrH5N9sNA6EFBi6nfbX0qBDMR12xET4EQjFQ4xO48dl6iSBJh2ZsmVWHs4Z73jtKotZk0EGdFWZ85rSj3EajN6Cxu6k2ZFWWPoTTwiOZ7pzESLNrjWn4Nv+sz+3XiYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453720; c=relaxed/simple;
	bh=omLnCvE9pW5xnwH1lyUtWGpoxx5AhQBo+Jw/pFvZuKc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fbi9BU+ZAQtRmIUKylnOedN495uOKY3MZwyCOMm599Mwa0ftxTRd/OInCk4q7ijAMrSxmS2MdxBCRF1L0JarvnMWUvqvOFhh67UCzH4JNtnLygEFE+Z3a46P0WkMTzj92tNoL/tGLq7eij2uC1ew1hjqhcKQXeS+oHiLPhdwUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/6vbPpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/6vbPpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0391F000FF;
	Thu,  8 Oct 2026 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453719;
	bh=omLnCvE9pW5xnwH1lyUtWGpoxx5AhQBo+Jw/pFvZuKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/6vbPprINQri1SlzNSGKkl/jADUsT+jyXNyLnjvwAEptGRHtM1iU/9RMLSJlU7Dy
	 ETywBaGTHyNCTasvtG8szkwwubr9Z7UJR5/hbERdwMgRMjI2NsW+qwq0/rn3fiz1ti
	 LFyWNOb3zD2iiarYv+F2X1tlwPkkCqNg9FP3V5XNvGbY0n9iyCD52MXKjChL84dzub
	 kNayNADk/OaIpk+DEaO4pVkG4ffnmX3eezUPGQF3f8rsE5DPa9ZTVsLQEPaQOscuSt
	 4Lq7fxZdgm07b08dBXG9OGkzL+MzVSZRzSpPeNYJk85dCXfjTVWpF5rzp23uxGVg9X
	 TpNru8RRuBfEQ==
Message-ID: <sashiko-outbox-163978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] serial: max310x: don't power down the port
 mid-transmission on close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-5-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-5-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:01:58 +0000
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
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D5

