From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date: Wed, 12 Nov 2014 10:04:27 +0100
Message-ID: <3356477.HitZEsNa4H@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-6-git-send-email-cernekee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65008 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaKLJEt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:04:49 -0500
In-Reply-To: <1415781993-7755-6-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Wednesday 12 November 2014 00:46:30 Kevin Cernekee wrote:
> Remove the platform dependency in Kconfig and add an appropriate
> compatible string.  Note that BCM7401 has one 16550A-compatible UART
> in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
> clock domain.  This driver handles the former one.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Can you explain why you are using the PXA serial driver instead of the
8250 driver, if this is 16550A compatible? I don't know the history
why PXA is using a separate driver.

	Arnd
