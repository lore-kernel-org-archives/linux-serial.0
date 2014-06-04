From: "Valerio Vanni" <valerio@valeriovanni.com>
Subject: Re: [PATCH 2/2] serial: core: Preserve termios c_cflag for console resume
Date: Thu, 5 Jun 2014 01:31:43 +0200
Message-ID: <lmoa97$q3h$1@ger.gmane.org>
References: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it> <1401891371-4946-1-git-send-email-peter@hurleysoftware.com> <1401891371-4946-2-git-send-email-peter@hurleysoftware.com> <20140604142232.GB1008@kroah.com> <538F3150.6040102@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51687 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754675AbaFDXcH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jun 2014 19:32:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WsKf7-0000bs-Fz
	for linux-serial@vger.kernel.org; Thu, 05 Jun 2014 01:32:05 +0200
Received: from 81-174-24-37.v4.ngi.it ([81.174.24.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2014 01:32:05 +0200
Received: from valerio by 81-174-24-37.v4.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2014 01:32:05 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

"Peter Hurley" <peter@hurleysoftware.com> ha scritto nel messaggio
news:538F3150.6040102@hurleysoftware.com
> On 06/04/2014 10:22 AM, Greg Kroah-Hartman wrote:
>> Same as before, regression, or just a normal "new feature"?
>
> This was reported as a regression since 2.6.24, but that was likely
> misreported, and more likely due to a userspace update which triggers
> the bug.
>
> I would be surprised if console resume _never_ worked if the serial
> tty was opened then closed, but it probably has worked for a long
> time.

I don't know what was my initial mistake, but I realized very soon it was 
not a regression and took away the "regression" flag from bugzilla.
I tried many and many kernels and all were failing. I tried also to go 
down from 2.6.24 version, but I had to stop rather early because at some 
point the kernels were incompatible with distribution (I don't remember 
the details since I did these tests some month ago, and later I tested 
only newer kernel versions).

The patches you sent are for -next? for -rc? for stable?
Can I try them on 3.13.11? (at the moment I'm using this) 



