Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF8C77B73
	for <linux-serial@archiver.kernel.org>; Sun, 16 Apr 2023 13:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDPNnp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Apr 2023 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDPNno (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Apr 2023 09:43:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE71BF0
        for <linux-serial@vger.kernel.org>; Sun, 16 Apr 2023 06:43:41 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9npT-1pkS9y0OVp-005nPd; Sun, 16 Apr 2023 15:43:11 +0200
Message-ID: <d5009984-d2eb-0343-5bb4-df8a7f526121@i2se.com>
Date:   Sun, 16 Apr 2023 15:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Regression: serial: imx: overrun errors on debug UART
Content-Language: en-US
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
 <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
 <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
 <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
 <cb16ddb7-f22f-d637-8670-bccc77add0af@i2se.com> <87mt3ynsa7.fsf@osv.gnss.ru>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <87mt3ynsa7.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JDp1QuHcnVy9sJQ92SUaTVHnjsELclAuiPfTALoajWJVPth0VI2
 MT3Hk7BTZrpUYu/smRXVxn2E7/TaPJ1zsojPR4QLAXOKOvuaLHUM570wH5P4DRhijpD7xIK
 FRE0Ey7JqAq0PFMkgeJpeIG6wXKeEIneEvARw/0FNZLh4jHaIzDcT2u9epdZ8LqV/Ado+XB
 LxjfsRIP4QN7Q8ipAWNjA==
UI-OutboundReport: notjunk:1;M01:P0:96eb5fZgSi4=;gS/UA0PnQorxbvBMZuuDbjlzH3f
 sJeisHdwSnrA+c3Zyi7JCte4xWtI98/6fUk+BO703pe23DI5EXIxTtEUlZCdAu8ZnHtebKtdQ
 XHljBcrVcTeLbGuhm22/th/VQKrsQrEW551oX8uQZabzVinLKxZwRdqZ9kzuTKqw3CZFMbQxv
 h0RLHEbidVutK+wFA3o7syOc0NwOGqKp1htH7TuwYvAyvKGZuHYpVTB3NYRBDO4Y4VXLM+PTz
 1Bchy5TGWuPW9cyGCeBBLMg+ZXqfYX5RRi4EgToxETiRPqA15OT/akwHpHtxBZnTlY8rVdMCm
 sxVI8XAui+dXwQ0VLEAJ8iW4QhNBC/8gLnqdytKAW1gILOq1a1lvXZpZNtzJypCZx1NrIvcZk
 SFd1CPVKS7VGEloukgH/odJHIVePNVyHzwcnnll+gfstUx/EMlt8JJ1DTWjjFim5z/SVo+PO4
 yyXXH1oBU754LNj1sbEijtx5hMW6mKnoGYrq1jex9G3S/b6cLiYdq8sZfxdXrLCOCmTxmbQtO
 OzBBgUr6bVnDxgmd2eubBg+5lphXQQLnTZoF7VutoiEOrKzw8RysL7oW79NyGelQGNTVyapM9
 UO0v/wrG7tYO+lir1RxuvrnBUx1IcOoxv5QlfKK5oIhtP0cniDjsy8hpDNSdSgmkTVjICwV8+
 f3P6hiQ0dOdn2PDSH+/DfVHvfmsos7Y2ocKwZpZ7MA==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sergey,

Am 27.03.23 um 17:11 schrieb Sergey Organov:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> Hi,
>>
>> Am 25.03.23 um 16:11 schrieb Uwe Kleine-König:
> 
> [...]
> 
>> today i had time to do some testing. At first i tested with different RXTL_DEFAULT values.
>>
>> 1 No overrun
>> 2 No overrun
>> 4 No overrun
>> 8 Overruns
>>
>> After that i look at the # echo 0 > /proc/sys/kernel/printk approach,
>> but this didn't change anything. The kernel is usually silent about
>> log message after boot and the console works still with echo.
>> Enforcing some driver to call printk periodically would make the
>> console unusuable.
> 
> As you figured that printk() is not the cause, it must be something else
> that causes overruns, so there is no need to check printk case further.
> 
>>
>> Finally i tried to disabled the spin_lock in imx_uart_console_write:
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index f07c4f9ff13c..c342559ff1a2 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2007,14 +2007,12 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>>   	struct imx_port_ucrs old_ucr;
>>   	unsigned long flags;
>>   	unsigned int ucr1;
>> -	int locked = 1;
>> +	int locked = 0;
>>
>>   	if (sport->port.sysrq)
>>   		locked = 0;
>>   	else if (oops_in_progress)
>>   		locked = spin_trylock_irqsave(&sport->port.lock, flags);
>> -	else
>> -		spin_lock_irqsave(&sport->port.lock, flags);
>>
>>   	/*
>>   	 *	First, save UCR1/2/3 and then disable interrupts
>>
>> But the overruns still occured. Is this because the serial core
>> already helds a lock?
> 
> This probably isn't even called when there is no printk() output, as
> user-space writes to /dev/console are rather performed through regular
> generic code, AFAIK.

i had some time today to investigate this a little bit. I thought it 
would be a good idea to use debugfs as a ugly quick hack:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index b8c817d26b00..d5bde4754004 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -30,6 +30,7 @@
  #include <linux/dma-mapping.h>

  #include <asm/irq.h>
+#include <linux/debugfs.h>
  #include <linux/dma/imx-dma.h>

  #include "serial_mctrl_gpio.h"
@@ -237,8 +238,19 @@ struct imx_port {
  	enum imx_tx_state	tx_state;
  	struct hrtimer		trigger_start_tx;
  	struct hrtimer		trigger_stop_tx;
+
+	struct dentry		*debugfs_dir;
+
+	/* stats exposed through debugf */
+	s64			total_duration_us;
+	s64			rx_duration_us;
+	s64			tx_duration_us;
+	u32			received;
+	u32			send;
  };

