From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] serial: altera-uart: fix NULL device in log message
Date: Thu, 1 Jan 2015 20:15:48 +0100
Message-ID: <20150101191548.GA465@amd>
References: <1418714914-2836-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418714914-2836-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, lftan.linux@gmail.com, linux-serial@vger.kernel.org, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

On Tue 2014-12-16 15:28:34, Ley Foon Tan wrote:
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

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
