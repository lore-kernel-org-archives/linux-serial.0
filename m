From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [Resned/PATCHv5 0/2] Serial fixes
Date: Thu, 16 May 2013 07:07:29 -0700
Message-ID: <87ip2jt3vi.fsf@linaro.org>
References: <1368632138-31695-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:41798 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab3EPOHd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 May 2013 10:07:33 -0400
Received: by mail-da0-f51.google.com with SMTP id h15so1678446dan.38
        for <linux-serial@vger.kernel.org>; Thu, 16 May 2013 07:07:33 -0700 (PDT)
In-Reply-To: <1368632138-31695-1-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Wed, 15 May 2013 21:05:36 +0530")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>

Sourav Poddar <sourav.poddar@ti.com> writes:

> Hi Greg,
>
> I have rebased this patch series on top of 3.10-rc1.

Thanks for the rebase.  

Once Greg queues these, I will queue the OMAP specific pieces (which are
not strictly dependent on the core changes.)

Kevin
