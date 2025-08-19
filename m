Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9972253FC
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617286; cv=none; b=u82rR77FZeSYH4XJj+e/ACc7Eij4GPbuZD8NCSH1iD1XgtkwgvGQrwTqnM6HFp4R0rrPfTuVOKVCrbAwws/2suGLAmx1JmgYODqKwjm+fKNvTr+pMlZOxfTU+bcKiuso8T4YPHvVwjwSN3rOFvqmyGSbT4DY4OXgsBb4sywkrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617286; c=relaxed/simple;
	bh=MLTYll2C9BMVNHsQxlgPvf9o/+Owbkp/YClX4nQ2x8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB0PfYmjxk/xOen1eHHN6IiDRofRLix9EGl46E2oQds5TF9VWPhQ8WSYv6+ldKtmyI7FwIFt9Ew8Pt/dvoNFm07cu2vcn5/gRj5SWuRlLpWyH2l+mjTbFsj2nPxa9vBWa17FJHTw3BNc0QAt+VdQRkYByC0ps3/lpbkNCeYIAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dpw9FE91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dpw9FE91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E5C4CEF1;
	Tue, 19 Aug 2025 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755617285;
	bh=MLTYll2C9BMVNHsQxlgPvf9o/+Owbkp/YClX4nQ2x8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dpw9FE91T//XDUuSxB/YQoSKVMu2OnyCtDuONmFg+1ETW2QlTux/nkmj5/G6HXgoH
	 btJqzIs65FY2LQheReW/RQJiSNEzdhjxPtq6TNdM51mTF4uu/aL47Lv0w0UI0a5PNL
	 F8SM+k2aNXZnJzbWoIXvqyJ6HAr2qBezZOSEq1zw=
Date: Tue, 19 Aug 2025 17:28:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adriana Nicolae <adriana@arista.com>
Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com, Prasad Koya <prasad@arista.com>
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025081927-matchbook-chapped-26a4@gregkh>
References: <CAERbo5wdG_n6sFnYjWL6oqfvDFz4iokhNz-H2XLHCkmfyMWOdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERbo5wdG_n6sFnYjWL6oqfvDFz4iokhNz-H2XLHCkmfyMWOdw@mail.gmail.com>

On Tue, Aug 19, 2025 at 06:06:55PM +0300, Adriana Nicolae wrote:
> This patch is proposing a custom configuration for Synopsys DesignWare
> serial to be used by products with associated compatible string in the
> device tree.
> 
> The PORT_DWAPB config will be used instead of the default PORT_16550A
> which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
> bits for the FIFO configuration register. Having those flags is necessary
> to clear FIFO when the serial port is reconfigured with do_set_termios.
> 
> Additionally, inside the do_set_termios we use the LCR (Line Control
> Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latch
> Low/High) registers for baud rate setting. These 2 registers are sharing
> the same address space with UART_TX/UART_RX and UART_IER. The sequence is:
> 
> (1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR
> 
> When there is a TX or RX flow on the serial while we attempt to set/clear
> DLAB, the LCR write will be ignored and we will get a IIR_BUSY interrupt
> afterwards which is cleared by only reading the USR (UART status register).
> 
> The sequence above can leave the serial in an unstable state in two cases:
> 
>  - if UART is busy while (1), then LCR is still pointing to the normal set of
> registers, which means the code setting DLL/DLM is actually writing into TX or
> modifying interrupts in UART_IER which may end with either a garbage char '\'
> on the console or with serial interrupts disabled.
> 
>  - if UART is busy while (3), then LCR remains pointing to DLL/DLM instead of
> moving back to RX/TX. The first transfer on the serial will be stuck because
> the transmit/receive registers are not accessible unless the DLAB bit
> is cleared.
> 
> The changes in this patch include a specific serial_out function for this UART
> type similar to the one for Armada-38x devices in commit
> b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_wait_empty
> function to check the UART status by looking at the USR register and actively
> try to clear FIFO to reduce time before a LCR write since the characters will
> be lost otherwise after baud rate change.
> 
> The USR register may report that UART is busy even if TX/TX FIFO is already
> empty so we will loop until all USR[0] (UART busy status) is cleared and USR[1]
> TX FIFO is empty (RX FIFO bits should be 0 in this case).
> Keeping the same timeout of 20ms as measurements with the 9600 baud when
> the console was busy it took max 1.9ms to get the UART free state.
> 
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |    8 +++++
>  include/uapi/linux/serial_core.h    |    3 ++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index ace221afe..337b9a8bf 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -33,10 +33,16 @@
> 
>  /* Offsets for the DesignWare specific registers */
>  #define DW_UART_USR 0x1f /* UART Status Register */
> +#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
> +#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
> +#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */
> 
>  /* DesignWare specific register fields */
>  #define DW_UART_MCR_SIRE BIT(6)
> 
> +#define DW8250_REG( p, reg ) \
> + ((void __iomem *)(p->membase + ((reg) << p->regshift)))
> +

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
