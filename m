From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
Date: Wed, 5 Dec 2012 03:37:45 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BD66B0@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
	<6d5fc2e0799c12554aa8acdb2d7782ba8643902b.1354505472.git.lv.zheng@intel.com>
 <20121203114604.079a2721@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17490 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab2LEDiB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Dec 2012 22:38:01 -0500
In-Reply-To: <20121203114604.079a2721@bob.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

OK, all uart_driver and serial_core.h stuff will be removed from the next revision.

Best regards/Lv Zheng

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Alan Cox
> Sent: Monday, December 03, 2012 7:46 PM
> To: Zheng, Lv
> Cc: Brown, Len; Wysocki, Rafael J; Greg Kroah-Hartman;
> linux-acpi@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: [RFC PATCH 1/3] UART: Add UART subsystem as a bus.
> 
> > + * uart_tty_find - find the associated TTY device for the UART target
> > + *		   device
> > + * @drv: the low level UART driver
> > + * @dev: the parent physical device for the TTY devices
> > + * @line: the line number of the UART target device
> > + *
> 
> Our top level abstraction is struct tty and struct tty_port. There is nothing
> requiring a serial tty is using the uart helper layer, nor should there be, so your
> code needs to support devices not using the uart layer. Otherwise it looks quite
> reasonable.
> 
> our 3.7 tty layer has sysfs nodes on the tty which may also help
> 
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
