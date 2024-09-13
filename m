Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BE1BC07E;
	Fri, 13 Sep 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216803; cv=none; b=X9KOfDvj5x/svDHh/xo+qRDWmsETgrivuTdiehcSupkHZg8FOPrkNR2cZhCskE5GuwKGZyGs6F0oyjMTkfAdIDUxcf15Op/EdbVHD9hnijlu7omHsJh37vxQDN0Xe/0YkaufzY0eWhIbTIGl+I1NOmDNhfQqENw7YMAnQVBtZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216803; c=relaxed/simple;
	bh=st/YOUKHt7mTrSOi39Ic1qZPpt4tegKJFkaBdwH/HZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YrbNFLQKYtchWeiCuzH63VUjtT2KjsJbCC/LRm9XJUf+5aWgydQv/yF15bbbcXGx+vNSC2G/1mpsn9MZDaZq8NLnVFOhQTpTi2lfZfcOUshyL4VJ1pwM6D7N51MgUJaDmQlGA4RMPqLe+nuqITniZBTqU6EO6ClbsEpeUSEIMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=v6m0tedB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="v6m0tedB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WnHN7qMcG8tuD13zIADdEsVNMqZ34MUXlFCfvG8EYAs=; b=v6m0tedBbDqYDJdypQtCEzP5Tk
	NX869ilVDTik14Yg4COsDcbUTRsjv7j6Z7cahYnn+cqAIGqsCKJbUoJsjE7tnhhrP9IxS+VRazKky
	MnfraUBGmmqA8d2qiCB8OD24VrHACB5wbm08zaIxG16BDB+1s3cWN4qah2FUvCuM63Gbd7HcB+A99
	K8+t6BVYspFipZl2hTsNmzyZM9LcGCjhD87zD5nhaOsuxBj9EkRl+67+ZOeoZ9pTcsZ4HJ1QekMmg
	AaWcviBkF8ZVoXqbqssFL2297ef8bU1RlK8CuE9W4MAhco33ikeNY2QZIyLk/20VXxAH/UFJJ6hB0
	lyZFD1lQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sp1qL-000Dwj-Qa; Fri, 13 Sep 2024 10:39:53 +0200
Received: from [80.62.117.18] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sp1qK-0003Hn-2N;
	Fri, 13 Sep 2024 10:39:53 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 13 Sep 2024 10:39:49 +0200
Subject: [PATCH 1/2] serial: imx: Grab port lock in
 imx_uart_enable_wakeup()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-serial-imx-lockfix-v1-1-4d102746c89d@geanix.com>
References: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
In-Reply-To: <20240913-serial-imx-lockfix-v1-0-4d102746c89d@geanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 John Ogness <john.ogness@linuxtronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726216791; l=1035;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=st/YOUKHt7mTrSOi39Ic1qZPpt4tegKJFkaBdwH/HZY=;
 b=GFqRZZb5hDDFmJ6nfbHrxykfNuBZyqojtW8NnRHxTQ3JBPTqSRp/dkC2uZ/4pLH2hHycvCcL1
 WSg8ALqwgcsBqQh4lfS7vA87Vvx309o1iWQM+w7fVzegMcDybDvrqxA
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27396/Thu Sep 12 10:46:40 2024)

The port lock needs to be held when doing read-modify-write on UCR1 and
UCR3.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..efa3eb3a2c57 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2580,10 +2580,13 @@ static void imx_uart_save_context(struct imx_port *sport)
 	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
+/* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
 	u32 ucr3;
 
+	uart_port_lock(&sport->port);
+
 	ucr3 = imx_uart_readl(sport, UCR3);
 	if (on) {
 		imx_uart_writel(sport, USR1_AWAKE, USR1);
@@ -2603,6 +2606,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 		}
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
+
+	uart_port_unlock(&sport->port);
 }
 
 static int imx_uart_suspend_noirq(struct device *dev)

-- 
2.46.0