+static struct dentry *imx_debugfs_root;
+
  struct imx_port_ucrs {
  	unsigned int	ucr1;
  	unsigned int	ucr2;
@@ -536,12 +548,15 @@ static void imx_uart_dma_tx(struct imx_port *sport);
  static inline void imx_uart_transmit_buffer(struct imx_port *sport)
  {
  	struct circ_buf *xmit = &sport->port.state->xmit;
+	u32 send = 0;

  	if (sport->port.x_char) {
  		/* Send next char */
  		imx_uart_writel(sport, sport->port.x_char, URTX0);
  		sport->port.icount.tx++;
  		sport->port.x_char = 0;
+		if (sport->send == 0)
+			sport->send = 1;
  		return;
  	}

@@ -576,8 +591,12 @@ static inline void imx_uart_transmit_buffer(struct 
imx_port *sport)
  		imx_uart_writel(sport, xmit->buf[xmit->tail], URTX0);
  		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
  		sport->port.icount.tx++;
+		send++;
  	}

+	if (send > sport->send)
+		sport->send = send;
+
  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
  		uart_write_wakeup(&sport->port);

@@ -808,6 +827,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  {
  	struct imx_port *sport = dev_id;
  	unsigned int rx, flg, ignored = 0;
+	u32 received = 0;
  	struct tty_port *port = &sport->port.state->port;

  	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
@@ -815,6 +835,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)

  		flg = TTY_NORMAL;
  		sport->port.icount.rx++;
+		received++;

  		rx = imx_uart_readl(sport, URXD0);

@@ -868,6 +889,9 @@ static irqreturn_t __imx_uart_rxint(int irq, void 
*dev_id)
  out:
  	tty_flip_buffer_push(port);

+	if (received > sport->received)
+		sport->received = received;
+
  	return IRQ_HANDLED;
  }

@@ -942,6 +966,8 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
  	struct imx_port *sport = dev_id;
  	unsigned int usr1, usr2, ucr1, ucr2, ucr3, ucr4;
  	irqreturn_t ret = IRQ_NONE;
+	ktime_t total_start = ktime_get();
+	s64 total_duration_us, rx_duration_us, tx_duration_us;

  	spin_lock(&sport->port.lock);

@@ -978,14 +1004,24 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)
  		usr2 &= ~USR2_ORE;

  	if (usr1 & (USR1_RRDY | USR1_AGTIM)) {
+		ktime_t rx_start = ktime_get();
  		imx_uart_writel(sport, USR1_AGTIM, USR1);

  		__imx_uart_rxint(irq, dev_id);
+		rx_duration_us = ktime_us_delta(ktime_get(), rx_start);
+		if (rx_duration_us > sport->rx_duration_us)
+			sport->rx_duration_us = rx_duration_us;
+
  		ret = IRQ_HANDLED;
  	}

  	if ((usr1 & USR1_TRDY) || (usr2 & USR2_TXDC)) {
+		ktime_t tx_start = ktime_get();
  		imx_uart_transmit_buffer(sport);
+		tx_duration_us = ktime_us_delta(ktime_get(), tx_start);
+		if (tx_duration_us > sport->tx_duration_us)
+			sport->tx_duration_us = tx_duration_us;
+
  		ret = IRQ_HANDLED;
  	}

