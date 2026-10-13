Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CE55295D;
	Tue, 13 Oct 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905628; cv=none; b=p3HHoboO8LxDQ7V40mvNF6bxKEUWw5gBF2ufrTbLtwp59itul7xqgI1JdqEvGj5GyG0+14R/wejgPjMzeFBkhZLO9ZmURsxLhYMrrOboO50xGnf5FsEZFrIW9WMNskbzWNV2fZ6KfidFmB5kPa9IvwqoqsEd3xzyEXDHkyDvVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905628; c=relaxed/simple;
	bh=qGQz6sPArVYSo+BSk0q0CONVWr+KQ91QOKs2TnXXq3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ruzqr9/6Pl8ioLF/HBtoMAK7+t7RIotdb96RrLI90Tgtn3hHtQrOT1DWoumGjCnUKP5ZIhkcNT2yCSPcJ68tcU/m0XDOZMadqeZ8lMXSAUS7DQppurpMImfLMQELERMZG+1S/jOKOuuR6eNO661NzmAAu4WCJxq4+rs8sy+3EUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mF+LRGP5; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mF+LRGP5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=S8bDuI3nWaw8+YqpdTH7mC2lIK3+yVOlUI6mv3/MWpA=; b=mF+LRGP5+RcPk0IBSb6wyX95+e
	WdC2SLJZtFYiFFfXogBtCW8AJ9cdOsSIN8oJ5x1x65hvteZ2Pa79sV2SeHPH5QWqfzDO5BU3rZYhF
	8a+c3iPxVhkXhMnfdOxkLmKbmfywcP6qLplzCcJQ8irVgkkrI9UEy8pzAGhiOQ5uyrvo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xGeVY-000000007dc-2AgI;
	Tue, 13 Oct 2026 11:33:39 -0400
Date: Tue, 13 Oct 2026 11:33:37 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: declare MCR and IER as volatile
 registers
Message-Id: <20261013113337.37ecdceaf63aa17572fa6ef7@hugovil.com>
In-Reply-To: <sashiko-outbox-162399@kernel.org>
References: <20261006192540.234402-1-hugo@hugovil.com>
	<sashiko-outbox-162399@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam_score: -2.0
X-Spam_bar: --

On Tue, 06 Oct 2026 19:36:09 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] tty: sc16is7xx: making MCR/IER volatile fails to fix bank-switch=
 race
> --
>=20
> commit d56a719b3706ed6ed6267916f8234030f616e7b3
> Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> serial: sc16is7xx: declare MCR and IER as volatile registers
>=20
> This commit declares MCR and IER as volatile in the regmap configuration
> to prevent potential access errors, as they share addresses with XON1 and
> DLH.
>=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index 296079c16fdb9..d6b3b67d17d55 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -501,7 +501,9 @@ static bool sc16is7xx_regmap_volatile(struct device=
 *dev, unsigned int reg)
> >  {
> >  	switch (reg) {
> >  	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
> > +	case SC16IS7XX_IER_REG: /* Shared address space with DLH */
> >  	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
> > +	case SC16IS7XX_MCR_REG: /* Shared address space with XON1 */
>=20
> [Severity: High]
> Does making these registers volatile actually fix the underlying bank-swi=
tch
> race?

Interestingly, I ran Sashiko locally but it did not report any
warnings/errors. This is a pre-existing issue that I will
investigate.

>=20
> If sc16is7xx_set_termios() holds one->lock and changes LCR to 0xBF to acc=
ess
> enhanced registers (like XON1), and sc16is7xx_reg_proc() concurrently upd=
ates
> MCR without holding one->lock:
>=20
> drivers/tty/serial/sc16is7xx.c:sc16is7xx_reg_proc() {
> 	...
> 		sc16is7xx_port_update(&one->port, SC16IS7XX_MCR_REG,
> 				      SC16IS7XX_MCR_RTS_BIT |
> 				      SC16IS7XX_MCR_DTR_BIT |
> 				      SC16IS7XX_MCR_LOOP_BIT,
> 				      mcr);
> 	...
> }
>=20
> Won't the forced physical hardware read-modify-write still hit XON1 inste=
ad
> of MCR since LCR is currently switched?
>=20
> This same pattern appears in sc16is7xx_tx_empty() where it reads LSR with=
out
> holding one->lock, racing with LCR bank switching:
>=20
> drivers/tty/serial/sc16is7xx.c:sc16is7xx_tx_empty() {
> 	...
> 	lsr =3D sc16is7xx_port_read(port, SC16IS7XX_LSR_REG);
> 	...
> }
>=20
> Does this approach fail to fix the underlying locking race while adding
> unnecessary I2C/SPI overhead?
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20261006192540.23440=
2-1-hugo@hugovil.com?part=3D1
>=20


--=20
Hugo Villeneuve
