From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 0/2] Add support for Freescale QUICCEngine UART
Date: Wed,  9 Jan 2008 17:35:04 -0600
Message-ID: <11999217062265-git-send-email-timur@freescale.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:41663 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbYAIXfZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jan 2008 18:35:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org


This patchset creates a new serial device driver for the Freescale QE.

Part 1 of this patch set contains all the PowerPC-specific changes.

Part 2 contains all the actual driver and changes for Kconfig and Makefile.

The PowerPC portions of this patchset have already been reviewed and 
approved.  I'd like someone from linux-serial to review the actual driver
itself.
