Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AA26E6E1;
	Sat, 10 Jan 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087616; cv=none; b=dTVnYIejwZwYvFGdnIZCwYTW/VgXYp3to+PQVZx1AOb9yQo0P5E8rjim+jAtLI46JufJTUWAeQnpEI11LKu8eiglo795HwnsaXrnCgdyrnZ5sNlQjR7yFdXGBgsG9lCm3qiCV0R0vFCF14tDHJw+ytsfm7ACtXNBgf+mLAZLYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087616; c=relaxed/simple;
	bh=iCYS7nazhk9qvnVW6nNZNrqaiaAb8T581JSnfxwLcy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSaj8sgFjReMQvB1VVtRUipMsqWx2xq92cAP0pWKmvZqIfa8K4EMG3SlKXToYCeY9saMEloGaCXRu63JQU1aikSaO+eyGPSwSYTX7H49dMw47cNoiu2F+OhyzmOMGIX+QpXo7M1pirBYAHkusWvjmkJch9F4R8/uMef5xkoDgBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZgAb21fM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZgAb21fM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=duQxC0uTPFl9OBKTDlU60acfDEsAvmXsqLyESd2q+zk=; b=ZgAb21fMU9zEvTCxuYUUeKkYN9
	9tCP048g6wto3O+VMT1rBFjda71BOWMx55FAkxw7XUvvYeMPWzl0ur1dEoLxfCWeZNPfg3DOlctdD
	f4NE51Nipv5nfwF7HgEOBalsHnGZB124bzmhNgFI4Vnv3A/aVva55BrtB9Fnb2h5Fie1yPErgUr6d
	hFBG9FqB+qm8hwDPEHjaA+81kBS29ncYlNaQXUYiot5C3VSbpNEYqoqZDoY/yUO/2rZlirPv/PvHt
	S2jgDRf5OWK6HcisKqrlbxsSqczZTgAd4fG16L/TqSn2WTXReNDaRRJX19Dp0wI6Ers5crJMosrKY
	0004KsAw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veiM1-00000003lbk-0IXz;
	Sat, 10 Jan 2026 23:26:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/4 v2] serial: imx: change SERIAL_IMX_CONSOLE to bool
Date: Sat, 10 Jan 2026 15:26:40 -0800
Message-ID: <20260110232643.3533351-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110232643.3533351-1-rdunlap@infradead.org>
References: <20260110232643.3533351-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SERIAL_IMX_CONSOLE is a build option for the imx driver (SERIAL_IMX).
It does not build a separate console driver file, so it can't be built
as a module since it isn't built at all.

Change the Kconfig symbol from tristate to bool and update the help
text accordingly.

Fixes: 0db4f9b91c86 ("tty: serial: imx: enable imx serial console port as module")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: drop Fugang Duan <fugang.duan@nxp.com> (mail bounces)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-serial@vger.kernel.org

 drivers/tty/serial/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20251219.orig/drivers/tty/serial/Kconfig
+++ linux-next-20251219/drivers/tty/serial/Kconfig
@@ -486,14 +486,14 @@ config SERIAL_IMX
 	  can enable its onboard serial port by enabling this option.
 
 config SERIAL_IMX_CONSOLE
-	tristate "Console on IMX serial port"
+	bool "Console on IMX serial port"
 	depends on SERIAL_IMX
 	select SERIAL_CORE_CONSOLE
 	help
 	  If you have enabled the serial port on the Freescale IMX
-	  CPU you can make it the console by answering Y/M to this option.
+	  CPU you can make it the console by answering Y to this option.
 
-	  Even if you say Y/M here, the currently visible virtual console
+	  Even if you say Y here, the currently visible virtual console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
