Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E213C553B
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578411; cv=none; b=Ta2wzF8tSRjOhV3GhlF4B/G35QUjq0Lfai4QCfq85rSQLqo/i5fbLJUbS/lfOQAfmSM4CtJGygjCscCX+4BibTROARap37bmP4BfsQe0BtH5R7lp1zewzVj9pJtZ6mBafosKCcN+ALFlWr2b7+35rW8ks68Azh3WurpLYMYeoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578411; c=relaxed/simple;
	bh=aLKsWDAwz2GNv0and/N/QxAf4HluEjygqicLIneo6A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IX3m3opkSnzAFPWwEedk94jRnry040IFba2NGS8ytGnnz3HzCWvt3QNesydsBTF01JxuUMa6XoE/XAvBFcJkXR23T+Ky6+2rgm36cT8eoW94nVn7TIGsiLbekJSVElevxE6vPfZZaKB0WHUOUCCsQPJLfKiFYgkDeZJmrKSWn/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TO/+YiWH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BvQFJSxS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TO/+YiWH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BvQFJSxS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xx6U710928
	for <linux-serial@vger.kernel.org>; Thu, 9 Jul 2026 06:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=; b=TO/+YiWHz6cxuFqq
	qzv+0B/gddlxjqw7W5u6QCi1+Q5k7D63FXxoFjj3t8O5SZsGfAp8aaF/BMzqjznH
	/0XgRQPo8+dmjJw6HU0nFMFl1NGXVT/G+NG6pAQW7ZepcQjzKr4KZI/cmcxp/3z/
	URT5MLHK4BjfJR0WyIzO+4iDnxM/yxuDsXKDylNQlXfixTpLeIT4Qi5M5YiiWdxB
	q3p0z4G/ZWfnUmdky0Elzu6CqhWcrdafuMKBiH0UzjXrMBF1WsSQV+aDeY3hzKVO
	xEXKkRTV6KNjNkAA+Tcd7H4+mAM7DrCWVvRm6E85kQrm6DeB4uDJrBJ1bKiCV4b8
	7aXVVw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vg9my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 06:26:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so10976845ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 23:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578404; x=1784183204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=;
        b=BvQFJSxSvhYnyTc71TMsJ03yaggkDLpbcsC2+XZwCU+yJMJ3lh4WyaCNkzNNFspLnV
         LnuJOB2tlkYZ47Slx07OycRZDAYuI25CWA5aDmswbkqYZrgQtXUVCLzRB+GuSFfQlKUr
         mPfZEyXduxod+cgPqBN16cEeA6mXcVBkMBHM7S8hsicyaCSGmjbH9+KX+xOm93ELg/dL
         2DltPGrUY1QFcyBJ412L4wZK56NwYweambtVgR1oAtiMgQK2ekT2p0HBX+1aZZbVumPw
         8+cSrGMol4PpH4sOk3tBNiLQlRin9m1WWNS7/dy2EMRq1Ia7RnoqVUMWoE8fXp6m8xO+
         S83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578404; x=1784183204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUNYYkOrLEAjmX4TG3ez/Z/YI7BUz6Ijll5yCR5/a/M=;
        b=DL7AK58d3tH7qk9vZwcKMTX4WiruZLaI36LgkI419W2ruxgKmUIeUo8neQtg8239DJ
         tVF7jyGyMi6lUSTf8f3urkatVUVN/YuMpGx1HEelXB9Dn+5stmPRL51Pq+W3v/trWsG/
         YzRUZeejWtzmYDYwDLiZbVVpeF7HbPPtgf6rKxtADOEWf38T2QMeGGlrkWBC5noelTHO
         YsYm83N6l/In57oMufJ/RraEpjG4NY3CKKTsBfjuIaXdv+b1CVRCU9GMaljUzJuc4WqZ
         WGXbeeR+Z4VyifuW4f56Jxk+AKw5ozy2ie+x7Gi4auw+3yQcLkINFDxJ4rX0HylpBTnB
         b8UQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNdsfwHkNOHqZqjdZkt3/Yee5PY9RNunQ5mvdaur6zl9j3a/GJzp1n9KQ4U9WoH3t/4kldVe2c1HZlLWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nPrEltWXu5sEAahKmvtjX8xvrgB5K97AVJVMKu4BYhngRLNY
	YnRGrB5ZWvPQ27nxWOJ/I4oafoeUMHE1VsiJZmynPCSuucRuz+VbWNCl8m/ishVN0WHMGAjPYyO
	ShnkgwqVRxC3xZl5cHjoelql0C6XFnGHadCWNVSGVqgH7LiQiXACURfpMUA146I4Valc=
