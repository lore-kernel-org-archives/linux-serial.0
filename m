From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 01:17:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751997AbXHDXRA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Aug 2007 19:17:00 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org

Hi,

I tried using of_serial.c on a (PPC) MPC8241 based system, which has a 
"16650A" compatible double UART built into the SoC. Using of_serial.c 
causes the ports to be autoconfigured, and this fails. The loopback test 
fails, because the MSR register on 824[15] doesn't implement the 
UART_MSR_DCD bit. Question: what's better, teach 8250.c to handle UARTs 
without this bit, or set the UPF_SKIP_TEST bit in of_serial.c for these 
SOCs to skip the loopback test altogether? The latter is certainly easier 
and affects much fewer systems, so, I'd go for that.

Thanks
Guennadi
---
Guennadi Liakhovetski
