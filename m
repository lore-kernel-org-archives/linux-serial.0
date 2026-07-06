Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84683EFFA4
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330685; cv=none; b=RPiey11PyRhW3Z42rgapLcobw0dJ3CCGj1NOIcCSm/dJEOQ9kYLoYfv6JmqGW1zb4UAozT1vtJM4CKIEG3JXutPvDzMD0uxWM4XlqOGmgep7H3wfExBPS7bAaA46FcZfaN+QHfaf8EdWqj+mKUyf8+iWo7U5oLGyn0jrmO1389U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330685; c=relaxed/simple;
	bh=L9x33N8kaAJ+pi/cD+0MZcVKOy3W4Tm3EptqZaAO8BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4dZzJTewy5EqGJ+C5LEZ75hXIvpZAw81i08kcj5n97rYOJj0f/lb9/TntOnTJaEQxFG+EuwHSq68Q+yt8yvWYcdMa1660X/NrWRaOzEJFEIEmZLpDbHu2KszbMu9IeDL8oU8eT6PTp5NhGP3JAwlMPWlWkXQnCQq0IGH7ZP0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TspKsaJT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dTFGN44b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TspKsaJT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTFGN44b"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669Ptds184204
	for <linux-serial@vger.kernel.org>; Mon, 6 Jul 2026 09:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zN9sl4KDiu18GnxHMI7eqmRrC2W1ejMrxfi
	QvPqQWWQ=; b=TspKsaJTnmxFlxXWeoNnxs5eDWOC8rotbU+YTUpDQfEWPWar5ls
	rL/hngVAe0xpPLfSjFjaITURYMiEFs8IWnOx/Igf9eUzWm9IFAbvvJoyIDHr2C7w
	5nKZULBjQulg0xjbSwKLRK1S/TfuNeOkYOH23lXNujkXI6miYcNeugjmMOXuzc8V
	9pzGt8GIKWptB0FPaBVzP8S/kW+qF08OcQaTIkRKrp2NVyDTBFOmn4v8a9u7zYLZ
	2xjNJIZWYcqvv+CfaF3FeWW0UPV0Z8MdAPEmQ1xRftJR7DhNxjHoM+wReZzPPAD2
	jbJGk8gzatGgP2PXROSA2F7xBXLju/JDWZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpg1kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 06 Jul 2026 09:37:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cacd6d37edso40765005ad.0
        for <linux-serial@vger.kernel.org>; Mon, 06 Jul 2026 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330678; x=1783935478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zN9sl4KDiu18GnxHMI7eqmRrC2W1ejMrxfiQvPqQWWQ=;
        b=dTFGN44bepNEVWYzTHGEKvFMQ0tTdZzSp/pizDKraY0Br9Xz4JTozbneqbm6gVILrw
         Jr/vCD5T8WyKxWbZ2Dt93EXysxSj5fk8D+W/2v+sKEnd8uHUIAqvU2zUxxMyxlTVZrXO
         SOUEohSQLu9g4B5nK+GvOBv6xmQKOtMAtyWh1sWOggM3jFfxsKfhNpy+Sv4X0RZ0dRlx
         Jveok0vbfgx8INr3+XGKfn/CU7T+E6r+gy8tvbZVfg1cclUhGuqDOi+kO3K7EcepiE/6
         XZTszHAxK6IoBHGLp1qLXSu9btS1+BY1Pl/4wlLNvXOgLJpN0alZHilqd6u47BaxUki0
         daVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330678; x=1783935478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN9sl4KDiu18GnxHMI7eqmRrC2W1ejMrxfiQvPqQWWQ=;
        b=YhBUqiJTMDPspIofyWaV3WzOgLaczAe99IyME9JVsv9exhLRaseqL72DYKvPuZ0gsN
         HEbgohNhfv4qA2s1zqcozltkTcqu2KwdWTOt3meB1jjUEjOOFFM+j6OHzqwcdgfgTFkU
         8fzHaJ83YO1ou22Pzw0K7XMcdpvZwh9IJRKYDlsfY4ZmwhXpKGQKHwyHUoqtUaarYtjl
         cJobRVH+yCJ2Rtb3v1V8b4kzyXzQnc+19UL3Vg+PSXEluBGF6xFM9PoOhhW8Mh0N+Hp8
         4gNoGpu6cjIZ+QJQm56zSJ90FEHsq1k/16VYWn0F8oChw7rGIQdqLRv3LCEMdayX+lPw
         RdFA==
X-Forwarded-Encrypted: i=1; AHgh+RqJ/BKSBn8Fp9Uwod2mMYNdMsf7H+a2ymn1mUwuQUIXHCwgKB4TUGb2l9vQIdpY42bDtamccIiR2+7TH1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+fZyzCT0J48wVcPzsGZQ2ZbizlTNAqvSxHkxI4YkP6YBwwpT
	qSxDJDuPHTB19uQKvD00msrkTU2S9AwvNrv13r3DdD7II19VfUwuRvuhiuXf/D0/OLqHZ2mkopX
	AzYbSEt2MxziONbHTb2CrZLoqL8+1ZXiuIlq+xQNr/OaCj38OZXs77BTNkG9zyRGWOAk=
