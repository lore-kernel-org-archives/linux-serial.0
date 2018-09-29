From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [BUG] sleep in atomic in 8250 runtime PM code path
Date: Sat, 29 Sep 2018 13:20:36 +0800
Message-ID: <20180929132036.0323e24b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

Recently I found I could trigger sleep in atomic bug on berlin after commit
d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling"). The path looks like:

dw8250_probe => serial850_register_8250_port => uart_add_one_port=>
register_console => console_unlock => univ8250_console_write =>
serial8250_console_write => serial8250_rpm_get => pm_runtime_get_sync

The irq is disabled by printk_safe_enter_irqsave() in console_unlock, but
pm_runtime_get_sync can't be called in atomic context...

I guess the reason why we didn't notice it is due to the fact that
only OMAP and DW sets UART_CAP_RPM currently, and DW set the flag in
May 2018.

Per my understanding, the bug sits in the 8250 core driver rather than
8250_dw.c.

Thanks
