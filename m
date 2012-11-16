From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
Date: Fri, 16 Nov 2012 23:08:36 +0000
Message-ID: <20121116230835.GR3290@n2100.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk> <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk> <CAGhQ9VzYc8qqvZxU=AB+NHa4nGKJFxPYR7grc8Ssn-kP1bfq3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44124 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab2KPXPz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 18:15:55 -0500
Content-Disposition: inline
In-Reply-To: <CAGhQ9VzYc8qqvZxU=AB+NHa4nGKJFxPYR7grc8Ssn-kP1bfq3w@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alan Cox <alan@linux.intel.com>

On Fri, Nov 16, 2012 at 11:08:47PM +0100, Joachim Eastwood wrote:
> When the atmel_open_hook/atmel_open_close assignment is dropped, these
> global variables will be useless so we should remove them as well.
> There are also some other code that uses the variables that can be
> dropped. Should shave another 22 lines of code off atmel_serial.c
> 
> I can send out a patch on top of yours if you prefer that.

Yes please.

Thanks.
