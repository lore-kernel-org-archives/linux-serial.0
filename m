Received: from cvsmtppost23.nm.naver.com (cvsmtppost23.nm.naver.com [114.111.35.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67F29ACF6
	for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883422; cv=none; b=BT3eN6zlxZm2SD46nxzExDi9oFBn8rSd9zzwFnCgY5qZjmDtog+d7GSqmQK8AEdZ2PbftPDGcQlReiDUaAzYkJt6XKfUtP8Wpq3qREid1BtEfMAbKDHFjLsXHp9XrI4Umocg+8urf0jzZt/xogdMUnC7sGtzO04V8Ckbn4rvuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883422; c=relaxed/simple;
	bh=9XrIPgYRDo+W2usQFkeBYLACbA1KNyI8sLBUGQzR0Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB3QQz2kj1oReh4sCVbYSFKsihn5zvVE/XMHENPfqOB47QdcOUkzwafkKTIGAnZ+E9tJHmQFarJifK+BlljaR91Vjw/LH0wN8JUkqLiFytCcbaaweDZX5d8gnH0lPAB+L4+3EnqhSe1Q68DVv+LBTpEyCPYoH0tM4UWhQqtG1qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=jWijRy/C; arc=none smtp.client-ip=114.111.35.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="jWijRy/C"
Received: from cvsendbo009.nm ([10.112.18.55])
  by cvsmtppost23.nm.naver.com with ESMTP id 9y0g-jE4QEi3PolCvhNa0w
  for <linux-serial@vger.kernel.org>;
  Wed, 22 Apr 2026 18:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1776882811; bh=9XrIPgYRDo+W2usQFkeBYLACbA1KNyI8sLBUGQzR0Bs=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=jWijRy/CM1/0eAYyewrdNVIa0NkTTWpE7mPjNZDWWWfzeg1tz6VTdyaEqt+GLdLAz
	 Q2r4lljEYOox9QMveLPGrKgmNp67X3Afbi8Fxoxr2ywSE19bHDKy0OHcxWJJpOshLB
	 LcSUvALKzNTs0kPOz1DPT/Hc1sL20TvZpx4Yg/mF9+EB+XxI65fVxRvEzcru5KJwCt
	 kLZ9vx/naTaCTdnXIH0nDm55ZMu2SaXpNMIJxU1vKiRfw156TV22Y5S30deZKUb44k
	 5pkp2Ev49V5uO6F+VqKWJmJbXGICWELKD/IpAQNINEBFsyenkl1g/vvZthnSK67iU6
	 /WQrb+NKt45Ig==
X-Session-ID: 44z8U0u0Rb6xTqzhvo8sdw
X-Works-Send-Opt: B/YrjAJYjHmwKo2qKqJYFquqFNwkx0eFjAJYKg==
X-Works-Smtp-Source: Vmn9aAMXFqJZ+HmwKxtm+6E=
Received: from JMW-Ubuntu.. ([14.38.141.199])
  by cvnsmtp009.nm.naver.com with ESMTP id 44z8U0u0Rb6xTqzhvo8sdw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 22 Apr 2026 18:33:31 -0000
From: Minu Jin <s9430939@naver.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: daniel.starke@siemens.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Minu Jin <s9430939@naver.com>,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: [PATCH] tty: n_gsm: fix memory leak in gsm_activate_mux
Date: Thu, 23 Apr 2026 03:33:21 +0900
Message-ID: <20260422183321.596414-1-s9430939@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a memory leak in gsm_activate_mux().
The root cause is a missing cleanup path when gsm_register_devices()
fails. In this case, the previously allocated DLCI 0
and its associated kfifo remain allocated, leading to a memory leak.

And gsm_dlci_alloc() does not check for already allocated DLCIs.
Repeated calls to gsm_activate_mux() would overwrite the existing pointer
in gsm->dlci[addr], causing the original memory to be lost.

Fix this by:
1. Adding gsm_dlci_free() in the error path of gsm_activate_mux().
2. Adding a check in gsm_dlci_alloc() to return the existing DLCI
   if it is already allocated.

Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
Tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
Signed-off-by: Minu Jin <s9430939@naver.com>
---
 drivers/tty/n_gsm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..de3d30eac86e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2645,7 +2645,12 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
 
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 {
-	struct gsm_dlci *dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
+	struct gsm_dlci *dlci;
+
+	if (gsm->dlci[addr])
+		return gsm->dlci[addr];
+
+	dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
 	if (dlci == NULL)
 		return NULL;
 	spin_lock_init(&dlci->lock);
@@ -3196,8 +3201,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 		gsm->receive = gsm1_receive;
 
 	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
-	if (ret)
+	if (ret) {
+		gsm_dlci_free(&dlci->port);
 		return ret;
+	}
 
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
-- 
2.43.0

