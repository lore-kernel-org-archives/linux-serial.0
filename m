From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: 2.6.25.3: serial problem (minicom)
Date: Sat, 17 May 2008 10:10:26 -0500
Message-ID: <20080517101026.270a6f4e@osprey.hogchain.net>
References: <20080517082207.4b1e8556@osprey.hogchain.net>
	<543631.10570.qm@web52902.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fmailhost05.isp.att.net ([207.115.11.55]:58801 "EHLO
	fmailhost01.isp.att.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754979AbYEQPKe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 May 2008 11:10:34 -0400
In-Reply-To: <543631.10570.qm@web52902.mail.re2.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, 17 May 2008 15:49:08 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

> Does yours still work if you raise the baud rate to 115200? 

No, but I also get garbage characters and a generally unusable logging
device.  57600 is slightly better, but not much.  I remember going
through this progressive reduction in baud rate a long time ago,
trying to find a speed that works reliably, which is why I settled on
38400. I get unpredictable results for anything higher.
