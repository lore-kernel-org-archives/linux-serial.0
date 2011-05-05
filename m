From: Ali Bahar <ali@internetdog.org>
Subject: Re: Config. tips sought: Serial-console garbles boot messages.
Date: Thu, 5 May 2011 12:07:40 +0800
Message-ID: <20110505040740.GA32433@internetdog.org>
References: <20110504042106.GA25237@internetdog.org>
Reply-To: ali@internetdog.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from msr7.hinet.net ([168.95.4.107]:61888 "EHLO msr7.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab1EEEGl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 May 2011 00:06:41 -0400
Received: from suxbox.internetDog.org (220-141-34-152.dynamic.hinet.net [220.141.34.152])
	by msr7.hinet.net (8.14.2/8.14.2) with ESMTP id p45455uP011194
	for <linux-serial@vger.kernel.org>; Thu, 5 May 2011 12:05:05 +0800 (CST)
Received: from ab by suxbox.internetDog.org with local (Exim 4.72)
	(envelope-from <ab@internetdog.org>)
	id 1QHpqm-0008Ra-Qo
	for linux-serial@vger.kernel.org; Thu, 05 May 2011 12:07:40 +0800
Content-Disposition: inline
In-Reply-To: <20110504042106.GA25237@internetdog.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Wed, May 04, 2011 at 12:21:06PM +0800, Ali Bahar wrote:

> - serial console grables all the boot messages, until just at/before
> the log-in prompt. Then, if I reboot, the 'shutdown' messages continue
> to be seen correctly until boot-up begins again.

It should go without saying that the baud rates etc have been set to
match on both ends.

  Dev. Host                  Target's /proc/cmdline
  115200                     console=ttyS1,115200 console=tty0

Partity etc match, too.
