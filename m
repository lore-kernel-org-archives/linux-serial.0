From: Kumar Gala <kumar.gala@motorola.com>
Subject: (unknown)
Date: Tue, 16 Mar 2004 16:48:34 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <0E7928A8-779C-11D8-B4F3-000393DBC2E8@motorola.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from motgate4.mot.com ([144.189.100.102]:63151 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id S261772AbUCPWtL
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Mar 2004 17:49:11 -0500
Subject: 
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: Dan Malek <dan@embeddededge.com>, Tom Rini <trini@kernel.crashing.org>, linux-serial@vger.kernel.org

Russell,

I'm working on a new uart driver for the 82xx CPM that uses the 
serial_core.  I had a few questions about how things worked that were 
unclear to me.

1. how do tty's (in /dev/*) map to registered uart_driver(s)
2. what is the purpose of 'driver_name' and 'dev_name' in the 
uart_driver struct?
3. how are major/minor device id's being allocated for uart drivers?
4. how does uart_port line related to everything else?

thanks

- kumar

