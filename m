Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517459E355
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894353; cv=none; b=qwBfiEkXnayL78WqaNu+fH+dv51GRjSryHCkW04xtDwNK7HPcJEqdZu24RFycu1izCcnqcJBbQhKFFeSCEoZHav5VOyO4nUbPo5MbUPIKhttCDNg41RIhHXMBhtlBATnS0qSjbjjyCf091ILMfMSqZLTyYpRM0R88kVFQbshpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894353; c=relaxed/simple;
	bh=I9NPf4pLqCIOuVZ40TomZH1MXhGVApNTB25lCkX0SVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMemUkBr3bEsQiHnfj8U/llHiVzKqBiI+qwty+n6EGbKJtKigYsBszdFWMekt+lv6KDG9YinpK8mEXSqTu9HhKsc57eKFlklAMWOdUV/PQOzO5L390Nz7h1ZJDlhfbkEfVoRkZ6NItlcxY0tNWnCwVq4igBv1YKNpm+L/DQfnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eq+NwHIH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e1kEyhVs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eq+NwHIH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e1kEyhVs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688IH8gk127829
	for <linux-serial@vger.kernel.org>; Tue, 8 Sep 2026 19:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/+O69czRh5+nb2AnqE6PCiArTobyyEV/mm4r2qu7338=; b=Eq+NwHIHsM5IRto1
	g9sVNziZ671fde3YDfR94fpapFdxk4OCQ0ek3zQDWyV3/Ot6sEdtoZbHxA2I00xs
	DTY8+fX8I6lpTtHEjqvPiCDa/2YDEXoXkJPn4N72BHetk13CRAP1LJTnKqRam6qC
	iIaJuUJ7Fm0CacGX3Ns2dz8Mx/DGLAQgpLv5aiqknufWk16lBLLfBGJrWs8TjNfl
	QOpLfbG1vrY5nvktuI5UaGe0qEM7JTJwz0OLuTPMMwQh8giNaywmXH+YHR6ZPYin
	P6mBPVLYs9KAcL3ncWe5xLncWcg+JgApG/kpDhfzW+oCnu6ld2+p3oE+YwARZLNy
	0DsoqQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp4ame2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 19:05:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc18ced1a5aso8200853a12.1
        for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788894350; x=1789499150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+O69czRh5+nb2AnqE6PCiArTobyyEV/mm4r2qu7338=;
        b=e1kEyhVsOuZJdR2ELOjwAXV0emiBNCazmkYqufVtqM2lUmnINFD9ZGY8c+eJQiNbOT
         gQW3Ighl8SN5BvwCEGO55EGU5JxcJXnkvaExIhDtNG17nl1asMijI9sH/Av+vFQZeEle
         y/DTDiCG+O4DyuK2FQeBuEwrv9g1/qq8ghdkJ8Yvmzamk+gOmSgs/RMi96bAlFRdpmcM
         HRcHPaGYVNssjeVfVTt428be8jw9z/foqoZ5BQzpzeXbJGiXeFqqnvSjkvxeGTb9EFgo
         uem4qGpvpyZ5v2FANVcVzm6rBTfX3mbcG1FjgoVhjKTO94qi8G9WVHWB33fzCjht2AmD
         boDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894350; x=1789499150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+O69czRh5+nb2AnqE6PCiArTobyyEV/mm4r2qu7338=;
        b=WDdsunJ32C7D2juYMoTTUiVf8b6r2f34kg8XQUrGgwTPPts9mTrANHQtg9rIZh8yyG
         jNuH/V1H4Ijz86jleHP9wRTUOgAVLcFXohuXxJPz7ZT1lOv+ELOhgoJYi4n5u6dBUKJA
         DbC1lM8c3m2OlX0mc7j/l8Y7iZFy+UjC8vtwjPw0cp0VTyTDvRRktD2cVS/pOn54flYS
         AYVM9bGhcRKR9864pbVbFOZmPYOyQhhZTL/VIAao27pVmwsVnELU9uXjcz302IrsVFz0
         MDfCXfMgNxP6vvfnO+aKkwYL0wSnQS0mtx0qwroWY5ha2bGGfU96l1RYVYD9QgCF7cdt
         TWEw==
X-Forwarded-Encrypted: i=1; AKwUvByO2kqadlkz6u+s1v7DTAdHqcXTOr5O7AVwf6MIFEGWqeA0p50QBY/+7u4sWIszQFlz/7JnXUwYB2FuTc0=@vger.kernel.org
X-Gm-Message-State: AFuF++kqgFWLz9WIUrWqgT5fb8Q0UN0ZDQPx/unpKf76UgtO3GzbpVgB
	O+c9n8hyXytQQ/dDQlfE53uGhLLHfxgFKYdSxSt7itLqoDfTmr4NwcP0YvTSAxtI2jaFAQZy9Xf
	bu9ihLdiY2Vk6XHEtTFw9L5uZ+NXvJLi+522lWDw6T6d90Li7tWjxiFoNW4V7xzoAxmE=
