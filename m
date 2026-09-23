Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787384A0904;
	Wed, 23 Sep 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168111; cv=none; b=FYylaWNA5C4LMdzOOLfdNu0mTZBDYEjYHB6x3vwPZoasjmt/sRjuZI53SVHweQbFXb9fovvb5p/acZmn6c1i60SouhVX0zViMOt37hUVohegWZGYfJrPBU0pwAAYTI0m+iV4uwnaiNtZFKk/1O7Mg7GDCRiQ1banJw1/5TPQBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168111; c=relaxed/simple;
	bh=ewgQahr390TzVb6MmAWj4RoBL/NNZ+4Sp+7ieTmGsbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPwtYuHNDtA5GQNtE+C+K07v9vfEY0j/UldiBxK2VLsNxZRt9SQksV0crxlQrY+9tIMh+ZJ21mGX+MxY+rj63NCupPFA6U1UfFGwLpTSMYaXKM8MK+stWRKWzALHL0iPKu2WXr7e0NqqiuPMSwAguMNx+WdYsK5gxm+Pl68U5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYcrNT7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYcrNT7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2801F000FF;
	Wed, 23 Sep 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790168110;
	bh=FRi3C+epsIdutFBlhwS+gFpit1TLgJroCohgwHrl8Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZYcrNT7P0hjDlcFWhTnT6+Mxr6YY6Iiktuhuedn/b37B8n+/jnAQd7UEma7I6Gkz/
	 hgCoughMEp760bK5dumjUrd8WmsOyZaShg4e4uSPR1v18S6XRaCA1wF4LW+XcQ/ar/
	 jRVTbV5/bnhbKBwk61V2FmWW2pvfHaEU6V9Psd74=
Date: Wed, 23 Sep 2026 14:55:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>
Cc: jirislaby@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, phil@raspberrypi.com, stefan@agner.ch,
	bcm-kernel-feedback-list@broadcom.com, linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: 8250_bcm2835aux: Add support for RTS/CTS
 auto flow control
Message-ID: <2026092346-snap-kosher-b487@gregkh>
References: <cover.1786030659.git.sairon@sairon.cz>
 <7e5ed3fb37ee4e113706c258d792121b868861a9.1786030659.git.sairon@sairon.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e5ed3fb37ee4e113706c258d792121b868861a9.1786030659.git.sairon@sairon.cz>

On Thu, Aug 06, 2026 at 05:42:04PM +0200, Jan Čermák wrote:
> The bcm2835aux mini UART can automatically de-assert RTS based on the RX
> FIFO fill level and gate the transmitter on CTS, but the driver never
> made use of it. Wire it up:
> 
> - Enable AUTORTS/AUTOCTS (with the RTS4 threshold and inverted, i.e.
>   conventional active-low, polarity) whenever CRTSCTS is set on ports
>   declaring the "uart-has-rtscts" property, advertised via
>   UPF_HARD_FLOW.
> 
> - Gate the AUTORTS function on TIOCM_RTS in set_mctrl() so that
>   clearing RTS (port close, TIOCMBIC, B0) actually de-asserts the pin
>   while auto flow control is active.
> 
> - Implement throttle()/unthrottle() by disabling the RX interrupts and
>   letting the FIFO fill up, making the hardware de-assert RTS - the
>   same approach as in 8250_omap. Re-sync this state on termios and
>   rs485 changes, as those paths may re-enable the RX interrupts (or
>   leave them disabled) behind the throttle's back.
> 
> - Never enable auto flow control together with rs485, which uses RTS
>   as the transceiver direction control. As the software CTS fallback
>   of the serial core cannot work without a modem status interrupt,
>   strip CRTSCTS whenever it cannot be handled in hardware.
> 
> - Restore RXEN when rs485 is disabled, as the emulation may be torn
>   down without the rs485_stop_tx() callback ever being called, which
>   would leave the receiver disabled.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jan Čermák <sairon@sairon.cz>
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 160 +++++++++++++++++++++-
>  1 file changed, 156 insertions(+), 4 deletions(-)

There are some bot review comments on this:
	https://sashiko.dev/#/patchset/7e5ed3fb37ee4e113706c258d792121b868861a9.1786030659.git.sairon@sairon.cz

Can you address them and submit a new version?

thanks,

greg k-h
