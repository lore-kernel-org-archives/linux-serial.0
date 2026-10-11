Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD512AD00
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791750779; cv=none; b=S35HhGq0X22U2wjy7xJs6yZct8gT4sSQ0UgoAPUiZor+lGfhlQckEefHBLuLtbEKpYomgGzC//OAw67U9406hdu+v30jqLU7f8G+ZrCo3x0uPYhdr18zLfeS5lbsPTr+HxODvrn1z7uJOBAD5B+Iph5rTtXv4aEV7plicYOteEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791750779; c=relaxed/simple;
	bh=YChLvPC6VsICt3nqGzRj97p3ru8MgGqXhtbHFkpyibY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Oy4SWBzT0/LqRYJb8tiXQdmVWVVo4J6raagx6KJWvTCiRTM6LIyaKNR3HoXUQT27j0Zuk0kYyiDGagn45Hd5m83t3FGZ0ZlEI2Cy1JYEC5h3NITj0fKxmR9Q0w2WuGOAJp9Y3FKNNTRDbTlbFYMueQun0UvarJmZ+htmdUPa8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+B4A2re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+B4A2re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DDA1F0089B;
	Sun, 11 Oct 2026 20:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791750778;
	bh=YChLvPC6VsICt3nqGzRj97p3ru8MgGqXhtbHFkpyibY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+B4A2reRi8B/eERZSJhQt0QHykq8m//8kYUjH0wySv9MYTSd7ftiN+vJjPaCkLb8
	 vhbeY6ZSyXurrw1ti+QhZUr4hxyfew0x+oR1Y4Zm5IK69M4R+tnH4L+PNCHWOjE+ck
	 jTm19jIpNi6pVfD7+fgser1z/GsWlHsddW+JjOxLVFZzIlCscXONT7a6iIFFPHng6B
	 Xv579VsdBCEeFC840Px9fOaK5wRTGqwsw/tee1xaXNMOzgQk0ROzFlI3sZXe/irwVz
	 jLmibEvITpss2Wb1qDTzqRNecQrxSNtHLqERuE9OIOr5txyv/xTnGkBvHD59fT2rrI
	 pGECCQIIYZaLQ==
Message-ID: <sashiko-outbox-167455@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: amba-pl011: drive the bus during break in RS485
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de>
References: <20261011-devel-pl011-rs485-break-v1-1-62ff402378c6@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 20:32:58 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In RS485 mode the transceiver is enabled only while data is sent. A
> break set with TIOCSBRK therefore never reaches the bus, and protocols
> that start each frame with a break, like DMX512, do not work.
>=20
> Handle an active break like a transmission. Enable the transceiver
> before setting the break, after delay_rts_before_send if one is
> configured. When the break ends, stop transmitting unless the TX path
> is still sending data.
>=20
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-devel-pl01=
1-rs485-break-v1-1-62ff402378c6@tipi-net.de?part=3D1