X-Gm-Gg: AfdE7cltzirlgcJgaIZ/59TXcvIY8JV+eV6nHO7ml50bXYAjHmbC91l384WPYZI5wLQ
	cG+r4fRObUvEkDQMHQbWt/XFBOkXTOIJAsBiwv5ql3HFNPLaZ7y22SK1MUkzPXG4FGeyGndFmU1
	+E5jejhkLCMNanTyVi5df/TstHDCTOdXG5dU+5daNvKeq4Vm75gbeL7KxwV22VxkqbEysKMseHt
	a4zGxXsF96mhfrB57Z+6orfyTR7GyJ5siz9eTyuFlH4iDgXe2vmDrmBEM/uSir2ahDmUqspwi5V
	TCFOpzM33FahjGf0N2iGRxg8Jgnf0TeNWFqVolzUn4Cm780g8TW24K0rk03T2+CBvNPncC3FcW9
	76xadZOpH/Rs+WySyfgKq62PUAImH+3zlCim+Z4Cev8fvhQ==
X-Received: by 2002:a17:902:d508:b0:2ca:d151:3835 with SMTP id d9443c01a7336-2cbb9ea61c9mr99023755ad.27.1783330678128;
        Mon, 06 Jul 2026 02:37:58 -0700 (PDT)
X-Received: by 2002:a17:902:d508:b0:2ca:d151:3835 with SMTP id d9443c01a7336-2cbb9ea61c9mr99023495ad.27.1783330677651;
        Mon, 06 Jul 2026 02:37:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260c7sm47333775ad.12.2026.07.06.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:37:57 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: praveen.talari@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        viken.dadhaniya@oss.qualcomm.com, quic_zongjian@quicinc.com,
        krzk@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH V1] serial: qcom_geni: Disable closing_wait for console to prevent shutdown timeout
Date: Mon,  6 Jul 2026 15:07:49 +0530
Message-Id: <20260706093749.836121-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4b7777 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=NsA6dLvGf97xVj5pE-8A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: SbHiErbq1kpksg7TWzBeeYH996cFXe1O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX/5ptcfqmS0iv
 fe8HjANh8ngirW9wSoolS0+Q3xJkWE43Esq7wOLJMETauE1vXYulbZ1x9/4agfxlpe+MJc2unxQ
 qQrv6NohCylX4wAGxhTdW2+Ed+O4x50M/mJ07gBIYu6e0yQ18ITi92w59JjF8iIk2zZ3D5UnuZ0
 MtrhiGQYGDzn3YD9jOI+X6IRQW7XCpDHfq2l/2fJBCw3obW27HvPbOcMojA6z6ntnMhQsDlGftw
 +3fQ85phkxw2d19bRDHFtnEjJS+O7V2nDS6sQp5c8dxNSL3N6pnY1Jv1jp50rUDtZ4dJIMqiWBC
 qj63UZDUV16q0pEETj9CSlF+Ipr8qi3vXM9g5VL++mTseIJmZzrJXbLgI3tDJRgeGvolPFnbWhP
 2vo1oCIYPVZKI9qmaO3CAF8YMMk8QERjIfk2wMUVLKIdamvqHMpmtNifk2Ax0flJM3wkVqYwK6R
 nG9p3gbVu+EGAeuw+Vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX5Q/4Q5JD0T/l
 HmBz/zXBTCQ7cJ8Owm7XqgZWkDcw5y3t5v0M7PZY4aBRAC4v9UNFfxHnKCJSTYx6mbwxyeLRsi+
 460j7gXtLTvBG0Okt4tLIGIP6f3iNmQ=
X-Proofpoint-GUID: SbHiErbq1kpksg7TWzBeeYH996cFXe1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060097

During system power-off, systemd closes the console UART and blocks in
tty_wait_until_sent() waiting for pending TX completion before
uart_shutdown() can cancel pending TX operations. With the default
closing_wait of 30s, this causes a watchdog reset when systemd is
responsible for watchdog feeding.

Set closing_wait to ASYNC_CLOSING_WAIT_NONE in startup() for console
ports to bypass tty_wait_until_sent() on close, allowing uart_shutdown()
to cancel TX commands cleanly. This change doesn't impact regular ports
functionality.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..3d3bed0923eb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1245,6 +1245,7 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
+	struct tty_port *tport = &uport->state->port;
 
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
@@ -1252,6 +1253,13 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 			return ret;
 	}
 
+	/*
+	 * Skip the close-time transmit drain for console ports so that
+	 * shutdown can proceed without waiting for pending TX completion.
+	 */
+	if (uart_console(uport))
+		tport->closing_wait = ASYNC_CLOSING_WAIT_NONE;
+
 	uart_port_lock_irq(uport);
 	qcom_geni_serial_start_rx(uport);
 	uart_port_unlock_irq(uport);
-- 
2.34.1

