From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 69/76] Staging: tty: fix build with epca.c driver
Date: Wed, 16 Mar 2011 14:12:39 -0700
Message-ID: <1300309966-5745-69-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33007 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab1CPVPf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:35 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>

I forgot to move the digi*.h files from drivers/char/ to
drivers/staging/tty/

Thanks to Randy for pointing out the issue.

Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/{char => staging/tty}/digi1.h    |    0
 drivers/{char => staging/tty}/digiFep1.h |    0
 drivers/{char => staging/tty}/digiPCI.h  |    0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename drivers/{char => staging/tty}/digi1.h (100%)
 rename drivers/{char => staging/tty}/digiFep1.h (100%)
 rename drivers/{char => staging/tty}/digiPCI.h (100%)

diff --git a/drivers/char/digi1.h b/drivers/staging/tty/digi1.h
similarity index 100%
rename from drivers/char/digi1.h
rename to drivers/staging/tty/digi1.h
diff --git a/drivers/char/digiFep1.h b/drivers/staging/tty/digiFep1.h
similarity index 100%
rename from drivers/char/digiFep1.h
rename to drivers/staging/tty/digiFep1.h
diff --git a/drivers/char/digiPCI.h b/drivers/staging/tty/digiPCI.h
similarity index 100%
rename from drivers/char/digiPCI.h
rename to drivers/staging/tty/digiPCI.h
-- 
1.7.4.1

