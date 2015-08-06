From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCHv2 1/2] tty: serial: men_z135_uart.c: Fix race between
 IRQ and set_termios()
Date: Thu, 06 Aug 2015 07:29:18 -0400
Message-ID: <55C3450E.8070107@hurleysoftware.com>
References: <cover.1438844880.git.jthumshirn@suse.de> <535885237699310100f3e6804b3677495634042e.1438844880.git.jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535885237699310100f3e6804b3677495634042e.1438844880.git.jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org

On 08/06/2015 03:16 AM, Johannes Thumshirn wrote:
> Fix panic caused by a race between men_z135_intr() and men_z135_set_termios().
> 
> men_z135_intr() and men_z135_set_termios() both hold the struct uart_port::lock
> spinlock, but men_z135_intr() does a spin_lock_irqsave() and
> men_z135_set_termios() does a normal spin_lock(), which can lead to a deadlock
> when an interrupt is called while the lock is being helt by
> men_z135_set_termios().
> 
> This was discovered using a insmod, hardware looppback send/receive, rmmod
> stress test.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
