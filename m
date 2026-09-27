Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883624A21
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489568; cv=none; b=H+qq4YpykZD8Yeu6Fzy4EQqsf0RmUpma7Mkj+yKanC+u2WvET//jKWqGrB51x9S5Gk7Z7YH6WmNMvec4UTfV9b+zd8OcrI8PgqD2Sos+/pL41YXVidsfhru5XOqxWiMcLmYfCrKSMwK4qIer8HiM/D+MOpNzqFfZaFL0hUyg2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489568; c=relaxed/simple;
	bh=gtLoNiO/6lSxsRScB2wMOFSloItyhOipMNiQ3vdn4B8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5+hmJOp7/hFTY142N8xrAUjdX29EM/mqKMy/LUHWirzFDWwUJxU6xkJoUreasau7ecxPEz6oq20xlL0pRD8fJWUpol9Hy/R8dgTsF48XX/0y/xjJgksfYuZmHV+Exwukj+LGlpcX/CTr4yz/8PMuxGADz1U5lDhmg4MhMT92l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEqMG8/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEqMG8/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF51F000FF;
	Sun, 27 Sep 2026 06:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790489566;
	bh=gtLoNiO/6lSxsRScB2wMOFSloItyhOipMNiQ3vdn4B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEqMG8/X/GlAdDG5O/zz3Am6XctBdbcCDOn7mGWwGrPEaSckTCUdYXaxZleXbGowv
	 D0RBAtMCpXDzSf+Gf8/xMf2cXKBvqEV5TiGWDjz8Z5dKmyycRElV+/0W5E2p9Xfa/G
	 +yErfx47uqz2G0yLMa6AjX4y7dJLqDZnu7mDAwEDj8wvshuJQjdmxXrxSNaKyk3/7a
	 5mdaUWoaqLYf9202ehEVxHaDoHH+EYG2VGw11KCGBOBpKJdmOS+NWWDFJEPBYRShEo
	 wUOmjxcPxwvJ2zydoF4H6kqqsWPR9wJHvwvQs9EdtnjUbS0jh72fiFyHruF0QpKAGR
	 D3uL2y7LzfYfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] tty: serial: max3100: shut down timer before freeing
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260927055957.561030-1-fanwu01@zju.edu.cn>
References: <2026092346-sizzling-dallying-a3c1@gregkh>
 <20260927055957.561030-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 06:12:45 +0000
Message-Id: <20260927061245.E6AF51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> max3100_shutdown() stops the polling timer but returns early during
> system suspend. If the SPI device is unbound before resume, the serial
> core does not call max3100_shutdown() again, so max3100_remove() frees
> the port while the timer remains armed. max3100_timeout() may then
> access the freed port and re-arm the timer.
>=20
> Add final timer teardown to max3100_remove() and use
> timer_shutdown_sync() to prevent a racing callback from re-arming it.
> Also free the IRQ and destroy the workqueue there before freeing the
> port. Keep timer_delete_sync() in max3100_shutdown() so that a
> subsequent open() can re-arm the timer.
>=20
> The workqueue is created before request_irq() and destroyed on both
> request_irq() failure and normal shutdown. Its presence at remove thus
> identifies the IRQ left registered when suspend bypasses shutdown.
> [ ... ]
>=20
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Cc: stable@vger.kernel.org # 6.2+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927055957.5610=
30-1-fanwu01@zju.edu.cn?part=3D1

