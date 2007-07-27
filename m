From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 14:14:51 -0500
Message-ID: <1185563691.23486.12.camel@x2.microgate.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	 <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com>
	 <Pine.LNX.4.64N.0707271216410.425@blysk.ds.pg.gda.pl>
	 <46AA2748.80703@howardsilvan.com>
	 <Pine.LNX.4.64N.0707271825220.425@blysk.ds.pg.gda.pl>
	 <46AA3801.7090204@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:44351
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763283AbXG0TPL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 15:15:11 -0400
In-Reply-To: <46AA3801.7090204@shaw.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Lee Howard <faxguy@howardsilvan.com>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

OK, I see where TTY_OVERRUN is set:
include/linux/serial_core.h:uart_insert_char()


--
Paul Fulghum
Microgate Systems, Ltd

