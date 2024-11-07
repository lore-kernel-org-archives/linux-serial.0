Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7114293;
	Thu,  7 Nov 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964825; cv=none; b=t3mXI8RyTfmTzjNtddJANQlNaa2O8168uJFqiaMJki99Kecxq0pJi3lRPQMlGIA+TCgar/dz8rd2vrkEH/tGMTc9/W+bo3C9dfoZfni3tRH7f2mBWxAJFkp3lTWu+2dSLDZBMtMeNF8D/aC8wF2Mf3+25NWw/O2k/uFeqA15VXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964825; c=relaxed/simple;
	bh=wdHUfCI1TF5YK8JqBfUOtgrwF72O63sgu6UiYdzXN1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V5uXuMWy/e8NZBL9RhWQ0ZZXKS66sgusnU4uDvLWZZdFMfI3wNtINxN871Mh4DZXU8egHM4Ce4gJi+I609cQgaNetfpQePvapD3tFO/G45SDPTTsARUZN6X6tMURW25RNpPUbKgH4Ly8corVIW/tbjZHfqCW8Jpf0vvokt4dZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9672c6d4e297-ec2ab;
	Thu, 07 Nov 2024 15:33:36 +0800 (CST)
X-RM-TRANSID:2ee9672c6d4e297-ec2ab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9672c6d4f48a-59aaf;
	Thu, 07 Nov 2024 15:33:36 +0800 (CST)
X-RM-TRANSID:2ee9672c6d4f48a-59aaf
From: liujing <liujing@cmss.chinamobile.com>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	maddy@linux.ibm.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tty: hvc: Fix incorrect formatted output
Date: Thu,  7 Nov 2024 15:33:32 +0800
Message-Id: <20241107073332.5483-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The termno parameter is defined as an unsigned int 
in hvc_opal_probe(), So the output format should be %u instead of %d.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

---
v1 -> V2: Modified the description of commit.

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 095c33ad10f8..1d2e7f2ce088 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -199,7 +199,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		/* Instanciate now to establish a mapping index==vtermno */
 		hvc_instantiate(termno, termno, ops);
 	} else {
-		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
+		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%u\n",
 		       dev->dev.of_node, termno);
 		return -ENXIO;
 	}
-- 
2.27.0



