Received: from mx06lb.world4you.com (mx06lb.world4you.com [81.19.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F293002DC
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916100; cv=none; b=BXyS/GprWU6srPERp+nULXkddh2S5eI6DoWQBLRLy+TCa90SCbVpK8dxHIPSQto2fNhld9GrBprGYoSHKT5VOR8Yi3KYIS1DyL4O/J99GPRc9P6Tjg9XAXmQqJDhN7NNxCNfpF0pBTRMj0KrZ8qlTM0CW7zC+GJTeqbU7tvPiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916100; c=relaxed/simple;
	bh=GeWNBfnTSEYsWcGbVHIKjSgKRznbzQcfuiKkDE/ZZjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IrYlIVKheONx0MnFRA38VhCzeqaKW0tK2v9KwUyxbk/tumk+/lWujo8BaTCMkocXnG3ctDPBBfWt5NRsKX3ltXr11SZpyxVsbdyUTYMRqDtH+i7E7y3SpZ8iyb1AYThOgtKpAJexrJL+ZtQp2xiTMQqs59rxXOy/5nq2rdTQ7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=rvVKxstK; arc=none smtp.client-ip=81.19.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="rvVKxstK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OxxZHUb+j1YRdNC8Ua6/3LFw0btHKBL43Ex5BT+pwkU=; b=rvVKxstKtAWOkCS2Otv3452oRG
	40unFnqokco5ulBNEoJqEdkItOIn2yn2FmzSO7hQ53Og5jfd2gGZPqRza6iuwUXqnTuXVbD6oHgZb
	eGnDdo3I+Lqx3rgPAuPhrS5G7UmOWTJPgtGDh+8gtXKrM/4DFFDQ+Q/wfqhuYfbJKlek=;
Received: from 188-23-39-151.adsl.highway.telekom.at ([188.23.39.151] helo=hornet.engleder.at)
	by mx06lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vVark-000000005P3-3eXu;
	Tue, 16 Dec 2025 20:37:49 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH 3/3] serial: 8250_keba: Use dev_err_probe()
Date: Tue, 16 Dec 2025 20:37:26 +0100
Message-Id: <20251216193726.55449-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216193726.55449-1-gerhard@engleder-embedded.com>
References: <20251216193726.55449-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

Simplify the probe() code by using dev_err_probe().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/tty/serial/8250/8250_keba.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
index 149953c6a288..f94d97e69dc5 100644
--- a/drivers/tty/serial/8250/8250_keba.c
+++ b/drivers/tty/serial/8250/8250_keba.c
@@ -252,10 +252,9 @@ static int kuart_probe(struct auxiliary_device *auxdev,
 	}
 
 	retval = serial8250_register_8250_port(&uart);
-	if (retval < 0) {
-		dev_err(&auxdev->dev, "UART registration failed!\n");
-		return retval;
-	}
+	if (retval < 0)
+		return dev_err_probe(&auxdev->dev, retval,
+				     "UART registration failed!\n");
 	kuart->line = retval;
 
 	return 0;
-- 
2.39.5

