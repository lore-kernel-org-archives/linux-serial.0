Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B5470437
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798475; cv=none; b=UUm/maQXTkZgM69ITQjUmoBgoZjExR5mGMyEKphi4nxX6kW0zXMQ7narrOnP9kbQ9EFF0nwlxnPda9kF/w6IO+xAuUJLm2OjgiX6i/Rb5hy/JpeJ+j+qFTyFe3shPO6cHrmtS7Rh0267uWIyJFrMUhuK4+Hj1An4vWhQSS97COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798475; c=relaxed/simple;
	bh=xhxsHeQ2MkO8iexLy2Hna/8YQVsU7lWJEJK88VH/tCw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f+o6L2HCA/iG2On/G7/AuK/PrYbo3rMflRC25kIyAwvg0BXt55lull+LAYIWZzfP8VSuO20WWbXJgXvzaclbJ5UTuns6WaDcF2otRW3f2dUJOCA4jkmbbfCfo15SC5tm/JG40ln1BBn5bjYPv/oH1oDlGHGM34GhAamBwlqRezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U77C62LL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U77C62LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9818F1F0089C;
	Mon, 12 Oct 2026 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798473;
	bh=xhxsHeQ2MkO8iexLy2Hna/8YQVsU7lWJEJK88VH/tCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U77C62LLu6MlnvdNJB22oruiVi/lrpc9O1f120uyI2UZczYbku1Z3WhoTa7NhSvlD
	 B/5UkGxtHQL/xoTVfMOH6eRSr2KLTe8J01ikzUKEb7Ck3qbWYkfCRAJMmb0dUPYz90
	 o+vpvF5xMzJb+MTtAxjTLC/6EvSteJU5YIP/xNzVwnHT6XeZ1sSYJMkFPqnqoKEHcT
	 WQzR9nx1wCPzlZWFds5Vc5sSx8JiUij/9DKIRbvWUa+5X4m4V351y7HO/H7t+ltwQv
	 OINQBt5fT34O2ioZufXhGdk8krmgA1yKauW+0Twnu8SgNsqx/k4WTCvFr7bLH1O40Z
	 Y8HLPnqRVFskA==
Message-ID: <sashiko-outbox-167905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] vt: Distinguish between blanking and VESA blank
 mode in con_blank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012094114.38549-3-tzimmermann@suse.de>
References: <20261012094114.38549-1-tzimmermann@suse.de>
 <20261012094114.38549-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:47:53 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The con_blank callback in struct consw encodes blanking and display
> blank mode in a single parameter named blank. Its semantics equal
> the FB_BLANK constants from the fbdev subsystems. Yet it is of type
> enum vesa_blank_mode, which describes VESA DPMS levels of the attached
> monitor. Although related, this is something else.
>=20
> For this reason, calls to con_blank fill the blank parameter with
> values that appear non-sensical at first. For example, to blank the
> console, but keep the monitor on, vt passes VESA_VSYNC_SUSPEND (eq '1').
> This is because consoles interpret '1' as pixels-off-but-monitor-on.
> The constant VESA_VSYNC_SUSPEND actually means monitor-vsync-off. And
> the argument used for monitor-vsync-off is VESA_VSYNC_SUSPEND+1.
>=20
> To fix this by splitting blank into two parameters, blank and blank_mode.
> The new blank is a boolean to control the display blanking. If cleared,
> the console creates display output, if set the console does not. The
> new parameter blank_mode specifies the VESA blank mode for the monitor
> and equals VESA DPMS levels. If blank is set, blank_mode gives a hint
> to the console, on how to set up the signal to the monitor.
>=20
> The actual interpretation is up to the console. Newportcon and sticon
> only handle blank or not-blank. Fbcon and vgacon implement blank plus
> the VESA DPMS handling. The implementation of both consoles is again
> somewhat confusing because types and values do not match. Clean up
> both with the new blank/blank_mode logic.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012094114.3854=
9-1-tzimmermann@suse.de?part=3D2

