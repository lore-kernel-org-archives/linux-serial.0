From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 18:41:16 +0200
Message-ID: <200708051841.17471.arnd@arndb.de>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange> <200708050135.07753.arnd@arndb.de> <Pine.LNX.4.60.0708051600550.4120@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:55483 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbXHEQla (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Aug 2007 12:41:30 -0400
In-Reply-To: <Pine.LNX.4.60.0708051600550.4120@poirot.grange>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> That would be a possibility, but that would mean all 8241/8245 have to 
> adjust their .dts. Ok, there are not so many of them in the mainline now 
> (in fact, hardly any apart from linkstation:-)), still. Cannot we use 
> something already available to just check if we're running on such a CPU? 
> Worst case - find and parse cpu node, or maybe using some cpu_feature?

It's fundamentally a property of the serial controller implementation,
not of the processor, so the cpu_features are the wrong place to put
this. There should at least be a generic way to define thsi in the device
tree so that _future_ trees can just mark the port as compatible with
one that has this bug.

If you want to work around existing systems that don't mention this
in the device_tree, you could perhaps use machine_is(foo) to test
for it.

Another option altogether would be to allow the device node to
specify the linux specific serial port flags in a separate property,
like "linux,uart-port-flags" that contains the same flags that
setserial can set from user space. That would also be useful
if you want to specify UPF_MAGIC_MULTIPLIER on certain high-speed
ports, because it cannot be autoprobed.

	Arnd <><
