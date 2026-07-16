Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC28326951;
	Thu, 16 Jul 2026 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184480; cv=none; b=nYoMVvtmS+QUPI2p2Z0z3ZGedrAIDWoxoLkPwq+JAftxii5GMH/ae5leAJbj6r/BtPrjjbaacMv2MNqglfMyDJTgfaMb+89ZKNgUo8r1R5B3V72YDqhOr1as+kCTfCvYZAOWKCFwHKfEja3D2xTmJb1TiZXPP5t65mZUrjiSgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184480; c=relaxed/simple;
	bh=iL6rcBDj4YdEG+BrlZUbA2p1B/PZEivfghYAT9zVSAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5v4dRWlIHD3njhGQC+jfz7yzGdol5fAXL4JytlS9KS5yn+o18Y2i5mY9569iYWMqbE7Sozioc0nzN6emVhxG4SB4KakeAE5N354Ty5lw4TG+GHBh0ClN5zm9gK7MbSZyDWBRfWI6TvRwRFLVdBQbH/JHEVAlHsmMcW2y1mExoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=UYC63Mg3; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="UYC63Mg3"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3xpLF1818358;
	Wed, 15 Jul 2026 23:47:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=KcqFdEGx9
	ifEWgTpQXC0YvaTEiljkyZSuvr3aBIsijQ=; b=UYC63Mg3xVXlLU0a47kKYIQkQ
	MM8WxhWvv/uqAKK1vhY+XJlY2j3VKeBHLeuj+fcJ5+Vk94ayQ8PCvqh0KEkffDaT
	LMP9Lhow5UtcgfMKwzh+yC8u3qFCpKWrsPkXZ21xN/C6mtE4mIZr7/OG/GJRz2g+
	N0KV+zsCyULgbfuRkntCS9OM/mhuTfUerIolvz8+X9FE258fcMolcodjhgE//693
	zbtG0pBvOXNRqQ9cKOdEYDP/lCyQjzZk4mh0t5izxI20GxfNxkTOCETkuNKhyuei
	ZOiCS8lSh3IBJeKc65VJ1bELpDDz6+bLxQsKaFkb5GtnB+lZ0ENIKeaE3PxDQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbnbdqdf4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Jul 2026 23:47:24 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 15 Jul 2026 23:47:23 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 15 Jul 2026 23:47:20 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <socketcan@hartkopp.net>
CC: <linux-serial@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yun.zhou@windriver.com>
Subject: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Date: Thu, 16 Jul 2026 14:47:19 +0800
Message-ID: <20260716064719.1401892-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2OCBTYWx0ZWRfX58xN8djre09Q
 zr5VpvCs8KUcyiUjl+Bjag27Agv1RIO0YAy++uCmjqIGzPnXuKyKCxo3xQI4nnteKOC3uZNA05R
 Jz4G+vGFrSGnh/t1QTFVYIFsEgamSdLCuBdFjk/WwhPRPOjmtSoysxUwZMdd+REn6pd0eB7oHBF
 iT1M2xB7s3yNTd94xloZP4/Z9+s2cPoptQoCP3h4S6SpX92jEd9r/eUx0Kdn+VDZXkzBL/ruq08
 YFWzwaGrjItugoITRKOni+/FTyX2TpHct6i3nxD9YUi+l1O55A20SJQwXFM2A8rjsN0R4RSLjMz
 qpVD8iZm+r2WO+rfRIW0ez7qEX2Tms4dP4UeX+L5Vacvmbu64psbdFQK+uC3A87TwPowTyKJLx3
 fmovg7MB6xBSaYQIUW8H0U91IaViM+WQObqGDBy95OxjkkIC/JlQNJhXCtOBoz667KuiwEOBpDz
 ji6dLvQEy4m33wC3+ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2OCBTYWx0ZWRfX1Z6lCq0sTljt
 OPg0Z4/0sbqIsGd/aFOqQAdwijUcilcFWX7g9BfjCIQ8cLcSDbuOEGJ3F8gO1pGdHRJgwoOe8PI
 8oYRhbHnl5MLwKvQooUHjWKmFAOr7c9zpgDWSFGCKJvgIDnYoZxb
X-Authority-Analysis: v=2.4 cv=VI/tWdPX c=1 sm=1 tr=0 ts=6a587e7c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=ORBgStWXSJTWfv0flmAA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Uq9SEa6k71S2RHdgtp84X9B7pJGvpY_l
X-Proofpoint-GUID: Uq9SEa6k71S2RHdgtp84X9B7pJGvpY_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160068

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
 - tty->ldisc is set to NULL during the window, so concurrent readers
   (tty_ldisc_ref, tty_ldisc_ref_wait) see NULL and return immediately,
   which callers already handle as a hangup condition
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
 drivers/tty/tty_ldisc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 27fe8236f662..248a6995cc53 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -556,15 +556,28 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
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
-- 
2.43.0

