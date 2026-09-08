Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAB5A5135
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894346; cv=none; b=ijKMnYnmGewSITPprIcuOg1V/ZfipSVSfNwXhd5dGAjgtdwSrtN1dovZBKUSFiAh05704j3nBA3yZA4jRZrZu7ETF/ycz+KGzDXj6YWPy0SQAVJD0twmwWKaFzRjlHS8yBQMmc79Pj3cD7PBGlJsamc/2WOYn+Uom5ULrw5QYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894346; c=relaxed/simple;
	bh=YBKWLdaQrCd1SWtaDl6Xz6EgYyBf3pvL+cDJoV8L84Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uE63EhDemHp1JBzy1wxUq1XOG2syP9kjyuw6/x2yGA7+FsX6joaw5TFUPTyKmJMigNwITa5JzfInigSze0H9Bt+0zzFoFJKZiwj7M9fBbb/xMOnhfEcoJglp9gFD88rcffo9c1vJhi4qVxrMc6gT+4Ozy86zp1QYJV9qEP5A3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9p9v2d7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dV7EmmzP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9p9v2d7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dV7EmmzP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FdWRi2769550
	for <linux-serial@vger.kernel.org>; Tue, 8 Sep 2026 19:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MTMhfxs3AojChSkFpOSdA6
	zOXQ4hO2RLfty6pFXXyF4=; b=V9p9v2d7V4JsDKpm9mkq2pMs4kkYLzhHDle06g
	Ffa/I3yx9OIe4v8Tir7LUUtKkugKGvsme/f2Bwxry1e01wJNJDgtlhJT9Df949MZ
	7M79zjERLWjl/kGP54SbX7dohJ90O/qu1y7OB1Eov7laFo3yiKJjKZqvu+iKsorF
	DNrt3ECDIFcXYxn9DWhOUqJp3/7/FQ5mrqW8XOSNe7OYzPiTh2dzqHD5CuLk3Ce2
	+HL1/gux2xZ1JFRKM+R9GapBj6aOA7Wpb55xOSCW6Sg5dioxPrNns4/qNswY2l0b
	OCqgxoNWv3uU69namHgEimSMZ+/CGAU6NVZcFcQMEBJF2fMQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjjvuhsrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 19:05:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-399311947f6so8407641a91.0
        for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788894341; x=1789499141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MTMhfxs3AojChSkFpOSdA6zOXQ4hO2RLfty6pFXXyF4=;
        b=dV7EmmzPDK8qyR6fb95swxo6FVva5MVkKDBA5D+u/2ltYoqPW4WeoWJJRPZxRDLh3t
         XzSG+BvA+eTcxnFZUsw9U5jRoaqcLedBP9A4R9jktU4XYv66DvejROwsjngBJ9MG7bl5
         rxhquocb+brU86MI8bM997mHEkub/B0NRO+9nHK63Nn0NQV+vdxSZ9GJmaRwHzFpL2Qe
         Y0V0EQHHqiEoUgE9YTi7zK30o8a3BUNrrhspy9DjP6ViFGAmz6XdAFprS647HSRkWbaL
         Ak+bGJaq0ymts4NiBMROxCBMT6a+Zvnv3C3GIy+72+R1wvsU42Y+t1GEZraxvrDVQueA
         JUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894341; x=1789499141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MTMhfxs3AojChSkFpOSdA6zOXQ4hO2RLfty6pFXXyF4=;
        b=lGS+wPODggs/IRyea7t88cXg1CT3faYYMF9AOgSN152AVD/kHwT4eUaQOgGdnwbyB6
         730NhZIGguJis5gNoZfK1a2KyzEwwcfslz8hKO9wmbxRMQpR+tfeqZUomEtj7QGreu1b
         BL1CfdkUkRdi9U7n5aZNM9d3K6aSWfkd/HSHLY9SsrVsSEwBxWaG725nTJaqLQthENfu
         7qJ0dJUfcqpGgxexlT1ouxAxEF3ajIErPgMbvrjA9k+iYjvjQ+S6WGt28sX3t1mD5Y8/
         nB0CO9d10CuRXae6SHc8bun+W6tT570vC46eyNxcsXRZoE+jIwQaVF66Cs1C6i6lyKNN
         cZWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLEyxj1B1KQE3nz6ogHWw9srO4sdr7X2IdBvAkFWNxDeA+zrdXn7fetB3To2j9Db8xdx6jD5nJKIczOIs=@vger.kernel.org
X-Gm-Message-State: AFuF++lF65oOfMZWufDzNnrARx7ekN4hFblYkMacFRusuCcy3WgnQIZy
	vwAcQurdTgtPcCs2u7P+vWp1lzB33DIBXcUZRNfMAVcGAy64DloDhYSEDiMQq43zt8obksOckh3
	oiG64neFbxkvBVsq3boAqxEkoEhHLmL9+CdxAwsatMc9DsEj40cOvF5ENHyX96KCmKLL7lyD7iI
	g=
