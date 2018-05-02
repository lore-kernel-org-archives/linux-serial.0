From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tty/serial: atmel: use port->name as name in request_irq()
Date: Wed, 2 May 2018 21:16:32 +0200
Message-ID: <20180502191632.tgda4g5v3rhncx7c@linutronix.de>
References: <20180426150625.q5tqcb7fzchvkb5d@linutronix.de>
 <20180426151222.6vw67lwqmu6ffgnw@linutronix.de>
 <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0dbf4a4c-71d4-6456-67b9-d4d202acffb7@sorico.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2018-04-27 12:31:52 [+0200], Richard Genoud wrote:
> Hi Sebastian,
Hi,

> > If this is unknown and a bisect is requested, please let me know.
> Indeed, this will be appreciated.
> I'm quite curious to find the commit that led to this.

commit 761ed4a94582ab291aa24dcbea4e01e8936488c8
Author: Rob Herring <robh@kernel.org>
Date:   Mon Aug 22 17:39:10 2016 -0500

    tty: serial_core: convert uart_close to use tty_port_close
    
    tty_port_close handles much of the common parts of tty close. Convert
    uart_close to use it and move the serial_core specific parts into
    tty_port.shutdown function. This will be needed to use tty_port functions
    directly from in kernel clients.
    
    This change causes ops->stop_rx() to be called after uart_wait_until_sent()
    is called which I think should be fine. Otherwise, the sequence of the
    close should be the same.
    
    Cc: Peter Hurley <peter@hurleysoftware.com>
    Signed-off-by: Rob Herring <robh@kernel.org>
    Acked-by: Alan Cox <alan@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The thread starts at
  https://www.spinics.net/lists/linux-serial/msg30070.html
  http://lkml.kernel.org/r/20180426150625.q5tqcb7fzchvkb5d@linutronix.de

> Richard

Sebastian
