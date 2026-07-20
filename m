Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231C418A43
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560089; cv=none; b=lGZ8htiaDKY0l4NN37IJdUoKSiJow6lpx06/Y6l8Tbe9eO4PB9HuyVSAlbhdR2C2hKnaIMZNClKTWIBOjbaWA3z30JXTDM4GNu3E0toKWWhA9/B5r3BuGtF0brjTIAk7k7rlJV45cMO32RXL8nQhZqFr2IDWc5uGTI8/5vbkZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560089; c=relaxed/simple;
	bh=7WLCND/ZXGAyuMsyPwAtugUkkMEKi8fZq+9tUxivf5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s/L93Cckiyhs5yidAuL27JGf+ULLfdsx7pdrhn6sT1QBvmhvg3blEcAl6RoXtFtkIp70be+49bRnmCGIxHQn80IhG9AV9HAMJVK7HtQHpxlM9kbxyaWuCpCK6qm7pGbOjCgGHAly9dy+4pdSfDT9Al5hO+pCKhGoCBBESjxmdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLLvt+rl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YrQRY2nl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLLvt+rl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrQRY2nl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDrFP82807741
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2sUNNETE0h/q96BSYwXRXi
	Gn6f30NVrYm0hZ1/p0G8I=; b=iLLvt+rlvSQtLaBtXNrnal0A8Hwvt+5Fm+Q09D
	qtundav73bMBc0CMc8Wf+ze1+6OaySs4lLhqR/XKrUbSmmGNsShHVNtAccahOa1F
	c4PS5tSq1YzpB5utTfZNrjblfJ8pOm9/Hkn8uboVAiJsPPXGNdENcXnx+gN1srCd
	dyDfzQMMcbyAlv/JOvb6mX6+JduZ+k87Ih8gK2e6dB7jczvlGd1gblMmDL+KuY8Z
	VRnu9h6UwlynhZY7kBZzjsHWAjuNLbTY+sXAEKaqPkZUus+g55fWZUVJpMVR1Pg8
	efz5r2moAmZ/F4EZl8z8KJVHVqGed+vrnV7NOMEX0SC1uJfg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre9k7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso10569457a91.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784560086; x=1785164886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2sUNNETE0h/q96BSYwXRXiGn6f30NVrYm0hZ1/p0G8I=;
        b=YrQRY2nlcfaJ/+M4T99m0X3LG2fE3bKoVkEu53LNZAnnTkLRSKOmGs6+5kJiymnIZW
         Hm15doYHkNpyCiJTl7XllKPQtsQgNvEAx3I9/3tx3mxO8O5tV7VPwYFs9cD7ZvbFoRFN
         O+LDuNZckvEkf3WBNTTUF+SxVPsd5v38cw/jK0zCUBy5uRgn77HL6fN2IjgwgN9mOVN4
         lGmb6oqwSYbfbWcf8TofNTusB1BQ1GwOb8PsXiOHGoUhutTcbMCWWd1nTY5ab5vCbWR9
         xWYDq4XpvdZ2zExm1p+BCeVjDTJzpq1SX7AxEzOaYZ4/K/At0VXZD2u6DjvsBLCXbKNO
         UcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560086; x=1785164886;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2sUNNETE0h/q96BSYwXRXiGn6f30NVrYm0hZ1/p0G8I=;
        b=E0/ifLQumOTdfSAEhYB0tb451o6TFrAJZglJ1Pmm4WCI8NTMRHb1XYJqLoAGfyHRF2
         +SWpXZyAa47PqjJO4IPW0J4uDj2krNYSC1xukyl3Je+D8FiA91aoP/E+BaseY2koLfgs
         ezPwVRuruxgJOE539dYLGUVAHT9QKWVQlgYdNRjTeM/Fsb4lKN7V6/dJXj8VMpgRTwJz
         Xqrm38nEzMXJ7eNQ+RKuymqSfemMGjR5cJZmu4XXDaJRJ7jF9GpDbutxYzwA2dZ5oSH5
         yiQrhLP0enBKU5oFVLBUmKYR+pQ9ze4Ru8q+KF0Xql1fcKZM5xZSbxdWuMZHclIxuIkl
         Z0Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rrd5xrKqJppeErMrrHOovAIBQ250LqfULSH443ZZlkiXFVzbmrnXZawxkLnd9hocB93KzDldPWZqcspAN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uO/SbAKYhulTnQfKCMofcZNkenxZyNW6vcsF2T1F++fwUgd/
	lHScZs1wa7ZWk+08laVcKI/IazuJOtrBEWXQzuu3zaLpll1ySTbuvHqBrdllZq+BtTb5OYcTRzJ
	ebb77ypfXWHlsKbd8J8XJCtn/x5vnEM6QbfMRJE6vJUWJS7pICX7JXjmH7OuXkvKxXqE=
