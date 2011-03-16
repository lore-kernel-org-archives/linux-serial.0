From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 70/76] tty: move cd1865.h to drivers/staging/tty/
Date: Wed, 16 Mar 2011 14:12:40 -0700
Message-ID: <1300309966-5745-70-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32804 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754700Ab1CPVPg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:36 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Arnd Bergmann <arnd@arndb.de>

The file is required by the specialix driver, which was
moved to drivers/staging/.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/{char => staging/tty}/cd1865.h |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/{char => staging/tty}/cd1865.h (100%)

diff --git a/drivers/char/cd1865.h b/drivers/staging/tty/cd1865.h
similarity index 100%
rename from drivers/char/cd1865.h
rename to drivers/staging/tty/cd1865.h
-- 
1.7.4.1