@@ -1015,6 +1051,10 @@ static irqreturn_t imx_uart_int(int irq, void 
*dev_id)

  	spin_unlock(&sport->port.lock);

+	total_duration_us = ktime_us_delta(ktime_get(), total_start);
+	if (total_duration_us > sport->total_duration_us)
+		sport->total_duration_us = total_duration_us;
+
  	return ret;
  }

@@ -2233,6 +2273,26 @@ static const struct serial_rs485 
imx_rs485_supported = {
  #define RX_DMA_PERIODS		16
  #define RX_DMA_PERIOD_LEN	(PAGE_SIZE / 4)

+static int debugfs_stats_show(struct seq_file *s, void *unused)
+{
+	struct imx_port *sport = s->private;
+
+	seq_printf(s, "total_duration_us:\t%lld\n", sport->total_duration_us);
+	seq_printf(s, "rx_duration_us:\t%lld\n", sport->rx_duration_us);
+	seq_printf(s, "tx_duration_us:\t%lld\n", sport->tx_duration_us);
+	seq_printf(s, "received:\t\t%u\n", sport->received);
+	seq_printf(s, "send:\t\t%u\n", sport->send);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(debugfs_stats);
+
+static void imx_init_debugfs(struct imx_port *sport, const char *device)
+{
+	sport->debugfs_dir = debugfs_create_dir(device, imx_debugfs_root);
+	debugfs_create_file("stats", 0444, sport->debugfs_dir, sport,
+			    &debugfs_stats_fops);
+}
+
  static int imx_uart_probe(struct platform_device *pdev)
  {
  	struct device_node *np = pdev->dev.of_node;
@@ -2485,6 +2545,7 @@ static int imx_uart_probe(struct platform_device 
*pdev)
  	imx_uart_ports[sport->port.line] = sport;

  	platform_set_drvdata(pdev, sport);
+	imx_init_debugfs(sport, dev_name(&pdev->dev));

  	return uart_add_one_port(&imx_uart_uart_driver, &sport->port);
  }
@@ -2678,9 +2739,14 @@ static int __init imx_uart_init(void)
  	if (ret)
  		return ret;

+	imx_debugfs_root = debugfs_create_dir(
+		imx_uart_platform_driver.driver.name, NULL);
+
  	ret = platform_driver_register(&imx_uart_platform_driver);
-	if (ret != 0)
+	if (ret != 0) {
+		debugfs_remove_recursive(imx_debugfs_root);
  		uart_unregister_driver(&imx_uart_uart_driver);
+	}

  	return ret;
  }
@@ -2688,6 +2754,7 @@ static int __init imx_uart_init(void)
  static void __exit imx_uart_exit(void)
  {
  	platform_driver_unregister(&imx_uart_platform_driver);
+	debugfs_remove_recursive(imx_debugfs_root);
  	uart_unregister_driver(&imx_uart_uart_driver);
  }

Using this i was able to better compare the behavior with RXTL_DEFAULT 1 
(without overrun errors) and RXTL_DEFAULT 8 (with overrun errors) on my 
i.MX6ULL test platform. After doing my usual test scenario (copy some 
text lines to console) i got the following results:

RXTL_DEFAULT 1
21f0000.serial/stats:total_duration_us: 61
21f0000.serial/stats:rx_duration_us:    36
21f0000.serial/stats:tx_duration_us:    48
21f0000.serial/stats:received:          28
21f0000.serial/stats:send:              33

RXTL_DEFAULT 8
21f0000.serial/stats:total_duration_us: 78
21f0000.serial/stats:rx_duration_us:    46
21f0000.serial/stats:tx_duration_us:    47
21f0000.serial/stats:received:          33
21f0000.serial/stats:send:              33

So based on the maximum of received characters on RX interrupt, i 
consider the root cause of this issue has already been there because the 
amount is near to the maximum of the FIFO (32 chars). So finally 
increasing RXTL_DEFAULT makes the situation even worse by adding enough 
latency for overrun errors.

Best regards

>  
> Best regards,
> -- Sergey Organov
