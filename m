From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Uartlite driver & CONFIG_CONSOLE_POLL
Date: Fri, 16 May 2008 09:47:18 +0200
Message-ID: <87ve1eg06x.fsf@macbook.be.48ers.dk>
References: <4826FC28.4090701@seznam.cz> <1210545557.5798.267.camel@localhost>
	<fa686aa40805112131td11daa7n6ba24c85a413b243@mail.gmail.com>
	<4827E073.9020301@seznam.cz> <482C4C90.8060606@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:12462 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYEPHw2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 May 2008 03:52:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so308081nfc.21
        for <linux-serial@vger.kernel.org>; Fri, 16 May 2008 00:52:26 -0700 (PDT)
In-Reply-To: <482C4C90.8060606@dlasys.net> (David H. Lynch, Jr.'s message of "Thu\, 15 May 2008 10\:45\:36 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dhlii@dlasys.net
Cc: monstr@seznam.cz, Grant Likely <grant.likely@secretlab.ca>, John Williams <john.williams@petalogix.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-serial@vger.kernel.org, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David>     One of the key differences between my uartlite driver and
 David> Peter's is that like many other serial drivers I have a timer
 David> to support irqless use. Just like Peter has UartLite Like
 David> devices with 16bit datapaths, I have UartLites with no
 David> interrupts.

Many others? I think not.

ls -l *.c|wc -l                     ~/source/linux-2.6/drivers/serial
62
git grep -l request_irq `git grep -l init_timer`|wc -l
9

 David>    I have tried (unsuccessfully) several times to migrate my
 David> timer code into Peter's driver. This is probably the most
 David> fundimental remaining reason I can not use Peter's driver.

unsuccessfully in what way? I afaik haven't seen any patches.

-- 
Bye, Peter Korsgaard
