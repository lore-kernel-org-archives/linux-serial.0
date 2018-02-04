From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] serial: core: mark port as initialized in autoconfig
Date: Sun, 4 Feb 2018 12:02:35 +1100
Message-ID: <20180204010235.GE7714@localhost>
References: <20180203112723.11129-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180203112723.11129-1-bigeasy@linutronix.de>
Sender: stable-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Nikola Ciprich <nikola.ciprich@linuxbox.cz>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Feb 03, 2018 at 12:27:23PM +0100, Sebastian Andrzej Siewior wrote:
> This is a followup on 44117a1d1732 ("serial: core: mark port as
> initialized after successful IRQ change").
> Nikola has been using autoconfig via setserial and reported a crash
> similar to what I fixed in the earlier mentioned commit. Here I do the
> same fixup for the autoconfig. I wasn't sure that this is the right
> approach. Nikola confirmed that it fixes his crash.
> 
> Fixes: b3b576461864 ("tty: serial_core: convert uart_open to use tty_port_open")
> Link: http://lkml.kernel.org/r/20180131072000.GD1853@localhost.localdomain
> Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Johan Hovold <johan@kernel.org>