X-Gm-Gg: AfdE7clFn+1EK2V5Q51T917XrrHsStIZk2lZAo0ojNhty7vQyAKyRKmXvE58DhZm0eB
	9gi7IVcVVycmGjYXvsdwDs5KWiE/DbNbXFjLbNegzk20SAS1rqGKE49V5JXZXkgNoXUJNKMflPK
	7GDIh4iGwqTawrjH2kfxF7qXw/QqqGCQsWBQLKAG19c4e3nMMt/+y1hsCef4RObYsjb3yqgRxWH
	HHjJGVst7ARtaoVn0MagGSF4VRPbYj7Kh3k4mk9J/Sz3r1vugIf8gPePi0xGjRXvNvPmEA/jWtx
	dq1zExWThHPf+Ohg4XWo+4ipzubw1PK3PzgUEV4BDS6HZw1fwaKtzCK3Zagz4cLTHTP41VSvM/q
	BcJVPGEe2JIYSzgaSWhiTvrvnGov/GvgZDTTwlb4ZBtDE
X-Received: by 2002:a17:902:ec87:b0:2ca:16:c169 with SMTP id d9443c01a7336-2cdd8a8446bmr16030185ad.12.1783578403728;
        Wed, 08 Jul 2026 23:26:43 -0700 (PDT)
X-Received: by 2002:a17:902:ec87:b0:2ca:16:c169 with SMTP id d9443c01a7336-2cdd8a8446bmr16029695ad.12.1783578403107;
        Wed, 08 Jul 2026 23:26:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:42 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:18 +0530
Subject: [PATCH 6/6] serial: qcom-geni: check return value of
 pm_runtime_resume_and_get()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-6-e85c6ffa8ec4@oss.qualcomm.com>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
In-Reply-To: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=1832;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=aLKsWDAwz2GNv0and/N/QxAf4HluEjygqicLIneo6A8=;
 b=Hx8QUSLFIpbdbLJRMgaFZQcfWKI4SYHgH+sbG/r5N+1eUuprXpiRnOv/uNONREm1aauXqcg5E
 vvr6LWy+bUWDhuqdCnrvTyC5LuYYyp0okWLAMvA7Bc49vRU5kMASEqP
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX0kGii2lybsXc
 MtC3bTjEYgzb0na8u7KbVFKHiM3/+6QFVeqyv3AkovEAU0kfKROYl7KYgnfwh+6RJvdnyAsAb7B
 WUYl3kwLutvdXiaaeCtsoT8wlqgE2d3Mfelc6odG/IE1rhjVCnakLMvAce1D352mLPTDQ1tscDK
 KB1u4Sh85RDAXjZi84zUCYZ9cxPoaO4U1vmI0aQCMPx4qs4g4wmy75ghpWpGWAV//4JVhwuwNF8
 TJqr7Df17nNjzwKXlMQ9Osc5D7BCi9vVrANIhCJ3irBbXAZNdQAOc8GoNru3ZxNCsOgjEmVC3aM
 9f1AKY68at0KurXiP8MYa7wmccegcFB8hfQfdLtENNDeog1RcX/gZ0nmuLjE5ksxiGJHq+3G8Jf
 VRAzPGsZfznIVlS/HYl3dFDDV4fl3ARhU3/AH6xGmrxOMK75bFW37j7Oed+ItOUHszR45WQjV8k
 IWjnOydIiGvJI6QggBQ==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f3f24 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=f88WUc_itYv57WQCX9cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXyAOPJKPyTLrW
 q2szQmHEP7amCj1bWeA5Bdu5ISzehzJG7d2LtApOgVuID6+zesQ0wNEfHJoRELlFeXmAn2Ud+ec
 4rJOShMSJW1hvWirKgE/4gcKo+qThVI=
X-Proofpoint-ORIG-GUID: OvJEWKWdwoIaa1MjQ5aR8iDA2_PBlUpS
X-Proofpoint-GUID: OvJEWKWdwoIaa1MjQ5aR8iDA2_PBlUpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

The .pm uart_ops callback calls pm_runtime_resume_and_get() but
discards its return value.  Failures such as -EAGAIN or -EACCES go
unnoticed and the driver continues as though the device is active,
which can lead to register accesses on an unsuspended device.

Check the return value and propagate the error to the caller.  The
.pm callback now returns int (since commit 6ffcacf023cb ("tty: serial:
change uart_ops.pm callback to return int")), so returning the error
code is sufficient for the serial core to handle the failure.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 17ab8acb3b8e..1ed09ac0af0c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1727,14 +1727,19 @@ static int geni_serial_resource_init(struct uart_port *uport)
 static int qcom_geni_serial_pm(struct uart_port *uport,
 			       unsigned int new_state, unsigned int old_state)
 {
+	int ret;
 
 	/* If we've never been called, treat it as off */
 	if (old_state == UART_PM_STATE_UNDEFINED)
 		old_state = UART_PM_STATE_OFF;
 
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		pm_runtime_resume_and_get(uport->dev);
-	else if (new_state == UART_PM_STATE_OFF &&
+	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
+		ret = pm_runtime_resume_and_get(uport->dev);
+		if (ret < 0) {
+			dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+			return ret;
+		}
+	} else if (new_state == UART_PM_STATE_OFF &&
 		 old_state == UART_PM_STATE_ON)
 		pm_runtime_put_sync(uport->dev);
 

-- 
2.34.1

