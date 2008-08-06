From: Sergey Lapin <slapin@ossfans.org>
Subject: Interface for setting half-duplex transmitter mode
Date: Wed, 6 Aug 2008 23:25:19 +0400
Message-ID: <20080806192519.GB21558@fan.ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fan.ossfans.org ([64.79.206.219]:39693 "EHLO fan.ossfans.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbYHFTpQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2008 15:45:16 -0400
Received: from fan.ossfans.org (fan.ossfans.org [127.0.0.1])
	by fan.ossfans.org (8.14.3/8.14.3/Debian-4) with ESMTP id m76JPJiG008051
	for <linux-serial@vger.kernel.org>; Wed, 6 Aug 2008 23:25:19 +0400
Received: (from slapin@localhost)
	by fan.ossfans.org (8.14.3/8.14.3/Submit) id m76JPJ4Q008050
	for linux-serial@vger.kernel.org; Wed, 6 Aug 2008 23:25:19 +0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi, all!

Is there any interface API for userspace, which I could use
to set RS-485 mode on UART (which suports it via hardware, by setting 1
bit in configuration), which means half-duplex mode with RTS line
toggling. Now I have it hard-coded for appropriate UART,
and seen patch which sets this from platform data, but
is there some API to do it dynamically?

I know I could implement this by ioctl mechanism, but
I need some non-standard ioctl number for that. Is there
some sane way to accomplish my goals? I mean one which be accepted to
mainline?

Thanks a lot,
S.

