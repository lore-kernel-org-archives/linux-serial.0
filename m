Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6F1DE3C7
	for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102599; cv=none; b=oLrIiTPqssm62vyRH+QBZfnW9gEtvn2GUANZAJjSofeajmF2R5lA4eXg2/KjfMV64dRnj+DWDSDIslj36Ehbya+EmbLhZWhPPKs/LksRdpiI7uuV87dWodMBivrh35ljiOeFrzY5T/S2QCpvAWcC3itpCerWeippGa0MW5b4tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102599; c=relaxed/simple;
	bh=nJlWE7TMkJF+qGX9RK5h0Ifycl6qj/LOobvEdjZQzrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TqX9c2t1yAk2a9dCrsg3jioBD1QgHoeQlWsvrqqMlSp0lya7NEAJFpoBuYYTAIBMJdNrfnKgJOmCeJ24qfXu1q+TbbaCpbx06Ex6k+QzvNjOFbD051SyDats3fwR1KRAxh0vhipgWBI+w1y5U+ddbvEFZK2hBVPaF7ZJCiLkDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=xbdICgzP; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="xbdICgzP"
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 59M39rxR084312
	for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 11:09:53 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 59M38ktb078051;
	Wed, 22 Oct 2025 11:08:46 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (zeshmbx09.spreadtrum.com [10.29.3.107])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4crvFD4wVqz2NG5xV;
	Wed, 22 Oct 2025 11:06:08 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 zeshmbx09.spreadtrum.com (10.29.3.107) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 22 Oct 2025 11:08:44 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhaochen
 Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: [PATCH] serial: sprd: Return -EPROBE_DEFER when uart clock is not ready
Date: Wed, 22 Oct 2025 11:08:40 +0800
Message-ID: <20251022030840.956589-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 zeshmbx09.spreadtrum.com (10.29.3.107)
X-MAIL:SHSQR01.spreadtrum.com 59M38ktb078051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1761102535;
	bh=3QHy8p1fdhdVE9oNK7Yv7NVBgLHQMmSDxFOKxwgs8AQ=;
	h=From:To:CC:Subject:Date;
	b=xbdICgzPDv9fXYSmY52e8JwI6Zx490rRJS/mcItAknQrzBIljr6JI1HQAlhi0wK3j
	 bRbcvp+4wHc0m8+vLZ4rJKpVeh7gMlmJ5YiKcV3SQzha3im3cK2ZPpQbjwop84spoe
	 Ari7gJgrXvkozeTWOH6jgT28+M2j0yEmjTEXcdbT5pU6c1hr8f8vuvy6gOMVh2lvWa
	 DBteDF6cfkE09COAaXL2psCD0azZEiEgWNRvSn1tMd2Bgi1LkxTh/sr0YIPTnOFmYo
	 TEqCDsrD47aZ6kuBMepceoPnquFW0PCviNfVNb9N8KqUpEUCsHWWi9ZpRuzRl0f+nI
	 iGRhDXxgcev7A==

In sprd_clk_init(), when devm_clk_get() returns -EPROBE_DEFER
for either uart or source clock, we should propagate the
error instead of just warning and continuing with NULL clocks.

Currently the driver only emits a warning when clock acquisition
fails and proceeds with NULL clock pointers. This can lead to
issues later when the clocks are actually needed. More importantly,
when the clock provider is not ready yet and returns -EPROBE_DEFER,
we should return this error to allow deferred probing.

This change adds explicit checks for -EPROBE_DEFER after both:
1. devm_clk_get(uport->dev, uart)
2. devm_clk_get(uport->dev, source)

When -EPROBE_DEFER is encountered, the function now returns
-EPROBE_DEFER to let the driver framework retry probing
later when the clock dependencies are resolved.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 8c9366321f8e..092755f35683 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1133,6 +1133,9 @@ static int sprd_clk_init(struct uart_port *uport)
 
 	clk_uart = devm_clk_get(uport->dev, "uart");
 	if (IS_ERR(clk_uart)) {
+		if (PTR_ERR(clk_uart) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		dev_warn(uport->dev, "uart%d can't get uart clock\n",
 			 uport->line);
 		clk_uart = NULL;
@@ -1140,6 +1143,9 @@ static int sprd_clk_init(struct uart_port *uport)
 
 	clk_parent = devm_clk_get(uport->dev, "source");
 	if (IS_ERR(clk_parent)) {
+		if (PTR_ERR(clk_parent) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		dev_warn(uport->dev, "uart%d can't get source clock\n",
 			 uport->line);
 		clk_parent = NULL;
-- 
2.34.1

