From: Brad Davidson <kiloman@oatmail.org>
Subject: Equinox SST-8P Serial Controller and Linux
Date: Thu, 12 Feb 2004 08:16:09 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <402BA6C9.2090501@oatmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.oatmail.org ([198.145.35.3]:65291 "EHLO mail.oatmail.org")
	by vger.kernel.org with ESMTP id S266502AbUBLQQK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Feb 2004 11:16:10 -0500
Received: from obsidian.ghostbusters ([10.0.0.21] helo=oatmail.org)
	by mail.oatmail.org with esmtp (Exim 4.20)
	id 1ArKm6-000BFd-3j
	for linux-serial@vger.kernel.org; Thu, 12 Feb 2004 09:37:18 -0800
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello all,

I'm working on getting an Equinox SST-8P Multiport Serial adapter to 
work under linux.

I found an old (WAY old, 1997) post from Alan Cox talking about how the 
vendor-provided binary drivers suck, and are distributed poorly:

http://www.geocrawler.com/archives/3/59/1997/1/0/2206254/

The current release of the drivers claims to have been tested against 
4.2.21, and appear to work with the current release of 2.4 (tried with 
2.4.25-rc1). Full source is provided, and there's no mention of a 
license in any of the files or included documentation. There's a 
copywright header on the source files, but that's it. The source itself 
sets MODULE_LICENSE("GPL"), so I'm going to assume they meant it. Here's 
a link:

http://www.equinox.com/Driver_Search_Results153.cfm?uid=331

Has anyone ever tried to add support for this device to the kernel, via 
the 'non-standard serial port' section? I don't see any options for it 
in 2.5 or 2.6, and the driver certainly won't compile against either tree.

As I understand it, this board does some odd tricks with memory mapping 
to accelerate transfers:

ftp://gsyprf10.external.hp.com/pub/equinox/eqnx_sst-8p.pdf

I've never really mucked about much with kernel drivers, but I'm 
passable in C, and have browsed through O'Reilly's 'Linux Device 
Drivers'. Is porting a 2.4 driver to 2.6 something that can be worked 
through with sweat, tears, and some RTFMing, or should I just give up 
and leave my server in 2.4 in the hopes that Equinox will release 2.6 
drivers for this EOL'd card?

-Brad
