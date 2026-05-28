Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66402D9780
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951960; cv=none; b=KQQ4J1g8pcWA5LtrXUQ1yGGlBP6wpRI6as38huXBLgcoD4PcDhFkvFwFi+5HzkG7fyM9NvANGWR/XWZoHy7ypxz0ozHnFH0+l3DDXyh0pNsu1X5UvmisCaVgJbOpgfpPyD2fxor5gVWB4jKCbTvSciOEjC+n2Spffd83VHOGuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951960; c=relaxed/simple;
	bh=6l8wxJF78Sm1qsTECaxMR9Jxhn223y61PPSh2SXZlS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pU/z6+qryLkZVmKEx09G/eRenE8Q7qaAFtErdkNVtaQkR0Z44X7VLFvKcx/RfrxWBlZ5Em7D3skaUIY3f3FR+0bg0Od7x9ID1C4snkhs9UeGZHx3XkCJ6S87r84yokkpGOaC+MQH3fQhEdAjBkdxPsQ+in/87sxhIeSAd3ny3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bgPYNmfQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhsT5a43; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgPYNmfQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhsT5a43"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKllle2753827
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 07:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zn6MXtkf9VBJ8MXm0zIEgP
	KH57WoIwNAFOEHdnwNHIc=; b=bgPYNmfQMbjVL09cnXhdpMohLOhH+CCcQ0k/ap
	+1M1nLQVRAxexVFW2mfewS+0zEpvMH8aChUnN1/DmfUhWttXNnnxDvQrrz/Q44gh
	T9hbhMTiEcQJSXIq/5OEnTl4TWrc0Dno3lJI0l1VDndJhN9LrsPXjkWEuyrb+9xP
	e5jqn4jiV3UcZSgRRhnR3hqE/AaWc3VgWO6jbsjxc8BRKx+XxbEl4ah9RC07A+qj
	YuJIzrYrvQkEEAzggRQugkYQ5CUOS+LG+1NFn7KQp0O+8d+sDO06tXcWMcaBtG2w
	Yc/Oh+UOLRpl/s50ToAFo3LmQFfMTvfnONENljb07Ap2P1uQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yc9qah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 07:05:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-835423c69ffso6634512b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779951957; x=1780556757; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn6MXtkf9VBJ8MXm0zIEgPKH57WoIwNAFOEHdnwNHIc=;
        b=BhsT5a43gUVLEYbnN1XcHr1BP3HdyAQU59u/yF0GosDvh8U7uMTRj+HtO0vOk7f7Iw
         VWb8ZViuQ2bf1hr2FIq68mnvyBV5JTGj3YOsKLxGtC+sRuBANzoMpV9wI9xr9M7lJyLA
         9Ua/oABJVBFaR1w8jqGXVMOxHjOA9NW/O6AGoZXzP7aLFbH6ql2fX6lDXEW1Vkxnc7WR
         VrxiiyfeVC3Nv/lApBDYQZ/bVKrbUgSDxKgkebq6j/l1xw1Eg7C+uQjX8YZNLomyhEqw
         MkCy1acT4d8NPCGEjQj0aUuN+YFneV769nufYWEu5S4sH3Qj6eoK2p6Nvdae+NcXaNix
         tXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779951957; x=1780556757;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn6MXtkf9VBJ8MXm0zIEgPKH57WoIwNAFOEHdnwNHIc=;
        b=SC9ZquN0aXQVsIHyFHthov2DPmV2rgiha4Xwd4GQGypf/OoWbMg2p6NGty9GcRJWt+
         BKVf28WHZEuRF1lsSZEkHWXsFb9jrfScDBgcQjBocxxcMCB1VteXBsq9hUe/IzWPw9I2
         BzDN46lEs5CxGBrdwOvFzolgSTuBT9waE3+kCUS6F+3LNblBudZkYlSQRpZCaIbZTEYC
         D4QERtQOpsrAWv8FK6UG/kjRms6R/cD1MtN1MVSqCRNUgYZnpfILWWwgupJXVDegIA9L
         /e4cyRdGzQyHWwRexIVfPiwZdPDju+qH8Tb2D67IJPEO2XwNvSRbHKmg+YxTJZb+HNtY
         1gmw==
X-Forwarded-Encrypted: i=1; AFNElJ94yDnx+/bFTm3EAI2hSeVPEpvHZtb5SqQtf99+Nf+X0L0ElE9o0PeB1gpKmvDrbUe01tRAG/9MOK9GdWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQT/bYJ3S5k/j9nqYEERU377jxxX2kNyjB/Xkm62xiueqVEsj
	A57vGQc79YZePZLLmCYvBe9xgdwJaJOO9X3YlS8BEpLy1K7qGRuCSmL9WHTx5QEOrHOGlig6mZo
	US6/1kmWSA4yqgmCnEWETDgoTmjCyR90iSDzRdtNFpjS8dQdBr1iRDQqKedyiaEdmVMM=
