From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: Adding new driver - looking for suggestions
Date: Mon, 9 Jul 2007 13:37:05 -0400
Message-ID: <000001c7c24f$c4401f10$7a4b82ce@connecttech.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4070 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbXGIR7h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jul 2007 13:59:37 -0400
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id l69HbOqL093149
	for <linux-serial@vger.kernel.org>; Mon, 9 Jul 2007 13:37:24 -0400 (EDT)
	(envelope-from cdore@connecttech.com)
Received: from cdore (cdore.connecttech.com [206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id l69Hb4J11511 for <linux-serial@vger.kernel.org>; Mon, 9 Jul 2007 13:37:04 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>


Hi all,

We would like to add support for our (Connect Tech) multi-port serial
adapters to the kernel.  Currently there is some limited support for some of
our cards already in 8250_pci, however we have some specific functionality
on our cards that we would like to add.  We already have a patch for 8250
(and friends) to add the new functionality, however I'm starting to think
that it may be better to create a separate driver, based on 8250/8250_pci,
for our specific boards/needs only.

I'm looking for any suggestions on what we should possibly do.

A current patch can be found here:
ftp://ftp.connecttech.com/pub/misc/bhbltnptm-2.6.21.patch


Thanks, Chris

