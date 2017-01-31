From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC] tty: pl011: Work around stuck BUSY bit on QDF2400
Date: Tue, 31 Jan 2017 18:42:47 +0000
Message-ID: <20170131184246.GA27312@n2100.armlinux.org.uk>
References: <20170130234417.20855-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170130234417.20855-1-cov@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, timur@codeaurora.org, pelcan@codeaurora.org, nleeder@codeaurora.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 30, 2017 at 06:44:17PM -0500, Christopher Covington wrote:
>  {
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
> -	unsigned int status = pl011_read(uap, REG_FR);
> +	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
>  	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
>  							0 : TIOCSER_TEMT;
>  }

I'd much prefer the reg & mask == val approach, but the above makes that
difficult.

So for the PL011 changes:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
