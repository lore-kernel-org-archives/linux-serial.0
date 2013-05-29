From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v4] tty: serial: add Freescale lpuart driver support
Date: Wed, 29 May 2013 06:57:43 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130529034913.GF370@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:13715
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933908Ab3E2G6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 May 2013 02:58:08 -0400
In-Reply-To: <20130529034913.GF370@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>



>> +static int __init lpuart_serial_init(void) {
>> +	int ret;
>> +
>> +	pr_info("serial: Freescale lpuart driver\n");
>> +
>> +	ret = uart_register_driver(&lpuart_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = platform_driver_register(&lpuart_uart_driver);
>> +	if (ret)
>> +		uart_unregister_driver(&lpuart_reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit lpuart_serial_exit(void) {
>> +	platform_driver_unregister(&lpuart_uart_driver);
>> +	uart_unregister_driver(&lpuart_reg);
>> +}
>> +
>> +module_init(lpuart_serial_init);
>> +module_exit(lpuart_serial_exit);
>
>I think you can call uart_register_driver and uart_unregister_driver
>in .probe and .remove hook, and then you can simply use
>module_platform_driver for lpuart_uart_driver.
[Lu Jingchang-B35083] 
  For multiple dts uart nodes, each node will call .probe once. If the uart_register_driver is called from .probe without any conditioning check, it will then be called more than once, but the uart_register_deiver can only register the same uart driver once. So I think current arrangement will be more reasonable. Thanks!


