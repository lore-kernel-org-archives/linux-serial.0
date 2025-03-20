Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2671E47CC;
	Thu, 20 Mar 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484597; cv=none; b=QL0fOWIXyrIipFYWTL/FO7WSSER0JwsEyK2IfzMvmOEddG/xzt6Mr3EIxejb2hYv0fFV1pwKMkBMLv+UTbPF+I3lBYqxKSXh+8ItKTyTx1IObIvZXsqXiIu+FvembzuBOpcZG/d94MV0I2W4YRVY2gb8jLI5ikS85e7DrA6+uuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484597; c=relaxed/simple;
	bh=nhlsebc47vjyAXYRWdQscnBm/MLer3fNbBO3/NN6CEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l50ecAATCXCgvnqmJX26P1RQCQJe+xk9KL2VDNGjI2l+a0XvSw+Dk023CHuHCozK6Z/KbuOf27abzBlYIJSBFKKxdnA6820bIDLkCXc4rtsOWGlxj/jCnfczrt8QfWqLGSpoJyvX216GLKI+DGp4vfvciJ2/0SITG9ie1wu3iTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qBSWxkQR; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qBSWxkQR"
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEDdFE025715;
	Thu, 20 Mar 2025 16:29:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=N9t+AghIDu3YhdnKtuwb/m
	1eiGg+UJ8M9f9LIHIvdYg=; b=qBSWxkQRxYg0v28ApSjg+eMdESIOTCLCqgoPg/
	qUxjEA2xY9jPtKUpF7CM4yJSbxjyzDAA0/2Rl4nAeGVsi+kzLGmm3z/FVL7/IwjJ
	8Yq5I00kcf2c5xGxSQsgYl/x8Gg6CucpPi/JkcJTqoKbGLPNN+1VqVyrZObBTOuA
	+usEAhCY5yHqt0lK9aOaRLom94NLoszPhzXKhXtuaPGIA3FpiNW/MPNSlX2ldT6c
	Rrd504BJ1vkTY53rsxrP5LkXtHMqswFJa6SdS75fCKckTTn2DJ1pQsvTcxpGPo+Q
	DZm++goN/JSoTdj86vHuJ0NsgzFbw/JrBJB6xKy47sFaAVlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45fuc8pg4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:29:30 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AE1F3400A7;
	Thu, 20 Mar 2025 16:28:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3FCDD8140B1;
	Thu, 20 Mar 2025 16:26:11 +0100 (CET)
Received: from localhost (10.48.81.58) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 16:26:10 +0100
From: Cheick Traore <cheick.traore@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Marek Vasut <marex@denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] serial: stm32: do not deassert RS485 RTS GPIO prematurely
Date: Thu, 20 Mar 2025 16:25:40 +0100
Message-ID: <20250320152540.709091-1-cheick.traore@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01

If stm32_usart_start_tx is called with an empty xmit buffer, RTS GPIO
could be deasserted prematurely, as bytes in TX FIFO are still
transmitting.
So this patch remove rts disable when xmit buffer is empty.

Fixes: d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
---
 drivers/tty/serial/stm32-usart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4c97965ec43b..ad06b760cfca 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -965,10 +965,8 @@ static void stm32_usart_start_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 
-	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char) {
-		stm32_usart_rs485_rts_disable(port);
+	if (kfifo_is_empty(&tport->xmit_fifo) && !port->x_char)
 		return;
-	}
 
 	stm32_usart_rs485_rts_enable(port);
 
-- 
2.34.1

