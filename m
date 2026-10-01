Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4453DA5A7;
	Thu,  1 Oct 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843986; cv=none; b=QJ2JGHKG4oQcSI5K3ehXwufK2R+qnOzLDX2UX/Nx2j0rDe5V+qqYbA8ewKKF2OQw9xrsmPKk68bdRhw2+A3gLP8a8DOkwhzCz3knlWH9Sqwvt/WZ31fkciHBGuecdBE7B2Hpmj+VJajLvXwSpuRmM+hMaiJDDRoGEf6HWKwIKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843986; c=relaxed/simple;
	bh=M2seEQnLc7DVucbbgUSjELtpc3xDE2Xgr+zIRHHnEys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPgZ5CQI6upn4aVh4Wxu02ibxCEiSMxm8ucDpdaAcF3JGfQ2s/WKrFFQK4i7QoLsnozCOdCMnFGxzjUEYHkc9/ZsmGfqLME6kgIbhMb4Z3SVWvlnCClP3ROtJi0AFRirCBpF/drK85foI7cPklckEzdPY02aTdw1Zzai33oPXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvdNIjIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvdNIjIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079951F00899;
	Thu,  1 Oct 2026 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790843984;
	bh=j/RnWaY84K7NxRT+Dl3MJsVLPAwuGx8R4hiQP+sNEkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vvdNIjIwILZSpdnBP/cMooYLCoakeofqnL6V5bBrRHNZfz30J/DuKcwhC/mPIfXlc
	 Jo2n3s9qDBwK8a0mxzZ+nWYAqK8ryRYprm38alQi37WZxBS1nOxwb6utIhppDDPvri
	 fYtlzeYWSEUN3czFXCabauIXSqIAXvZvECGWRVm4=
Date: Thu, 1 Oct 2026 10:39:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, phil@raspberrypi.com, stefan@agner.ch,
	bcm-kernel-feedback-list@broadcom.com, linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_bcm2835aux: Add support for RTS/CTS auto
 flow control
Message-ID: <2026100123-dipper-amnesty-f721@gregkh>
References: <20260930125620.221836-1-sairon@sairon.cz>
 <2e420fc4-e829-42ea-99c2-48e518ac59d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e420fc4-e829-42ea-99c2-48e518ac59d9@kernel.org>

On Thu, Oct 01, 2026 at 08:09:32AM +0200, Jiri Slaby wrote:
> On 30. 09. 26, 14:56, Jan Čermák wrote:
> > --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> > +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> ...
> > @@ -46,6 +59,150 @@ struct bcm2835aux_data {
> >   	u32 cntl;
> >   };
> > +static bool bcm2835aux_tty_throttled(struct uart_port *port)
> > +{
> > +	struct tty_struct *tty;
> > +	bool throttled;
> > +
> > +	if (!port->state)
> > +		return false;
> > +
> > +	tty = tty_port_tty_get(&port->state->port);
> > +	throttled = tty && tty_throttled(tty);
> > +	tty_kref_put(tty);
> > +
> > +	return throttled;
> 
> Instead:
> 
> scoped_guard(tty_port_tty, port)
>    return tty_throttled(scoped_tty());
> 
> return false;

LLMs do not understand "modern" kernel programming styles :(
