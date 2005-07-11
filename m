From: "Matt Schulte" <matts@commtech-fastcom.com>
Subject: RE: Serial PCI driver in 2.6.x kernel (i.e. 8250_pci HOWTO)
Date: Mon, 11 Jul 2005 09:19:51 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNMEDDCLAA.matts@commtech-fastcom.com>
References: <20050710130343.A3279@flint.arm.linux.org.uk>
Reply-To: <matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp005.bizmail.sc5.yahoo.com ([66.163.175.82]:55929 "HELO
	smtp005.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261804AbVGKOT7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Jul 2005 10:19:59 -0400
In-Reply-To: <20050710130343.A3279@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

>From: Russell King [mailto:rmk@arm.linux.org.uk]On Behalf Of Russell King

>Can we see this code?
Because I was working on the assumption that the driver would no longer be
serial.c and would use only my card, I may have done some things that
weren't exactly the best practice.  This is partially why I am trying to
figure out the "correct" way to use the new serial driver.  Because I went
with the entire serial.c file, I don't think that I can post it.  However,
you can get my modifications here:
http://support.commtech-fastcom.com/fcap335_07_11_2005.tar.gz.  I renamed
the serial.c file to fcap_335.c and I changed the devnodes to be
/dev/ttyFCx.  I think every modification that I made has a comment //mds
near it.

>Despite being the maintainer for the serial layer, I'm not on linux-serial.
Right, I am on linux-serial and I had seen a couple of posts from you on
linux-serial, I kind of assumed that you were there too.

Thanks,

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com

