Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DB31985C
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144273; cv=none; b=A3dPsrYBgHONOxRWpjFC31TAfQVyznUTric1QWnp9gSZTq7AIkN8ZL+YyjaTuhqWNdCUGS35I7awU7vrh/9rr2V66SHcy2coPrxWNOSHhcRF0f9E5qmqydsYc7Pqx/KBO4yJ+mNuZrr5x7/p3HqMKsO562txlwtZXgll8e/xrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144273; c=relaxed/simple;
	bh=SBnRSODcu+BEcMd+HCD9hRp9IxuD24gRkwX5OrkVLig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1BFa7awpFhWvmo5jQxN6fDjOqqRANKJSoQez4B/6fAv4BaQIvv6nZVQ+lcuN4V4olR0GQwHPGQRhZdlyQaL2P5i8n4tF1KpN4LdXmWX0C+08bQn8R7lVRiofxMjePlea5qgtet5ElyM+orMSD1zn2TCLKJBxk6M20ul2OKK2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1E0BnoB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YE+48cqx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1E0BnoB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YE+48cqx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JClSR21374285
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 12:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHX
	Xsr1YvVo=; b=p1E0BnoBweztQLgbQj5cofd7eEa+YXb6eLSpht8aErTrLdIo5VN
	U4Uw/dbPxR7mPu2g+LRzwML06Xat+GU9tJMq663X2q9h1AjRXy1d1UbQTAAkqTFv
	EOS5c3HoZ5X+tJg0UqNJ/iMlES1G+/C/3Av8gMyirUoj2UytI/EqBJNbmmouCvC7
	DhFrKqKGw3bIz5GgLyBYEMSsDH2dtDsZvdV+e2412G759LrLfSgIWkO+4Rt4KyOH
	TmL0TZDKjp4Mel9HbbySFGwsZtBhH/5XXunZ28w1YSaR559O7Yr1yqSRLCcjBkbl
	BidHADccYJf4BI2iLbdzZYmPxGi9LnI0mCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm395b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 12:57:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so98328285a.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787144270; x=1787749070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHXXsr1YvVo=;
        b=YE+48cqxleTuWfiLwLvS4RSr5dMGilPoRt9f1oL5t/TQ8Lu3DunG2NxOHUHa/Cs86l
         MLNUXyY+YGLo7dV9xcziwQvGn9v1dlHmx+jFKoN7PKMiPGrJYRvzdrgz4XNP5+uoabHy
         himSCUZzkgJdAH5FZMKqDB2y3mAzEOg+B5jlnixVSVrdNaYbjp6rj1pwOs0HspUyb//P
         A1TIfI0E4zAeTIfOiPmIxSJbuXn4OYkzK1WDDJLd5BFZksGEJwPnfYfgZSRDJWt5qJPI
         XaYseLmMVuoqpgPA+cMnq0fnnLsxcO/RWL/ovEFZ0S45h94DNiStqF2IIAEHUnX1qh2e
         9A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144270; x=1787749070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJR4NmkM02I7TCKsHwKAlsIMTf+H3Xz7PHXXsr1YvVo=;
        b=hsl8m84crpa51nQoFjXXiWBbpnCJ2uc4i9mvvSoI2/FRiGXXTm1Okt7olbtWYY35iK
         vb3YxlhICDZ/HbXzVHcfkokwcbAKa0zTTJKr32IvpCq+0Msj3S5bMT8Pgayzh3fzx6uF
         jbFuirV3NUCT5kj+Cou/zrjAt9s7powxuSk4f0Z3lZ+kUwHlNBM3UHmOdKXrnP0uoLZk
         9ipjJUae0Zo1aAL5YEmXV/XTysZvXiDAGFzO2tvCS+ntvyby9pqyPbD+UWGXejSFJ0rD
         /hF9dHu6PlJuDY9j8toqBlyLsu4uhHb7mTuf5WigdRCIv8/GQzoHuHN9DNZVHyeni0uB
         LomA==
X-Forwarded-Encrypted: i=1; AHgh+RqwcDHVPxCgFhQgCYruqsrXwdWPWAWfUvTlVwhn7qxRSVnEPrZ7k+tgId0j1Xo5e6LQ0OlYZDz0HyEqDcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nd9vfw5tX1dzQl13YQfMY5nib52tYpxdG/sKreP9hVk9Qzdt
	/fWYWc9QJnT8jeNu4RKGrnc5FZNVicSrmTOCs4RvYvihlreiXRsGoFgJi7l24NYiPZClIQA41zO
	SW8Ifu0Fkul7kSJTfvr+89YVHeTxYAwW28sKS+2kp/pedz/JDoQ8y0pih/GLhMtxBxsg=