X-Gm-Gg: AYBFou0xPznUmJ4VelLNypYNBVBlW3rN6RsHnBZaB0qr741x61YzfoG2RIHnZk4EMCI
	lKysmuF7uwHmb+4kACPrOFjp2YLiUB2WcwzMaBirtBROUm10pjhLIl2Hpm/hYYfLSfCF4nNJgbp
	vruiv7xTSjiAa11DC4/69Ysi2FU4nGHR9Ev8XA7fKzcDbOsWfF7bYBIjCmKZMtcV2zh9ZjcrFSE
	2b4P7SNp8UJJr6ng8C49trEO9xC5TXh3Ww0BvcgQH+g64hgouY2R4obBJNnl06qc151f4KQ6khg
	147jKN/eLb9jTe2+TlZ9AWfHr7WxbjBakXaRmXOgE5S4hfTI3/ER70lPuvmZ4lbuBqTidpxYuzs
	2prZ+b9/VduXMm6WIjRpxJBng3jCmxV2mZVzO
X-Received: by 2002:a17:90b:4c41:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39b2623ac0fmr45352416a91.21.1788894341146;
        Tue, 08 Sep 2026 12:05:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4c41:b0:398:9bd5:490e with SMTP id 98e67ed59e1d1-39b2623ac0fmr45352341a91.21.1788894340624;
        Tue, 08 Sep 2026 12:05:40 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm37603085eec.12.2026.09.08.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:05:40 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH 0/2] qcom-geni: Fix QUP Core ICC votes
Date: Wed, 09 Sep 2026 00:35:32 +0530
Message-Id: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxcoGoC/yXNyw6CQAyF4VchXdukgCHiqxgXcylSFx0zHdCE8
 O6Muvxykv9sYJyFDa7NBplXMUla0Z4aCLPTB6PEauioG2ikC4aUM4eCEgJ6p/Etscy4psJ1Uit
 Oi+F5JGr9NDD1HmrqlXmSz+/mdv/bFv+snW8b9v0AwuzMhYgAAAA=
X-Change-ID: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788894336; l=1340;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=YBKWLdaQrCd1SWtaDl6Xz6EgYyBf3pvL+cDJoV8L84Y=;
 b=CA/9n0q3xs9bYFZPoP5Q4L5kcTC9+7pH11bNlGa/PJEuPd24SNvSJZk9+tjgQlv272hnYE20/
 XP5lfkP16VND3bK+xvkZd2zoBFOERBfuf5fg3I1mOwUJrKvvIOSd3TV
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-GUID: A5UYL5cuH7mrHIMKmZt2g1rUqvETB1-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfXxAAkZqRUhZ5t
 0++Ym84pxKFLCYCWAzQKZ/hARS0ffUB75Ux7xV344mXQlTx/VwfDfuijPQW79UxdfKJsVYXMEgL
 73VQdhWa0i1ro0YwMY8zx6s75LBmshnbU9oYjPM/gFgqh3A59YIz7a+m4NuNRLqmF65AzP84yPp
 2Whu9sUj4cGWm2bhqL2se3gR9FawRc240NC3Jqb4hr58pw24NvZV9U4JeHxNKdCaIDw5FC/B1R8
 ihlQ9w8L/EDv24JCEgqvBXh37RII0jjInNbAVziSo0FVMozYB14M1NzNY/EB6SdhIhEIlROpMIK
 yIsl6Zwe8x+Kzvfk+z2o1nK4z5psMOcctwlr/RsU12LcJfO6El9ZVM0uq74zh4qPUyQgY+V/cTC
 9jStVKXi99fVU2Day6/M7RLUDf6F7Rm8aeJ716m82P/11pYuLE+bW9i70NC8VlEFTXq/IXwWcEL
 o2pWNgxsF+c9clo4dHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX1HGw+PVwdEBs
 AKygTUQ5BFWD1RX76V6vD13RMDNWiNlSImldLtyssnnJgBuh8xQUUgD+YBm8ISc/OCnAQ6wbVyU
 un2fQdPGP/Bbp+hVremnARDb7lDm+nQ=
X-Proofpoint-ORIG-GUID: A5UYL5cuH7mrHIMKmZt2g1rUqvETB1-t
X-Authority-Analysis: v=2.4 cv=X8hi7mTe c=1 sm=1 tr=0 ts=6aa05c86 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MOdl1PVcvyPrLPiNne4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080207

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
Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

 drivers/tty/serial/qcom_geni_serial.c |  5 ++---
 include/linux/soc/qcom/geni-se.h      | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-correct-icc-bandwidth-vote-constants-49001bf6e03b

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

