Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1322D4C8
	for <linux-serial@vger.kernel.org>; Tue, 24 Feb 2026 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893550; cv=none; b=pJs4u8M/ob6fqQ5yDirrDpYD7zk5D/0rien9QKfLfBzfDr05BradI+qwHUoQnp3Ugm1ss2EMBQY96NVyoxSxVueqKuIH3nMfa+11LtdMIsH1n+4D7ehDDsgegIJxDcRV7SRWjhrZqgNX6BHydcfMaz4lK7xXATbqSYSDPleaSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893550; c=relaxed/simple;
	bh=qNlHGqjTHH8LyHyOr4HPiUphZTLtvXz+dccGz01OT8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKJQWvvPj4jDjvptfxVpdYRHoevvAqNaEPqoDMkgzr5LkOc/fsddFP8qi77AP0YvtwbaOHDSfO+PF06H1FGIMgAcKapj5ir/9rHT55QrALXVqmWVHOyw76r2hOawHkgS0mhYHo3Cf7MWnmecq9vgs5O8zg3sTAdg80RkHcOoza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sn5MrbII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sn5MrbII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF29C116C6;
	Tue, 24 Feb 2026 00:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771893549;
	bh=qNlHGqjTHH8LyHyOr4HPiUphZTLtvXz+dccGz01OT8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sn5MrbIIcf08Go5AXhGthK3sAmARaLIQAuZYrhbYsksjgNC2A/UtI6Hc4Ga/kmlu0
	 QlTyKQh41QfcWdaNcK/eLM/ehXH4i8/S0Rl/nFjj35L8QCHzDDFpkBx29kvOK2NyEC
	 JA8EU/zR43V9I+I2SCqDr0e/8QEeSZ4wDD0GzFy8=
Date: Tue, 24 Feb 2026 01:39:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Forest <forestix@gaga.casa>
Cc: linux-serial@vger.kernel.org
Subject: Re: Seeking help diagnosing serial port failure to transmit (while
 receive works)
Message-ID: <2026022418-stellar-overwrite-bf17@gregkh>
References: <7imppktb51fdnlm8jaovts1tkhr6r1751c@sonic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7imppktb51fdnlm8jaovts1tkhr6r1751c@sonic.net>

On Mon, Feb 23, 2026 at 03:19:03PM -0800, Forest wrote:
> Hi, folks.
> 
> I'm seeing puzzling behavior from a recent AMD motherboard serial port:
> It receives data, but doesn't appear to send, and doesn't report any
> errors. Does this problem ring a bell for anyone here?
> 
> dmesg reports this:
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 
> The /proc/tty/driver/serial tx count rises as I type in picocom, but the
> terminal at the other end of a null-modem cable (a laptop with a
> USB/serial adapter) doesn't see the typed characters. The other
> direction of the same connection works just fine.
> 
> Things that have not helped:
> - Replacing the motherboard's cables and connectors
> - Replacing the null modem adapter with a different model
> - Replacing the remote USB/serial adapter with a different model
> - Switching picocom's flow control between RTS/CTS, xon/xoff, none
> - Changing the serial port's IRQ and address in the BIOS
> - Changing between 9600 and 115200 bps
> 
> I'm approaching my wit's end. Could this be a known problem with the
> kernel's serial driver and the B650 chipset (socket AM5), or with recent
> AGESA versions?

Based on experience, it's always flow control being set somewhere (on
one side or the other), so watch out for that.

good luck!

greg k-h
