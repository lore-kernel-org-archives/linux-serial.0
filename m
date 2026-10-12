Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B938F922
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815656; cv=none; b=Nyn1rNvSOlnvBM8gzz6y0eCckDvk96u6wGJzK2hx1Ui5VuJkE9zskZ1kQHr41F3pzqia5OOpXTodOs01DnHSzmN6y4zqzu8sMAbIMpGlf1FXcy0agqEvZtNttbLuIbN/lfn7UP4hRbEuyO/wcz+N0NXJ3g6pUDqpAGFNnpUE1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815656; c=relaxed/simple;
	bh=BEmyzAX6+xZ3O7rFrQuUX3fUgwJwrkMiHk1+ELZ+x+U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RnklYgl/lyOqS/XSAUNuCRFu+Q7EezI+bBrLBQWzw3haSw92PtSwQDZIc06ZY3wX4OPl7eEjAJRXcaGMsx3lT+StuE7zk45Byw5lr5VMShKzsnxKg6EmC030V02X6TpjI9POUrcipEvi+YYNpgdtXEcgMk81IG4Z/zQlScXuGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaS1/CdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaS1/CdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004F11F0089B;
	Mon, 12 Oct 2026 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815655;
	bh=BEmyzAX6+xZ3O7rFrQuUX3fUgwJwrkMiHk1+ELZ+x+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aaS1/CdJWpgR+lSPd65gWzEK5xDueavshpXtsDg7PtlbcPqoaXsaXG5MzZtL+Zk0H
	 43m86WHkvTlHt8torBOqJH/ACzmA3I97l6kAi6Al8JKNrl6IN9KuX3477Oz1rYZ/sC
	 CG/FCre6DnYPAXY9aJwI3Bu5R1dBOGJ6YO9eqD6zX47cRK/mrfUvK7jKp10bnG4IpD
	 nHx/IBbE9nzLd095ILdooOluqKnyt/+aZ2JyksZUjKQ64JeN2DBVUza2tPX/CoJ9Ig
	 3Xmnmyi86pHqCj9Mku/xBWO8Da+ZPzTmyOl2FDhhQweM3ZyStj8YyeQ5d6gWoqcjeL
	 xM1S2mCCqy3Bw==
Message-ID: <sashiko-outbox-168270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] serial: amba-pl011: keep transmitter enabled when
 disabling RS485
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de>
References: <20261012-fix-pl011-rs485-txe-v2-1-e9bf7d218389@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:34:14 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Disabling RS485 on an open port calls pl011_rs485_tx_stop(), which
> turns off the transmitter. Only the RS485 TX path turns it back on, so
> any later output stays queued and tcdrain() hangs until the port is
> closed.
>=20
> pl011_rs485_tx_stop() also checks only the hardware FIFO. If a DMA
> transfer has started but has not filled the FIFO yet, the transmitter
> is turned off under the transfer and the DMA channel never recovers.
>=20
> When leaving RS485 mode, cancel pending deferred starts and stops, leave
> the transmitter enabled and start any TX that was still waiting for
> delay_rts_before_send.
>=20
> Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-pl011-=
rs485-txe-v2-1-e9bf7d218389@tipi-net.de?part=3D1

