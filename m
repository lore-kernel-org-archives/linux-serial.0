Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8482DC32A;
	Sat, 18 Oct 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820307; cv=none; b=pO7p7oCfzh3zyU4J27od3CBfYbNJ8Cx8zqar+X80sIYDFYSC2uN3gmy8p3VlGsoishxriOBcfuVIcLYg7MmBmRpi6n8iHvkG0pmshxtVEO9fpOYNs8JaMjz17836NZdmGZ4hzDtYDIwsCax/MLocE2mvD01sq3rVtKzlzi8PUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820307; c=relaxed/simple;
	bh=WBLwCEMqZvCh3Or0SjSAg2uyUloa8c8iF6i/L/YPNzc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=qU7rZNjnGluSh9R0PIZxhA+r4lQISMbwWEuHPCeQxYBX3yIp1O9SZsqeduWLVlg+F4wzFdk09TOui9jDZ+ohZncNfgMqRxizKDqhiRWKeLi6YlHAApQEhkskSBSnL8w4ub/ZurvB6ucyRLnnUz0zfG3d4Kvp9hm1zlv0S/znJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.133.77) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 18 Oct
 2025 23:44:38 +0300
Message-ID: <b238b17a-c22b-4bd8-87bd-2d924328a062@omp.ru>
Date: Sat, 18 Oct 2025 23:44:37 +0300
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] serial: 8250_mtk: correct max baud rate in set_termios()
 method
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <lvc-project@linuxtesting.org>, Fedor
 Pchelkin <pchelkin@ispras.ru>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/18/2025 20:34:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 197197 [Oct 18 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.133.77 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.133.77 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.133.77
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/18/2025 20:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/18/2025 5:59:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Commit 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.") claimed
the maximum supported baud rate to be 4 Mbps; of the Mediatek datasheets
(I was able to get my hands on), only MT7987A datasheet did support this
claim and MT7981B/88A datasheets disagreed, claiming just 3 Mbps maximum.
However, this commit failed to enforce even the claimed maximum, passing
port->uartclk to uart_get_baud_rate() for the maximum baud rate -- while
the datasheets mention up to 52 MHz for the baud clock's frequency. This
means that an integer overflow would happen (when multiplying the baud
variable by 256) if a baud rate higher than 16777215 bps is passed via
termios->c_ospeed (division by 0 will also happen when exactly 16777216
bps is passed). Pass to uart_get_baud_rate() the documented maximum of
4 Mbps or port->uartclk (whichever happens to be lesser) -- this way,
we can avoid both overflows and regression with the maximum baud rate...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the tty-linus branch of Greg KH's 'tty.git' repo.

Changes in version #3:
- updated the maximum baud rate to 4 Mbps;
- rewrote the description again, adding more info on the MT798x datasheets
  studied, on how the bug manifests iself, and on the solution.

Changes in version #2:
- changed the approach to the problem (and hence rewrote the description);
- removed "the" article from the subject for brevity.

 drivers/tty/serial/8250/8250_mtk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tty/drivers/tty/serial/8250/8250_mtk.c
===================================================================
--- tty.orig/drivers/tty/serial/8250/8250_mtk.c
+++ tty/drivers/tty/serial/8250/8250_mtk.c
@@ -358,7 +358,7 @@ mtk8250_set_termios(struct uart_port *po
 	 */
 	baud = uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / UART_DIV_MAX,
-				  port->uartclk);
+				  min(4000000U, port->uartclk));
 
 	if (baud < 115200) {
 		serial_port_out(port, MTK_UART_HIGHS, 0x0);
