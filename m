From: dann frazier <dannf@debian.org>
Subject: missing fix for CVE-2005-0504 in moxa
Date: Tue, 2 Jan 2007 18:38:30 -0700
Message-ID: <20070103013830.GM17404@krebs.dannf>
References: <20060816225742.GD11954@krebs.dannf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:51055 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238AbXACBwG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jan 2007 20:52:06 -0500
Content-Disposition: inline
In-Reply-To: <20060816225742.GD11954@krebs.dannf>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: support@moxa.com.tw, dilinger@debian.org

hey,
  I noticed that the moxa input checking security bug described by
CVE-2005-0504 appears to remain unfixed upstream.
 
The issue is described here:
  http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-0504

Debian has been shipping the following patch from Andres Salomon. I
tried contacting the listed maintainer a few months ago but received
no response.

I've tested that this still applies to and compiles against
2.6.20-rc3.

Signed-off-by: dann frazier <dannf@debian.org>

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index f391a24..4388791 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -1669,7 +1669,7 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 
 	if(copy_from_user(&dltmp, argp, sizeof(struct dl_str)))
 		return -EFAULT;
-	if(dltmp.cardno < 0 || dltmp.cardno >= MAX_BOARDS)
+	if(dltmp.cardno < 0 || dltmp.cardno >= MAX_BOARDS || dltmp.len < 0)
 		return -EINVAL;
 
 	switch(cmd)
@@ -2711,6 +2711,8 @@ static int moxaloadbios(int cardno, unsigned char __user *tmp, int len)
 	void __iomem *baseAddr;
 	int i;
 
+	if(len < 0 || len > sizeof(moxaBuff))
+		return -EINVAL;
 	if(copy_from_user(moxaBuff, tmp, len))
 		return -EFAULT;
 	baseAddr = moxaBaseAddr[cardno];
@@ -2758,7 +2760,7 @@ static int moxaload320b(int cardno, unsigned char __user *tmp, int len)
 	void __iomem *baseAddr;
 	int i;
 
-	if(len > sizeof(moxaBuff))
+	if(len < 0 || len > sizeof(moxaBuff))
 		return -EINVAL;
 	if(copy_from_user(moxaBuff, tmp, len))
 		return -EFAULT;
@@ -2778,6 +2780,8 @@ static int moxaloadcode(int cardno, unsigned char __user *tmp, int len)
 	void __iomem *baseAddr, *ofsAddr;
 	int retval, port, i;
 
+	if(len < 0 || len > sizeof(moxaBuff))
+		return -EINVAL;
 	if(copy_from_user(moxaBuff, tmp, len))
 		return -EFAULT;
 	baseAddr = moxaBaseAddr[cardno];



-- 
dann frazier | HP Open Source and Linux Organization
