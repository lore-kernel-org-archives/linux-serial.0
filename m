From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ARM: S5PV210: serial: Fix section mismatch warning
Date: Fri, 28 May 2010 19:36:11 +0900
Message-ID: <4BFF9C9B.4080904@samsung.com>
References: <4BFF9917.5000503@samsung.com>
 <20100528102906.GB4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:49185 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0E1KgN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 May 2010 06:36:13 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L3400D1TLGB9T@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 28 May 2010 19:36:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3400AG4LGB5S@mmp2.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 28 May 2010 19:36:11 +0900 (KST)
In-reply-to: <20100528102906.GB4720@trinity.fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com

On 5/28/2010 7:29 PM, Ben Dooks wrote:
> On Fri, May 28, 2010 at 07:21:11PM +0900, Joonyoung Shim wrote:
>> Rename the structure to avoid the following warning:
>>
>> WARNING: drivers/serial/built-in.o(.data+0x534): Section mismatch in reference from the variable s5p_serial_drv to the function .devexit.text:s3c24xx_serial_remove()
>> The variable s5p_serial_drv references
>> the function __devexit s3c24xx_serial_remove()
>> If the reference is valid then annotate the
>> variable with __exit* (see linux/init.h) or name the variable:
>> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> if it's from you, then why is there a signoff from marek.
> 
> if Marek is the original authour then there should be a "From:" line
> attributing the patch to him.
> 

OK. Marek is the original author.


From: Marek Szyprowski <m.szyprowski@samsung.com>

Rename the structure to avoid the following warning:

WARNING: drivers/serial/built-in.o(.data+0x534): Section mismatch in reference from the variable s5p_serial_drv to the function .devexit.text:s3c24xx_serial_remove()
The variable s5p_serial_drv references
the function __devexit s3c24xx_serial_remove()
If the reference is valid then annotate the
variable with __exit* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/serial/s5pv210.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/s5pv210.c b/drivers/serial/s5pv210.c
index 8dc0383..4a789e5 100644
--- a/drivers/serial/s5pv210.c
+++ b/drivers/serial/s5pv210.c
@@ -119,7 +119,7 @@ static int s5p_serial_probe(struct platform_device *pdev)
 	return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
 }
 
-static struct platform_driver s5p_serial_drv = {
+static struct platform_driver s5p_serial_driver = {
 	.probe		= s5p_serial_probe,
 	.remove		= __devexit_p(s3c24xx_serial_remove),
 	.driver		= {
@@ -130,19 +130,19 @@ static struct platform_driver s5p_serial_drv = {
 
 static int __init s5pv210_serial_console_init(void)
 {
-	return s3c24xx_serial_initconsole(&s5p_serial_drv, s5p_uart_inf);
+	return s3c24xx_serial_initconsole(&s5p_serial_driver, s5p_uart_inf);
 }
 
 console_initcall(s5pv210_serial_console_init);
 
 static int __init s5p_serial_init(void)
 {
-	return s3c24xx_serial_init(&s5p_serial_drv, *s5p_uart_inf);
+	return s3c24xx_serial_init(&s5p_serial_driver, *s5p_uart_inf);
 }
 
 static void __exit s5p_serial_exit(void)
 {
-	platform_driver_unregister(&s5p_serial_drv);
+	platform_driver_unregister(&s5p_serial_driver);
 }
 
 module_init(s5p_serial_init);
-- 
1.7.0.4
