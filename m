Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660A3478E25
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478820; cv=none; b=jjUmiAsviIrerBJEB0cDZ3pY4WlWS77Rgqfq5i036Hhg/X5hRyccCiSMeis25jPuxj3on5AmSaXAnoDX1kYE8/8kV0AOi2y17HEDifJWH9v4bYd/gufV4dP+R7qzxJDQwoVby6iFiF1G6U4Y7xuw/aeRYhJEMch5/BZEv4e5hBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478820; c=relaxed/simple;
	bh=ORYvywvQF9sr2A9kmeEgyJb+JyTAQ1yhyURfVvOXciU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b1uTjrWATfQWoB9qu7LEkYMR0Oh+VPJUbs0MfaAlGMwdUIn1mx1GC+XTWxWeyvTuuJ/nJhrnpKYPhfsWuMyFVS/1WE9OoRi4T1mcFtN18YDQTke7u4ZyX8zLTRhuRXunO/80iUZZ9gFu25MDtEKdHVQIc3r9QTM0sZZswxYTKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=brG9/f5Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O1JDNELg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="brG9/f5Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O1JDNELg"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxv6f3265242
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=; b=brG9/f5ZHsm+OWy9
	edieNlypHui3oeUhNtwGZXlvW/TAJgmTIRb61YuDVrQrFJN1DBtd4sEWm3zxvajn
	HKPp6dcmD0dBrO59dhmAsE6nNCfZEwTmxuJferlrSfcyse4luZQuYVbLkeVzhiQF
	DsWoR/JLXitTvALazoDdiKK+MZuUzm0Cho66AIdO3S061t9IGUeX8rQTRFSgdLSG
	Yb6QuN/Ttou8BUkpHqI5TXXW+dhQBqRFgnUnldvBEfolyiv/R23G27079WNNr7OJ
	KANQqK7fSxvgRfQHj8dKeTY8sMjhiCp3mdyvVrWLSXd2wFud9tyxq35ivVXPx9ST
	o/HD+g==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpxyda2nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:58 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81ea59b5979so54008937b3.3
        for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478818; x=1790083618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=;
        b=O1JDNELgwCHfBg3hK+Ta9pAytgIACFQSPVSmWii/+Oku5jopavUv1ZmztuhfPJ44L1
         8K8F7SELogI0d8q+GcwbvdGZpnDPUxVfQvL5usBW8MMoRM5M7RT2wC0//O/z4JTch/1t
         HcQlYN1o5G3fwCgZnCrT22E/0VjK9ODihylyelytiizTL+/5FP1szSGIrPPIzJVr6b+F
         wNgpFsBgRUG5ZMR5UeJOuNId9QG4PUBxX9ufjVxk+Skr9tX6AUIsF99vE1T2C83Hkcv3
         cOMJTKnIVWdJ4mmfWhjKqA+TuKyVl/43UBqts0XoelBA4KZBqTwU00c0ghtG0rGKX9h0
         fq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478818; x=1790083618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mXggK2jLiWbRfUTf+c3NeC4UYb270KnX1MFdTp2Ppc=;
        b=xw0xpDMgwVbHeVYQ3U/6pNONoIpwVxsQr61Rk0dGd1SUcA5/Hirhgu7N14sU+p9hFb
         ylUnM9fRmULS0ZYp0FnM9LvXKGN1ZBCYzfsvCKaNzb9v1FoTMkP4VRHVFi57yOVZL2JH
         KjLjMLjIVGaBnI/B9ExvgUcsVxUy4AeCgScRczQsSwMEElYuPiCLdD2E4SeB7/oquDU0
         V/PSCDIJFiIp6JiUm2FIGddB2vY6hx2AU8hp5xveVMDfcBmI1T+kJ+zh4HrKekTKth0e
         hjAdJQvlAA5ScO9CahOblhHKT3eWoayp4I+r6b74Bj3alb4zp2iFSn5Xs3JcvgLcbgb2
         sHqg==
X-Forwarded-Encrypted: i=1; AKwUvByXau9kXhbrG9iGnSSvqoAskvYT+zyVXriiNokn6+umtgS926gh7Na6fctAjGrOgvqEZI3LA7rJlKVEQpc=@vger.kernel.org
X-Gm-Message-State: AFuF++nc+7ztBCJ5mIoP3F43RHgCiBHYosBRbbf/ZxE9q5WrA8N7wZl/
	zkvzDLuQxCM5+jb7RLIIlR4mrTWqCDEv1hFPxegFGGrNSFrPwDCKV+wfGLWCTZVRJC7uPJUkQ+C
	7RtmwdL0Nk8WcYCxrzRF/TA/yrLaVmH4xou0FQayPUY9w8yKtgOK2HIht/hOGi4FoVX8=
