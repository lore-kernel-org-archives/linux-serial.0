Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80227990C;
	Fri,  5 Sep 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102843; cv=none; b=j9Bmj5B23CG4IpXdTyDURdWbJQx0LtgDRnA+NTp+kc2RIHwVrSZoc/XZpBlARLw9ue+7B1TWt1S4ZCIBGeTLZLmP7vIRaO8llqCQLCF8q8pR53+uXR2pSomPrUwVGD2mVjUxfAW2VpfATkGqoIOPb3lvjjhttvYKnUOmJaX8GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102843; c=relaxed/simple;
	bh=c7Z8AwDrfVSK0Ip17lf53vHcmB+b89NSxKZjLyr8a6Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=Gm9/GA43JJoZvjSE/QiYVwOEa9HeuTrCfTAXQyQ5gBLY5YEpGiefrjkJyAAFHIHTl6CX/lOgkS72WZdAHPAyKGqFtk1mI7vkKAYJJANebpQU9i4FkCvPVUONqUo0YlboFRrvylEAyUYZsLUj8s5iZaaUDdW3uuFJ0JVFuhje76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.137.226) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Sep
 2025 23:07:13 +0300
Message-ID: <bd8764c5-c43c-4bca-996d-65367805ad5a@omp.ru>
Date: Fri, 5 Sep 2025 23:07:12 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] serial: 8250_mtk: correct max baud rate in the set_termios()
 method
Organization: Open Mobile Platform
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/05/2025 19:27:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196074 [Sep 05 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.137.226
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/05/2025 19:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/5/2025 6:47:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

As is obvious from the code calculating the divisor in the set_termios()
method, the Mediatek UART driver uses 256-time oversampling for the high
baud rates, so passing port->uartclk to uart_get_baud_rate() for the max
acceptable baud rate makes no sense, we should divide by 256 first (this
should also prevent overflow when some arbitrary baud rate is passed via
termios->c_ospeed)...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
The patch is against the master branch of Linus Torvalds' linux.git repo.

 drivers/tty/serial/8250/8250_mtk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/tty/serial/8250/8250_mtk.c
===================================================================
--- linux.orig/drivers/tty/serial/8250/8250_mtk.c
+++ linux/drivers/tty/serial/8250/8250_mtk.c
@@ -358,7 +358,7 @@ mtk8250_set_termios(struct uart_port *po
 	 */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / UART_DIV_MAX,
-				  port->uartclk);
+				  port->uartclk / 256);
 
 	if (baud < 115200) {
 		serial_port_out(port, MTK_UART_HIGHS, 0x0);
