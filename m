From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Mon, 6 Aug 2007 21:15:34 +0200
Message-ID: <e8ffca0a9f533e4685f0573e72b90239@kernel.crashing.org>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange> <200708050135.07753.arnd@arndb.de> <Pine.LNX.4.60.0708051600550.4120@poirot.grange> <200708051841.17471.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47368 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbXHFTPv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Aug 2007 15:15:51 -0400
In-Reply-To: <200708051841.17471.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

> Another option altogether would be to allow the device node to
> specify the linux specific serial port flags in a separate property,
> like "linux,uart-port-flags" that contains the same flags that
> setserial can set from user space. That would also be useful
> if you want to specify UPF_MAGIC_MULTIPLIER on certain high-speed
> ports, because it cannot be autoprobed.

Such high-speed ports should simply use a proper "compatible"
entry.  Similarly with the problem at hand.


Segher

