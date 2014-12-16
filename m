From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] serial: altera-uart: fix NULL device in log message
Date: Tue, 16 Dec 2014 09:00:37 +0100
Message-ID: <20141216080037.GN16916@distanz.ch>
References: <1418714914-2836-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418714914-2836-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, lftan.linux@gmail.com, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

On 2014-12-16 at 08:28:34 +0100, Ley Foon Tan <lftan@altera.com> wrote:
> Add device pointer to port->dev.
> 
> Before:
> 
> "(NULL device *): ttyAL0 at MMIO 0x2020 (irq = 6, base_baud = 3125000)
> is a Altera UART"
> 
> After:
> "altera_uart 2020.serial: ttyAL0 at MMIO 0x2020 (irq = 6, base_baud = 3125000)
> is a Altera UART"
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
