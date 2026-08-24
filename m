Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B04078C0
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568329; cv=none; b=hVPYVY1Kj3ODLYxOnp5YsJ2nqOV3M5lhsPIdL9W1mYRR/mpa71++vS/W1q+I1MhHV2ma7Eg2+ScMyf2wOauHTRXX91QLnfCVa9t3XDhBE4TOhpAvyOvseS/MXko0lcQoKU1cYcpfUJkN3gzs/c4mSx94zcd5tdGoho79T9cp6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568329; c=relaxed/simple;
	bh=fvLJEoTbG7x7YjEzxCfSesZ/Qr9wwF7rbtjWeVqSHYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CbJD8fmGSrW2euXWIZDu3+HaTRNcF6SEa+2v2VnRTjH3DJtQXasD7HdTDT+FjWexziur5DCAOCX4kJ00lm6sTzof4VAGSWDPlFQqUiFUOcMHwQ64tot/09KiqFs/tYQQGexmBOAw7pApH+MN7Feg+Vy1N5cmTq3eXIafi7fbupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+6kORRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvuRXIgf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+6kORRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvuRXIgf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9978C1378533
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 10:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+LIBYtIL0v8CM9/T+oWSwU
	EA64rVmEdJGaHGlR+XkR0=; b=K+6kORRUZFoLc2OhB0ZzgaV8qWxMuUbj0koF7h
	iasnGY4Yhtyh/3zOqlsqn13PR96TvGezGxhdwSM9zSG2mmKIRBT1hGssfPqwbspw
	N5V4271BLGGm3G8C8Qh55PC1EWPwolEZiF6lvAcJW/+7MYW7MEQT+pFJZ4EonOVK
	AUvZpRlpMI2IghSPtRrIOT01eQ21FhoRF+EtCJzh0XsWaR5v3xPxWFqe3vgc6Iyo
	Q4xxup6VLgLjKfim0eY0EmVBFDSrZfGqQx69vJsUI91O79tgvSjddD0JzFE9GJ11
	TIHN6RZQXpvUGxP9rR46qNVqs1622iN9pxv9DtiT3dB8vyog==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf0t52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 10:45:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so4340294b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 03:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787568321; x=1788173121; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+LIBYtIL0v8CM9/T+oWSwUEA64rVmEdJGaHGlR+XkR0=;
        b=SvuRXIgf6KYcyza7kuyrwSQ3e8y6p9z7AYDeb4lC/7Ryl18c0t8NTqeX0Jlbq/ebFS
         ch48WX/RCdok+tPKpBGm6bUmqL3FjzRDxUgHqXgm2jnncG+zPtF3lhCNw5eAH0zCQMPx
         M33xvIpuiijEsvJQwZP/g1SRtFF80jxLO1Qbnwj1qwsZ44sXOIASXd77ke99v3KjLMOg
         6kefsRciUv+FyT6VMWvTKw+/vbpUfhjCVd3cVzXE+y99CVaVt7gNbvX+J9qDaYlt76kR
         JSodQRjCzo4pcL0PgZBc2fNN46FVaLfzLSdCdmOdjniHM0F0ygEijzm4qJ889opiDnEE
         lnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568321; x=1788173121;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+LIBYtIL0v8CM9/T+oWSwUEA64rVmEdJGaHGlR+XkR0=;
        b=Rlcgpvtem67MTjGidElpoO/PdYX3dEbGyHiMJhq6IXm5EqJ7bltApntpdf3o0w5c87
         XfSMJ0KqUPoGD2RKGqAv6aLn/+jgeHx4n+l0V/4yWiOSH6XMzDC6wMBaMmiLm46V4jpk
         jvQ6iWo0dYq0ZxVzZcjRcqdcpgTxvifvLsXLZSdiq1SdAG94a0FioIowvvpxxJBsFlbe
         KH6P91dIZCD22C5PGFR5EpfGs/iWLglYypsVfx71RpEwQ98yriZ6/IhFOa0L0IWbw5P0
         /Ta8IdOwj9DuNBG9vETng58QxxKJmp9+FIyXGVmaO+lB0LfoAibVaP4ognWuqEEDYqP/
         5q5w==
X-Forwarded-Encrypted: i=1; AHgh+RqTFViWYGG65nxnBw4F3L39cmN51C0US+CeTAsKTVw/132my1BQc5iUnSajdcXg/wefPCicEqW1AK6kWQs=@vger.kernel.org
X-Gm-Message-State: AFuF++kXtRiNqpfYprT1fTo4x4gG5+U+KgSirRejrLGU22O5h+YfLlys
	baC26OAKynZJ+oB0qeCgNVwV56rgQ4h95+bME9ty/Z0eQYWY06CFXqwsu+hwaAVqi1XIS+pePP6
	0KZdEg9aSdEuOhzY7NUUyMJCoOLDfNZQ9TxTFJOeeQUc4TaBEFKT5ODF+1I6m/fuSZ3w=
X-Gm-Gg: AR+sD13YSG9n0jDrfJm//kMPZBqH6bZd1T1kSyV6+Rw79lmh0JsEEex/D1nryo2ZkBI
	tVgktr8ykR5xl7K4nSb0OOs167rBTeZnNQBgG6aBH/zVQS9UKmSUMNjJYbt+VUNoVuSMPceWHR3
	YPpdFDe6U1afyNaaB3ZUedDJJouaYv/bqDVA+2p2gGhmJj9bj76eED4s2nviAggRM984QuxYIo8
	SSh18Ii0V1kQ4jv08nsTx7Ka8YAOiNNEW37Ixa73y+6Gm7QAAcqIyKR2akIs5DLuHZmE54x+NRV
	gEvtOTiOOjkQmOnjxbzJ0oZ3NZx78XP3JeFI0/+8ChH30FywlMTTIbxeOnqzBW6uIWn6bCqeyC5
	OnJT/gVOXzCOPZnRyM5Z+j0WIBL77QCxa8A==
