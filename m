Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73103C1083
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478816; cv=none; b=fepToehO3gXtmUguH4EnL2H4LMogTzYz9rezNOuEbt3b4mnXwGhdZD+ftGUlkLHo/ma2J8Ta1JvTtSmCXew7R3qQ+U3T4eRXTTSKtnwEVvVWONZgxOXQUn/X+v7fRDlw8behRupuPExjLGSCckC/m9FMusyyzRN//odeHyaE2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478816; c=relaxed/simple;
	bh=iYf0Z3IUg5KR7a1qHZ0mBPi3Zdla7UuK7O+KESklDX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NPiM7cs5vnzZ7hZyIB68I1MFhSENs4mhA5G92e33UVnINxNwL28kEmeRFEquMG0wg0mZQ/Kc4Jmqa7IfaJYmMwnkvaEx5bRFLV7m4SQbf3NNTSYoM4lSI4bWOEiLC/F+8oWJiYyrPMtTOfUkNeDyrorwY2DDyJ6IMTIA38guJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kjtMXzNq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVnT7rZ6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kjtMXzNq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVnT7rZ6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD0BhF3015927
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g2OwLyaZtMOAIiCLuhR+Wp
	6NOjJhPYFA3tdfLkK+WY8=; b=kjtMXzNqi7yhVkilmzo0cTMPVSWjw4C1hv6fBf
	lNzwrD7cYwv+izQOfKOgrICB9p7KxkOWec2qfPq0UYWIA5FEAvn3oc2TXF4sPJcy
	GRXioYi3Lui+tAOJFB1ru7fHX4RMrocZ77FcvQqegQdP8D+ueQhua6JLPppcvcZA
	UDIycYpji1PEQcW7jLsjNPC9ILk3w8FDQcrcLWO90RIFY6WXSwiT6ow0vml9r5hs
	j8Z06Z6Iq6UylZSg2I0P8RVIaykyIgWlbHcwlYvCykN4dwnD/vvBG7DVtBiFdGWG
	hVOgltZOOETEoa/apZQUYUnKzd9tvYiR8bFnYevMO3pvL0qw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpx4sa938-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 13:26:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a07b5b5efso181904185a.1
        for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478813; x=1790083613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g2OwLyaZtMOAIiCLuhR+Wp6NOjJhPYFA3tdfLkK+WY8=;
        b=eVnT7rZ6ldkKU8tVSG1vNm4K2BIf/UKH+2Xf2nJuUnXCch54MhZRwAblL4DPXZM1sC
         67tAZeofa3mo8o+tbI9BLJ6T33FHSwztcks6qG5N3KwQ5WRmJIujNuiMbCc7ntyrzJiT
         4WIgeby7MLG99heKbdG5nZZa5z8NnFXG/xt+Ir0pEo6zBXa0ec0RmYPtWwb5K7f/Fypt
         kZPoUPb9cQVfHZpWgPmGiAydJE36vbpWoabKo8CYeidLQYg84B3xPiajBi8zGZFzCh/c
         me/lFfiLCVBHj6WrypsWuWH+0VCIOFFlE1EOp+GQAZiih5tRmxnSlMhAt4NZXh7qQ/7Y
         8R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478813; x=1790083613;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g2OwLyaZtMOAIiCLuhR+Wp6NOjJhPYFA3tdfLkK+WY8=;
        b=jDazIAvBlJCjFWRYjcoMpVN0BGJKgdx0qjkBXCMYKXOWYhgLXu5mut+dko4vpS3nLP
         APf2qoQ0p1V0Kp4k0nm/tzASWKQyFoWssW2Hl0RoTc1b0SFCBLR47AwUW1Fn5TUgo6oA
         NMmbFOAJoEFNGMA4ed/5WtqOe8MGaHgJHMdbp+49pFF5WnzvvnRsqX/KKmqWaA8Tsd2z
         lzrrgDoA1DlWIRVdJryHm6L6QoMOV2t7HV4ro2pQfskksTACc2lPM+IRAIZ54QZZLQqc
         Py8vwdy/5IN333UeY8fWBjeEZ4TGeP6cB3KyQbpTdrbO6B3HtI7QOgI6IeGZN/A96y8G
         fZZw==
X-Forwarded-Encrypted: i=1; AKwUvBwhk/1662gYh0WgEb7kkeqMRtgefWrbyMUcgh2JbPqHrRgswwFg/tbA9MWr5S3f8qTvm56PZckuGYMseyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nfOaDYWyQhd6bL64ITMtNnlp90KF1Sl2YtbYERtun7UULKVfzu
	xeWlyZD9J3H8snDfY8gmdF7MoeWprEaXgH7M62MLEv4amydiB78OISYSQxz3yL8P1+kFNcDXsPJ
	7WPsTV6wIH9G7xzPBMrARKMQvbFmUyGQRirS+Z6y35G2D1PGX/JshaF9hYNhWmdHQ7NM=
