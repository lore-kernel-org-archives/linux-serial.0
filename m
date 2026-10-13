Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE5415F38
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855855; cv=none; b=jF+WgTv0t+tOqI9r/RyQAGV4TuYNwxoha3Bg1CoUozS/nyiepfuxehu3G4NhWSr4zJQZB/LhJTX21HI0L0VeZbStpvUjYA2rgoQrJhAzIrxRNrFuKMZdFyjIpf8jY7tzMFTEDUk0OcPAWhE/5iyUhzirUueX3sQ99Eyz3ku5c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855855; c=relaxed/simple;
	bh=bGVTJqzPWrlkb5npf2H7WSQ2PKRBnVqWJsPviU6o/ro=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Bl/91g+snWwLwxBEQD5iLmMkArF7KKv7SZzoWYuq2/rc8GjkKjTQVTsaJzP0wpldx9Tm2EMsHJ/ga3btRLJdLbxw0LUpMI+9mQtY9zWLKFgZVJZneE126vUSe8YkZoFdp7DpAxrULskR6UsgrjByGnoLqRfbHp4M3Ub5T8FHgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wib5htC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wib5htC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1F1F00893;
	Tue, 13 Oct 2026 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791855854;
	bh=5ofcr14dhsxUvgPOeZGTziOTEESV5/xQMLh705/EpHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wib5htC0Kc10wcDlwJshntZKxAf3V8tV4AmQ79bCs9q1tg3yxATRp5KIKRqpSc4Ir
	 JhhQSVarUpparqgUR1hrxW9K8q/nHmCPDEyBgEj3Ey1Y8wU2Wb7LrtefYpDFJhvydA
	 xtvvSiexGkQA/qSNaedCWazwlf3lWBkAJUP7HKyp+fvz5P5VGyocQbUJCAELO5fD/M
	 5ud7RRIi6jU3LR9A6z+sr3rMoGjaoN+gD/mPUBtt8dt7PINR9L+BKokOTiHB7mPKSn
	 IzOOzUT0k9/IVlqwD1LO9/vPwt36pntLmSECgEnqarq0pPfh35dmaKKp1scc5UnfRX
	 LqHIM5Lh1tPDA==
Message-ID: <sashiko-outbox-168837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: pmac_zilog: report received breaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Douglas" <me@timdoug.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013013541.4535-3-me@timdoug.com>
References: <20261013013541.4535-1-me@timdoug.com>
 <20261013013541.4535-3-me@timdoug.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 01:44:13 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: serial: false break injection on NUL after Rx overrun
--

commit 009d6cf5b2db60250bcc44251e6de09814cc2746
Author: Tim Douglas <me@timdoug.com>

serial: pmac_zilog: report received breaks

This commit modifies pmz_receive_chars() to set the BRK_ABRT flag in r1
when processing the null character that ends a break. This allows breaks
to be properly counted and passed to BRKINT, PARMRK, and SysRq handlers,
matching the behavior of sunzilog.

> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zi=
log.c
> index f49d6052d11be..a612f1db9f189 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -233,6 +233,7 @@ static bool pmz_receive_chars(struct uart_pmac_port *=
uap)
>  		ch &=3D uap->parity_mask;
>  		if (ch =3D=3D 0 && uap->flags & PMACZILOG_FLAG_BREAK) {
>  			uap->flags &=3D ~PMACZILOG_FLAG_BREAK;
> +			r1 |=3D BRK_ABRT;
>  		}

[Severity: Medium]
Does this code risk injecting a false Break event if an Rx FIFO overrun
occurs?

pmz_status_handle() sets PMACZILOG_FLAG_BREAK when it receives an EXT status
interrupt for a Break. Then pmz_receive_chars() waits for the associated NUL
character to clear the flag.

If an Rx FIFO overrun occurs and the hardware drops the expected NUL charac=
ter,
the PMACZILOG_FLAG_BREAK flag will remain set indefinitely.

Since BRK_ABRT is now artificially injected into r1 when this flag is final=
ly
cleared, could a subsequent, perfectly valid NUL character (such as Ctrl-@)
arriving much later falsely trigger a Break?

This might cause dropped data or trigger an unintended SysRq. Before this p=
atch,
the stuck flag was harmless because it was cleared without altering r1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013013541.4535=
-1-me@timdoug.com?part=3D2
