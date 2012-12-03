From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Mon, 3 Dec 2012 11:46:04 +0000
Message-ID: <20121203114604.079a2721@bob.linux.org.uk>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41673 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab2LCLnd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2012 06:43:33 -0500
In-Reply-To: <6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org

> + * uart_tty_find - find the associated TTY device for the UART target
> + *		   device
> + * @drv: the low level UART driver
> + * @dev: the parent physical device for the TTY devices
> + * @line: the line number of the UART target device
> + *

Our top level abstraction is struct tty and struct tty_port. There is
nothing requiring a serial tty is using the uart helper layer, nor
should there be, so your code needs to support devices not using the
uart layer. Otherwise it looks quite reasonable.

our 3.7 tty layer has sysfs nodes on the tty which may also help

Alan
