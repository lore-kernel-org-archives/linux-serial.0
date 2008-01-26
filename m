From: ian <spyro@f2s.com>
Subject: How to use serial ports from a kernel module.
Date: Sat, 26 Jan 2008 19:19:24 +0000
Message-ID: <1201375164.3368.6.camel@wirenth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:32906
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139AbYAZTT2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 Jan 2008 14:19:28 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi guys,

I'd like to use one of the serial ports on my embedded device from a
module (so I can write an input driver for the buttonpad on my PDA).

I need to be able to set the data type to 8O1 and set the port speed,
and send and receive data.

Whats the proper way to do this? Ideally I'd want to prevent userspace
being able to use the port which has the keypad connected, but not touch
the other two ports.

Thanks,

-Ian