X-Gm-Gg: AR+sD12Iq0Wyf2sIf9kvQTpd83dtsquTJmVMAveGu8pwh03TNPHycRBrz4kSVdA6T7k
	vu4r02cK750TLpKtFEi766XPpJYw0hVvmiD9i4PDV7lXM6xDQ1ooiqwJ6+bBWdK1pM9RIlVZLIK
	7SZgtrudqFiBTaFgTZWul8ZX8NfyOZ+zbq2uREn+Ol6vomTbgkTri+GEvZQtp5sKLSR8VbX7XWt
	Gm1wZ1w0k4nmC/jreCe03c6sgXHvoXxPudlVjukdGhiq1EifDB+Ntl9swRjS30tqpGEf2/e6RCC
	kf+aQW4A9vOzVFeVhYK3okxnT0Drzlrs4m9+o4OY4SbTqsJifihSfkib/5o0hS5FAvaHRznOUXI
	TFXEhGDaR6Tg9YbzCEW9rWJofWLxvCZSjrjh/d+O0IxrA2m7W72wM27TASe10uDJF8x09LU3nUR
	6lotsH9usUNnM2XFQ=
X-Received: by 2002:a05:620a:4613:b0:932:db03:4da3 with SMTP id af79cd13be357-9371e7046c1mr323571785a.19.1787144270384;
        Wed, 19 Aug 2026 05:57:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:932:db03:4da3 with SMTP id af79cd13be357-9371e7046c1mr323568685a.19.1787144269924;
        Wed, 19 Aug 2026 05:57:49 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c38c5dcsm68931666b.44.2026.08.19.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:57:49 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] serdev: ttyport: Clear serport->tty after freeing
Date: Wed, 19 Aug 2026 14:57:48 +0200
Message-ID: <20260819125748.194377-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX5qt23nrO09Wp
 pPmLD/Z+5R3obxLxZIcDGP1eJ7fWogazDbZYageFHPo/ME3Jb/ewKbOsmjYRpzDrQfOONWFD0S/
 BxKUX8MtLvudFxPBlgwlp7iuBaiFve8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX+Qn5k3+8tEvf
 yN10iAQ43L08UTlSOsttSLlgSsp2KBu7wf4j9Vs3unQ35Vvzuem5Bqxa5+HJQz5qXR4+5kWN6lX
 yc2J1SCkLgfSkrDv9RW08sAA7fi27kQxWnbKFust/KfVOkxCBSZZBDi9bN4xEF50vF+UPoxN5f5
 fj3DhrlTJSfkFqB2fgG6/8/cHZhMWC8JIgYKkt9Cc4kOD0pgYd75lstSF11Ctd0luvf6EyDYsx9
 qQsLxBVWivMV3E/Hr6ISumFAE9+DKISiQ/Vj4/xcNNbK6kYOPyPyW8sLXIVfO3RQ2donHkBTkWT
 hfEhID1Z0g3gvfs0hdNmyu5nv5pfWmjqkYc9TPR2bUxd/Yg4Es8yEkEnAM6qO9uk5M0duImiNqj
 lDXKhm3KHFCw8TWq4gzVY9aY9z+UzFFbvIXD8NgBs6SK/GWIn3O6NRm02NAyzYpWFB853X+oW5G
 D0hawY3B/WZ+Ilwvi1g==
X-Proofpoint-ORIG-GUID: ZCyTJaeJ5ZxuHgXkPpr6Unv5hdHxj7b_
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a85a84f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=c0e1n4jylXfP7e-yc8IA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ZCyTJaeJ5ZxuHgXkPpr6Unv5hdHxj7b_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

Both error paths in ttyport_open(), and ttyport_close(), release the tty
with tty_release_struct() and leave serport->tty pointing at freed memory.

The serdev core itself never dereferences it afterwards. However, a buggy
driver could easily trigger a use-after-free by calling a ttyport operation
on a port that is not open, or by calling close() twice. While those
drivers should be fixed, clearing the pointer, makes them fail
deterministically instead of touching freed memory.

Note that a driver which currently double closes gets away with it only by
chance, depending on whether the freed tty has been reused. After this
change such a driver oopses immediately instead, which is the intended
outcome, but it may surface latent bugs elsewhere.

Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bab1b143b8a6..b6638f9f40d2 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -137,6 +137,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 err_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
+	serport->tty = NULL;
 
 	return ret;
 }
@@ -154,6 +155,7 @@ static void ttyport_close(struct serdev_controller *ctrl)
 	tty_unlock(tty);
 
 	tty_release_struct(tty, serport->tty_idx);
+	serport->tty = NULL;
 }
 
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
-- 
2.55.0