X-Gm-Gg: Acq92OFRwDPPC1bAl4ZFuTqZilUXaWrZliZRKHFIyLUEthpcwD9QoRtXR9NSsenEmCk
	FG8p5RuCUIWi79BfpGDRrlxD1G1/NFFvI9iKGK+C3mYDeZ7K5ZmgkzI7hzJxUw0ZJKi+kUptgT+
	M2l6FS3aXlYiUlmBzvjMj/5lHISP0gFnmAHgEZMOuhCgOqT+AiwzuH07IK0Y/Lq7aqB74FxVX3i
	qMH4mRrsnqZ3DKGEdYYQRTANd37g3dzt78wJNCu1OHIvNRSi31ZGzy4Og97vHWmjBgUbdPP18gh
	qA1tsv2VjBFnREqnyviT2yPli78ig6hREQ4G4Xk7u2WeTLs8qxR0ZMxYGv/lkhZmaQ3N2wD7rY0
	sENtycjDzjdAh0bQEtpvpmk+hci29/lAo4XFFPCXWREIshNGIdKKTbUoLS7+tk3CNSEmR
X-Received: by 2002:a05:6a00:14c8:b0:82f:559d:ece3 with SMTP id d2e1a72fcca58-8415f32d5ffmr23009163b3a.15.1779951956710;
        Thu, 28 May 2026 00:05:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:14c8:b0:82f:559d:ece3 with SMTP id d2e1a72fcca58-8415f32d5ffmr23009126b3a.15.1779951956049;
        Thu, 28 May 2026 00:05:56 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6ed19c2sm3992512b3a.25.2026.05.28.00.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 00:05:55 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:35:43 +0530
Subject: [PATCH v1] serial: qcom_geni: Fix RX DMA stall when
 SE_DMA_RX_LEN_IN is zero
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-serial-rx-0-byte-fix-v1-1-dc4e876c7368@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEbpF2oC/yWMQQqDMBREryKz7ocYqKa9SulC46i/FFsSFYt4d
 2NdvsfMWxEZlBH3bEXgrFE/Q4L8ksH31dBRtEkMa2xhrtbJsa/eEhYxUv9GSquL0N8a43zL0hH
 p+g1M+p99YM7xPF2c6hf9ePSwbTuPFbeTfAAAAA==
X-Change-ID: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779951953; l=1800;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=6l8wxJF78Sm1qsTECaxMR9Jxhn223y61PPSh2SXZlS0=;
 b=+CUlkAPdkKpET1LGpF5QcG9RbMucMjNy+72nXZrNy/joe/1WCcEiyd+WIKFK/dhG8m1LZO3gg
 DHChh8zKlLeBWOrV6AqXRlusZMnA5WxJtbt3mC0ryM/paua7rVKMIip
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a17e955 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=e3_-XpViw8z6FsUMn4gA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: YPHK0EgJ6HfydyHygfwMKuWHByoAzmgd
X-Proofpoint-ORIG-GUID: YPHK0EgJ6HfydyHygfwMKuWHByoAzmgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2OCBTYWx0ZWRfX0wHpS6QGghXF
 rK7shLjcxDl28Ddepxg0WmSG3vZPMQ0gZ550pWA8QAtx5FmDAueID0tj/pa7vrHWlQvQVut9mXE
 LcHNfHrr9b280ygrUKFuZHK3X5Y7IgML+gPyV9CTvECoYmPEtO8s5fZQ80Of+3XeOHDwLfwKJiB
 E+vVLZwK15WT6orPIjWU1ukbamQcYeEf+remfYnt/4ENpDn8dWKBugxp9eAMPmNyXcZ/H8bBqir
 eYJ7RU5Ig2uLbLjlTr/i1drE6zZJpG8ooWGvwasOFOlczIZW4CyR2O/kujhWMElf/f22Mc/L83N
 j1gKtT/1Qqsiy8vdRG4G6fDM0UtUa4kZ1gpHV+Y4/CE2Adp+8UoBBgvNEdFpCkM9eOFBO5cXlbB
 1LzxwFH8cKFahass7vWXKYV3mGT/SpIdVrabQx6MQGELIfaTREje5omAzgRkD+R4wlUH9dle854
 cd9IUBx1os91zgV2Mmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280068

In qcom_geni_serial_handle_rx_dma(), geni_se_rx_dma_unprep() clears
port->rx_dma_addr before SE_DMA_RX_LEN_IN is read. If the register is zero,
for example when the RX stale counter fires on an idle line, the handler
returns without calling geni_se_rx_dma_prep().

The next RX DMA interrupt then hits the !port->rx_dma_addr guard and
returns immediately, so the RX DMA buffer is never rearmed and later input
is lost.

Keep the handler on the rearm path when rx_in is zero. Warn about the
unexpected zero-length DMA completion, skip received-data handling, and
always call geni_se_rx_dma_prep().

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..7ead87b4eb65 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -905,12 +905,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	port->rx_dma_addr = 0;
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in) {
-		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	if (!rx_in)
+		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
+	else if (!drop)
 		handle_rx_uart(uport, rx_in);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,

---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

