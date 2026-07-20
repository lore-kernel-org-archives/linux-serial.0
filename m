Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23E3859F5;
	Mon, 20 Jul 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577268; cv=none; b=pV+s2r6iKLOWTcj0IziSUBOXTFj71MrJ+j3QbpX/JnlPyHdNiwkC6juktEVRtF7v666mVCPI938KaRyusAYYPlh60gsfWwahPtdbaA6tCLLUGmpUGfOpQi8H9ZykbVIuEsGHxql7PjTLKqbt460Z28gd93MkKXK6QRwFI7/BTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577268; c=relaxed/simple;
	bh=gr++SKTsuiU1nnDtgqy68QOrXEpeYSoP7Oao7llCJJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aTqlnCm8vZNK0YjpzsMf5mKvOAPUAf3SqXZEH6dsq3SVt/f38nmT/nEc9dy0SbdZNd+qqRXdBI+0JsFCd5mEAiPLA6025z5d5FlSIw+Y/zLLewlINAH/WeOXPVTOcsgv5NtNFo/ZnPH2nBSiRwAH8lY/ETPgkh6pBpALSOtRD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=qnvVbGef; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="qnvVbGef"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=mg78F8Bjxia/BNADv+L6tDU1QYwOdmH4sHpEvCvjNFc=; b=qnvVbGefgzN1We8md4e49QuRgn
	PFYQTL35mNxNi8eB4LAnWQXkppy11KWZa/vyxXYP+Qjh1A1lueHfwVVBEvFs5f7SQ4dYLiGdsIpdg
	QP507zgydfzLOKAX7/cSfpRig0V6U4Z6bI+SNayKoCVIyJe1NU3reAtKj74YQFIKg3r8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wlu4F-0000000068Y-2xAV;
	Mon, 20 Jul 2026 15:54:24 -0400
Date: Mon, 20 Jul 2026 15:54:23 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thierry Bultel
 <thierry.bultel.yh@bp.renesas.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate
 from uart_get_baud_rate()
Message-Id: <20260720155423.3cb27b9d9479f4b7c6668713@hugovil.com>
In-Reply-To: <TY3PR01MB11346FBC3C68B5B970962FB4C86C32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
	<20260420140426.237865-3-biju.das.jz@bp.renesas.com>
	<CAMuHMdXQi7eSZg71=01dYjpmgHRXS+L9hXZMN_dR-mtM6sLKNw@mail.gmail.com>
	<TY3PR01MB113464AE43A23A0B69BCC5675862D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	<CAMuHMdUfGY6VwW09zQX8T3_JkRHwKGRUyNGRXvQaD4e58OV8qA@mail.gmail.com>
	<20260422100538.25c6a279ec46defecd8d9a4f@hugovil.com>
	<20260720114829.14dee9de11975bb46f3126cc@hugovil.com>
	<TY3PR01MB11346FBC3C68B5B970962FB4C86C32@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Biju,

On Mon, 20 Jul 2026 16:33:38 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Hugo,
> 
> > -----Original Message-----
> > From: Hugo Villeneuve <hugo@hugovil.com>
> > Sent: 20 July 2026 16:48
> > Subject: Re: [PATCH v3 2/3] serial: sh-sci: Drop check for zero baud rate from uart_get_baud_rate()
> > 
> > On Wed, 22 Apr 2026 10:05:38 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > 
> > > Hi,
> > >
> > > On Wed, 22 Apr 2026 10:59:23 +0200
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > > Hi Biju,
> > > >
> > > > On Wed, 22 Apr 2026 at 09:26, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Mon, 20 Apr
> > > > > > 2026 at 16:04, Biju <biju.das.au@gmail.com> wrote:
> > > > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > >
> > > > > > > On DT systems, a zero baud rate from uart_get_baud_rate() is
> > > > > > > not
> > >
> > > The fact that uart_get_baud_rate() cannot return zero is not related
> > > to the system using DT or not, so I would drop this "On DT systems, "
> > > from the commit message.
> > >
> > > > > > > possible even earlycon derives its bit rate from chosen/stdout-path.
> > > > > > > The zero baud guard and its associated done label are therefore dead code. So remove it.
> > > > > > >
> > > > > > > Also drop the unused done label from rsci_set_termios().
> > > > > > >
> > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > >
> > > > > > > --- a/drivers/tty/serial/sh-sci.c
> > > > > > > +++ b/drivers/tty/serial/sh-sci.c
> > > > > > > @@ -2719,8 +2719,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios
> > *termios,
> > > > > > >                 max_freq = max(max_freq, s->clk_rates[i]);
> > > > > > >
> > > > > > >         baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
> > > > > > > -       if (!baud)
> > > > > > > -               goto done;
> > > > > > >
> > > > > > >         /*
> > > > > > >          * There can be multiple sources for the sampling
> > > > > > > clock.  Find the one
> > > > > >
> > > > > > I am afraid you are missing that sh-sci is also used on SH, without DT?
> > > > >
> > > > > Ok, please share your thoughts to handle divide_by_zero fault for
> > > > > SH platforms on the code path after done label??
> > > >
> > > > Someone has to check on an SH platform (or qemu rts7751r2d) if this
> > > > can happen. It might have been broken along the road, as people only
> > > > use earlyprintk when debugging a problem that requires it.
> > >
> > > Geert: this "goto done" is not related to the earlyprintk block, which
> > > is untouched by this patch?
> > 
> > Hi Biju,
> > I cannot see any follow-up for these patches. My series for "serial:
> > core: improve safety of uart_get_baud_rate()" has been accepted and integrated, so now the renesas sh-sci
> > and rsci are the only drivers still checking (for nothing) the zero return value of uart_get_baud_rate().
> > 
> > I plan on sending two patches to address only that for sh-sci and rsci, unless you are preparing a new
> > serie that includes it?
> 
> Ack. I am busy with RZ/G3L SDHI/USB/DU work. Please go ahead with your patches.

Ok, thank you.

I sent the first patch but forgot to add you in Cc. Here is the link 
for both patches:

https://lore.kernel.org/all/20260720195147.3630241-1-hugo@hugovil.com/

https://lore.kernel.org/all/20260720193411.3517484-1-hugo@hugovil.com/

Hugo.

-- 
Hugo Villeneuve
