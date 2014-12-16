From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] serial: altera-juart: fix NULL device in log message
Date: Tue, 16 Dec 2014 09:00:15 +0100
Message-ID: <20141216080015.GM16916@distanz.ch>
References: <1418714866-2744-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418714866-2744-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, lftan.linux@gmail.com, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

On 2014-12-16 at 08:27:46 +0100, Ley Foon Tan <lftan@altera.com> wrote:
> Add device pointer to port->dev.
> 
> Before:
> 
> "(NULL device *): ttyJ0 at MMIO 0x1008 (irq = 2, base_baud = 0) is a
> Altera JTAG UART"
> 
> After:
> "altera_jtaguart 1008.serial: ttyJ0 at MMIO 0x1008 (irq = 2, base_baud = 0) is a
> Altera JTAG UART"
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
