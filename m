Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B37263B
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785563310; cv=none; b=YXOO738yGawM0R7RKawV1LXjvMNQLPitmK70jdB7n4tWe0Zi8pfCH3DLW5Z0XdwMr5rLb4dY1ouj/d6JhA97XCVB2U31oYIFk0gW/INvk1u5jO0O6RjzCyFLlt3Q421Q/pqF0OFjDqJng015G9v2kdE4dS6DnuHOZhqgCxe9WM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785563310; c=relaxed/simple;
	bh=W0+x80zMaiZjHQQpjKgCMn3xdgnjn/ha+uXYP8AHjCU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tMZWDslDQny7s/h9mDS7DrBlD+uZBXIJbvJTDVtiWzy7yv598jjfTd4mCPN7WCpEkib6JUSr3NC3FKvCYLZ8y2a/711J+mWUXbTgaTWg7mhdeImBgyXSiLlali1HIsVpYaZR5dUCh1gdCxHTg2r/n6nJHeBwzN36hPVfCLmpF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0IBeo8+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PZXF3myE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0IBeo8+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZXF3myE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713Ff1E1758987
	for <linux-serial@vger.kernel.org>; Sat, 1 Aug 2026 05:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8MX3jV3we/gcIAGbf6UkGo
	WsKs4LX9upvHXLLurfMjk=; b=e0IBeo8+0VWk6p+h7ou3xJkpdHGyYAYYMtu4Ky
	zLeuyx0RSi3snJ/2pzj3r15YtsDbFvwykCz2y3BdnGkWYOi72QCML7ZZGBpdtwFu
	bDQfR2hWq3XjlB1CDYKoSkIs2KpNMjYTiBKqJfBnKOT3G1xE8sp0dts1Ru8ND6WS
	NnKbCm7ssPbenFfyQDaTqoGxqiU2IN7xr7oT/f+HGuubyHzBXS3x1dmz9tmalUh/
	k5IAVeiO8kZ+9k+bbYggyDHp24rDpqBHsMd3wnAMjsCoWhlaTGn36TwjnrT/rQl1
	2WLvJDRs327XRh9JjFwIrLrmVtKWmeEZS/vbuoLhVjtgKuVA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6g9te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 01 Aug 2026 05:48:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so48087675ad.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785563307; x=1786168107; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8MX3jV3we/gcIAGbf6UkGoWsKs4LX9upvHXLLurfMjk=;
        b=PZXF3myE2DIVlnhzjejj/gEV2bueipTSijY77T/tGmthC7vwebqLBXldWbM69H+PRj
         41r/S78CyRzgKQ4Tai8kP/bdL6ENy6n9ZUEDfiYLQnj8p+IBxkFu4xkTofmdc/+dqfiU
         VSZptDGOrTrt0chXZAxyEfh08GugeF6wyHnyvK2+p7jsok1JG/5QozAErHqt0jtkxjDl
         qsb61rKGxx9fU5znyzgnxNuuWmWvtL07BNiR4bwsRFF1wxJjJ9/ljX4sbohGR0qhpRMJ
         mgP9OTkbh4MR3BdxkdxKFSzaA1E8xLwvh55DEosf0RPxV5gCr0cLXmqPg5x4n2/w7RSM
         rHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785563307; x=1786168107;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8MX3jV3we/gcIAGbf6UkGoWsKs4LX9upvHXLLurfMjk=;
        b=A8RXCAYsgIMYA5gT4XnIMEEZvr9OAj+AZkitihRaoXEckHy3AG7kqmbKofdAkQ7/gp
         mxOle/smhZIiUquWc27tsp4YYxVxIOQM+WN5HkvsBWqHw+WRdE+WNtrJyZcjabjBi2cm
         qL+78HsErQMBSsBMtvoBJ1vWMdsfU+UYUR9O+kYSWr9zsWxD8LYgkPq1X4oS8HE9Tyvc
         rgUNtOuc6W02ZpMyE2YdUVJM+L1ovXQHL5gJXx8sKaTVSSsvr0zAzeXrUgxhQlBFlb+u
         3UReBAI1XHBK0sys0cfe5MOX7zbvIx0YfKSuoggNVhee0KbLTOW4bi9JguO8kdrwhBdt
         gsRA==
X-Forwarded-Encrypted: i=1; AHgh+RrDU55t3VQBSCBJ6yb3nORtES4oEFABC22TjH247S7jSPIwItKusTPOk67o3yO5YX5dPy+gcEyj2VTyUwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgENx9B8AHaR6XQo+psM3ETPGGy/ZjOcimmfql+S/n7C7XTSfm
	Cfz32ZrPrgFbtpKxzZWESz8Ye+RwKLAZlvkPohfHB0wv7/DCYlafJh9SgskaJdYmuJmg8nU/i6u
	GYAQvHZ/vaxvDfHxa5BXvN5Gv9jldo6Wbe9Jed1FjScT5J/9qfQlmGC1jaUbHqAJagHIPyE2xbu
	g=
