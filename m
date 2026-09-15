Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6E49DBAA
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478830; cv=none; b=L121JUtQH6x+Pw24CVhlQFKoJNpRNpHMuWv8quFkSHEtFobU9mvvqWAze9kd103gEKvglsIg2FX43oD7HDImjTRGhVvhShOfPgUfua0Yar/jR7oYDPErKHPm0+CZX9DejO0XYxmt5qen0H++BtnKiIMzixBhaOvFXsjLHLhNiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478830; c=relaxed/simple;
	bh=XMZcz6kYBdTUSQPlM1s/g5+gV03lvS/f/BpAkn8eNuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNLXwL0YuADWtBzzXE5M+k0c43TGMIagsTa9vFUwJECOVxwsrxxhCP7ajeS1pW1RIFuqKOGq9CCyDiXnSU1FPez6oRPR3TwwluMcXKGVZx47jpq46kAVGWSPfnWkxF9iPK8+h40nMBhmFnVc/iRuTdXxvPjsO7T0/Q2TfFx525Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuC/zuaB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cxu6MCYj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuC/zuaB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cxu6MCYj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxobK4005196
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=; b=FuC/zuaBUxqxNEe2
	qH5/epyShHcCw1cchQDsHN1wiKCMlgk0NU6hwCQWJIJrknym89MmBUggFQo/FF2A
	qWF9kNstIb7t0OgUOqMzez26mOrD5QOUzMjTybblCQSGXS5SL8wTlPpThQbkk1zo
	/0AJ/ypH/tMncHakRUBBRssr6XlouefATcBULaaTKxkTcCnrU9kqpsKTulisBI9o
	Z3zc3q1vdGdl9T6tX3x5npDa7MWGD3vx3llrvqw/ii14KoHvBgXwg4ZUlW0zWldM
	4NfLraK7+9MxB6BoeRP15tlTubLnhmn6Alx7Itwa1Snr/n6OlD+8oZ9d5rPLvbVB
	+mRd5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xts0hj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:27:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so1146320385a.2
        for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478828; x=1790083628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=;
        b=Cxu6MCYjLwfH5y42FpEHBxnjBYLsFhAkf3OjAur67+nkv74YpFGuT6jlU52el7jft9
         eDFQ14StWqf5SYm5WhzL2gYGH+VmtHG4vRQqdULLJO4wKnprQGJzrc5bdOljwSCI345v
         W/rFD2YBJqEubgZULGk4HocPngo1ZiLSxj/TFAxeg8+6gyMMwapinbFmxJuEze3y2Am+
         3V3G9WC+0K3O3uar/D3jP0NzmilVZ6KOjEGq8dpeVKUR3VPioWGPhOz/lxWEUO0ydtxn
         6Mh551wfpLWzuLqv+0Hn10fzOkESHLcMtkA2/IlndsuqWbGozJP+J/5VPkMTNFYWNlzE
         3zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478828; x=1790083628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbqlJQjQyZug5ULzZ6y7JKD7Ojfb/phQ4FDoOtOPOVs=;
        b=ft7PqeFGCBtnT7JTxa5c4TDaYy8NUJD+bL/YIkrH9ivUUB1bpbHYhQsyMUhxq6RILO
         8a+U8sx+NCe7L4rcAif8PS8ncArfIXlI+afe5jnt4JGY+k9crYZgMzPpsiFdBVXiIKjO
         zQjODsfk0JH5k+tJdfAmYXa56pJofHUbHpTsSHYpg7gWKsmkxGdU1+hzCmhTIoH/xcxA
         ER/YPFH5X3NBnPTQmeL8IT2v+rpM/iVbymgHCLe5JU9SQ5THFvWvZiFq2E+b5rW30QS/
         ckIOCgbuLdEuVAaYTMaOskjZodzbRU9Ma+wsFa7JyLWChOtsvxbc1HGwHLbLPA58jNsq
         /rhg==
X-Forwarded-Encrypted: i=1; AKwUvByEeus73QYHb6w5a8AY6U0LYkcuGK6WKPprQsEv0viQvZE2OIx0ZyO19dig99+juaHvzUROMKPrVX1tBiM=@vger.kernel.org
X-Gm-Message-State: AFuF++m0artdMhj+QvD93PQGsnZGZBYfwzUnd4lidQYuBjJ7XlNCXAjm
	9ivZEDe3M0+oJ+GI9DZE7FD4kw6i6WUHbcs7GQQQev9q+E+cBrfgToGdglYJVJk8e80Qwf+AJq1
	+2LyoGVRy9c2OHljdaB7TVj+qOm8MTYcByLUoIkAtG4rE+gYmS/t1Yb03hPsR8rb/0lY=
