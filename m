Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D583EC82D;
	Mon, 17 Aug 2026 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974944; cv=none; b=D3J471KFz+ykvUHLE5+cs60NUaz+cIbA6yv0WXDHOedBlN52Es5RQioeWF+empG7IL1+hfcIFBYiozMMoEtPYedpxLyymtk+uDCDFqpiKCcomD7zAcnYAubAGsMKfOPCDGgcB0zbr0IIp6FKWMGe3bGfdYI2/kG0r/t0yXaI0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974944; c=relaxed/simple;
	bh=2b28gpyO74OvnboGMfs6XMlpW97XwqylhC48G0RFMkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uqbxqzDmKAQ/4EasTXcCHNyEne7avg2S8+hRb0fjFFDrci5ZhZAqMqsLWeQv03DMnQhBJvG4Ks72q3jJDlM4Iefj303tD9Aj46LpDW+kR55n1kT6YYUyBdYUYcPEIK8w6BGesv9C8NsFACQ9axyCM26M759RRw/gZREuhVnXdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iddg0sOF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iddg0sOF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD68Ci2329989;
	Mon, 17 Aug 2026 13:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XB+1w/rL4F2agfvTbAyxmvx2OYmAWpqE2lq
	eMF8DoYY=; b=Iddg0sOFQRx0mqdPVPDxOhn1TnWLq/T9PZ09a3IsIXjzvKjWb7x
	nlH0c4EtXC6YxgwyyV/NvIlsxSCYVBBAEhPwjWr0e6vpy2eLrGtSna600P6mYzR4
	MDjRTzI8yZIkVJbqDNTJBYySas3NlDyYA4LVRQN9clDySjSApAM6X/l5ZTGyfNyz
	Q+XvfMGfRxcMbHqk2bd7NH+FQodhyIpIRJq7YaeI2zw7ccBTVETrCAoSjzPUFA+R
	P1Xj7ETUWjGvlKIyPh+HNKKBPc8GvTgvg0J9y85jt2y3f+yWVl8Ey2Wlx2i+itzw
	i1wcWtyeLrKcMzRFZbV8tkmvDWJ8S+Rp9Bw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3vghsx14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 13:55:33 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HDtTqQ011834;
	Mon, 17 Aug 2026 13:55:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4g2h6jnw2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 13:55:29 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67HDtTlG011829;
	Mon, 17 Aug 2026 13:55:29 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 67HDtT0L011824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 13:55:29 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4260555)
	id 17EA622948; Mon, 17 Aug 2026 21:55:28 +0800 (CST)
From: Xin Chen <xin.chen2@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liulzhao@qti.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        Xin Chen <xin.chen2@oss.qualcomm.com>
Subject: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline data
Date: Mon, 17 Aug 2026 21:55:26 +0800
Message-Id: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a8312d5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5IXlErGSFCVb9qIZTWgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwNiBTYWx0ZWRfX9PXhi14gv9GT
 aXd7dm6Jyz1vNW9k9v7HI1oTchOVwVw+sAc/u8aNG6JZAQ0xKHW13EzIKzLg9j3t0kZJaw7owEo
 XCOUA+8DQm+mtiqBi0mAS935PSYkMdI=
X-Proofpoint-ORIG-GUID: KcfK1MrntN3g5sL7QMnHOwcik0-JnSXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwNiBTYWx0ZWRfX6zOr2jqS5aVP
 BxXLG6uINICCbNwdQTI+CEfPofcetmyg2cgRfjndU1RRBgsXNU1i3L3CVBhu1jzBB7zMYp1a1fY
 nYgcOyKlFzEO4QE201giSGtALdKIV24tTeo+VD7SfeNPfyJtT/MjT1LBye271hF/LPg2HFwE+Ru
 2QAMJy3ju6SSYgZ3SOGOIJEdTf+wFIZTKvaLmHR82LJYEgvNgkwDcsO/YnFCHOoiSFuDyOo15aJ
 CtycCCYzcGX4/gV3hhFgGl41JSy6dczQCAJ9i4fjm7mqUdIw0FeTfAi3KlfNBjJcF65wCDAzNBK
 DcACkVMZEIbU01IvOzJ0sMYSoNP7G5r2pJbJ/Zrpdq2lzrTA7gJhVmrHPMTu2iVxht+ZfmNULeD
 //F3kesGHM0k//mKaCqcwH5iJ/pbA3b1mD/LIO5V331m/KpzfOltfd1Kq8fhRVfYVTI7uGaAzxp
 NdXVU3YQkYmK8wfkNog==
