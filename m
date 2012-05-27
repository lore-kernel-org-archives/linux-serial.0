From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
Date: Sun, 27 May 2012 12:07:36 +0000
Message-ID: <201205271207.36770.arnd@arndb.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de> <201205271023.16742.arnd@arndb.de> <4FC21214.7060804@antcom.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61555 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2E0MIZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 May 2012 08:08:25 -0400
In-Reply-To: <4FC21214.7060804@antcom.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org

On Sunday 27 May 2012, Roland Stigge wrote:
> > Actually some of the other entries are wrong, too. The ns8250 entry should
> > be i8250, and I guess the 16750 and 16850 were also not made by national.
> 
> But maybe we should keep the existing compatible strings because
> existing boards/bootloaders are providing them already?

Right, we should only add to the list. Any entry that's already used potentially
needs to stay in there as you say.

	Arnd
