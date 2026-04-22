Received: from mvsmtppost24.nm.naver.com (mvsmtppost24.nm.naver.com [61.247.196.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42233932DE
	for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.247.196.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880641; cv=none; b=lSjHDx/vE3WMU36Dh+PnwugDVBfHR5SUYAT0yHhR+vFLHE6BS0vRvacOklO3tOr5Sw2xlxrFQ1XTeqONoZvK9jy3d7lg9k66E6g7E2VT4EBgQZb1xLWJAtgazadSkDBL4XycbY7F1Wjr/AUTSuYwDBRPPSQbL+YL565WyHkERkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880641; c=relaxed/simple;
	bh=KbeJM7r0JIiRFTq/2vYPOFHv4GN+w1pTKLsu6MIatJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P8rlEcjZUhq54NWZ/XixCiwSVTBd6LUmTG4vbGDCLHwK6tI+j6MCquReW7VtkCcFQJ+sPVo2uH0vWK5WUJhAPvjfsTlMthNqx7D4rrLDSa+8bGcaaskBZP17PU6KEC8dyQkGSRzJ0Z1xVSocSYqyb54VUCxSRvAxZq2/6CG3piA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=DW6oS9Lr; arc=none smtp.client-ip=61.247.196.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="DW6oS9Lr"
Received: from cvsendbo017.nm ([10.112.18.57])
  by mvsmtppost24.nm.naver.com with ESMTP id +z7aNcVVRBu+RMY9r115Uw
  for <linux-serial@vger.kernel.org>;
  Wed, 22 Apr 2026 17:37:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1776879422; bh=KbeJM7r0JIiRFTq/2vYPOFHv4GN+w1pTKLsu6MIatJE=;
	h=Date:From:To:Subject:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=DW6oS9LrWz3z6gr2UNJX2KKcvCn/VZyYYH+Vw2KuOciJ2T4AsuBCNhtQ1+8zBfzDJ
	 TySYxFUbwaXppLs8B/ZodxWkBerNejWJx2b1msvrV3UAnGpVuKV6S58P8839FOC1XR
	 iAPXfX6TpuSj782hTp7kb9UBNuahNMKxuLT5p9mrTF9bSLrB5UDrCSebxkJ7wI3JWx
	 ighLbqkHef96cUR50oajm8V91qARjydn6AWM+6hq18depY3bHbzD96iCYOffGFLUub
	 GZoCY5Hedsl+FqM4Rs0yA2yVReYTw2c4+/shZt4Gw733KlyDEk3h7sI/qawprTGXVn
	 Hk5rA1VMADpTg==
X-Session-ID: l62BOuS9Tm6px0zWxj3vOw
X-Works-Send-Opt: E/YdjAIYjHmwKo2qKqJYFquqFNwkx0eFjAJYKg==
X-Works-Smtp-Source: IwYdaAMXFqJZ+HmZKogX+6E=
Received: from JMW-Ubuntu ([14.38.141.199])
  by cvnsmtp005.nm.naver.com with ESMTP id l62BOuS9Tm6px0zWxj3vOw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 22 Apr 2026 17:37:02 -0000
Date: Thu, 23 Apr 2026 02:37:01 +0900
From: Minu Jin <s9430939@naver.com>
To: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: fix memory leak in gsm_activate_mux
Message-ID: <aekHPX4zEYZoZFOp@JMW-Ubuntu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I found a memory leak in gsm_activate_mux() from the syzbot dashboard.
I have analyzed the root cause and created a fix.
Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next

---
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..de3d30eac86e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2645,7 +2645,12 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in

 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 {
-       struct gsm_dlci *dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
+       struct gsm_dlci *dlci;
+
+       if (gsm->dlci[addr])
+               return gsm->dlci[addr];
+
+       dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
        if (dlci == NULL)
                return NULL;
        spin_lock_init(&dlci->lock);
@@ -3196,8 +3201,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
                gsm->receive = gsm1_receive;

        ret = gsm_register_devices(gsm_tty_driver, gsm->num);
-       if (ret)
+       if (ret) {
+               gsm_dlci_free(&dlci->port);
                return ret;
+       }

        gsm->has_devices = true;
        gsm->dead = false;              /* Tty opens are now permissible */
