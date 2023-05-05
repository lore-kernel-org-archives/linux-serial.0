Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E5C77B73
	for <linux-serial@archiver.kernel.org>; Fri,  5 May 2023 02:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEEC7Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 22:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEC7T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 22:59:19 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5828D1163A
        for <linux-serial@vger.kernel.org>; Thu,  4 May 2023 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=bfkS6nQp5UWtLxqsn/xk94v8llWEfonyL/vrhIQScOY=;
        b=AI1Pwf8nGV9BrOEDuc/SP0Ee5FTyCxC56ffhPX/VyzhoeWZ6Kecsk5yHc8OzMv
        h1eiXcuneuDf13YkgNfg5YlpGr4rBjzsDeggy4JWhUd1fazYJO4VZmqg8vB6DrpJ
        Eok//OEzMvBKvOoFOHVBxPpTKTIRN5xXdqjO7CM+1SlhY=
Received: from [172.21.25.67] (unknown [218.201.129.19])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wBX1jLwcFRkWqoBBA--.23157S2;
        Fri, 05 May 2023 10:58:57 +0800 (CST)
Message-ID: <d8693191-be31-b471-7ddc-b491daa48650@163.com>
Date:   Fri, 5 May 2023 10:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: serial8250: can not change baudrate while the controller is busy
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com>
 <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
Content-Language: en-US
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <ab524eb-da1d-bf74-6d73-2defb7f7118@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBX1jLwcFRkWqoBBA--.23157S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrykXF18CryfZryDGr18Grg_yoW3XryUpF
        y5Kay3KrWqgw47Gws2yr4ktF4YqFs3G342kFsrGryFyFn8tr9agF1xK3yrta4fCrykKr1D
        ArsIkFy7Ca1DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuwZcUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzhZm7WI0ZE4+IgAAsz
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



在 2023/4/14 20:10, Ilpo Järvinen 写道:
> On Fri, 14 Apr 2023, qianfan wrote:
>
>> Hi:
>>
>> My custom board is based on allwinner R40, the uart is compatibled with
>> serial8250. Based on it's datasheet:
>>
>>> When TX transmit data, or RX receives data, or TX FIFO is not empty, then
>> the
>>> BUSY flag bit can be set to 1 by hardware, which indicates the UART
>>> controller is busy.
>> We cannot write LCR and DLL to update UART params such as baudrate and partity
>> while the UART is busy, however `serial8250_do_set_termios` is a void
>> function,
>> the upper level always assume the uart params is updated.
>>
>> The upper level `uart_set_termios` do noting if ktermios params is not
>> changed,
>> it will not update when the user space program running tcsetattr set a same
>> baudrate again.
>>
>> So we can not fix the baudrate when
>> `serial8250_do_set_termios`
>> failed.
>>
>> Allwinner R40's datasheet provided a way for this case.
>>
>>> CHCFG_AT_BUSY(configure at busy): Enable the bit, software can also set UART
>>> controller when UART is busy, such as the LCR, DLH, DLL register.
>>> CHANGE_UPDATE(change update): If CHCFG_AT_BUSY is enabled, and CHANGE_UPDATE
>>> is written to 1, the configuration of UART controller can be updated.
>>> After completed update, the bit is cleared to 0 automatically.
>> I can't know this feature is expanded by allwinner, or it is a common
>> functiton
>> of serial8250. Perhaps the serial8250 driver need this.
> tcsetattr() can be given a flag which enforces TX empty condition before
> core calls into the lower layer HW set_termios function. Would that be
> enough to solve the case you're interested in?
>
> Obviously, nothing can prevent Rx from occuring as it's not under local
> UART's control (e.g. a busy flag check would still be racy). But does
> writing those registers actually break something or just corrupts the
> character under Tx/Rx (which can be handled by flushing)?
Hi:

I speed long times to create a common solution for this problem.

(I had create two commit, the first one add some sysfs debug interface
and the second one try solve this problem. So the next following patch
has only patch-2. Let's we discuess this solution and I will send all
patches if it is good.)

Allwinner introduce some bits in HALT_TX register which can change
baudrate while the serial is busy. But that is not a common feature
of dw-uart. Rockchip's uart is also based on dw-uart and they doesn't
has such feature.

The loopback is a common feature of 16450/16550 serial, so we can set
loopback mode to cut down the external serial line to force the serial
to idle.

Next is the second patch:

 From 171e981c3695e3efcc76a2c4f0d0937d366d6e2a Mon Sep 17 00:00:00 2001
From: qianfan Zhao <qianfanguijin@163.com>
Date: Fri, 5 May 2023 08:46:50 +0800
Subject: [PATCH] drivers: serial: 8250_dw: Make uart idle before set 
baudrate

Some registers which control the baudrate such as DLL, DLM can not
write while the uart is busy. So set the controller to loopback mode
and clear fifos to force idle before change baudrate.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
  drivers/tty/serial/8250/8250_dw.c | 57 ++++++++++++++++++++++++++++++-
  1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c 
