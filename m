Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5063C870E;
	Fri, 24 Jul 2026 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882874; cv=none; b=P2Clr+FnmRdviJOewuaKieqkLC465ZavzAgLCaf99B+oAZXnh+jTAtEsrAhlRdaOhYq8weTjuK6NY+e721sxpVnOWr9QcZBdpNOpT+SV55iGACdKFgRYd19eHa6eeoTYabl1+nIy/No7XpHfRre4d9gFLfhVq1fiOW8iBmHarg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882874; c=relaxed/simple;
	bh=h3NDiqX+rGNiXkzjGF9eTlJaijNZG4QBavzJjFgAaZc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pUxVCU4MlH4d7Bvi1BGU6yNxVyGsdlZp0o1ip+Jh0EWj8f69nyPq61UhOuuf5igslc4IRGmmY7BZSL3AzdHjWsOg+78pVPyo+vYnjaaP5LITNF0I5j8o2Bz0/sYDKr7Vw5KD6khTqZ6rm+0VbAhdctzJxL1ae0pu35//Det+1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=D36sMkOD; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="D36sMkOD"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O6oJfv1326143;
	Fri, 24 Jul 2026 08:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=bFjm9iSZE
	fLquS44SuJeUnoXzQySb3+Is/c2MrJyP2w=; b=D36sMkODn1BW5Dd+9gR0+WGz7
	kqT+zhLnkTZ7z8Haq0+m72EZYlrjQ8jUMP4gi/A9zp1L9oYXnE9hq+GSl220rL2U
	qwmhqyN5crkSGVJZNs0Kityh9Lk7EqLIAwk3O7Mx1eNwyvQzfhp4y0ToXdjGSv6R
	Hi49ZFcl8DkOcjsdUAghRGUaspujDKetadVcfj7+ioWLPwj002sxNum+1PwJsar4
	Um7/iXXcIfXkMxhNw1IxZWVssmfV87HwqNFHHNTAbJH/auma+sDpFiM4s7Q4dU0H
	no4qIMrvEs1w52l+wRPHqHf66u2QeNwWg5pymDRvynZSiUtGydOG7BRZZJb9Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fkdfsaabv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Jul 2026 08:46:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 24 Jul 2026 01:46:52 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 24 Jul 2026 01:46:49 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <socketcan@hartkopp.net>
CC: <linux-serial@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Date: Fri, 24 Jul 2026 16:46:48 +0800
Message-ID: <20260724084648.3879356-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OSBTYWx0ZWRfX/hsjabw3FN3L
 FI7UtUV+iDaklPsF3ADXhodYWwPNqSTDVIO/N8x5bGuILOIabmFV/gJEPQRYhGtPbYNIqhI2nyT
 gi1OkQ3tbNkcse0Jz0GiJN64f3l7B8yvrH1dKpT0WB3dzQcuUQdF
X-Authority-Analysis: v=2.4 cv=EKE2FVZC c=1 sm=1 tr=0 ts=6a63267e cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=Hu20QylcDlXMs8uSXQcA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: RP-VCYcV9A6QGH1hvMP68CROYlIKbXM5
X-Proofpoint-GUID: RP-VCYcV9A6QGH1hvMP68CROYlIKbXM5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OSBTYWx0ZWRfX1rYkdmNupDAz
 sl2N09jtM8A234nJFJS68kGD0SRtvqjKVFo0dIm2ePwRHp5zM7Mh7jI78/qLo3RlJkA6aXKTe9o
 QFRCSb3JO74S9RwDIPHvKpxyDMxOKwE86+BtZ6MYRV24MoQsHw6vcv15bcOp5B57RV5QX0GVSkG
 O/ZqfYmq0X+JoupnZhrlANsECB2m2McV/+lxZZWO3CqtlPwMoIHFpq11MnogXtErTP13ZVasdf7
 7Hm4m7QKOXvwbiHEeIX9pAi9OD/EkKTTHNQ5P3qBPOCoUnEeR+FtzzAIjDhnUgZDkhLiiI4wUZh
 xUhZNRw31P3EGXE47YFbYCg87Ahz5vU5KYeVQJySvd4jl8LVREX0+r2OOFQf0YBPyXjPqr8e80I
 tnj1eZvYb6kjL0ISST3dOSqIjWgb5i6iz3v7xJxseSJFZddJd/f2YNBygpU/CZNNu85rNHsvVy7
 5u15XrODOKt+HJ9cpbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240079

