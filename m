From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/2] arch/powerpc support for MPC52xx serial driver
Date: Mon, 27 Nov 2006 14:21:00 -0700
Message-ID: <1164662462514-git-send-email-grant.likely@secretlab.ca>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from S01060016b61d1226.cg.shawcable.net ([68.147.191.145]:42125 "EHLO
	sandbox.secretlab.ca") by vger.kernel.org with ESMTP
	id S933685AbWK0VVP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Nov 2006 16:21:15 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
Cc: Sylvain Munaut <tnt@246tNt.com>, Nicolas DET <nd@bplan-gmbh.de>

Here are the serial driver changes required for mpc52xx support in
arch/powerpc.  First patch takes the opportunity to do a whitespace
cleanup seeing as the patch is undergoing heavy change anyway.

Cheers,
g.