X-Gm-Gg: AYBFou3pUugmmqJt3Z/EODKjBlVAXbfNxMaurJeyt+fFh+5XVEQcm62WJJLTztoaWH/
	MqsEpT9YWtJjC1v05qJVLFRfwnt4OICnKGozyEEWAvmT8HYEaKlZbmsU1R37JJvZqCn53vxrLsE
	2fhCBFmM2Bzs6OfextWZz5FsYgZdd9Qc156QnI0BBqSB2BdtzwfAaCiy73a7ioKiYEjAtP7Ax64
	Oarjte1bPzsw6/oL3r/+4S5andY4yDTif5Pc9PJlOEDtx1J8kLmIUWObXDUV57ZCzC/QdTiLFuW
	JCMLAzs/nDbQ/qxQJ0eb0GDGE1XZibO5l4Bs1Am/BlplZ+8rRgw6k+ptsizVzYX4j344KPR8zV+
	qhdzs6SJ0+RWOkXeFGNnUXA==
X-Received: by 2002:a05:620a:6914:b0:939:f861:8836 with SMTP id af79cd13be357-93a34647d22mr466465185a.20.1789478812856;
        Tue, 15 Sep 2026 06:26:52 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:939:f861:8836 with SMTP id af79cd13be357-93a34647d22mr466459385a.20.1789478812305;
        Tue, 15 Sep 2026 06:26:52 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bfc90sm1248906185a.37.2026.09.15.06.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:26:51 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 0/2] qcom-geni: Fix QUP Core ICC votes
Date: Tue, 15 Sep 2026 18:56:26 +0530
Message-Id: <20260915-correct-icc-bandwidth-vote-constants-v2-0-f78eb611204e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJHqWoC/42Oyw6CMBBFf4V07ZDyCBFX/odh0ZZBxmirnVI1h
 H+3YNy7meTk3twzs2D0hCwO2Sw8RmJyNkG5y4QZlT0jUJ9YlLJsZCv3YJz3aAKQMaCV7Z/UhxG
 iC5giy0HZwFC3UhZ6aFBWWqSpu8eBXpvm1H2ZJ31JO+v22hiJg/Pv7Y9YrL2fsv1PGQuQMGhMV
 l2Zqi6Ojjl/TOpq3O2WpyO6ZVk+32jmp/EAAAA=
X-Change-ID: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789478807; l=1532;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=iYf0Z3IUg5KR7a1qHZ0mBPi3Zdla7UuK7O+KESklDX8=;
 b=d08jlEM5VgBRvdC4T7g4myaKphJkeogjF77ziBgbB+C9u0cB2ARnLUAAiAyEv4s6k93DgNN1B
 FvYamBUVSbRCCy2N0fCJFKGBEf3Zq/KgiZ+RuTPb+ccXpt6wzymbL8+
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfX/4w72dkzoG2C
 5zJUN3xxCF2vXO9r7QQfNL6itSC3JawWVDaD2XHjImrEBWn8G6/Yc0wQNEQtOT6O0AicYW9Fhp9
 rqQYeuWV+P+qVk/B0HYfqk/jSPP7UDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NSBTYWx0ZWRfXzc+JP6G19bz5
 OpIzwzR1ey2kqvjxhOLA/SG1grC+nJpgEz1YS67NryzW71x0lmHkqlkWnrFACvNTx1KiK8ZyUp5
 cNwWuM5KPfv2uruXstlxNWcwZoDvBN6U0vG0WdoLesfc/41617bL8nf8asWMN1BToUUToJq7WM/
 S5xoD8fZFjfco5b4acq11MpE4DwpbPLF1onkz0LahYHqJ6UlS1jfgaO/d/py4usHXqTA5AhBE2v
 C5/iUOX18FL9xuDfvV4VMBd75G6PgeRO6dymioYvWSgmcHCEp3PpgEkihWwsEqQ+INj8/5qopfv
 CZ6J6lflYmOllmqVKxeU5wdHHXxR3Ar1JUpkv4KM4fRCI7QVDZ4Jqhz0fm8+6thWBNsiDrI3vsq
 zB5s7xScEpCM3DeWruND2o5RAjdJEqo7YIAgcmbh82wh4Nb7cEuE/FpokrqYxfMGtLe2ytQTnwl
 vNIk1kFQFJoZ89NnC3A==
X-Authority-Analysis: v=2.4 cv=HsDjiETS c=1 sm=1 tr=0 ts=6aa9479e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=MOdl1PVcvyPrLPiNne4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: V31rv_w0ClBUzBZpdCoYXIRacfcHivnx
X-Proofpoint-ORIG-GUID: V31rv_w0ClBUzBZpdCoYXIRacfcHivnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150195

The GENI_TO_CORE ("qup-core") interconnect vote selects the QUP Core 2X
clock rate. The Core 2X bandwidth constants currently contain values that
are several orders of magnitude too small. Also, at baud rates up to
115200, the serial console uses only a 1 kBps keepalive vote, which does
not request a Core clock and can leave console RX unresponsive after the
system enters a deep CPU idle state.

Correct the common Core 2X bandwidth constants and use the 19.2 MHz Core
2X vote for the low-baud console path. Higher baud rates continue to use
the 50 MHz vote.

Patch 1 corrects the common Core 2X bandwidth constants. Patch 2 updates
the serial console's low-baud vote to use the corrected 19.2 MHz value.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Drop the unused definitions.
- Remove parentheses.
- Link to v1: https://patch.msgid.link/20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com

---
Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

 drivers/tty/serial/qcom_geni_serial.c |  5 ++---
 include/linux/soc/qcom/geni-se.h      | 15 +++++----------
 2 files changed, 7 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