X-Gm-Gg: AYBFou1uJhFPiWCrHdGJEJXQVLkVV4M13fgO+qGm4WEKo+uZteOCIU5rUm7DsXcKsSV
	3ejrOsNH/68NFocPcw/uls7wff/iNYvVRgzH5efjYWhKgQ8hmL17vqbMT8AULlf8vIYw56f9deu
	fepTZ7eKfppqMsCSelyFspPdnc0Po1fSxTQWUey+pAvDSq91Xsj1rV2TzLgTlvkrynydx15pL1M
	pYGQCNvBadw86Aa5lfm1/St7rd6wTO4JeUZ9/+y82ljOwE/qa2Lhz+rB+zfLy2H0QT8276YOm2c
	ZuxYD/J8q/sEnHM3GGKPlhOImRFuZSmlIHx3jySqpSIC7aKgvtlvjnV1WeeG+pmUJjDHbPlhX+h
	p0qIEdUQHekaOe5LZiZ1BBJs0zdtSoN+wTUXM
X-Received: by 2002:a05:690c:c622:b0:887:1704:be8a with SMTP id 00721157ae682-88d1f402767mr18659677b3.8.1789478817690;
        Tue, 15 Sep 2026 06:26:57 -0700 (PDT)
X-Received: by 2002:a05:690c:c622:b0:887:1704:be8a with SMTP id 00721157ae682-88d1f402767mr18659497b3.8.1789478817225;
        Tue, 15 Sep 2026 06:26:57 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:26:56 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:56:27 +0530
Subject: [PATCH v2 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com>
References: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
In-Reply-To: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1891;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=ORYvywvQF9sr2A9kmeEgyJb+JyTAQ1yhyURfVvOXciU=;
 b=PGCt+aP+jk42cabmUEyAbYy1FPHGiHZieIT+Q77R5gl7R5qYcVOMHXJUjENBMiWlo7gxcyFCj
 DeVmA43HBOcBNQHpUGLcaRyIdrUVQQc1pup9sh9PiZKXNAjvv2mhQkm
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX0wiqluuuqQek
 M0X8+nfixmsSJwPK0DZuzvxyCGPyJiX3pGKjkRqX0cagUgQYaO/IM/rVSIKbs7ejOyuH0zXFPLL
 M8NJ6522ChTrQcCfOaXyB3UkhdjXdgI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfXxIn6nVTbjJGW
 mkry6/vLRyXxymY7xRQzck+DeeY5dRSfvV/EumJE3Qtc/5LK2OpaklAW/PcpoDIU56/sDHYAo3S
 sP501BwU9bF4gjF2G5OECi2UukET7tyZbnMua/YetlS9NTAx8KtWQKWsamBsa/6NNBKnhNbZubh
 O56HIVSOQ3S+qUCNVTQtFJbs1nMvRgDy3Q56JSt8mb6HEdTT183PMHSEmD+M4z7RDbD/9W7IZ5n
 Y/RvIqcAE59jlRMGys+0Jjb8mm75TQxp/5GrjhpcqDwmgOII0NFO/H9BBHiTXXa4LD5v7wbssV7
 bSCka0XTI3pID6I2Ct8WQuQkbJPCIXEDZ0GrCxpkdOAKd/w6H1Vp1NU3ETMEUDhSH6vt5zaAy5c
 phnDxahauEAiIoRgY9567PJtOlRprpSpkfR0svDnw8d+SdHrIoicaY66NVCA0k7H5jd7ulBTjW5
 Ob+S2yMNPfkRA8wc2Bw==
X-Proofpoint-ORIG-GUID: MS2EPP-3_N-J90xRDgzZzTUYm9NWT_rr
X-Authority-Analysis: v=2.4 cv=LYepeTfi c=1 sm=1 tr=0 ts=6aa947a2 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B_gQsAElUtnq2ZcdrgMA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: MS2EPP-3_N-J90xRDgzZzTUYm9NWT_rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
values are several orders of magnitude too small. For example, the
50 MHz threshold is represented by 2500 rather than 25000000 Bps.

As a result, clients using these constants can severely under-vote the
QUP Core clock.

Correct the constants to their intended Bps thresholds so that the ICC
provider selects the corresponding QUP Core 2X clock rate. Drop the unused
definitions.

Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 include/linux/soc/qcom/geni-se.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..5f18d281e6a4 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -347,17 +347,12 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * QUP Core 2X clock votes used by GENI clients through the "qup-core" ICC
+ * path. Values are in Bps and must be converted with Bps_to_icc() before
+ * setting avg_bw.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 

-- 
2.34.1

