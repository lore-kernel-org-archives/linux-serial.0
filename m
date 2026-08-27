Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88C4B048C
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853645; cv=none; b=TjJik+xaxFGNKFeAcrCub84KX88383dpPtO0vTVgKoS9pmbNNqT7G2g+/CkQT9/T3n364vw+36xd0GJy/nIyH/qDO5pjBnETtlesYFkZS+7Cg8eBTzn6yVMRRU4HrFPgxw3R5j3HBlTFTioFm4LaIpuAINxtlJFXOE7RJG5MFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853645; c=relaxed/simple;
	bh=NjCwN+DsAYC8C+NrLmOLrNQM+M1WYqvKKDKj63mj+98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i06DHr2GIN6gKmNmIQggR5aYE/hUnaR9Do/J8aaI9Cmi/pSB2MXeaYRFNESR5zpZqxYJd18IuQWllpjmZwXQitLXhosddO3N718D6C6/mtjUW6DYwwCAJYXWzXv5QzzWWgk7UVTtDm/u1GYNhzoodmaU2hMifMBptq0AriBXigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ppmv8yPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E1Uxp6pu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ppmv8yPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E1Uxp6pu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXiFU1121810
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=; b=Ppmv8yPKbb9PHUQa
	uo8WRtVl4iinZTO2w9ED9nUIJ8fEyPnMYBqDvE/P7e1vMbyjoWEzFH5549C/TIni
	CGIDYKmn+CnZ2ffU64ONax2SutM9EXNkp6HaAHb0uOimGMXcI71e67HFt7sy23bZ
	m9WqgUocbnJiH6C2p98B8+FluWdmXmRknFm8d/fxJaxHbRneFosHn6lMQMY7/jF1
	UvnZCVUfeUqzImgs4j0ZE39rtYaRYRLlWAAqYFMgZN/TijQc46Lttd5/aFEEB7Dp
	jRxNLA72WAb5X6PCfAgTV2JRuHF+U2WsZvFdiEq4uiL1crN1y9KpFaavKKF+1JLw
	yUUc4Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgv9ayr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:00:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso383338a91.3
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853638; x=1788458438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=;
        b=E1Uxp6puAmjY9IX+8bjwspks0yi4ElMU2+3NKz4tntVVwDjh96dvejmN+Q9md/44oQ
         Y8BUzLAX0+csCzoCDl3L6WqGzGnkTOJVZr556mTwG5xenVBaL7tQV0BasXFoowJjgrDw
         qvq4IIp8sfsqJa+hmAuoKMku/dlqNHJuNwWVbiSjCXCTI6z/EF3RxHd3bwiVp3EQEh4z
         yK5G2jg2Z1QIaQSj6tEgMh2KV+fKVOHYSn3qIFGFVosKnOPgJWTwPM5dnW0XV/pvCW7A
         YhA0j9iuDShc0FlavfK+9TEjA0rHf+DCsfCCg3rZ48i7XFh1yTIIsVpvdP2XDxUKSBvo
         jE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853638; x=1788458438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QvdWGn5rqFtTcef6NfYXo2PfwQibN77OSCU6yboIRk=;
        b=slsFKTrQMoK/23WYpQfnL+mRdcI/G6goYCSLBBCz+X6ze5BtAlmrphioORN3ds4E1K
         WR5oDZmRDlSYA9aQyu0kFjqQttYnG127znibHdAB/jRNCZzUz72xXeHNoXfgLktd7ZdC
         QUJ1GFHm1He8nBc2fTnpkFMfv3iJfSKyFqwucMmjg4ZH8NpNaewJXpBEiJw7M/a2f5RY
         kORQVrHJfVytXYHcub5TwqYRiCvKcV4YeM3BjcFXH/yB3TdPd+HuePdSzdFGT12myACd
         7iBVCxWuZq0Xzz9bE1j9itxXE1yAT9WnhvQ6kev2OzzUjooRvuPq7GIVvxRi1DJMU7Jc
         GMxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/m4gR8o+j41zS2wFdYMHi7baqXJ2alpQg5EvknwAf729cdURB2wfAbqrXcA2CmRpZcFcys9o9F71Tlcc=@vger.kernel.org
X-Gm-Message-State: AFuF++lcJqHGrvu7X56ICCUIIxFsAPtrSpM1BwxM/vSd7MZNQMOp123r
	4PrrVcrwxieBOYdSMhIhruxjaNAihcsI5NOBFTHZuJwa3MgU4t+dpcgi0+c6mNOKj4FlEV9FMc9
	tHEfwBEmfsZumpztxn+cKcVYtNbXfPQDxfjV7zcqgP4SmuDOVXqv3MJm7BLxNSUrEhYk=
