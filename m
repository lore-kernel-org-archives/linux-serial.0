Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147D388364
	for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139741; cv=none; b=Xv6vdCPND3Z3jfG32auOICO0pOsi5p/Ue9YGX6SVCejokZvEiyppz/XXeqpuYfczlh/ZYzkyaAjybwUiD0tDIbaSCU2ixv0Qo2+8DvQiDKznuZuTN8MWiBbh79l9QqEKGncZXE+WhFQsqtish2MemoQLoqTe3FroB2Cwu3adN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139741; c=relaxed/simple;
	bh=bVtnesSZgi5d15TH39dhPg834YO0cJlEpOGHYWaCwkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/5WL+exxU3i8pvp8tRJ7NZD7RRnfR6R52/Id8SlU6Hjte6m0yGLB+rxT/nu67E1Zq/Idj9g6exX+5ea12RrAwnawVsDrj60mCx0oOVtRbEqXaLJwBD2R9frvYS9eA54giidLYnbIW1y0/4DxHPsdB1wBaNjLfPU7tc8xOn3xT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJPkrguX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cDySQ4hg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJPkrguX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cDySQ4hg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AA4AkC2501223
	for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2026 10:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/2NolHMEAcoJKvp6qHfCPngf0pFz/e/JPbP
	GZ6RuwII=; b=jJPkrguXdBrngS9UNoqqlbVasJOeq2s3oqkcSaAGzVLk5jVjuxg
	hjbSY9nz5zuqlwa+qv4th4LrwvxYE8WGuzbejx5cNrhjlqAKuRnJR0ik0/zJ0T5b
	LI2n0/qU+BwHTI0UTHDhUXoyBYojfSrJSNyVp0h58BAnjA4hmFpP8r3JH3ZmXRoe
	kXCaWx0nvoGmdbnHKKqYUJDJRdJ5tXMzkBPBJbWF8oLnTB2KDpJ8el+7q+dD2uG2
	LmS8ZIjfIPrWX8s14VFUCJcQ//9BBVpCCgR2vbEc3IyYVFpGhLcfQ7xnmtqQcJPD
	PePHqT9iAHfYnOt3BNjnNm9LjlT+is665gw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3w8ytp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2026 10:48:59 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-466f1c3c647so21873526b6e.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2026 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773139739; x=1773744539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2NolHMEAcoJKvp6qHfCPngf0pFz/e/JPbPGZ6RuwII=;
        b=cDySQ4hgEVWS/kt252wcQ9yPbFSPbhV7zPbBZ5FXPBZwIn2EDgYPwlbJhtZOir+Puy
         XTzB8Lls7MrpSJYouShuvdyx+MLe/iR3iASxXZ+Yc/ITbFJpkVaG9Vzdb3veWmnrUnBC
         aEYEklA9jwyT8sTm9KItGmEn9LGmOSgJ6VAbJQzPEuPyR5ehxc3LT6NwnfXcTO59ZVpF
         s4HvYlSS8qdue0XItD/Xj+46Zhu6dTfxWe8dLGyJOOs7Sd8nn9QBtvdlS35vB2FSqYCm
         EhMP0r20YHbw4hVpBdqjK9cUqDYzasGwFSZcugfFyob42xtb5UgKPo7N8Mk+Qbc25+Dg
         m1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139739; x=1773744539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2NolHMEAcoJKvp6qHfCPngf0pFz/e/JPbPGZ6RuwII=;
        b=N1NHOD7JMslYowHJrZcp12FJ9YLo85nARr7ipCsTj3sMIinEG/Jk2ZkwJxy5rBX9vg
         ZHUAElwS0p0ZW4fmzHu9Ch34SnWFg6FdQ2jziUff/oexeI7eWc3L8c0tb9nV1TkTQQq2
         dkeAVaQ0yvC4DlYRX4C5O0PHbBmWMboyVWjX5pHgxZWPxM6Er2X1WeZpdz/L9Y0YDVtr
         r2wvBzvK6RT+RwtUL1sJvyguORTVjF8CjbpNSmo1sBifYAjQ9Wpe1FxAVxVeqA7UOl79
         dnR7pWayH4hYl6/2JCwRlKIRnmqrGTDwvfPs1ZZKcSSYANCeosiTixEhIYEj2Qgq6zZW
         MZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCVt6gIAiMC8mm+zseQs0qBO/Y6vsiSNTGFtO+6zXPf4UB6AJvPtN6K0CtMitVK6CxNVAPoRLb7l//XhoeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqKJcFW5jtnaVGn8PbxWlqpob4EJXPVMt6T3nLwMh0msnawfu
	L0mevOIA0c5OxJL9coLZs1XpvSgposarW+6DqUpq9OXlpLno3G0U16JnzG52orSVP6CtG1x6N1S
	7nanyCXqanSK4PWIvqIr99AEVhcF4azO9rmq2rO/+Py/PVy1Q962llUKYS79cIWyvZkc=