X-Proofpoint-GUID: KcfK1MrntN3g5sL7QMnHOwcik0-JnSXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170106

BT enable fails intermittently with -ETIMEDOUT (-110).  The kernel log
shows the HCI Read Local Version command was sent and the firmware
replied with status 0x00 (logged by hci_req_cmd_complete() BT_DBG),
but the waiter in __hci_cmd_sync_sk() never woke up and timed out
after 10 s:

  bluetooth hci0: Opcode 0xfc00              // __hci_cmd_sync_sk
  bluetooth hci0: opcode 0xfc00 plen 1       // hci_cmd_sync_add
  bluetooth hci0: skb len 4                  // hci_cmd_sync_alloc
  bluetooth hci0: length 1                   // hci_req_sync_run
  Bluetooth: hci0 cmd_cnt 1 cmd queued 1     // hci_cmd_work
  Bluetooth: hci0 type 1 len 4               // hci_send_frame
  Bluetooth: opcode 0xfc00 status 0x00       // hci_req_cmd_complete
  <-- req_skb NULL: req_complete_skb not set,
      hci_cmd_sync_complete() never called,
      req_status stays HCI_REQ_PEND            -->
  <-- 10 s later: wait_event_interruptible_timeout expires -->
  bluetooth hci0: end: err -110              // __hci_cmd_sync_sk

The root cause is that hci_send_cmd_sync() clones the sent command
into hdev->req_skb so that hci_req_cmd_complete() can locate the
registered completion callback.  Under memory pressure this
skb_clone() fails, leaving hdev->req_skb NULL.  The firmware reply
is received and processed, but hci_req_cmd_complete() finds NULL
req_skb, so hci_cmd_sync_complete() is never called, req_status
stays HCI_REQ_PEND, and the waiter times out with -ETIMEDOUT.

The memory pressure is caused by n_tty_open().  When a BT UART
transport is opened, serdev_device_open() may be called multiple
times in quick succession, each triggering n_tty_open().  n_tty_open()
uses vzalloc() for the ~10 KB n_tty_data structure, which always
allocates page-by-page from the buddy order-0 free list.  Repeated
vzalloc() calls drain enough order-0 pages that the subsequent
skb_clone(GFP_KERNEL) in hci_send_cmd_sync() cannot get a page.

Replace vzalloc/vfree with kvzalloc/kvfree.  kvzalloc() tries
kmalloc first and falls back to vmalloc only on failure.  The
~10 KB n_tty_data is served from the kmalloc-16384 slab (backed
by an order-2 compound page), leaving the order-0 free list intact
for the subsequent skb_clone() calls.

Note: checkpatch warns "Prefer kvzalloc_obj over kvzalloc with
sizeof", but kvzalloc_obj() was introduced after v6.6 and is not
available in the target kernel, so kvzalloc(sizeof(*ldata),
GFP_KERNEL) is used intentionally.

This issue was first observed as a use-after-free in ttyport_close()
when ttyport_open() failed, which was investigated in an earlier
patch series [1].  That investigation led to the discovery of the
true root cause described above.

[1] https://lore.kernel.org/all/20250430111617.1151390-1-quic_cxin@quicinc.com/

Signed-off-by: Xin Chen <xin.chen2@oss.qualcomm.com>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e6a0f5b40d0a..7ace11f6d600 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1870,7 +1870,7 @@ static void n_tty_close(struct tty_struct *tty)
 		n_tty_packet_mode_flush(tty);
 
 	guard(rwsem_write)(&tty->termios_rwsem);
-	vfree(ldata);
+	kvfree(ldata);
 	tty->disc_data = NULL;
 }
 
@@ -1887,7 +1887,7 @@ static int n_tty_open(struct tty_struct *tty)
 	struct n_tty_data *ldata;
 
 	/* Currently a malloc failure here can panic */
-	ldata = vzalloc(sizeof(*ldata));
+	ldata = kvzalloc(sizeof(*ldata), GFP_KERNEL);
 	if (!ldata)
 		return -ENOMEM;
 
-- 
2.43.0