X-Gm-Gg: AR+sD10npw9C5vOWCxtFXqFVi2DWvzvQP44BocstSVzgNxxzkGMcYuyQ7I/JtJLxIMB
	fCckvawwezy6cyQOJ6z69/H6Q/TnqjzpfJIIQOVtIGax5Ue5SZDBx33ylLud08upjpNHl5gjVLs
	SQf7Mqyyd8HAb5280847Ukbm4drQS4cwWWouR7/lgnvxzX0ws7pYE+MWWnFNuJmE9UuLjAyCDcg
	1OoL0JSidHpDv6S62UQYZJcUGenEJpQZDYdvCYNeoEbh+tfOay695E6CavEQsu+I6FBW1c3bfsC
	URYVriOxllhLdTInRmEGXQfVbXdOdv3pRKQ5AAtDGiajcZpfMRv7iwls2Fl+wp7NjEWjV21RCjA
	953CJfohrlKmL1kbzJGI5H7GTIzj0kvlYwg==
X-Received: by 2002:a17:90b:1d45:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-38e4b41bfd4mr15181181a91.3.1784560085773;
        Mon, 20 Jul 2026 08:08:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:38c:e9e9:e7ce with SMTP id 98e67ed59e1d1-38e4b41bfd4mr15181122a91.3.1784560085273;
        Mon, 20 Jul 2026 08:08:05 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7856411a91.5.2026.07.20.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:08:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/3] serial: qcom-geni: Reuse common GENI framework helpers
Date: Mon, 20 Jul 2026 20:37:48 +0530
Message-Id: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQ5XmoC/yXNQQ6CMBBA0auQWduk7YISr2JMU8oAo7YlM6Amh
 Ltbdfk2/+8gyIQC52YHxicJlVxhTg3EOeQJFQ3VYLVttbNaMW6CPpaUSvYTZvIjh4Svwnc/42N
 BFuU6pzvTD60JDmppYRzp/btcrn/L1t8wrt80HMcHZW+mZocAAAA=
X-Change-ID: 20260720-reuse_common_geni_framework_helpers-787081bd61a7
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784560081; l=1120;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=7WLCND/ZXGAyuMsyPwAtugUkkMEKi8fZq+9tUxivf5I=;
 b=ba6QyJoKq90zD0bNNORo1pakURnwN5hTDD7brR3G5XDa74kxLjzDFk3kVJFU8lSfFm6lkhQjF
 MhlxVVjooOIByQVVOanNW2o+RP1+G4Vn8F84b6RHkNtjbwp5ycRIcZs
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX38+kM6slLohl
 CKpUPaL2tfDXaCEfS4MdiE5VkIMd8bp8RZTykLfECC+OJ7o99bkMcSiK+nbRRG99G2lUtEujN9G
 tYaEJkZKOuMsXuB8Mz9Vw5YYFoZCEKk=
X-Proofpoint-GUID: UGmOoYTBayZxjUfX8JD2s_cLq9GN-hsy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX1FUKluN+wgRq
 pDpb9Vjvh0tidpx2NqBObOKzwuk9LavmgWDmZ1oXzxIzLioEae9kObwIOwd0/iE69og1vkI0QIz
 ccLUAdG1QdxIeipUyFvnr7kpxOXZ51/szNUHyVIqwY8dj2fJU93NaHcIHHCAhU5YGtSoX+iW7cA
 +HUF3kOXVKqmMZZUkj8nnz2Lor5XiQSAtaESuL+4RmjJIV+P/7R7WiVF4NEh/1CzPNyybHAQ57L
 ehe0e75iDDaWgCxJ2t08KZY1lWzDjACgW8xRVVkzhEkUmswfzhwU8+Ty7/0MlbhbMuGJ9tj32+E
 CM1FksWmAZDqHw5nRaEZ8NNA1vMaFwh6mb1Jbj2usgvWeUKrQJS9nbsewGdqCR1evGvzVtajfxj
 ui/giKzuzx8q0WIPiy86zp3fg3/XufHDBnAI0wdhd/xxB6StzlfSAXbmU/qK4JSeMKLTnkiK6X8
 7npjFtj5vu4NJVoBeRg==
X-Proofpoint-ORIG-GUID: UGmOoYTBayZxjUfX8JD2s_cLq9GN-hsy
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e39d6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zYmsmQLqyy5UlMnypS4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200167

The Serial driver currently maintains several helpers that duplicate
functionality already available in the GENI core, including resource
initialisation, power-domain attachment, runtime PM resource
management, and perf-level selection.

Replace these with common GENI helper APIs for resource initialization,
runtime PM resource management, and performance-level configuration.  This
reduces code duplication and centralizes GENI resource handling.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (3):
      serial: qcom-geni: Use common GENI resource initialisation helpers
      serial: qcom-geni: Use resources helper APIs in runtime PM functions
      serial: qcom-geni: Use geni_se_set_perf_level() for baud rate perf level

 drivers/tty/serial/qcom_geni_serial.c | 204 ++++++----------------------------
 1 file changed, 34 insertions(+), 170 deletions(-)
---
base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
change-id: 20260720-reuse_common_geni_framework_helpers-787081bd61a7

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

