Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F6303A21
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769476; cv=none; b=Jjfg5NNxb8ufRhsDFRPnYefpT1tTLhfik9+6sr8dSmLZY7UxujMtce+OR/aYuS/1vjvLFH0CfEvXAvJZyQOraeqfrJyRd6IjH32UPKvFa6XtrFnWNcdE0LvXwcEqt79yt3z+NC2gaPWhPXiV3aqjw4Xt6u/HhuLfd4m3wMBC28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769476; c=relaxed/simple;
	bh=/4jBah1ZYFQOjplUTfS9BagKtVZTMkugu5wHS3+nU5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgdxDSE9HoB9ip4jG2Zl5e5fgLF7bwzY8g8vBsqWjFHZ4KOs+HAtcduAULW147caC2gx7U1xcpgizVe1YyjXji9zJD2nlRJqwXIV8MvvpjPq4Gg686qlHI7bNTQpLIqMobSpo9PibleFnDt7Eei/pWKU3SH1LQrWq6ZT83RUqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gY+zLt+/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UM4zGycM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gY+zLt+/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UM4zGycM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9EtQ92993175
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 10:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fxcXNLRndCS
	dBKrzLj3PXcds5y/egE2lHvpkckA8XEM=; b=gY+zLt+/QHUgTzNDk0lzHKH6596
	kxUOjSSeXyW0Ys0GxssliMGkKfaKUPquLFLFT4MJLISQpVzpGmTI8ioNqO3WY4uY
	bJAzBc6g0KvE51W5VMwnEyz83RdxQwG3eYA9445owA5odUvO/srUj7M9PYJRbu7O
	cMq/R/pqomTQ1m53LzdP9s5XomruskdovX9TQsylDf8qPtcpDdbd9JAGgj9QjTcO
	ei2MO0h2HgSOw7Dn9q0o0qpAR7C3f/7mtKdJR4yPUGzLgQ3WlTu0r49HetiVhc/H
	NjYwdxNCKFqs0PKQSe3COI5wYt5Os5S+cCAauCUhd42fVRHrDCDtzoiT0vQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88r5up-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 10:11:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297e5a18652so20666735ad.1
        for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762769474; x=1763374274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxcXNLRndCSdBKrzLj3PXcds5y/egE2lHvpkckA8XEM=;
        b=UM4zGycMmJ3GP6112kihRMp5IlRPPraJwWu1sRPX0AE82cl1qWgxDsMfpbXalUCHBW
         7nOqh8aOXntsK1axHnQ+FxvJzxrQmGxEzj9qDcPC3n2vYLMpE5lBDSxG1823b9svzinn
         d1AANoyETKzVZhOWYkVOL1o5F6Nybm/mgOgfOa5aIYmmdTFNJUtgi0QzAxhkAXwm70Vg
         pnShVf/n2/KNXTzl5xK6PkKvDplsxh99zWXNdULVwJ/soBvtUSLWDJphv67bi/kgdE5c
         hcB72uaKeHH02n1lz/QiKY/ZDDOCkGyF2Tb+4tT4NY7QPSDUH9/FAE77vILjwRhxtqFl
         dYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769474; x=1763374274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxcXNLRndCSdBKrzLj3PXcds5y/egE2lHvpkckA8XEM=;
        b=dC4Op74wiqCPOGyIC82s7E1lFERcAmvvpgrLkA9Nn1jYW0P7DuAIeaOpohhdsQ7YIo
         JnbT1Vl0n6OeaSqWCC00XY57XV8kJlNI95v9mR9V2/bcrwdGn5wsC8T7rEXvZ0xI9vn0
         aaD9XJBLaghsKLJWiOjsD2eln8zXEjPE/4pPVoqBDqmobc0QXHtFIHjUpD7heYssEFnk
         ZYliLiqYBkJSvkdXbeftgmkxTP88TlBWUSCaAS7BCGBcCq1SQyZc4FRjPy/UxzYgUsd8
         m6nem6CVFcMLZ4I/ojeCfGWzaVx35k5/cbjFgXFl6/93BfRaUEUticuouDJFkt1iCxog
         dEVw==
X-Forwarded-Encrypted: i=1; AJvYcCWNilINOahHUQEj5RWBhHl6K+Mm6sqnTYmfCdwG5SCaDloNWqH0TBogP4nPDR6yOoSfbHaltmVHtVEHPnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCzJL2Hnd87co6xD2uSvYNQj2DeNheq9rHojEYpqOXl/UFMhx
	GSoHZEyy/yvXV6F7UNvR4fN1T/JcwZX2UPqIr+mu1AC2Q+WERZpDa4y8JifClbpl0bdRUXFI1Xl
	IuLoyGsBTLyWw6ZeLPzJlKw8nB/8x4ee9x1hkYFKrzWo7uQ+KO/wLwkQbaDZezWQMn+g=
