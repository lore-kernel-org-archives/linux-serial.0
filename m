Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE93BF680;
	Tue, 21 Jul 2026 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623914; cv=none; b=sOZSUFv2vrbH21eB9USoIof8Aj5W5sJsq0xqrwx9ZSOHUsFIusChFPi6QrYILHvWPbqiEuLwMgr6G5MvV5jlOHzETv8dYkujoYrb6fJdwuH3ProvVtwZ82f+0Ddvep4/uj2LjAonC9W7dcPhAK8+J/62bZmEL7H1DsE4wpUjqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623914; c=relaxed/simple;
	bh=SoLBNynEe6RP6GZr/WGkFJTkIsQZTYJOqotDsMfN56I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+mDGMslZhRFJkgwnqWReRrCJeL5iRRe9ZvpWnJnVpCAjMzzo44EmagLt2CTUzInGPWRxaGIg63rm6kZdc5uUG3UyUyCsfSwOiX9TH10n8T5GMFJ3kuUV44q+CT+IRX/iRn1FhpkMX+Jsj1aWa+e+x1iOlUUU84uaDPFLZTsT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=cYDp0lLx; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="cYDp0lLx"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8j8qW2119679;
	Tue, 21 Jul 2026 01:50:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=FWA+m5ggl
	nbyMH2Qe8AaTEJPWm8abKUsVXByjjyNNQI=; b=cYDp0lLxk82s1Gj1eYcTIxODh
	T5Zs23876QDRzaNraXnHmzPw81CJmFk3KSoWwBS05RzNUrktEggqbPiHgmzwrXl+
	tzJevAcqfRPbj18aI/vyLWcuwAlqP4mJXP5hyVGS4Wi9k7R7SsYKJw9tLHBp4Uvi
	s1YfcKFP2/QATXfxD8mEdK5LJe2X5f/4s8gQEej3c3clb+loTRYPHqeXlOecWsf/
	VuYe4YD159ca5cc1rculW6/UJ1ovwrx1EFj2DM2K3NJl3YZxYNxkLnMAfFICvnpD
	6xgzQg2D7+SU8+DXMSgw1+ud8tqpz+/ssSZ6g+N1oPYNTpDci7wbY46k+jh5Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg90cv3r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Jul 2026 01:50:39 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 21 Jul 2026 01:50:39 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 21 Jul 2026 01:50:36 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <socketcan@hartkopp.net>
CC: <linux-serial@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH v2] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Date: Tue, 21 Jul 2026 16:50:35 +0800
Message-ID: <20260721085035.2485657-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -shmOVSADsceu_kZVrR9YOdRW5jNLI51
X-Proofpoint-GUID: -shmOVSADsceu_kZVrR9YOdRW5jNLI51
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a5f32df cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=9RZP_3u8z-ZScuIyL4gA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfXwRTDOgvl04jm
 r/Q35WoMz7xywkeDyKWu4wubhVPpb7rAUDq3yLrab2rAcsL/7SaQvBhxmCubQNQm0o4114vEInm
 yDBi2jk4rM6J0AUPv95UacHR02d5oVgTAdxx22HVmvOe7oHi56tN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfXxsw2uMeEE20J
 C2v4aaY6IqhD3xigZqhGrIrZhOLx4vrZSnbOJOAi+J5Qzmz04XvUxCtZoK/VApBgAx5zWXGXirm
 teN5SVv9YcCdZFLUWZkW5fnX5Mx+Y7fzg8nnu7/w44yGTQD59k9PIqIMcpzgRLlgFUGeX0cWB/o
 bdFX0HK0oI+6ZbeKhL6RtS1OEmHw4fSzCM6SN2RpqN22PeS+tTNdx4gAF6LGI7rA6DwJBvsoKYk
 W3XAcfaoCEYqH2cwQNm/OnLHEp2LtizG7sGy3aHZwhCavUzuJPDUFqL1fhLazo8aKscXlDT3gZe
 vFKY5f1aq3U54kkxWfnIRsgXWRToCDowtWz5L5+PGKXMYb27J4KBv0yvz+elrhQSfQd6uiQlp+i
 4+pVNAVb9QENKT2VsSykw0hY64jF21IciAHGushy5z0FMe/cJOZpB7Agh39TBL3+4cv0IHPEzW3
 kwYuuBYqgJup6nXXvSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210092

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
v2:
 - Keep user-visible behavior unchanged: tty_ldisc_ref_wait() now waits
   for the ldisc transition to complete instead of returning NULL (which
   would cause spurious EOF/-EIO to concurrent readers).
 - Fix a race between tty_ldisc_ref_wait() and __tty_hangup() where a
   reader could block forever if it observed ldisc==NULL before
   TTY_HUPPED was set. Add wake_up() after set_bit(TTY_HUPPED).

 drivers/tty/tty_io.c    |  7 +++++++
 drivers/tty/tty_ldisc.c | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

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
index 27fe8236f662..bd94a1f13c44 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -242,8 +242,20 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 
 	ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
 	ld = tty->ldisc;
-	if (!ld)
+	if (!ld) {
 		ldsem_up_read(&tty->ldisc_sem);
+
+		/* ldisc may be NULL during a discipline switch; wait and retry */
+		if (!test_bit(TTY_HUPPED, &tty->flags)) {
+			wait_event(tty->read_wait,
+				   READ_ONCE(tty->ldisc) != NULL ||
+				   test_bit(TTY_HUPPED, &tty->flags));
+			ldsem_down_read(&tty->ldisc_sem, MAX_SCHEDULE_TIMEOUT);
+			ld = tty->ldisc;
+			if (!ld)
+				ldsem_up_read(&tty->ldisc_sem);
+		}
+	}
 	return ld;
 }
 EXPORT_SYMBOL_GPL(tty_ldisc_ref_wait);
@@ -556,15 +568,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
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
@@ -584,6 +609,9 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
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