X-Gm-Gg: AR+sD13Mv7zf1Qp/42c6ROStlV+Rb6Nm/KBYt0N8AXImaaFak6e0hCIDZFVYdYPewMM
	uSFFAqGJZOXWs63UVLugdP681qzHoOrjCykd6Fvfu6hL6mVl2zrsIpr2en66yqSawsta4MF0KxQ
	TYI2xZZkLjmp8CI2p6+nZhopTlhbyJprDSjXxqTmtWXmnFwTRKC4HwsRuYMuaceFiKn6CbXt4ma
	ODfZf24NG6O8I0reV3n4cVPVGpFmoq0CSjCkp5+4/wNCUS3l64oXf1iXVqnKnh+8ZqXo2og3noJ
	1DVXh5WiHuOkJtlXVBb+7L+5DisVaRJRbCfp6t15e3VSaxxZTnRPtJnTZm61iU13Fh4uuO5iW7K
	S9ZPoZsZ+NU1j78udxyEHTCdDrLoTWrEV1Q==
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-396d0faa459mr1359411a91.12.1787853637589;
        Thu, 27 Aug 2026 11:00:37 -0700 (PDT)
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-396d0faa459mr1358225a91.12.1787853632427;
        Thu, 27 Aug 2026 11:00:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:26 +0530
Subject: [PATCH v2 9/9] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3297;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NjCwN+DsAYC8C+NrLmOLrNQM+M1WYqvKKDKj63mj+98=;
 b=it9A0O4HyitFGzlN8icAAHt99GLQ4iEQWhvQvTQy1VFytbLLTb33k1x+gZt/2GLUyQamW0TmR
 qBFXMl3rJimAGo0vjRZviG9h3ZLpZX8wqYXM1VWD6awoH4nAqu23Rlb
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: Ob3PfHwYAqyUoXryBjR2QnqjDiRmAGJI
X-Proofpoint-GUID: Ob3PfHwYAqyUoXryBjR2QnqjDiRmAGJI
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a907b46 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX3k34LUDPCZpP
 vhrSOOzL7MZb0PSgggnOOwhO+vBzBefipSjgBKkomleMJy90JbGggbSlFiX4JyhkH5LH/bm4Ie1
 OoLga/Ao0ikF1OPipnQk9tCDYN5NrO7mnT7MWsAGKcx9LJ3RVcmSb+0+FIyXfIXy06dS3bAs9Pm
 0q7o+VytW01mCtUTkg2PS2B4C5LvuMIGASJvuJXPBpUiRALGpypoXrR2qbiiimjSWIpX1M/Ktks
 WXVfU0yU2UuWYpnXgt105dol36+d36mR9ijIaRA9Zyq8iTASVXR3W49MEDaQ9ZGG65p/NwjAMuL
 IqvlCBGYOBBFX0YtwqWZx38i18+q+gicq38hDl//Qgb/6JnpjdNQiM/imISEEYxQImtHcmWWoEp
 nQN0q7gGPXCEsr6QTUE93H/Jxldrm6n9POOrSj5DVhKaegiNFhVjbMFNsEDcs/K3LFrBjFtnGA0
 xzGAB0IZFMWB2xn2+RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXx+s/q3y2FyKx
 Bgck13wXC/u1WPH7d8Y0pDKP7iyl4pF/ob2a8Dl3n7Sw5adPk8L3lfm3bAg8S73x5vtIBi0v3c8
 25Jm86qG7VrGPc6TWV1spuvgdcZCbBg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

GENI resource management may be handled either through the Linux clock
framework or a firmware-managed performance domain. Source clock
programming currently depends on platform-specific callbacks.

Use geni_se_set_rate() for source clock programming and perform the
source clock configuration from qcom_geni_i2c_conf(), allowing the GENI
core to abstract the underlying resource-management mechanism from the
I2C driver. This removes the need for platform-specific rate-setting
callbacks and enables a common code path across all GENI I2C platforms.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0b178701e1d1..deb0d822290c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/geni-se.h>
 #include <linux/spinlock.h>
@@ -219,14 +218,14 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
-static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
+static int qcom_geni_i2c_conf(struct geni_se *se)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
 	int ret;
 
-	ret = dev_pm_opp_set_rate(se->dev, itr->src_clk_freq);
+	ret = geni_se_set_rate(&gi2c->se, itr->src_clk_freq);
 	if (ret)
 		return ret;
 
@@ -985,7 +984,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 		return ret;
 	}
 
-	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
+	ret = qcom_geni_i2c_conf(&gi2c->se);
 	if (ret)
 		return ret;
 
@@ -1228,7 +1227,7 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		}
 	}
 
-	dev_pm_opp_set_rate(dev, 0);
+	geni_se_set_rate(&gi2c->se, 0);
 
 	return 0;
 }
@@ -1239,7 +1238,7 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
-		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
+		ret = geni_se_set_rate(&gi2c->se, gi2c->clk_fld->src_clk_freq);
 		if (ret)
 			return ret;
 	}
@@ -1290,7 +1289,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 
 static const struct geni_i2c_desc geni_i2c = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -1299,14 +1297,12 @@ static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
 	.resources_init = geni_se_resources_init,
-	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_i2c_desc sa8255p_geni_i2c = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 #ifdef CONFIG_ACPI

-- 
2.34.1