X-Gm-Gg: ASbGncsdO+LjygjMJAbNRxK/wX7Vzi4e4j87FQj6nZz/M3oLgvLWLG/IOc3xt6TwyAg
	/ea1DUKSV4EUM1xw3y63bq3Cjle5YbardjAVrTV0wNlVd2XEJKgrFevqHlfB9Mx2eQR4DZ2veUn
	VpGHW9tC61LQ4z3jpvXZ6Nqr+tP/anhiq0NoL7PL0453Hu/ijNF9lp/3QlygrYYNs6ZyjUSbdH5
	Ie3QMyDgiD36dut6lf8PK4+SxNNYNtxD7WPJAuDSEnbfrQhL1zJzZr8F3zq2vz3N2Y9ecW1AFQL
	eUkF7X6hTbtn9FqnjNX06Zz58TvUzyRkqf4UWEQ5nn+P4jb716h4qgRVfgrRKKBqlVcbS5UT6xq
	srg3CBvRNkumkvpREdZLNm3eMimRf+3th
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr104668435ad.60.1762769474067;
        Mon, 10 Nov 2025 02:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBi9O94fjJjAQcnZiBxSLEqKhzjpQEqnNAAKZJzH5cnIKsD+wOOBbY1vP06qkGJRhThmrAew==
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr104667965ad.60.1762769473441;
        Mon, 10 Nov 2025 02:11:13 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f2d9c971sm60180395ad.55.2025.11.10.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:11:13 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org,
        krzk@kernel.org, bryan.odonoghue@linaro.org,
        jorge.ramirez@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, psodagud@quicinc.com,
        djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>
Subject: [PATCH v1 2/4] pinctrl: qcom: msm: Fix potential deadlock in pinmux configuration
Date: Mon, 10 Nov 2025 15:40:41 +0530
Message-Id: <20251110101043.2108414-3-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
References: <20251110101043.2108414-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KAlpyNeZmOTF-m02ob3tkOJSxfErQolr
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911ba42 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hPkvY_wpCyZqdAZ5voYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA4OSBTYWx0ZWRfX8Y9LGR1Dc84W
 2v0EZl6bPK7Ed711bRYCoZidVM3GT1aM5VCTGWLuii0xku2GaXyOevkadxUN6kQcmLlbD9yLNMD
 J5ApOh+gm27G6l5bfzfxcLVujtIDfz49qgmH/Yr/mMB7ySIxhXWmGDoE5eTMxWfTJmRJwkEev4m
 kqapQPP/bwPfkp22x790wJEWmDXHF7XBIeS+YaYf9SpmOSN4e+RfRXgjlMPtCgquQzcDzW+0NhC
 Pa4hCCMTV9ynNaDURCuZP053YTjpYxQXhzJs5mx4HeNg5kr33iFMoC2GmRaRoeHb03uF+Kb5ABh
 JswW7eCYiHgBzdHDzmTlFnWY1Z+KJVdu/a3Jp4al9LdI5LiSsgeqhjpjLDuPqSNROm1Tut2RMh1
 tnPVNxKBklSqD09mCWn8UY/yzDUuTQ==
X-Proofpoint-ORIG-GUID: KAlpyNeZmOTF-m02ob3tkOJSxfErQolr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100089

Replace disable_irq() with disable_irq_nosync() in msm_pinmux_set_mux()
to prevent potential deadlock when wakeup IRQ is triggered on the same
GPIO being reconfigured.

The issue occurs when a wakeup IRQ is triggered on a GPIO and the IRQ
handler attempts to reconfigure the same GPIO's pinmux. In this scenario,
msm_pinmux_set_mux() calls disable_irq() which waits for the currently
running IRQ handler to complete, creating a circular dependency that
results in deadlock.

Using disable_irq_nosync() avoids waiting for the IRQ handler to
complete, preventing the deadlock condition while still properly
disabling the interrupt during pinmux reconfiguration.

Suggested-by: Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 67525d542c5b..e99871b90ab9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -189,7 +189,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 */
 	if (d && i != gpio_func &&
 	    !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
-		disable_irq(irq);
+		disable_irq_nosync(irq);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-- 
2.34.1

