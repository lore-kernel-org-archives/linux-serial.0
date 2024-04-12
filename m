Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C01798E
	for <linux-serial@vger.kernel.org>; Fri, 12 Apr 2024 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712893547; cv=none; b=BgkrT3m6ZPB0Uu/1bowpX+q/TQ8GWGas5q/X0Ac9uWybt5i84d4z31MYhp2eYM0bCZCqYn3/VdyToufxzYOoBWF5bhYmAUZNlWVe8RUsY3Vy95MglInRjIu3DuZUxlDWG30r8set2GMMIvRs2orFv5FaMsz34BBI2YwDIEZaPVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712893547; c=relaxed/simple;
	bh=kJlgFzzzcLo28Lym871bAG9Yf/dOtTVbIwbI2sdLpAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kok6RTSpG5u2uJLPdrFR2mRmNe1IRmOtHLKsNwKhS8oDmM5DXSM01kSVgqy3RQldIX4hqx94n8kbxZ/lykKpRc0gfTxCLSNPP0oH7r+qwImiR5BTbcUI3f8f8FQ86n+q9JNmMwmJYe2VsmwX1kwu3EaxU/ckRIynbxostOaLzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=QDLEfffO; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="QDLEfffO"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 49DC2603E6;
	Fri, 12 Apr 2024 03:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712893543;
	bh=kJlgFzzzcLo28Lym871bAG9Yf/dOtTVbIwbI2sdLpAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDLEfffO1njNG0OCAkiTz1tbFiygrNDAM2kUhrm19PI5Sb8E4qUzBlID05VtTZHYk
	 5KPO+gqOoEUMwHG2QdIHVSI6RfWrj+IOqZOHd87Sq+sr5XU36pXM6xLbLVByDf/nC5
	 7/pHfzRQ+/QXDpMIIdswdl7rsXBuIWxHguKb5/TagqQUnM1Hah7ycqboTb9/3+v3Ps
	 ULoez4pT6LU2LOCh6m9Xw2d1X/awsopz40bu6Or7D91Lc+/zEUnPAtaYJT3ZjvjPjS
	 JgjhRUn7j7BfFOMxkCmSXxUuqUYWutRtjOBmpqHn2SboPBTJgb8pyESHMQqiuESK6o
	 5tY+mi6Iq3a+w==
Date: Fri, 12 Apr 2024 06:45:33 +0300
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix missing shutdown and startup for
 serial base port
Message-ID: <20240412034533.GG5153@atomide.com>
References: <20240411055848.38190-1-tony@atomide.com>
 <ZhfgOU7htReGK3Xt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhfgOU7htReGK3Xt@smile.fi.intel.com>

Hi,

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240411 13:06]:
> On Thu, Apr 11, 2024 at 08:58:45AM +0300, Tony Lindgren wrote:
> > +out_base_port_startup:
> > +	uport = uart_port_check(state);
> > +	if (!uport)
> > +		return -EIO;
> > +
> > +	serial_base_port_startup(uport);
> 
> So, we call this even on uninitialised TTY. Is it okay?

To me it seems we should do it unconditionally unless there are
reasons to tie to the TTY init logic. This should be checked
though, maybe it needs to be tied to the TTY logic.

> >  	/* Flush any pending TX for the port */
> >  	uart_port_lock_irqsave(port, &flags);
> > +	if (!port_dev->tx_enabled)
> > +		goto unlock;
> 
> Can't this be integrated into...
> 
> >  	if (__serial_port_busy(port))
> 
> ...this call?

Yes so it seems thanks, it can be done to simplify the code.

Regards,

Tony

