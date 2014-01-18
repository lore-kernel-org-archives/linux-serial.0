From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers: tty: serial: xilinx_uartps: check related config
 macro before processing 'sysrq'
Date: Sat, 18 Jan 2014 17:25:56 +0800
Message-ID: <52DA48A4.80002@gmail.com>
References: <52D9465C.9000207@gmail.com> <20140117151618.GA16623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46027 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbaARJZ7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Jan 2014 04:25:59 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so5117083pab.30
        for <linux-serial@vger.kernel.org>; Sat, 18 Jan 2014 01:25:59 -0800 (PST)
In-Reply-To: <20140117151618.GA16623@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org

On 01/17/2014 11:16 PM, Greg KH wrote:
> On Fri, Jan 17, 2014 at 11:03:56PM +0800, Chen Gang wrote:
>> Hello Maintainers:
>>
>> Please help check this patch, when you have time, thanks.
>>
>> And now I find it is already fixed, but I still feel it can be
>> improved: "add defined(CONFIG_SERIAL_CORE_CONSOLE)".
> 
> What do you mean by this?
> 

Excuse me, I did not say quite clear enough originally.

What I mean is:

------------------------patch begin---------------------------------

drivers: tty: serial: xilinx_uartps: add CONFIG_SERIAL_CORE_CONSOLE switch macro

  For structure member 'sysrq', the related header defines it when "#if
defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)", so need
add CONFIG_SERIAL_CORE_CONSOLE for consistency.

  The related patch is

    "c2db11e tty: xuartps: Properly guard sysrq specific code"


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f619ad5..17de380 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -240,7 +240,7 @@ static irqreturn_t xuartps_isr(int irq, void *dev_id)
 					continue;
 			}
 
-#ifdef SUPPORT_SYSRQ
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 			/*
 			 * uart_handle_sysrq_char() doesn't work if
 			 * spinlocked, for some reason
-- 
1.7.11.7

------------------------patch end-------------------------------------


> What can I do with this patch, it's not in a format I can apply it in,
> and you say it's not needed anymore, so I guess I'll just delete it :(
> 
> greg k-h
> 



Thanks.
-- 
Chen Gang

Open, share and attitude like air, water and life which God blessed