X-Received: by 2002:a05:6a00:bd03:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8520ba55d99mr27055416b3a.14.1787568321138;
        Mon, 24 Aug 2026 03:45:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd03:b0:845:cf73:c1d8 with SMTP id d2e1a72fcca58-8520ba55d99mr27055338b3a.14.1787568320609;
        Mon, 24 Aug 2026 03:45:20 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f1638aesm1779459b3a.57.2026.08.24.03.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:45:20 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:15:14 +0530
Subject: [PATCH] serial: qcom-geni: Drop unsafe rx_buf realloc from
 setup_fifos()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALkgjGoC/yXNTQrCMBBA4auUWTsQg0rxKuIiPzMaqUmYaUqh9
 O5GXX6b9zZQkkQK12EDoSVpKrnjeBggPF1+EKbYDdbYixmtxSilYsvqmFBW9I1RyE1TCchS3qg
 0t4qcuChaP1ryJvhzPEEvViFO6+92u/+tzb8ozN8F7PsHmN9vlY8AAAA=
X-Change-ID: 20260822-drop-unsafe-rx-buf-realloc-from-setup-fifos-2b82eb0cb5d4
To: konrad.dybcio@oss.qualcomm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Praveen Talari <ptalari@qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787568317; l=2427;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fvLJEoTbG7x7YjEzxCfSesZ/Qr9wwF7rbtjWeVqSHYU=;
 b=5XZD6uUJOIi3z1M8HI842tmUvtNy4D+t2KQqUFSzPdF9Fkyv27L9pSBaoWU+tv15qij473Lm3
 nEIaAw39qjwAp7wnhcboynvBUetj7nF9bNzBWuXounf8hMj2ZBJlUNc
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4OSBTYWx0ZWRfX7BRQsz82gTDC
 YhmbmekiPHtEuLC2Lbn5QmsqGq4enDlk7vKkRgnU1RPgzAA+eJ/gY70ICl9WupKvm398YHdZBE8
 vUSUt+0Nh/d0sq6PRACFv8mTHff/I78=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c20c7 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rO80i1saf4kzB67oEq4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Jaiq-4x7HwWXZQLb4AJpD01zMb4QysGk
X-Proofpoint-GUID: Jaiq-4x7HwWXZQLb4AJpD01zMb4QysGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4OSBTYWx0ZWRfX9bu7mIgTG4Lq
 9ti8zZ/1Cmjf9CWgUqg0++Kyh+ODOp74N1tagXpkU8sB82PRYtZ05vRXhNE924Zcqjd31Slrwe4
 F7NAVQulUkIAFWhF/NVvUdTIdbluzrxbP9izXNjPOYlmgu1IZbIN9aeOtntDt4yJV3hdgowLY3t
 eVw2Bo+s+C18to4lc0+uQjE/g65Hp6mPz0kESTh7XjWrTMg0xpHNywwxF8Ax9FDFWFrwiHTVqaH
 AZ5q7EQKcaPzGOA/ulcqM6CxGsc8a01fMOiaN0GMTJ3Zs7ZL6EOs4EuYTRm2ps4CupanaqhObJY
 OpVxIX+WcVUaHZVhjWOY24YbWm548rmGOyXF9zXp9IZgbOVfA9M0Vg6bqvMifVQt2AaPYqyB78L
 PF5NSBF13dJfXxUDI0VY187+BgcI4RKp+nrmjydvnYoqmzjDUD5XFj80WZoGovjevZgOoX0FUwq
 VrIHfJxdeBkH0SxnT/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240089

The RX buffer is allocated once during probe using a fixed DMA_RX_BUF_SIZE
and is DMA-mapped for the lifetime of the port. However, setup_fifos()
attempts to reallocate rx_buf whenever the reported RX FIFO depth changes.
Since the DMA mapping is not re-established after reallocation, the buffer
pointer may change while the DMA engine continues using the stale DMA
address. This can result in RX DMA targeting memory that no longer
corresponds to the active buffer, leading to invalid DMA accesses and
potential memory corruption.

The RX FIFO depth is unrelated to the size of rx_buf. The buffer is
allocated independently using DMA_RX_BUF_SIZE and all RX DMA paths consume
it at that fixed size. As such, resizing the buffer based on FIFO depth
changes provides no functional benefit.

Signed-off-by: Praveen Talari <ptalari@qualcomm.com>
---
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..75b2e0b77d05 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1291,7 +1291,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 static int setup_fifos(struct qcom_geni_serial_port *port)
 {
 	struct uart_port *uport;
-	u32 old_rx_fifo_depth = port->rx_fifo_depth;
 
 	uport = &port->uport;
 	port->tx_fifo_depth = geni_se_get_tx_fifo_depth(&port->se);
@@ -1300,19 +1299,6 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 	uport->fifosize =
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 
-	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
-		/*
-		 * Use krealloc rather than krealloc_array because rx_buf is
-		 * accessed as 1 byte entries as well as 4 byte entries so it's
-		 * not necessarily an array.
-		 */
-		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
-					     port->rx_fifo_depth * sizeof(u32),
-					     GFP_KERNEL);
-		if (!port->rx_buf)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 

---
base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
change-id: 20260822-drop-unsafe-rx-buf-realloc-from-setup-fifos-2b82eb0cb5d4

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

