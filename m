Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4848F82D
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453528; cv=none; b=cqH+dfeSCVCiUW8E43P/Y4Oo/WY8M+VMrFGBUlQCT+dcVUzch1Q5w7Nss8TvsXfjI66mKNAZM1PXdaBoqklXzFnwb3Sp5Q3hxzrSzXGtx3QbbKuHcHpYGjLplyYZjEz6iIHWs8clOzB4CeznTB1rMlTc3gN/bw5EWXxOsc57UOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453528; c=relaxed/simple;
	bh=r6O/O28kx6k8bBQCRb2DbYgUI5Y2BT1wCDiB9wsJDzs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V9Q6dOwuNNPEzoss8/EPXJ+9FUC4oZV/BY6h6EmOX+BJcKP388rDlEDgXFHoiM99GV2x7/5tAF5c2sG066HdACuP/qSLT87d4+sn6gc3/1XoUHT6grbjzVX8HJe0yd61rlYOVSrvhGbH/VIwIp7kQqrURZo1TtNmdVwhMTVlJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VajCLJMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VajCLJMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11FE1F00893;
	Thu,  8 Oct 2026 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453526;
	bh=r6O/O28kx6k8bBQCRb2DbYgUI5Y2BT1wCDiB9wsJDzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VajCLJMI8qumSwKoa+DyRR6xg4AEIksC6SiGu71ck8lIa3b+GcZR0kEv5A0f0zo0e
	 erUHSZx7dprhd8OBOy2Qfg0bvspXhZyyGY0Qi/XnUtlfDsnNAF9LlHeHlz6bD1FBrY
	 +ipjs+WhP9Td68Ym8kkqPkG9w1NbnehzlKnW1jIWUU9c3aPFJjsjyP+hEAsnYFj1+E
	 LANV8xBZFhG7KpVslvhJribaCc/QUlZwsLCvBrxZzpHXkyg0jrU1N/C5kf0qqICarS
	 2+GE/FH7Mtu/W6tJw8wbeOhK3SZi+ErqS4s2Nw/TstM9L7MALMFFSTf1gJCKPMvYhM
	 VreUiV7WO0CFQ==
Message-ID: <sashiko-outbox-163973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] serial: max310x: don't clobber the TX break bit
 in set_termios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-1-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-1-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 09:58:45 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> A TX break asserted with TIOCSBRK ends early, with no error reported,
> as soon as any termios change lands on the port: a break is a state
> that must hold until TIOCCBRK, but max310x_set_termios() overwrites
> the whole LCR register, and LCR also carries the TX break bit that
> break_ctl() drives. No concurrency is required - a baud or parity
> change from the same process ends the break just as well, and
> break-led protocols lose their break with nothing in the logs.
>=20
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the unconditional write here
> was the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.
>=20
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D1

