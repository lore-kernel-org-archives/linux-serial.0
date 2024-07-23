Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B50137C35;
	Tue, 23 Jul 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744983; cv=none; b=Yqh/t3UdegaJ8S66By+hmmlosQDiq4uYbNr5rbm8XxWaVsdd0ZICc0RQkJx7w+ex03PSI6ST0ddB+9YMfPQNA6oY3pTPOuvUkGcyVRt2U1UJPrwdBMmHtNJRSo/g7z2zb3h1rseZvXVGLv91EqjvkyqMaUCB9DSjSzXLrhquMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744983; c=relaxed/simple;
	bh=Df5T8ekYlYlhVAs7eoHWEs5BY4/XAo2OkbzF/0m4JcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjh2RgKPoGvpfpJmdDtM98zxbRJpDJ1In2FsuHp0betlBr8AgrK5gcLbBiGq31cOXNpCMs9RcBEgHz2QoIyg6y7xJSCnvo6jid/862QLTZboror+fh4XxYkTA+EFwlSztskXbdlrhqNspQ9JQ90EfmYzBf3FmxtStdsvWVIEUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NlXQ6s9j; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NlXQ6s9j"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N4q37n006527;
	Tue, 23 Jul 2024 09:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=4up/RiundZ3XTKcm
	R14Em4WUczTg1vdCrb4iDskupjY=; b=NlXQ6s9jZioibdi42M7mb+TokvfMhiFo
	F7IEfM6Ql8X0HG2MxhvKYroKvsWsNXFOdNb8zP6ju40SwsDtVZoL8OTa9FXDAcvz
	9s9gydAeGRmhZT+ylyBekI58qPVCZnEaEMATPGRYsZI8sDwoYyKDj+uEnpKecAKg
	l1jMco8gWVdEZo7POeSysvfEEkMU6aOFd1R2llVHzWD6BP6DNCqteCl7wrEM+qXs
	HJdxFQWE5divI7/YBVJ845oiJf/HnD2KoC1zJN1FX+9zljs3zZVGmgXSD4HDGPZn
	0onO6GWB1z1V8HlEsTOEb5dQucrkuhxBXXIKy4ag76+Fz4OkBtVVgw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40gamx3dt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:29:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 15:29:18 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 23 Jul 2024 15:29:18 +0100
Received: from ausswws10.ad.cirrus.com (ausswws10.ad.cirrus.com [141.131.147.77])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 09993820244;
	Tue, 23 Jul 2024 14:29:16 +0000 (UTC)
From: James Minor <jminor1@opensource.cirrus.com>
To: <shubhrajyoti.datta@amd.com>, <gregkh@linuxfoundation.org>
CC: <patches@opensource.cirrus.com>, <jirislaby@kernel.org>,
        <michal.simek@amd.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "James Minor" <jminor1@opensource.cirrus.com>
Subject: [RFC PATCH] tty: xilinx_uartps: Fix break detection
Date: Tue, 23 Jul 2024 14:28:58 +0000
Message-ID: <20240723142858.2905083-1-jminor1@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: k74a1duqDx8rTF8RE0pa5-7_2Pcn2Yfl
X-Proofpoint-ORIG-GUID: k74a1duqDx8rTF8RE0pa5-7_2Pcn2Yfl
X-Proofpoint-Spam-Reason: safe

Commit b8a6c3b3d465 ("tty: xilinx_uartps: Fix the ignore_status")
used read_status_mask to mask the isrstatus, even though the
commit appears to be fixing the application of the
ignore_status_mask.  This has a side effect of clearing any
pending CDNS_UART_IXR_FRAMING bit, which in turn means that
cdns_uart_handle_rx break detection will only process framing
errors when parity is enabled (INPCK set via
cdns_uart_set_termios).

Fix this by removing the extra isrstatus masking with
read_status_mask, which still allows the ignore_status_mask to be
applied.

Fixes: b8a6c3b3d465 ("tty: xilinx_uartps: Fix the ignore_status")
Signed-off-by: James Minor <jminor1@opensource.cirrus.com>
---

The other alternative to this would be a straight revert of
b8a6c3b3d465, since read_status_mask and ignore_status_mask are
both applied in cnds_uart_handle_rx anyway.  Let me know the
preference here and I will change accordingly.

 drivers/tty/serial/xilinx_uartps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2acfcea403ce..e9165ae3c2e8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -485,7 +485,6 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
 
-	isrstatus &= port->read_status_mask;
 	isrstatus &= ~port->ignore_status_mask;
 	/*
 	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
-- 
2.34.1

