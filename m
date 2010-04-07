From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] [V4] uartlite: move from byte accesses to word accesses
Date: Wed, 07 Apr 2010 21:43:30 +0200
Message-ID: <874ojnqc9p.fsf@macbook.be.48ers.dk>
References: <0c9c4833-e369-4c21-9def-b53100f885fa@SG2EHSMHS007.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54410 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab0DGTng (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Apr 2010 15:43:36 -0400
Received: by bwz1 with SMTP id 1so1175941bwz.21
        for <linux-serial@vger.kernel.org>; Wed, 07 Apr 2010 12:43:35 -0700 (PDT)
In-Reply-To: <0c9c4833-e369-4c21-9def-b53100f885fa@SG2EHSMHS007.ehs.local>
	(John Linn's message of "Wed, 7 Apr 2010 09:32:55 -0600")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, gregkh@suse.de, john.williams@petalogix.com

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> Byte accesses for I/O devices in Xilinx IP is going to be less
 John> desired in the future such that the driver is being changed to
 John> use 32 bit accesses.

 John> This change facilitates using the uartlite IP over a PCIe bus
 John> which only allows 32 bit accesses.

 John> Signed-off-by: John Linn <john.linn@xilinx.com>
 John> Tested-by: Michal Simek <monstr@monstr.eu>
 John> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Looks good,

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