X-Gm-Gg: AYBFou0uTmJxpkK4sxOSJyfEt0xr4VPeZxFTXlbyEgLOzxrzvjDc1ztpDB3szZEmUrT
	P9S9UxPphDw27lh/4bFmZHF4wIa+VxmfVs6gfrMo+2tGLFmwaAZxID4m6daEQzogigONPpJPbBf
	I/I+7AEyi2LrhetBter0Mkwb1wB0YiNkYgAz2k7eaHWlk97w2XMlnMnPmKWBJ4q3dZ4iqQ71gGs
	lWQa1VuuNqap1E3KY2ZvqXm/ESLG+BNpIGlM0ShkyjyKJfY5uJE/yEVP6d1gUE3Bjup9Yqrfy6w
	wFRBFF4fbNggjiIRgahEZSKJvfUVMiXZBWVcu8dO8Q61Mieu3+8MxkWf+vi+2zEmNSmeShlq05i
	RJ/yXMIvTD+G4zSL+u+FavIBG4xQIQI7vkhBE
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr982091985a.46.1789478827628;
        Tue, 15 Sep 2026 06:27:07 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a29bbcd86mr982044885a.46.1789478822427;
        Tue, 15 Sep 2026 06:27:02 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:27:02 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:56:28 +0530
Subject: [PATCH v2 2/2] tty: serial: qcom_geni_serial: Keep console RX
 functional after deep idle
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-2-f78eb611204e@oss.qualcomm.com>
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
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1650;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=XMZcz6kYBdTUSQPlM1s/g5+gV03lvS/f/BpAkn8eNuA=;
 b=nOXSuI/UktldwjJpel37rGs1AWfUJDxcbpM3fdZBFC5keaZcGMeKYtaK3LOJa/rHbkvaviqxI
 Lt894M0YUpnCrdi054NmypRms2gV2khkH87fVp87rBot6XTAaGyEhGr
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: zl8ZsNN2MT_nFhKsE-Qlsh7OpxP8S0gV
X-Proofpoint-GUID: zl8ZsNN2MT_nFhKsE-Qlsh7OpxP8S0gV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfXzsYBewJ92gWv
 2h+2pavBrulj/nW/hhYCP8C/eDwbzJm2REj5TVMDgg3MwKShuFsMX48rUgLV/0th/5qS40dDW+M
 2bAfmozo2u701FD7iXYh0xh8EfzC7sY=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa947ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZOf5TxNYE7tYtAAs_IYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX+j4LHeASvfP1
 onNjyrARt8ZmaOwKnuJkvxPa1PiwioGzmNQ2kNJ/7rw3C8IbwW1BFANuaBpyVeJYmJJ6ReQNP5T
 QRE9/elOWHMLgYRIXp04dm7dVkIE5S7QOT5/Om0EEfAAfttq9ESMF/TQtsltamrMyxWTMaei8Zr
 vIAVA03auzTMbKoeTRBRt3BdcoEyOCcKTZhQCQsYVWUhS1K1h4VJG3yqqKgtXDwItHDoJFvJCJn
 5hFCkiiV2jP3M00S77u2lUlEtq4BpThJQ1qV3aFPTkwomuJwpSqdjRhYUcP2Kk6iTnJW5zYzSlv
 WS+fqVjyAnb5Li0f3zZKNgJ1HBlfmQwkCdhEPI8N0aoHbPoKNjb6wielH0QVnwNWGfQf53QBf9J
 E48TUaMNld3SJwJFwy0W9AA+E+FwWeHxEORyu/8WIaPo7U1kMdw9qz2H8OEDN7kwK0q0nL65kvx
 ca9TPoVCdSkTNq8pwSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

At baud rates up to 115200, the serial console uses only a 1 kBps keepalive
vote for the GENI_TO_CORE ("qup-core") ICC path. This vote keeps the path
active but does not request a QUP Core 2X clock rate.

When the CPU enters a deeper idle state, the missing Core clock vote can
leave the console RX path unresponsive.

Use the 19.2 MHz Core 2X vote at low baud rates, while retaining the 50 MHz
vote at higher baud rates, so that console RX remains functional after deep
idle transitions.

Fixes: 7cf563b2c846 ("tty: serial: qcom_geni_serial: Add interconnect support")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..f7e81b652255 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1482,9 +1482,8 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 	 * Bump up BW vote on CPU and CORE path as driver supports FIFO mode
 	 * only.
 	 */
-	avg_bw_core = (baud > 115200) ? Bps_to_icc(CORE_2X_50_MHZ)
-						: GENI_DEFAULT_BW;
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = avg_bw_core;
+	avg_bw_core = baud > 115200 ? CORE_2X_50_MHZ : CORE_2X_19_2_MHZ;
+	port->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(avg_bw_core);
 	port->se.icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(baud);
 	geni_icc_set_bw(&port->se);
 

-- 
2.34.1

