From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [RFC] With 8250 Designware UART, if writes to the LCR failed the
 kernel will hung up
Date: Fri, 6 Mar 2015 17:11:55 +0800
Message-ID: <54F96F5B.2090601@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tim.kryger@linaro.org, gregkh@linuxfoundation.org, jamie@jamieiles.com, alan@linux.intel.com, arnd@arndb.de, shenjiangjiang@huawei.com, long.wanglong@huawei.com
List-Id: linux-serial@vger.kernel.org

Hi,

	I'm testing 4.0-rc1 kernel on my board with 8250 Designware UART.(ARM Cortex-a15 single core).
	
	I found if serial is busy and writes to the LCR failed after tried 1000 times.
	The kernel will hung up.

	The system boot success after changed from:

 95 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 96 {
 97         struct dw8250_data *d = p->private_data;
 98
...
...
112                         writeb(value, p->membase + (UART_LCR << p->regshift));
113                 }
114                 dev_err(p->dev, "Couldn't set LCR to %d\n", value);
115         }
116 }

	to:

 95 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 96 {
 97         struct dw8250_data *d = p->private_data;
 98
...
...
112                         writeb(value, p->membase + (UART_LCR << p->regshift));
113                 }
114                 dev_info(p->dev, "Couldn't set LCR to %d\n", value);            //changed here
115         }
116 }

	The reason is serial8250_console_write can't get port->lock because serial8250_do_set_termios has
	got port->lock.
	So i think here we should change from dev_err to dev_info ?
	Any suggestions are welcome.

Best regards!

	

	
