Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517690;
	b=GzgJU78V8CVjWliNz1tlkbnb/uOagJ/nDWAJoLyN12GuHavDEFPA7GttdqAn4qrraJ39
	 o3xJDXKrmon3FE/v4ygPHcv/wqGLhGARuC6uxKV2RLYMjSgt0SJo1ArmAW+RdyhNBZdj/
	 ELiwo5yN81RWi15E06kgiNnU8z0SSkMot8uoq4gVmU8i7x+seEvGTOh0qLTb4xll8TODk
	 jIDcm2U42XBpatwkuKlxKNj4Kd5Ht6aDyVkv6wH/YrYHnDIYkj+tnbD+qnSGN0XmDoDtE
	 VsqxxbxEq9ImLyWBbblDJYY0sjRO1sGVgGQ7jryK+poJIX3OO32+eOd0lZaSnae2T8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rAp/Ls1/54nALRkGPdoe71Dsv0aoi886pdtKQJOKrIA=;
	b=cm3S+VtiIV+7wdE3UW+DQJT/13nctk5pQcqGWr9DKfsQPH0IsXCli3Io11vo736Vr6lv
	 PS6Wz1m/JB0MDBlLBiFlhagA3aKERicYZUhKzvCrK3k25SZOF27MfURvBqK2fTrH/bYLj
	 EW1Il7imGafpldswkydOI87O+1zPnG+3fO0KUyaJQikSPt+L9r0tzM0yZyExgjcCFI8zI
	 9zKiGfW4mz3+svY/txL/N3H5n2q1LyYSIVPE+km0gDdjCDkOCyOc247/RlOAGs9yLsEYx
	 q51BYLrvgbKwvNTefbwqJM/BfUttFrC6MB7zU8ju8P47ebKlP/ZyOV8xk5TXxqdwO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FvO48vrH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b8Sv5Vjo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A3606A322
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 10:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D5A3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FvO48vrH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b8Sv5Vjo
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8hOWn3850772
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 10:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rAp/Ls1/54nALRkGPdoe71Dsv0aoi886pdt
	KQJOKrIA=; b=FvO48vrHs05wyahmPTnBZZjM8Fn2C+qz3XTVR2X9tJzJqbZePyS
	aaVDddS4Y3J0YgLsAyKOnUJk1BNGHN3TswDAm67XOPnflO3Y4Wx2rJ26oKz3uTtz
	u10SyYo5g2TO+ZYN+DIvg+idTAqQq1RPZh0AAj6qJxlYru9/h1417JUJRC5OAYBl
	xsj/9z14BQ6QehSpR9r0kduDCJvD1uY7AWL/wBqsNGBQZIEmfV7x5+L5UgixrHDW
	BV97N8qLPwICsIv8YaWxyE8sL3iUhRhASB2UWVTu14ZeptTwFYq6j6BptweH9rtH
	bLYhMvsxZ7TjpMx7sFSZS49BCAHIWOW53bw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb2b26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 10:54:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14373747468so4281758c88.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795517687; x=1796122487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rAp/Ls1/54nALRkGPdoe71Dsv0aoi886pdtKQJOKrIA=;
        b=b8Sv5Vjox07KvqDZt/H7sVzT6tlxc0vtI7B+CzV+EKtHuFjkR3fJ+e4kc75l7H2TrU
         z6nql0qLJk0eMoIYDqmaV+qxixqsTv5bFVDer2xG9JeOC/wyOCE0o7c45qMJjs9ss3Hu
         pAPXOg6VTwXgmRFQYWwCnDMthzw+wN+8/Go6il12H1mh6zL9jsbf4+BKIG2ch+RVY1XZ
         O6vLQYpXDwmYTRC77fQ4UYBOi88CKNuMQs5KH487jTQV5aNgy1qW/hY5gXCCIde04ioM
         s2MjQqPa87YR1SleSgYk2imsv/F9Y1ukoQgyVxOlAR7kTLdmxz64vKzAc/M6GPOQQbOe
         67SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517687; x=1796122487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rAp/Ls1/54nALRkGPdoe71Dsv0aoi886pdtKQJOKrIA=;
        b=NFTc/AgHG6R3Im5a3gn40GdQzNEtU3fjQSAK8cLV4MUxTo2S0rywVFIjP7CRPz6GVF
         htyPL2LV2LNGu1qL9SyUMso7hG4Lo/8WfXffd988aApzk2iknS23NPL9j6Rq9ySQuQks
         rN6Jbi2P8h0zeOgQr1EBD1Qpx2Woi+ipkqxbtuZpwafEyH0jHFudM5LQMWxfcDhlYHAe
         SQfw94YzWfd6zk6OFKTUOmrWOq5pGBy4jWQQePRZdc5TGmJUtOUfxiEBpuJZrowja1V0
         pBntt5ZPPG5XShedJ6cmREqmvGimOVZUnS7Z6q/2+cZGVvXilkbYcNbjkGMUhytxWban
         alTQ==
