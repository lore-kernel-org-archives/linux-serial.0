From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/7] tty: max310x: Simplify the code and fix a few bugs
Date: Tue, 21 May 2019 12:17:01 +0200
Message-ID: <20190521101701.GA31141@kroah.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 14, 2019 at 01:14:08PM +0300, Serge Semin wrote:
> I started using this driver two years ago in kernek 4.4 and then in kernel
> 4.9. It didn't go well from the very beginning due to my platform
> peculiarities: DW SPI core with hardware CS and relatively slow MIPS-based
> SoC. This patchset is intended to fix some of the problems I found out
> during the max310x driver utilization with max14830 device.
> 
> First of all it was discovered, that workqueue API isn't optimally used.
> Work context isn't re-entrant by design, so the mutex used to guard the
> TX-method is redundant. schedule_work() method is also created in a way
> the work item is scheduled only if it isn't pending. Patch 1 concerns all
> these fixes. Seeing the similar container_of(uart_port) is used three
> times in the driver, the patch 2 introduces a macro to_max310x_port() to
> get a pointer to corresponding struct max310x_one. This is the code
> simplification and is going to be used in the following patches.
> 
> It was found out, that batch read and write methods used buffers allocated
> on the kernel stack. Since they might be utilized by SPI controllers for
> DMA it might be unsafe on some platforms. Patch 3 provides a dedicated
> kmalloced buffers for this.
> 
> The baud-rate calculator function didn't work correct for all the possible
> baud-rates requested within a pre-defined input reference frequency.
> Instead an algo fully compliant with datasheet divisor formulae is
> implemented in patch 4.
> 
> Patches 5 and 6 are created to fix some rs485 issues. Particularly the
> rs485 mode is configured on the port startup if it's enabled. And seeing
> the mode2 register provides a way to enable/disable the echo-suppression
> in RS485 mode, it is used to implement the SER_RS485_RX_DURING_TX flag
> support.
> 
> Finally it was discovered that in case if inbound hardware FIFO
> experienced overflow, a lot of '\0' characters inserted into the
> flip-buffer as a character of the RX-FIFO overrun. It isn't quite correct
> since the overflow happened only after the last character had been
> received. Patch 7 is dedicated to push only a single RX-FIFO overrun
> character in this case.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Nice cleanups, all now applied, thanks!

greg k-h