X-Gm-Gg: AR+sD13/IId67YK11zYndxk/IMehYVtt1A6wsslUGlzzvTZEWrzymWf3JkW1Ei60VyN
	RxCqY7vTQaBnBDgMigWz5sp3W/mHb1YWd49Ush9eCqLa6/UWIw+vlIRElqmy99Em83O6MNAZWDw
	ly0hLxs7i2tLtDI1EZ5OZp+RulBaQTgPwRunAzCtUWstQjhwAxeGkg28LgrMU7yZof2nu2rAsnY
	KdCoxnnPsQ1yMo8IPKafm47VhXDLpvKo0KW9GwrHvYUoqIKVifBBoF85iGBdEUJsIbqQuRqX6Gs
	wKdiLmAsnR0dimmjX0ysWiPWFRvwzlGg8RvNROBXL2GBAwDAD03zz0lp37/IW7cukXVSg1zBheb
	hjKPgW80m94XLQs/jwT9wE2fkeMioC9oJJw==
X-Received: by 2002:a17:903:24e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d0521c6d4dmr24693525ad.13.1785563306673;
        Fri, 31 Jul 2026 22:48:26 -0700 (PDT)
X-Received: by 2002:a17:903:24e:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d0521c6d4dmr24693345ad.13.1785563306156;
        Fri, 31 Jul 2026 22:48:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm18305211eec.4.2026.07.31.22.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:48:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/3] serial: qcom-geni: Reuse common GENI framework
 helpers
Date: Sat, 01 Aug 2026 11:18:14 +0530
Message-Id: <20260801-reuse_common_geni_framework_helpers-v2-0-13753256ef71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6IbWoC/5WO3Q6CIBiGb8VxHA5wE+2o+2iOAX4qlWJ8ajXnv
 Yd2BZ2827O9fytBCA6QnJOVBFgcOj9EEKeE2E4PLVBXRyaCiZxJwWiAGUFZ3/d+UC0MTjVB9/D
 y4a46eIwQkMpCsoKbOudaktg0Bmjc+1i5Vj/G2dzATnv17ugcTj58jhsL333/LS6cMmqzLGPal
 KYsxMUjps9ZP/ZcGoVU27Z9AYur/6PvAAAA
X-Change-ID: 20260720-reuse_common_geni_framework_helpers-787081bd61a7
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785563302; l=1292;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=W0+x80zMaiZjHQQpjKgCMn3xdgnjn/ha+uXYP8AHjCU=;
 b=bUkDAd6/fwJbE0AOGp+24pbNfQmBA/XqKWJEx+WxaPwCLvIdcdW1f5xoq2CmqkLoXFz7PeMGN
 C3llPWrgS68AuBQdPzvcY3evTBvTEu39XG9V2Q/mmcKYWrutkJa5wTz
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfX2eeDWoYbztl4
 cEOEYV04chuKgr86dmaVAzQTcY0GOguqqKyQe4MWzlG5moZWHfSI6wh7N/mxQInD9ROa+HnVS2E
 sgziAoeBld519ov/zOZ4n/Cs/UgJOxk=
X-Proofpoint-GUID: srZXty0XUaPvb3ayNTiX2YPXV8pJY5w3
X-Proofpoint-ORIG-GUID: srZXty0XUaPvb3ayNTiX2YPXV8pJY5w3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfX58xrkwY1Ow4i
 2eDO2d96hXwHBnDwq3WAcKZhG4/wSUmcXhZk6zzb49Re/tU4qNG2UsyPe03DxqrsjftY+wMGVrC
 U+/7jcnSS8sNkIsFkpbRvVy32FpDPvWs4L2R4zvaEcHNcJ5w5OhxXe3IkojuYuSK6avA1Ftbvpj
 f3xgRIIeysnyA1uTDPcUCbv8xTLcghNmHXR/st6bwtiFy9wxJFzu2CBwo4yh6R1qUQ4ssIY0gyh
 fJvUgDokoWF4wFUMTpEbY3qpYzU07cUeHaZmhBJ68/8acy0ZcEUX81eijYkESlCrN8iWp8AzGxq
 MSHo4P3lXvqKNJQHESoIHTwRiAFDK4eojYc0BIAUXQpsZzMEQnh6J1k/xIKorFio3eGwUzc2CYt
 Er2nEzKusqDU/ccMG7Zabo+CAbsN6bT3pXp1fGkbyibapPuT9ECu6RhEJaVWrZp29nM9ITcz1lO
 iWEpn40UUcSW2UO4RoA==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6d88ab cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=zYmsmQLqyy5UlMnypS4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010037

The Serial driver currently maintains several helpers that duplicate
functionality already available in the GENI core, including resource
initialisation, power-domain attachment, runtime PM resource
management, and perf-level selection.

Replace these with common GENI helper APIs for resource initialization,
runtime PM resource management, and performance-level configuration.  This
reduces code duplication and centralizes GENI resource handling.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Rebased on tty-next tree.
- Link to v1: https://patch.msgid.link/20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com

---
Praveen Talari (3):
      serial: qcom-geni: Use common GENI resource initialisation helpers
      serial: qcom-geni: Use resources helper APIs in runtime PM functions
      serial: qcom-geni: Use geni_se_set_perf_level() for baud rate perf level

 drivers/tty/serial/qcom_geni_serial.c | 204 ++++++----------------------------
 1 file changed, 34 insertions(+), 170 deletions(-)
---
base-commit: 8200871327d1bd4c08daf248a8693a3093982fa4
change-id: 20260720-reuse_common_geni_framework_helpers-787081bd61a7

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