b/drivers/tty/serial/8250/8250_dw.c
index 3dca344ca19c..4eaa4d05a43e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -35,6 +35,7 @@
  #define DW_UART_USR    0x1f /* UART Status Register */

  /* DesignWare specific register fields */
+#define DW_UART_USR_BUSY        BIT(0)
  #define DW_UART_MCR_SIRE        BIT(6)

  struct dw8250_data {
@@ -43,6 +44,8 @@ struct dw8250_data {
      u8            usr_reg;
      int            msr_mask_on;
      int            msr_mask_off;
+    u8            dll;
+    u8            dlm;
      struct clk        *clk;
      struct clk        *pclk;
      struct notifier_block    clk_notifier;
@@ -52,7 +55,9 @@ struct dw8250_data {
      unsigned int        skip_autocfg:1;
      unsigned int        uart_16550_compatible:1;

+    unsigned int        last_loopback_waiting_time;
      unsigned long        iir_busy_count;
+    unsigned long        lcr_busy_count;
  };

  static inline struct dw8250_data *to_dw8250_data(struct 
dw8250_port_data *data)
@@ -93,6 +98,7 @@ static void dw8250_force_idle(struct uart_port *p)

  static void dw8250_check_lcr(struct uart_port *p, int value)
  {
+    struct dw8250_data *d = to_dw8250_data(p->private_data);
      void __iomem *offset = p->membase + (UART_LCR << p->regshift);
      int tries = 1000;

@@ -121,6 +127,7 @@ static void dw8250_check_lcr(struct uart_port *p, 
int value)
       * FIXME: this deadlocks if port->lock is already held
       * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
       */
+    d->lcr_busy_count++;
  }

  /* Returns once the transmitter is empty or we run out of retries */
@@ -360,6 +367,46 @@ static void dw8250_set_termios(struct uart_port *p, 
struct ktermios *termios,
      serial8250_do_set_termios(p, termios, old);
  }

+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+                   unsigned int quot, unsigned int quot_frac)
+{
+    struct uart_8250_port *up = up_to_u8250p(p);
+    struct dw8250_data *d = to_dw8250_data(p->private_data);
+    unsigned int usr;
+    int retries;
+
+    /*
+     * LCR, DLL, DLM registers can not write while the uart is busy,
+     * set uart to loopback mode, clear fifos to force idle.
+     * The loopback mode doesn't take effect immediately, it will waiting
+     * current byte received done, the lower baudrate the longer waiting
+     * time.
+     */
+    p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+    for (retries = 0; retries < 10000; retries++) {
+        dw8250_force_idle(p);
+
+        usr = p->serial_in(p, d->usr_reg);
+        if (!(usr & DW_UART_USR_BUSY))
+            break;
+        udelay(1);
+    }
+
+    d->last_loopback_waiting_time = retries;
+
+    p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+    if (p->serial_in(p, UART_LCR) & UART_LCR_DLAB) {
+        d->dll = quot & 0xff;
+        d->dlm = (quot >> 8) & 0xff;
+
+        p->serial_out(p, UART_DLL, d->dll);
+        p->serial_out(p, UART_DLM, d->dlm);
+        p->serial_out(p, UART_LCR, up->lcr);
+    }
+
+    p->serial_out(p, UART_MCR, up->mcr);
+}
+
  static void dw8250_set_ldisc(struct uart_port *p, struct ktermios 
*termios)
  {
      struct uart_8250_port *up = up_to_u8250p(p);
@@ -449,6 +496,8 @@ static ssize_t register_show(struct device *dev, 
struct device_attribute *attr,

      spin_lock_irqsave(&p->lock, flags);
      ret = scnprintf(buf, PAGE_SIZE,
+            "%s: %02x\n"
+            "%s: %02x\n"
              "%s: %02x/%02x\n"
              "%s: %02x\n"
              "%s: %02x\n"
@@ -458,6 +507,8 @@ static ssize_t register_show(struct device *dev, 
struct device_attribute *attr,
              "%s: %02x\n"
              "%s: %02x\n"
              ,
+            "DLL", d->dll,
+            "DLM", d->dlm,
              "IER", up->ier, p->serial_in(p, UART_IER),
              "IIR", p->serial_in(p, UART_IIR),
              "FCR", up->fcr,
@@ -478,7 +529,10 @@ static ssize_t busy_show(struct device *dev, struct 
device_attribute *attr,
  {
      struct dw8250_data *d = platform_get_drvdata(to_platform_device(dev));

-    return scnprintf(buf, PAGE_SIZE, "%lu\n", d->iir_busy_count);
+    return scnprintf(buf, PAGE_SIZE, "%lu %lu %u\n",
+             d->iir_busy_count,
+             d->lcr_busy_count,
+             d->last_loopback_waiting_time);
  }
  static DEVICE_ATTR_RO(busy);

@@ -570,6 +624,7 @@ static int dw8250_probe(struct platform_device *pdev)
      p->serial_out    = dw8250_serial_out;
      p->set_ldisc    = dw8250_set_ldisc;
      p->set_termios    = dw8250_set_termios;
+    p->set_divisor    = dw8250_set_divisor;

      p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
      if (!p->membase)
-- 
2.25.1



