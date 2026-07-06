Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB43F825B
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347780; cv=none; b=Me9vphNMNbUr261Clq/5cz/rffq/ZD5We3GCqTxcdb7OpSwwXK04OL0Fhb2VGDJDTHdwEOxjBqjOPwY4tuoQNsYR+sKddANNQoPWfHUL6fyBXJ3zrbkXQduQSKZ1jmJ4PXoQ+M3sLLkfRK2+7VHt3jiqlcn/J2J6HJRbI1JXZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347780; c=relaxed/simple;
	bh=6FvsDbN3UoX7fNP2wSm1ePE8lgLmZFJYv8Qsvd8npcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAxjSP3vh6Ulqp6fjZPOA1qqU9M/INa0mL8XbyX5oNZyTF1AXeLA874Z2XrdXmnOCuKxCIgMJt1UDsr+OkbjSoAe52xP0qoFXTY/25EY/6JvuKwtfHYWfVOqpWHIKTQTiTOKqKQx1xUCTR7/U9o+gkFCNVLw4Jr/d96MVqNFBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wwrEhulm; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="wwrEhulm"
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 8A92680F14;
	Mon, 06 Jul 2026 17:22:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp) with ESMTPSA id jMISF7xgMW20-t9UAF52r;
	Mon, 06 Jul 2026 17:22:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783347767; bh=xh1Wy2o3/jBWD7dp+vkeF2GaxrbgTxo0K/46VRRR3B0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wwrEhulmojxgmtm8PZItJC5MvBUH0976R95Lv5t+Ds0wLBu8eaK8i+SGSLJ3t3qMZ
	 izENVrET0B6q7Np6EMzFJLFWnB1ArNHIY7b09V5vorMmArcts2PXwUP16ax6XjPdgD
	 JsOD2sEgs37imxGa0EMuilylfyGk4t4mX35c/mxs=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous cleanup
Date: Mon,  6 Jul 2026 17:20:15 +0300
Message-ID: <20260706142016.3385636-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially reported by syzbot at as memory leak, actual issue is an attempt
to configure DLCI 0 (via 'ioctl(..., GSMIOC_SETCONF_EXT, ...)') more than
once without previous cleanup (likely requested with GSM_FL_RESTART). To
prevent such a scenario, including racy attempts to do it from multiple
threads, adjust 'gsm_activate_mux()' to grab GSM mux's mutex and throw
-EBUSY if DLCI 0 was configured already.

Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/tty/n_gsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..ce447477ccf3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3186,6 +3186,11 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
+	guard(mutex)(&gsm->mutex);
+
+	if (unlikely(gsm->dlci[0]))
+		return -EBUSY;
+
 	dlci = gsm_dlci_alloc(gsm, 0);
 	if (dlci == NULL)
 		return -ENOMEM;
-- 
2.55.0

