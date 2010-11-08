From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH resend] Add sc16is7x2 driver
Date: Mon, 08 Nov 2010 15:01:24 +0100
Message-ID: <4CD802B4.1040704@gmail.com>
References: <4CAD818B.2070603@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58516 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0KHOCA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Nov 2010 09:02:00 -0500
In-Reply-To: <4CAD818B.2070603@iis.fraunhofer.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

Am 07.10.2010 10:15, schrieb Manuel Stahl:
> This patch adds support for the sc16is7x2 SPI to UART chips.
> Each chip has two UARTs and 8 GPIOs.

Hello Manuel,

can you send the patch inline?

Why you check in your probe function the gpio_base but not the uart_base?


Thomas



