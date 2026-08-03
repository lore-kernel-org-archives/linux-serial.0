Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A752836F;
	Mon,  3 Aug 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768810; cv=none; b=rA9xSwTYJzf0++il+1QpYpw9RtSCP027r6WWpCQZWkOckosPRKkY/4mLJ5esv9s1VqK663j2PC9T30P/FD5lObCMA++SPferLrdv4dGNhXYY9F9oD3aQMBs3oD+u3hYkUYw/b/yClbgw7XhVeQXXmetYB+ESykKqj32sPUPE5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768810; c=relaxed/simple;
	bh=WG24IppSyrWVtgq49qoJn/FTVTay3I8R4m0/bpR5ihM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmS+TBSdr3C4dbh6xQcqbge4MGPNUQ/WN0xgY3rDvBk8rX5yeOoqTPkzy53H1qb1t07c38sa7UbHpy7Nl6UU5ZOOPbkLo4bmNOqoDy4axmPVrsQ/RjlPvA3nOMLl5O2Jlpba7DKgyDMUINMxVPt9hZlXm9amJhSp2O43573fCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtcBUeHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtcBUeHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83891F000E9;
	Mon,  3 Aug 2026 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785768809;
	bh=omQX029SsGCTE9ez7BnaxT69w2wDaKEJAA3wRGXd2Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JtcBUeHtIKdDRbr8DdTk+LWU0dA8qrlpv11T2IM2O6wkeNbVyJg9TpD4/FwzL5RwB
	 1pGglnYbYf86/Qb6jiwjVzrQ59TLy/77w0gCRgeG66867OVMiYWinl0gkWSq2AsOk1
	 RXPhUr8Hdf8SXKl7yis4G4iMbT6ewHeiBVGoV0To=
Date: Mon, 3 Aug 2026 16:52:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 00/14] serial: 8250: add Moxa MUEx50 PCIe board support
Message-ID: <2026080335-prewashed-cozily-9bc8@gregkh>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>

On Fri, Jul 31, 2026 at 03:48:06PM +0800, Crescent Hsieh wrote:
> This series consolidates Moxa PCIe multiport serial board support under a
> dedicated 8250_mxpcie driver and adds MUEx50 UART support needed by these
> boards.
> 
> The first part splits the existing Moxa PCIe board handling out of
> 8250_pci into a separate driver while preserving the existing probe flow
> and device IDs. The series then introduces the MUEx50 UART port type and
> enables the board-specific UART setup, including enhanced mode and FIFO
> trigger programming.
> 
> The driver adds hardware-assisted flow control support for MUEx50 UARTs,
> including automatic RTS/CTS handling and XON/XOFF offload. It also adds a
> custom IRQ path and uses the MUEx50 memory-mapped FIFO windows to improve
> RX and TX data movement.
> 
> Later patches add serial interface mode switching, RS485 break handling,
> and per-port private state for MUEx50-specific configuration. The driver
> supports switching the serial interface mode through the RS485
> configuration path, covering RS232, RS422, and RS485 modes supported by
> the boards.
> 
> The final part extends 8250 core callbacks where needed so low-level
> drivers can override break control and rx_trig_bytes handling. The
> 8250_mxpcie driver uses these hooks to implement RS485 break handling via
> MUEx50 features and to expose the MUEx50 programmable RX trigger level
> through the generic rx_trig_bytes sysfs interface.

I've queued this up now, for the issues that Andy pointed out, feel free
to just send follow-on patches, thanks!

greg k-h
