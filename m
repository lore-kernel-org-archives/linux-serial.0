From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: Saving data from the serial port
Date: Fri, 18 Apr 2003 18:02:19 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <015801c305f6$2eebb9c0$294b82ce@connecttech.com>
References: <11E89240C407D311958800A0C9ACF7D1A33E47@EXCHANGE> <20030418000627.GB442@lafn.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:36875 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S263216AbTDRVrm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2003 17:47:42 -0400
List-Id: linux-serial@vger.kernel.org
To: David Lawyer <dave@lafn.org>, Ed Vance <EdV@macrolink.com>
Cc: alexm@ndtel.com, linux-serial@vger.kernel.org

From: "David Lawyer" <dave@lafn.org>
> I don't think so (but of course you should use flow control).  There
> just isn't any way to use flow control to protect the FIFO buffers from
> overruns in Linux.  Flow control (for the input flow into a PC) only
> protects the serial 8K buffer in main memory.

Not true. Many modern uarts have on-board flow control both hardware
and software based. Turn it on and the hardware does the magic when it
finds its fifos getting full.

The caveat is that the remote side needs to support the same method of
flow control obviously.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