syzbot reported a circular lock dependency involving tty ldisc_sem and
the networking rtnl_mutex. The full chain is:

  rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex

The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
discipline .open() callbacks (slcan, slip) call register_netdev() which
acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
tty_set_ldisc().

Fix by moving the .open() call outside the ldisc_sem write lock. The
ldisc .open() is initialization of the NEW discipline after the old one
has been closed - there is no need for ldisc_sem protection at this
point since:

 - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
   hangup, or close
 - tty->ldisc is set to NULL during the window. tty_ldisc_ref_wait()
   waits for the transition to complete. tty_ldisc_ref() returns NULL
   which callers already handle.
 - tty buffer data stays queued until the ldisc is installed

The sequence becomes:
  1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc = NULL
  2. Release ldisc_sem(write)
  3. Call new_ldisc->ops->open() without ldisc_sem
  4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
  5. Release ldisc_sem(write)

Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3:
 - Use a while loop in tty_ldisc_ref_wait() to handle consecutive ldisc
   switches where a reader could see NULL again after being woken up.
v2:
 - Keep user-visible behavior unchanged: tty_ldisc_ref_wait() now waits
   for the ldisc transition to complete instead of returning NULL (which
   would cause spurious EOF/-EIO to concurrent readers).
 - Fix a race between tty_ldisc_ref_wait() and __tty_hangup() where a
   reader could block forever if it observed ldisc==NULL before
   TTY_HUPPED was set. Add wake_up() after set_bit(TTY_HUPPED).

 drivers/tty/tty_io.c    |  7 +++++++
 drivers/tty/tty_ldisc.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6b283fd03ff8..e2f82e80f397 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -649,6 +649,13 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	 */
 	set_bit(TTY_HUPPED, &tty->flags);
 	clear_bit(TTY_HUPPING, &tty->flags);
+
+	/*
+	 * Wake up readers blocked in tty_ldisc_ref_wait() that may have
+	 * seen ldisc == NULL but not yet TTY_HUPPED.
+	 */
+	wake_up(&tty->read_wait);
+
 	tty_unlock(tty);
 
 	if (f)
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 27fe8236f662..6ec93e6b8498 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -242,6 +242,16 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 
 	ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
 	ld = tty->ldisc;
+	while (!ld && !test_bit(TTY_HUPPED, &tty->flags)) {
+		ldsem_up_read(&tty->ldisc_sem);
+
+		/* ldisc may be NULL during a discipline switch; wait and retry */
+		wait_event(tty->read_wait,
+			   READ_ONCE(tty->ldisc) != NULL ||
+			   test_bit(TTY_HUPPED, &tty->flags));
+		ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
+		ld = tty->ldisc;
+	}
 	if (!ld)
 		ldsem_up_read(&tty->ldisc_sem);
 	return ld;
@@ -556,15 +566,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 	/* Shutdown the old discipline. */
 	tty_ldisc_close(tty, old_ldisc);
 
-	/* Now set up the new line discipline. */
-	tty->ldisc = new_ldisc;
+	/* Clear tty->ldisc so concurrent readers back off during transition */
+	tty->ldisc = NULL;
 	tty_set_termios_ldisc(tty, disc);
+	tty_ldisc_unlock(tty);
 
+	/*
+	 * Open the new discipline outside ldisc_sem. The ldisc .open()
+	 * may acquire locks (e.g., rtnl_mutex) that would create circular
+	 * dependencies if taken under ldisc_sem. tty_lock is still held,
+	 * preventing concurrent ldisc changes and hangup.
+	 */
 	retval = tty_ldisc_open(tty, new_ldisc);
+
+	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
+
 	if (retval < 0) {
 		/* Back to the old one or N_TTY if we can't */
 		tty_ldisc_put(new_ldisc);
 		tty_ldisc_restore(tty, old_ldisc);
+	} else {
+		/* Success - install new ldisc */
+		tty->ldisc = new_ldisc;
 	}
 
 	if (tty->ldisc->ops->num != old_ldisc->ops->num && tty->ops->set_ldisc) {
@@ -584,6 +607,9 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 out:
 	tty_ldisc_unlock(tty);
 
+	/* Wake up readers waiting for the ldisc transition to complete */
+	wake_up(&tty->read_wait);
+
 	/*
 	 * Restart the work queue in case no characters kick it off. Safe if
 	 * already running
-- 
2.43.0

