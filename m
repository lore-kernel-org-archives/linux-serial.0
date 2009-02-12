From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [patch for 2.6.29? 1/2] atmel_serial might lose modem status
 change
Date: Thu, 12 Feb 2009 12:44:20 +0100
Message-ID: <20090212124420.6685f79b@hskinnemoen-d830>
References: <200902112114.n1BLEa02013569@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:51128 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969AbZBLLqM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Feb 2009 06:46:12 -0500
In-Reply-To: <200902112114.n1BLEa02013569@imap1.linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org, akpm@linux-foundation.org, anemo@mba.ocn.ne.jp, itai.levi.devel@gmail.com, linux@bohmer.net, marc.pignat@hevs.ch

akpm@linux-foundation.org wrote:
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> I found a problem of handling of modem status of atmel_serial driver.
> 
> With the commit 1ecc26 ("atmel_serial: split the interrupt handler"),
> handling of modem status signal was splitted into two parts.  The
> atmel_tasklet_func() compares new status with irq_status_prev, but
> irq_status_prev is not correct if signal status was changed while the port
> is closed.

I think this is 2.6.29 material. It fixes a real bug.

Haavard
