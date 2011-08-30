From: marcus.folkesson@gmail.com
Subject: high speed (921.6 kbit/s).
Date: Tue, 30 Aug 2011 13:53:09 +0200
Message-ID: <1314705190-5819-1-git-send-email-marcus.folkesson@gmail.com>
References: <y>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37493 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab1H3Lxa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 07:53:30 -0400
In-Reply-To: <y>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

After this work around was implemented the system seems to behave good.

In fact, I don't really see why the system should hang since there is a 
max counter, so the loop cannot run forever.

The patch is tested on kernel version 2.6.32, but the driver is allmost
the same.

Please take a look.
Feedback is very much appreciated

>From Marcus Folkesson <marcus.folkesson@combitech.se> # This line is ignored.
From: Marcus Folkesson <marcus.folkesson@combitech.se>
Subject: [PATCH] serial: pxa: a brief description
In-Reply-To: marcus.folkesson@gmail.com

