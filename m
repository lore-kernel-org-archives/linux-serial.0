From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] uartlite: move from byte accesses to word accesses
Date: Wed, 20 Jan 2010 20:23:43 +0100
Message-ID: <873a20mvgg.fsf@macbook.be.48ers.dk>
References: <28287b91-411c-4ae6-82b8-ec02a9d8e75d@SG2EHSMHS006.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:64556 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0ATTXr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jan 2010 14:23:47 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so3364076ewy.28
        for <linux-serial@vger.kernel.org>; Wed, 20 Jan 2010 11:23:46 -0800 (PST)
In-Reply-To: <28287b91-411c-4ae6-82b8-ec02a9d8e75d@SG2EHSMHS006.ehs.local>
	(John Linn's message of "Wed, 20 Jan 2010 09:45:21 -0700")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> From: XAQ IP Librarian <abq_iplib@xaqiptest40.(none)>
 John> Byte accesses for I/O devices in Xilinx IP is going to be less
 John> desired in the future such that the driver is being changed to
 John> use 32 bit accesses.

Why is it less desired?

Back when I wrote the driver, I used 8bit access on purpose to be
independent of register widths / endianess.

We have used the driver on systems where (something looking like) a
uartlite was behind a 16bit bus, so doing 32bit accesses would require
double the bus accesses.

Btw, the abq_iplib@xaqiptest40 address is (obviously) invalid.

-- 
Bye, Peter Korsgaard
