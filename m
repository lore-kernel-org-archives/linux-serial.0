Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A545DF59;
	Thu,  7 Nov 2024 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958439; cv=none; b=rIAFmBdq7cBe4mu2EhIfC6m+WsxCttyWZG0RkwFrcBaMdMehPixEZldPrzaIT6W2GGEvvYYCL1OepNctVNwYgW41Qqm1R2djSdK4HIZN+NgN1hlGEYK+qC5Gb3QYG07NKu7wJ7FYHi7pTuhYwTcky8FEmXw6iatr/Vdl062HFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958439; c=relaxed/simple;
	bh=XZ08kTYT5WJhIcvpY6egVP4kGFjCs9K7ef/jWYSPP3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ic+ikZjoF9KBqvDJU2jDn9ewqKZtQH/GYxrfgyZqSkmhVWOzpuc0uXSWHkjQuX36mRQmvnkcBQGcn6DjabEANBlvbEXycoo2tfD15p0AUxRPhehJuSAodsUm2ovCr/gbsASejT+QzjaiDc/WsUp6EkbP8AJXse62FTpGuC6GTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2672c545916d-1b185;
	Thu, 07 Nov 2024 13:47:07 +0800 (CST)
X-RM-TRANSID:2ee2672c545916d-1b185
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8672c5459fe5-52a9d;
	Thu, 07 Nov 2024 13:47:07 +0800 (CST)
X-RM-TRANSID:2ee8672c5459fe5-52a9d
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
Subject: [PATCH] tty:hvc:Fix incorrect formatted output
Date: Thu,  7 Nov 2024 13:47:04 +0800
Message-Id: <20241107054704.3247-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The termno parameter is defined as an unsigned int 
in hvc_opal_probe function,So when it output should 
be modified to %u format.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

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



