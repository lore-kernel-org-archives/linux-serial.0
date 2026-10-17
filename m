Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD03B71DB
	for <linux-serial@vger.kernel.org>; Sat, 17 Oct 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223475; cv=none; b=TDIXtFOsVNDBcSxiwSzNRc27ub1JMijZY3JqpWxLeX8CjolFy5U7sNOz2eHwDakFQucd5SIV4w25qw6Qpg3KyIVJik3NI3ZGmaeQpunDw9UFhJ4UG+PApb/cBhNXUjbgYnj1j+Ga5xwthhRzW/YrJFeWJ/5rg5CEKPp5UAbnJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223475; c=relaxed/simple;
	bh=EwWZuREwOuP8Pvfw7CiMNgeG9G4Ql6B0WBS1pFoRlIY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=S3TqhUfaFZFzagAtcxN2uhi5KBWL8PhbXTOdYcbwpohS+C/+TyhuUi8LkMd971lIK9jDMwRil6dYP5s7veYnwA7J0r0VxXwRr152nHqNNQ6f7D57FAj/A5nj7NvReJs3aVdhVynAuNYsmKxAPK6H1YGbLuKvMTgzULvpKM1tXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZNTAfiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZNTAfiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA92B1F000C5;
	Sat, 17 Oct 2026 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223473;
	bh=wOfBR8TkNgDEQZGyRq5h7IptjhuKtfiCgDcJgkE8Go4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZNTAfiwohb3qlzks+PyNyArRmVl0SqJ7Ic5LyJr/BTbKIVo4eCib311EA4HkGFVZ
	 hGx2bdb/tTChNM0rgUoVCygxriGhwyedppb3berM3WJqsdx7JPgJ3JDOdp4e454wee
	 uCqz9SCzFHLvnLi2guXxRi2GmdXuUCehUkHzmD1nQoZoS5PTJS7f3rv3pgt3agUAQ/
	 vsIBxGZCVilMrY5lLW8GmlTyO2v163bWYQZ8sQZ5wakDdnxN7RJAom3Ufx2FqXDtmk
	 SPg+sxGz0aRfFEHiWZtioJ/hi6h12w4oHw3y11qbFXqoryn+257TdkcY2FVdplNX0O
	 v8yefCnInrbYg==
Message-ID: <sashiko-outbox-175374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: sifive: fix NULL pointer dereference in
 probe IRQ window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Alba Vives" <sebasjosue84@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261017074453.62645-2-sebasjosue84@gmail.com>
References: <20261017074453.62645-1-sebasjosue84@gmail.com>
 <20261017074453.62645-2-sebasjosue84@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:51:13 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Sebastian Alba <sebasjosue84@estudiantec.cr>
>=20
> sifive_serial_probe() installs the interrupt handler with request_irq()
> before uart_add_one_port() has run.  uart_add_one_port() is what assigns
> ssp->port.state, and ssp is allocated with devm_kzalloc(), so
> ssp->port.state is NULL for the whole window between the two calls.
>=20
> The handler dereferences that pointer unconditionally:
>=20
>   sifive_serial_irq()
>     __ssp_receive_chars()
>       uart_insert_char(&ssp->port, ...)        /* port->state->port */
>       tty_flip_buffer_push(&ssp->port.state->port);
>=20
> so an RX interrupt taken inside the window oopses the kernel.
> [ ... ]
> left there.  Unwinding is adjusted accordingly: uart_remove_one_port()
> now balances the added port on the request_irq() failure path.
>=20
> Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> Signed-off-by: Sebastian Alba <sebasjosue84@estudiantec.cr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017074453.6264=
5-1-sebasjosue84@gmail.com?part=3D1