X-Forwarded-Encrypted: i=1; AL+hErF3wDHMDMNZDw6ToA/WVMDlrPVnWoxaxGYdTMFtq7TXD4wPXDfvIp10PGzAdmIkDJFuj+o3J3MqPejPd+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z93EcgzfJklRzLXDepaN6dl2Kjym8LQ01qaHcNLWyrG5SGFyzTC
	JyhKAFd5qEyAIsl7lud7RWzjojfgI80QIQLc38vM1VQxfQ50ioUv53hs39JwMqmDyt9Wo9amLWs
	H1NMWBxhOzkVpkWOvSueeolAOv4WhRU3Lzxvmt0MXYO+HJhvZaWezMuhFfJB4aPkrgyc=
X-Gm-Gg: AZFdTZc8GQ6CiFn/5tabyr42hAWiyTEVYMb0FikvngmcZT9bnT2k0LP5Rlsm+vxC27l
	R3v2jTgSTkll5Crj13g2finqW9aQMzT611z3cH9yMHgWuYeLwuMAgrrb8bhaDGXyp/MPDwYlMg1
	sGh+fNthOs0tQZXiMTXRBx30JjKB4N2Frq8/9tcZozlfv4vwKoLgvwO/2L9swVpGu9UZ5sHS5W8
	re1pnwmjfM5v0JWiv57XOl6gwr14dvSjd/pclc06TWKbbwb3K1h+Hmu3UGc6uYbmwf3FoirLgWE
	8XSmp9G9f1PGudLe3DqEgy8duUpNnatBEYo5tgQVGzR+tVjkL9Fh4DUhCsCK0s+bpu1GxWZLkxd
	iGQ1hNTLbbRav+934ESx9IshUEXVoW569UhdpAd4S3SXcSnYVOUgW0qgm0Y38duSFxISpHrlzbe
	sI7coM2dCn7H1d18JuwEY8UoNP73+nCC+Lumx8Hq68mUDmXlIpVpDTorU8
X-Received: by 2002:a05:7022:e981:b0:1b4:caae:3324 with SMTP id a92af1059eb24-1b5568ac1d5mr17920642c88.21.1795517687448;
        Tue, 24 Nov 2026 02:54:47 -0800 (PST)
X-Received: by 2002:a05:7022:e981:b0:1b4:caae:3324 with SMTP id a92af1059eb24-1b5568ac1d5mr17920609c88.21.1795517686848;
        Tue, 24 Nov 2026 02:54:46 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm38072085c88.6.2026.11.24.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:54:46 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Add compatible for Qualcomm Seca SoC
Date: Tue, 24 Nov 2026 16:24:36 +0530
Message-ID: <9ec98ffd6cec85ad77738128329ec77777a1f69d.1795517676.git.yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b056cf8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lHObh2IfMKzVuqTG74EA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: GyJz1tkwPNqToM9_ViV9cso2xeit09Yo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX9BgfNkwnYI+1
 8jhFy8JiAzMoTOb4B6RNby74g8aVTYHZxVo/4JWZzVr4Sa5wu/CPOt3MQ62K/KZmqHYzML38WeE
 xjqdqD26ivNqTZTzyCBnQeVy4IRVC1U=
X-Proofpoint-GUID: GyJz1tkwPNqToM9_ViV9cso2xeit09Yo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX+J4a6oy9WqKP
 kOXb7JpsiL2jROGmKNnEpicPYYwfV5tII6bWdopgTNQZO9QHdNW8DGzevQaHWKbODvpHyan/Zn6
 c7gaqajgkxaKDcwmJ3y56o8UskwXqdkcXEBePB9e1xKqEFNpGPu/q1vNSwc3o2zKYC7WO9njSFQ
 bIU+0bePJ6QaGHvFz9LnzIPYSNRhMfWZVeOJ91LpMnW5cuj+bIflLEHU7YCfTPcwVmCCzXPD/dr
 XO+8KnfD3BrFCadL+7CJ+ib0tBafsoO8Ie9sklBc1RAarIbaN6EjlSLco8FwOj9v3D6GxIz72ft
 q9ccIhUQBwJmTd7tIPZCHvgdrxTQm51oBXTreCuZyaeKs+f4vFPmfioyAJgRtHbglFj+c7l0QWm
 P7xcxfrmyP6AjEl1JsJwnMqvLi74gpSTX5fFiCW8qEwDvswAv/khP0UQjnWX6PvtuBsmIbGIyRt
 e5D+T6SaeCjnRPOnvTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240042

Document QUP GENI UART controller on Qualcomm Seca SoC which is
compatible with the SA8255P controller.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
The Seca SoC device tree using this compatible will be posted as a
separate series.

This series was prepared with help from an AI coding assistant
(Claude). It assisted with review on the device tree, bindings and
driver (formatting and alignment fixes), rewording commit messages,
and running the validation steps (checkpatch, dt_binding_check,
dtbs_check and W=1 builds). All changes were reviewed and tested on the
Seca Ride board.
---
 .../devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
index 8496f822dfa5..8415764222ac 100644
--- a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
@@ -24,6 +24,12 @@ properties:
       - items:
           - const: qcom,sa8797p-geni-debug-uart
           - const: qcom,sa8255p-geni-debug-uart
+      - items:
+          - const: qcom,secaau-geni-uart
+          - const: qcom,sa8255p-geni-uart
+      - items:
+          - const: qcom,secaau-geni-debug-uart
+          - const: qcom,sa8255p-geni-debug-uart
 
   reg:
     maxItems: 1

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

