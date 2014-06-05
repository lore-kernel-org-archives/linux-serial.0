From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: Re: [PATCH 2/2] serial: core: Preserve termios c_cflag for console resume
Date: Thu, 5 Jun 2014 10:58:37 +0200
Message-ID: <lmpbg8$l79$1@ger.gmane.org>
References: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it> <1401891371-4946-1-git-send-email-peter@hurleysoftware.com> <1401891371-4946-2-git-send-email-peter@hurleysoftware.com> <20140604142232.GB1008@kroah.com> <538F3150.6040102@hurleysoftware.com> <lmoa97$q3h$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43670 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaFEI7E (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Jun 2014 04:59:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WsTVn-0000Ra-99
	for linux-serial@vger.kernel.org; Thu, 05 Jun 2014 10:59:03 +0200
Received: from 81-174-24-37.v4.ngi.it ([81.174.24.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2014 10:59:03 +0200
Received: from valerio by 81-174-24-37.v4.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2014 10:59:03 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

"Valerio Vanni" <valerio@valeriovanni.com> ha scritto nel messaggio
news:lmoa97$q3h$1@ger.gmane.org
> "Peter Hurley" <peter@hurleysoftware.com> ha scritto nel messaggio
> news:538F3150.6040102@hurleysoftware.com

> The patches you sent are for -next? for -rc? for stable?
> Can I try them on 3.13.11? (at the moment I'm using this)

I've tried the patches on 3.13.11, 3.14.5 and 3.15-rc8.
They work. Thanks for the fix :-)

When I tried to apply them to serial-core.c I got an error (in all three 
kernels "Hunk #1 FAILED at 239.").
I had to apply them by hand (with copy and past).



