Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8F359A9B;
	Sat, 26 Sep 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463692; cv=none; b=qoXbGYN2qrjCYdOJwTLLVRXXQTx8Cdqkw4pJIv6duecMmIN0ofU5VTARRYrfwHDq4xHtV9dJcdrr4nmoyMH8voBuTDEkGtbj7r+QhSIzwrola/smqwjiO8EGzuj+vMR+9JBX1sLRh4H6sJBBOaCxYVYAIjN7y1OqDK2Gq3im8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463692; c=relaxed/simple;
	bh=taKqD93DHZ7v/qkc74N1mi2CZmXC1VD5mre60C5Y0FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L5BEmHEh3ojH+5R5F6gutPkj3uT7I6WZcFQZdlsCaLeQ0XRscSKUK8F2qZS1mL3ZaX8ii80CJtKpgBS28qMfu205Bu1Fz20WqoZCH9o8oWDsEHaKnjky5IAUHREriNcr3phB4SddNZXySGeUcnHkNp71n/5g3sWDM9p0Oq/F6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opiErF9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opiErF9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD7C1F000FF;
	Sat, 26 Sep 2026 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790463688;
	bh=DwDRTXT4oDssGU4TNV1D/LHozz5eIoltauFGK7D8oSY=;
	h=From:Date:Subject:To:Cc;
	b=opiErF9kS7I5Kw27lvAfikTHE0pnPz6SisTcpxZMgiu+M8CO1mlowJ4W/Sr9DyO8o
	 cnVG55iVtrZZFMGOKDXpLrPfQC2RMa7bVDLbd5Ddie1D9JCMf7Xh2iFDa+8fMfK3Uw
	 +jmTrcxCzpmeHGAAyji+7qIKn6PIARj5Uc2p5toyIKXSn+8tOI7cgeKxb45VKEZDbs
	 0JU5uE3rKeuckGfuNoy/LaEu7oJ7ps+yIMN99/3au9KhUokq9G0vqwOumOdBo1Wild
	 klDL4dCMh6lBCM5fmVGeZwR7dAoL5Nqnr0WzuQhH/VxZ6iJBC6Ucn3l9kIWfDRxKI5
	 35ue+fBKXhYuQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 27 Sep 2026 01:01:17 +0200
Subject: [PATCH] serial: 8250_mid: Add missing module namespace import for
 SERIAL_8250
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-tty-8250_mid-ns-import-v1-1-84d0482e1c5d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQjLRqr1KKqBnbKRglk4oi3
 r2pLt/i/w2Ug7DCPdsg8Cwqo0+wlwy6d+NfjOKSgQzdTEUFxrhiSVdTD+LQK8owjSGidWXO7Gz
 VWIIUT4F7WY7x43lav+2Hu/i/wb7/AJiLdwx6AAAA
X-Change-ID: 20260927-tty-8250_mid-ns-import-1d83eed19a12
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Tate Whiteberg <whiteberg@arista.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=nathan@kernel.org;
 h=from:subject:message-id; bh=taKqD93DHZ7v/qkc74N1mi2CZmXC1VD5mre60C5Y0FY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk7/I7oVKl1buupmiX7dMcJv6exTBI3irpveL8vvBBwN
 T1W5IJMRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZiIODsjw55FUq0eS1b/KWdf
 qFJkPstNLcb5aeOMLL3JLuLBTqrMdxgZ7nxbc3uJw8d/hZdzVxSsrvxfdIzDT9H7atq2BxMUP6t
 fYwQA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 1c305d5f1daa ("serial: 8250_mid: wait for LSR tx empty
before setting termios"), modpost errors (or warning with
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y):

  ERROR: modpost: drivers/tty/serial/8250/8250_mid.ko: module uses symbol 'serial8250_wait_for_xmitr' from namespace 'SERIAL_8250', but does not import it.

Add the missing module namespace import to clear up the error/warning.

Fixes: 1c305d5f1daa ("serial: 8250_mid: wait for LSR tx empty before setting termios")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index c02ecb96e8b6..47f820fcd1a4 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -415,3 +415,4 @@ module_pci_driver(mid8250_pci_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel MID UART driver");
+MODULE_IMPORT_NS("SERIAL_8250");

---
base-commit: bf961847813d9edcb5a9c089714069428d141fa9
change-id: 20260927-tty-8250_mid-ns-import-1d83eed19a12

Best regards,
--  
Cheers,
Nathan