X-Gm-Gg: ATEYQzzXpd2k85HBjbNqPCUsNLZixsaOjfHyTyThZsdRjqpMUyVlgzF5Dnu2WLgygwj
	u/mmDVapdc4RPh0nlfX+WNjmc5JQw2jSlRt/PU0gHu8Hm4Pk5JnD3ebHAONc4fHfLQb6K2wG5td
	qnoT8LTKXYaLHjO8nzYpne0qPhZel8KPuwScjd1l7UMGpiRNg2g1WCe1SnByk83oM9R1Wqizfyj
	s8vfJyPmNtfqPu5wiCC1wGj8aZqJYdeXyAltvhacDJNphA0Momstv8bsOJ5Y9Fb1TWJDLoiXkq4
	EEHvM/sTkkTgb46G0Sl7N+1Q0UoUqvvUrpjnxuWs4xBcgSNyvZBppqloBefYwh2bYsBVhlkmc9E
	UXt4lJDrjr/g2K57A+ZgSkbWjqd9KhpL229cfaEfLNr/W05ikF+ke6b0=
X-Received: by 2002:a17:90b:1850:b0:359:f9fa:147 with SMTP id 98e67ed59e1d1-359f9fa0257mr460442a91.3.1773139324279;
        Tue, 10 Mar 2026 03:42:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1850:b0:359:f9fa:147 with SMTP id 98e67ed59e1d1-359f9fa0257mr460431a91.3.1773139323834;
        Tue, 10 Mar 2026 03:42:03 -0700 (PDT)
Received: from hu-anupkulk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0c9666sm11110278a12.14.2026.03.10.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:42:03 -0700 (PDT)
From: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        praveen.talari@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        viken.dadhaniya@oss.qualcomm.com, quic_zongjian@quicinc.com,
        quic_jseerapu@quicinc.com, krzk@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
Subject: [PATCH v1] serial: qcom-geni: Fix RTS behavior with flow control
Date: Tue, 10 Mar 2026 16:11:55 +0530
Message-Id: <20260310104155.339010-1-anup.kulkarni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MyBTYWx0ZWRfXxu45R9b2rB8E
 bltrwtKDfJlArlxKOUvOlnNl79yfAjOi6Lla3oIkyvRyDTS6U+LLgXe2FWI54PGyvkgHFde7GwM
 6Une2k43FX9rrXK/cDwkLRE7uX2FPt6I2nuGUDOm8ks3brjjxniOI2c6FL+JFhqdE+Dgsp2g5wK
 +CrPrONSFCbgNPLzi6yiooD4Aa3Xg9JZ0y9qiJ/4x+83iz/pdsAp5ifmi1IyPSEM9CkoSshocE5
 T0gghpgbzcqvNBz2aQUVFedvoGFMVNW6ewKner3lKswFFuLZpeUFW1tuU6nDXfAHH8RSZwX7Cpa
 vKybCM114uQ9Mmz7iXjpKB5HtoBsYQOw2RXKvGuCrlK9W3y80YICK6fPpl/VrbmWtLrFnb0EIOP
 9YLYyj8TecsDdhg4+ALiI9CCDer0vvvGSQQyJ8COxn4rM0xmUIXZS5LX4Ax2TU68sMym7VRq8rs
 CwtO5qzHLZID5iC+u4g==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69aff71b cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0mDEy32cLckCWZYzXtIA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: At2IXowGcQqHDyrNSnX7CNPiJpwH_TAH
X-Proofpoint-GUID: At2IXowGcQqHDyrNSnX7CNPiJpwH_TAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100093

When userspace enables flow control (CRTSCTS), the driver
deasserts RTS even when the receive buffer has space. This prevents the
peer device from transmitting, causing communication to stall.

The root cause is that the driver unconditionally uses manual RTS control
regardless of flow control mode. When CRTSCTS is set, the hardware should
automatically manage RTS based on buffer status, but the driver overrides
this by setting manual control.

Fix this by introducing port->manual_flow flag. In set_termios(), disable
manual flow when CRTSCTS is set. In set_mctrl(), only assert
SE_UART_MANUAL_RFR when manual_flow is active. Verified by enabling and
disabling hardware flow control with stty.

Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..9854bb2406e3 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -146,6 +146,7 @@ struct qcom_geni_serial_port {
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
+	bool manual_flow;
 
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
@@ -250,7 +251,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 	if (mctrl & TIOCM_LOOP)
 		port->loopback = RX_TX_CTS_RTS_SORTED;
 
-	if (!(mctrl & TIOCM_RTS) && !uport->suspended)
+	if (port->manual_flow && !(mctrl & TIOCM_RTS) && !uport->suspended)
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
 }
@@ -1401,11 +1402,21 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	else
 		stop_bit_len = TX_STOP_BIT_LEN_1;
 
-	/* flow control, clear the CTS_MASK bit if using flow control. */
-	if (termios->c_cflag & CRTSCTS)
+	/* Configure flow control based on CRTSCTS flag.
+	 * When CRTSCTS is set, use HW/auto flow control mode, where HW
+	 * controls the RTS/CTS pin based FIFO state.
+	 * When CRTSCTS is clear, the CTS pin value is ignored for TX
+	 * path and RTS pin can be set/cleared using registers, for RX
+	 * path.
+	 */
+
+	if (termios->c_cflag & CRTSCTS) {
 		tx_trans_cfg &= ~UART_CTS_MASK;
-	else
+		port->manual_flow = false;
+	} else {
 		tx_trans_cfg |= UART_CTS_MASK;
+		port->manual_flow = true;
+	}
 
 	if (baud) {
 		uart_update_timeout(uport, termios->c_cflag, baud);
-- 
2.34.1

