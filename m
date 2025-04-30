Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2718641;
	Wed, 30 Apr 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011805; cv=none; b=apuacvqKj0DdaXy1YVe76Nv7wK4I+I3cZtRo4n9oo2nIM4MJV+9EB1WzP/ON/pI/ggKPF0IB4LMfLunQ3zf+YV+7tQgxk6MzqJumjDeGOrBp4aA0APgYcXLCQ2OAPHxfR+V6baszrRgCcDz2rze1gw0geWXj/JD3Mi3su9KQKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011805; c=relaxed/simple;
	bh=xHk6H/YNvrVLwKRMGPkNzbIOzEd05Cb/uDozPkZuwiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SbdHGhUivnsfW8F88I4H8hfQigl75ApkUGhzPWCA1wc4z9Mo4TM3CAqZ1wAMTpf3CPVcbtmaitKYFvXZvmwkdTvemOZPxabW1l52ik+rJkMU1p8Iz+qxblC6H4F8PYBCF2wUM95mqfCvDKceCzmXYiW/Gfm89JWCex7VhiegoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFt/ENqI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFt/ENqI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9ZdYh002822;
	Wed, 30 Apr 2025 11:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RqYNEjZ/BDjyq7y0Pmhe9j
	4xHHCqedlyJpgt+i2xESU=; b=lFt/ENqIzt358jYoKY3dl3zZTIFY/pj9NP5dHT
	2lD8+KwygbHaFTTbhH30hDdJpW6bJF2Dgy6I9FkXp4RwZcQj6Wzw9Omp9wH7xHW8
	WvKNz2M5EU81lhSO+xTYnCe2R3ON7CFd/kQgarHojcfQsowePnTHW0SN5aMJUCWa
	wrnuI+kDcnN3ysFQ9srMQa6SAglPAVubF6oiIq6rAw8C95U464w8EDRQSLvedRHh
	/MgRPC8nnmcUQzCexnddBdBviafUnRUD4uOtcRb72YbTHQopWtJFeM4umkB/3uyi
	5H90R+9r+M4ZcI/AkpV5jDZcLzUix1NKYHuvohWMVEZqR53w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u89wjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 11:16:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53UBGe1r002666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 11:16:40 GMT
Received: from bt-iot-sh02-lnx.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 04:16:36 -0700
From: Xin Chen <quic_cxin@quicinc.com>
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulzhao@qti.qualcomm.com>, <quic_chejiang@quicinc.com>,
        <zaiyongc@qti.qualcomm.com>, <quic_zijuhu@quicinc.com>,
        <quic_mohamull@quicinc.com>, Xin Chen <quic_cxin@quicinc.com>,
        "Panicker
 Harish" <quic_pharish@quicinc.com>
Subject: [PATCH v1] tty: serdev: serdev-ttyport: Fix use-after-free in ttyport_close() due to uninitialized serport->tty
Date: Wed, 30 Apr 2025 19:16:17 +0800
Message-ID: <20250430111617.1151390-1-quic_cxin@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=B7i50PtM c=1 sm=1 tr=0 ts=68120698 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=LtFcCqD5u6Uv6OvO8-cA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: av6yih-FKPN1iahcKdO_Hb2E1-Z6b8H6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA4MCBTYWx0ZWRfX77XsxLYVyWaD gQp/vKK50e89rHpbuniqYAFTvOjYfLuGb7jqbFDjfxZJPh83IJLCRyi9A5ClzrcXDInwtz4G6Gm by76BDTPwoU2VKgDzFfh+bzsqjObTV/PZhCJWGuegpKpgF2BuFEyxnORRtw9h4y1ry74xmK2tih
 l3S+hiaoJL806inuCSl5tmRNmKAwQLyQQq/owOPW4ehxdtPRv3zW8WN3Mn+PAoQKyoGla+8pRiJ i3aAdAfur2q+j7UrMIoIUi6CBrKxJNe+D6l/8XXBT7yoxyU2fiZxunZYogqwxukubChhAS1jRkf ILx5u7kyqQitfa+BhBuYiUXvhfWUeGyoHFwBcK0xNEiIltR6HrNyCGQrDiLEPwwfFMCjaBV+gFn
 I6M2R4V5hq2b6nUO004EZHTyquNS8GTouZGimbw5d8FSMlo4FCr/vBeoJDvn/YoLmyJER0r4
X-Proofpoint-ORIG-GUID: av6yih-FKPN1iahcKdO_Hb2E1-Z6b8H6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 mlxlogscore=766 lowpriorityscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300080

When ttyport_open() fails to initialize a tty device, serport->tty is not
set to NULL, leading to a use-after-free scenario in ttyport_close().

To fix this, initialize serport->tty to NULL upon failure and check its
value before reading.

Call trace1:
release_tty
tty_init_dev
ttyport_open
serdev_device_open
qca_setup[hci_uart]
hci_uart_setup[hci_uart]
hci_dev_open_sync[bluetooth]
hci_dev_do_open[bluetooth]
hci_dev_open[bluetooth]
hci_sock_bind[bluetooth]

Call trace2:
refcount_warn_saturate
tty_lock
ttyport_close
serdev_device_close
hci_uart_close[hci_uart]
hci_dev_open_sync[bluetooth]
hci_dev_do_open[bluetooth]
hci_dev_open[bluetooth]
hci_sock_bind[bluetooth]

Co-developed-by: Panicker Harish <quic_pharish@quicinc.com>
Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
Signed-off-by: Xin Chen <quic_cxin@quicinc.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 3d7ae7fa5018..287908f2009b 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -88,6 +88,10 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 	struct tty_struct *tty = serport->tty;
+	if (!tty) {
+		dev_err(&ctrl->dev, "tty is null\n");
+		return;
+	}

 	tty_driver_flush_buffer(tty);
 }
@@ -108,8 +112,10 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	int ret;

 	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
-	if (IS_ERR(tty))
+	if (IS_ERR(tty)) {
+		serport->tty = NULL;
 		return PTR_ERR(tty);
+	}
 	serport->tty = tty;

 	if (!tty->ops->open || !tty->ops->close) {
@@ -156,6 +162,11 @@ static void ttyport_close(struct serdev_controller *ctrl)

 	clear_bit(SERPORT_ACTIVE, &serport->flags);

+	if (!tty) {
+		dev_err(&ctrl->dev, "tty is null\n");
+		return;
+	}
+
 	tty_lock(tty);
 	if (tty->ops->close)
 		tty->ops->close(tty, NULL);
--
2.34.1