X-Gm-Gg: AYBFou3x7lCYWJ6Gn2FkQdFRjKxbn9kpVoV6KfuSwvkV5WSn5DKxZUhXJxVCAyF3qBt
	khHOrz/N31P7CRcPmkr6aEC1U50djlBZ/mBfGisrlfzOH2q6tsqow8RveSEkTs2UOBdCZyNVuUu
	LU61EksBBKjb8BHf7yWbkCT6wb4YeMVgVaidB2YXdImOC2hrvc7/8Sb6QzGoB3BEReburquDrTB
	9Rp66LSnIH5izngv77Wydm3Wb9J079jSYBehyQxCUlOKeauOT3j2gvchGCMR2ozlixDZtHxB+vV
	V0VopGjmvVz+c+RogbdnErGLCX/wW1Ou3hCfBsOqsjE6xm7VAFgu9jAuUYNwRIUvGqMRm1LY9i0
	1canTXy8UQOq3kjGeflGNygSXmc32c6WBCaa+
X-Received: by 2002:a05:6a21:62c2:b0:3d0:d0ed:f141 with SMTP id adf61e73a8af0-3da39d18dfcmr49471669637.2.1788894350054;
        Tue, 08 Sep 2026 12:05:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:62c2:b0:3d0:d0ed:f141 with SMTP id adf61e73a8af0-3da39d18dfcmr49471610637.2.1788894349655;
        Tue, 08 Sep 2026 12:05:49 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm37603085eec.12.2026.09.08.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:05:49 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 00:35:34 +0530
Subject: [PATCH 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-correct-icc-bandwidth-vote-constants-v1-2-fbebf6b3c341@oss.qualcomm.com>
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788894336; l=1563;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=I9NPf4pLqCIOuVZ40TomZH1MXhGVApNTB25lCkX0SVc=;
 b=ecuJjDc5z230HhyVm6NEypOcCml4IuAvWcjkDgwj4yRHbucn5m3bE/TJz0eDZ1x8AWx2w9M8X
 xVepV7l82/tDfHzdNS9w0/bRJQLDooIC5xvECQaDYl6lA8b22UzGY3m
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa05c8f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ZOf5TxNYE7tYtAAs_IYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: JO8jdQVYvH6XXzTnCvs9rJnw1bbdGSgc
X-Proofpoint-GUID: JO8jdQVYvH6XXzTnCvs9rJnw1bbdGSgc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX7j9L3cfibgJt
 Xqvb+XCqU6MfwV9SqrdQKUSef8JUwSHEnT/ijowm2vnwwP6ca+3Hh9sR9IkQ4TAfqaseK7pPnJ5
 jyQIIvGrHEgyY7tjaVLkop0aAp4c5fmzCSqb3Q/9i1HfqUHl+oPvBPxfDNZh6Z5lYyYyl5bHofF
 +7t900neEfebwV4T3nNqhZmmfZFd5H7KVBUwY6UUhZX1s3ZDbm3EXsiPi3g8si932OABTZrZqLJ
 MpUVE7t1MHX4Ks4uzTqIiDMzsf0wgPqH19Bp7k+yXMXjzslP/Vr3tsccjcldfb441bTjdwn3kZX
 STo5EnQUTSItH8lu0u9PlvgfVL6ILCdPx2mSygDd1EDS8RbtqixkmNJJHe0yeiM9n9kztUHBZXG
 0GC71RP8LDs0fI2uBUArrbspmSXpT0O6dI16J+59VVSAqWaF+h/BP5/q6rJVrZOOc/bCc1Gs6kF
 72EG+w5BkftXbFsktDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX4wd1i+U3Tq9G
 emHnPekHRjFNv7gfLwNLuVU0yszELT3CDrd3SwbScxbN8+k2/AMzr+JimvU6YwfC8rG8MReb5Aq
 1nCCXA0u+B64uQpQ7M67XvSKE98evk0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080207

At baud rates up to 115200, the serial console uses only a 1 kBps keepalive
vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
active but does not request a QUP Core 2X clock rate.

When the CPU enters a deeper idle state, the missing Core clock vote can
leave the console RX path unresponsive.

Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 MHz
vote at higher baud rates, so that console RX remains functional after deep
idle transitions.

Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect support")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..b4b4724f1c5b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1482,9 +1482,8 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
 	 * only.
 	 */
-	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
-						: GENI_DEFAULT_BW;
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
+	avg_bw_core = (baud > 115200) ? CORE_2X_50_MHZ : CORE_2X_19_2_MHZ;
+	port->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(avg_bw_core);
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 

-- 
2.34.1

