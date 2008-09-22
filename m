From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: tty_struct size
Date: Mon, 22 Sep 2008 08:23:32 -0400
Message-ID: <011c01c91cae$08df7800$1a9e6800$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:2140 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYIVMnY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Sep 2008 08:43:24 -0400
Received: from connecttech.com (cti2.connecttech.com [206.130.75.42])
	by inetc.connecttech.com (8.13.3P/8.13.3) with ESMTP id m8MCNtsf092303
	for <linux-serial@vger.kernel.org>; Mon, 22 Sep 2008 08:23:55 -0400 (EDT)
	(envelope-from cdore@connecttech.com)
Received: from cdore ([206.130.75.122]) by connecttech.com (8.10.1/UW7.1.1-NSCd) with ESMTP id m8MCNZe23050 for <linux-serial@vger.kernel.org>; Mon, 22 Sep 2008 08:23:35 -0400 (EDT)
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hi all,

Sorry if this has been covered before, I just want to clarify a comment
about the size of the tty_struct structure that I see in older kernels
(2.4.22 era).

tty.h:
"IMPORTANT: since this structure is dynamically allocated, it must be no
larger than 4096 bytes.  Changing TTY_FLIPBUF_SIZE will change the size of
this structure, and it needs to be done with care."

Doing some research I believe this comment is from a time when the TTY
structures were allocated using get_zeroed_page(), hence the page size
looking limit in the comment.  Since kmalloc() is now used it would seem
that this comment no longer applies, however I wanted to make sure that the
4K limit is not there for another reason.

So, do I need to worry about the size of tty_struct (I'm going to experiment
with the flip buffer, on 2.4.22)?


Thanks, Chris


