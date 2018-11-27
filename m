From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock
Date: Tue, 27 Nov 2018 09:48:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1811270946300.3368@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

Since size_t is unsigned, avail will not be less than 0 on line 742.
Perhaps just reorganize the computation on line 740.

julia

---------- Forwarded message ----------
Date: Tue, 27 Nov 2018 16:13:53 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix softlock

CC: kbuild-all@01.org
In-Reply-To: <20181127022536.104663-1-ryandcase@chromium.org>
References: <20181127022536.104663-1-ryandcase@chromium.org>
TO: Ryan Case <ryandcase@chromium.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>
CC: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>

Hi Ryan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.20-rc4 next-20181126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ryan-Case/tty-serial-qcom_geni_serial-Fix-softlock/20181127-102810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

>> drivers/tty/serial/qcom_geni_serial.c:742:5-10: WARNING: Unsigned expression compared with zero: avail < 0

# https://github.com/0day-ci/linux/commit/407559b41ed61fd8c95ebe39539677bc577c7c66
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 407559b41ed61fd8c95ebe39539677bc577c7c66
vim +742 drivers/tty/serial/qcom_geni_serial.c

c4f528795 Karthikeyan Ramasubramanian 2018-03-14  712
407559b41 Ryan Case                   2018-11-26  713  static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
407559b41 Ryan Case                   2018-11-26  714  		bool active)
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  715  {
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  716  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  717  	struct circ_buf *xmit = &uport->state->xmit;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  718  	size_t avail;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  719  	size_t remaining;
407559b41 Ryan Case                   2018-11-26  720  	size_t pending;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  721  	int i;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  722  	u32 status;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  723  	unsigned int chunk;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  724  	int tail;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  725
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  726  	status = readl_relaxed(uport->membase + SE_GENI_TX_FIFO_STATUS);
407559b41 Ryan Case                   2018-11-26  727
407559b41 Ryan Case                   2018-11-26  728  	/* Complete the current tx command before taking newly added data */
407559b41 Ryan Case                   2018-11-26  729  	if (active)
407559b41 Ryan Case                   2018-11-26  730  		pending = port->cur_tx_remaining;
407559b41 Ryan Case                   2018-11-26  731  	else
407559b41 Ryan Case                   2018-11-26  732  		pending = uart_circ_chars_pending(xmit);
407559b41 Ryan Case                   2018-11-26  733
407559b41 Ryan Case                   2018-11-26  734  	/* All data has been transmitted and acknowledged as received */
407559b41 Ryan Case                   2018-11-26  735  	if (!pending && !status && done) {
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  736  		qcom_geni_serial_stop_tx(uport);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  737  		goto out_write_wakeup;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  738  	}
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  739
407559b41 Ryan Case                   2018-11-26  740  	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
407559b41 Ryan Case                   2018-11-26  741  	avail *= port->tx_bytes_pw;
407559b41 Ryan Case                   2018-11-26 @742  	if (avail < 0)
407559b41 Ryan Case                   2018-11-26  743  		avail = 0;
8a8a66a1a Girish Mahadevan            2018-07-13  744
638a6f4eb Evan Green                  2018-05-09  745  	tail = xmit->tail;
407559b41 Ryan Case                   2018-11-26  746  	chunk = min3((size_t)pending, (size_t)(UART_XMIT_SIZE - tail), avail);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  747  	if (!chunk)
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  748  		goto out_write_wakeup;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  749
407559b41 Ryan Case                   2018-11-26  750  	if (!port->cur_tx_remaining) {
407559b41 Ryan Case                   2018-11-26  751  		qcom_geni_serial_setup_tx(uport, pending);
407559b41 Ryan Case                   2018-11-26  752  		port->cur_tx_remaining = pending;
407559b41 Ryan Case                   2018-11-26  753  	}
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  754
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  755  	remaining = chunk;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  756  	for (i = 0; i < chunk; ) {
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  757  		unsigned int tx_bytes;
69736b57d Karthikeyan Ramasubramanian 2018-05-03  758  		u8 buf[sizeof(u32)];
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  759  		int c;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  760
69736b57d Karthikeyan Ramasubramanian 2018-05-03  761  		memset(buf, 0, ARRAY_SIZE(buf));
6a10635e9 Karthikeyan Ramasubramanian 2018-05-03  762  		tx_bytes = min_t(size_t, remaining, port->tx_bytes_pw);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  763  		for (c = 0; c < tx_bytes ; c++)
69736b57d Karthikeyan Ramasubramanian 2018-05-03  764  			buf[c] = xmit->buf[tail + c];
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  765
69736b57d Karthikeyan Ramasubramanian 2018-05-03  766  		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  767
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  768  		i += tx_bytes;
638a6f4eb Evan Green                  2018-05-09  769  		tail += tx_bytes;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  770  		uport->icount.tx += tx_bytes;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  771  		remaining -= tx_bytes;
407559b41 Ryan Case                   2018-11-26  772  		port->cur_tx_remaining -= tx_bytes;
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  773  	}
638a6f4eb Evan Green                  2018-05-09  774
638a6f4eb Evan Green                  2018-05-09  775  	xmit->tail = tail & (UART_XMIT_SIZE - 1);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  776  out_write_wakeup:
638a6f4eb Evan Green                  2018-05-09  777  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  778  		uart_write_wakeup(uport);
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  779  }
c4f528795 Karthikeyan Ramasubramanian 2018-03-14  780

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
