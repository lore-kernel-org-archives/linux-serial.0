From: Lu Jingchang-B35083 <B35083@freescale.com>
Subject: RE: [PATCH v5] tty: serial: add Freescale lpuart driver support
Date: Tue, 4 Jun 2013 02:08:33 +0000
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851CEF95@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1369893217-27809-1-git-send-email-b35083@freescale.com>
 <20130603172908.GA3272@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:17566
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756754Ab3FDCJC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jun 2013 22:09:02 -0400
In-Reply-To: <20130603172908.GA3272@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

>> +config SERIAL_FSL_LPUART
>> +	bool "Freescale lpuart serial port support"
>
>Why can't this be built as a module?  I can't force users to only build
>this driver into the kernel, sorry.
[Lu Jingchang-B35083] 
  I'll enable the module support for this driver, thanks!


