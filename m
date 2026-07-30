Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBE4446E9;
	Thu, 30 Jul 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428393; cv=none; b=WZ0csL96d9yKR0eTxm7ZGMNaaJlVY7jPCnlRnZ2bkaT1Bv1P0aOUkj82g1Ds2T3BSLEBqczntzjpdLYDnbtcbYMwevubSiAryNcpBZNdfOIkoUIFmZr0Znq6Il7UqZPMzj6K92jj+RFrlvSex+AKAPOIVMdMBKBp470py33giM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428393; c=relaxed/simple;
	bh=xY82I03nfxAu/ewvQT1efg0nTaH2/NNi0o0cveckWZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMsLMtyI0mf3F7e6b+IfjoYvAuSqJDSUwfYwZ5lkc4GFRT/5q0BX1WQyGwg/7dtyyHnt9mAmzgpXrO3kZgOGeR2ZEBNukyU4K7Kk4h1hFakEHQH+qUJn0HxfwXJ40fRIE6nQ/+xQsyYHQGRwJz5PcZsyrheL0YcB2UHOi//CaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHHz5Dnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHHz5Dnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808891F000E9;
	Thu, 30 Jul 2026 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428392;
	bh=INX1gx+TS5p7GmYhmQZs/zFS9wyl2rG3IKU8q64/8KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iHHz5DnvPilgGjs1CVGQBPKJHSWU/ZWrtzsQmW6zms5L9kjVgGTDwCNKgAhDnZsKD
	 Izi1cVX8KkHqlHosS3KhjV/JdRm1kkglZApXJVSEnkpmjbhDmi01aUtYE9JCNNPtI8
	 vAD4C0q0UoEwB4s+Yd7NFtdhCPM0pAWILojQu7hc=
Date: Thu, 30 Jul 2026 16:43:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 00/14] serial: 8250: add Moxa MUEx50 PCIe board support
Message-ID: <2026073011-ability-humorless-4b89@gregkh>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
 <b383f0bc-f077-4a0a-ab8b-bde0021696e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b383f0bc-f077-4a0a-ab8b-bde0021696e4@kernel.org>

On Thu, Jul 30, 2026 at 08:05:45AM +0200, Jiri Slaby wrote:
> On 29. 07. 26, 8:05, Crescent Hsieh wrote:
> > This series consolidates Moxa PCIe multiport serial board support under a
> > dedicated 8250_mxpcie driver and adds MUEx50 UART support needed by these
> > boards.
> > 
> > The first part splits the existing Moxa PCIe board handling out of
> > 8250_pci into a separate driver while preserving the existing probe flow
> > and device IDs. The series then introduces the MUEx50 UART port type and
> > enables the board-specific UART setup, including enhanced mode and FIFO
> > trigger programming.
> > 
> > The driver adds hardware-assisted flow control support for MUEx50 UARTs,
> > including automatic RTS/CTS handling and XON/XOFF offload. It also adds a
> > custom IRQ path and uses the MUEx50 memory-mapped FIFO windows to improve
> > RX and TX data movement.
> > 
> > Later patches add serial interface mode switching, RS485 break handling,
> > and per-port private state for MUEx50-specific configuration. The driver
> > supports switching the serial interface mode through the RS485
> > configuration path, covering RS232, RS422, and RS485 modes supported by
> > the boards.
> > 
> > The final part extends 8250 core callbacks where needed so low-level
> > drivers can override break control and rx_trig_bytes handling. The
> > 8250_mxpcie driver uses these hooks to implement RS485 break handling via
> > MUEx50 features and to expose the MUEx50 programmable RX trigger level
> > through the generic rx_trig_bytes sysfs interface.
> > 
> > ---
> > Changes in v4:
> 
> This looks very well from my POV, except the two nits. Thanks for this.
> 
> Let's see what others say ;).

Looks sane to me, polish up those 2 things and I think it's ready to go!
