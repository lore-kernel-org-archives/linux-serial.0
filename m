Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001C32570D;
	Sat, 27 Dec 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766867116; cv=none; b=qAjVuW7JwvPUkYPXpn8zYC3t1yeTZX+TIif7AbnMT6hEqLu50n9Z+gzR64+dz1khx0yFCxdG/rEQ4UE5/7v5xkO3UiIcEmfT/Hy1goYoOZSOS9RzRQb4fmscrTqPj459BMK+JJGqUBF22rzSDJm+hNgZRqud7oBD4O8RwyMNjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766867116; c=relaxed/simple;
	bh=2f7HDSLeSY4R8hwDboP2LCFZ4ZNMd3FJ1lglVbCGJJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5B94ASi7c/Bk58DY4zpAg4UYMLo+QsvNSzPHAq4QiWumGbFHGLtUMAtvrSAgaqSxrSQmBMqvjmb5KOjSk7S9ZgzyT3XqYsbk0xzdY0QdzIepFPPv/MF9bgwQIh6VFUw1TdJfVSTIsp/CJuOprr9irPd/q3s1NmkOPuQt+oawAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ytGzKCMJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ytGzKCMJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d+PFfEmKrof57/BK7oCCBIQd/yMAzmjVNYFZwZ9wpMA=; b=ytGzKCMJyEGjjZ0B5e8H4obC1c
	xCPCcm6bPqEPfj4SzT6zycyJCeL6MLHYJ4frTE2U5rp2l+eLpz3Z5shfCaBjouGZ6il6oCsdCpS27
	2yYjaCE+oJKs2F2m3UTDuSC/Vd/fou8RXvNhiMy3IGOVnRULL7wLEx/3IVlLTL8mEssBmbB4AWw+m
	dJaVPLX5DJZIR1bcw76fD9Ft+xslPm7tVJZJzmq3eYe8PrNd1JKVnVX4v99Q8cYVMVwa033qdKI0G
	dSoInd/IYYK2Bus64ftvicUBxO13j3Kes2rqeBpJgpIdHDKNlj61+07auqbxMD2ZANdDs6duGbW8x
	bC5Z9Qug==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZaqd-00000002C4U-0361;
	Sat, 27 Dec 2025 20:25:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/4] serial: imx: change SERIAL_IMX_CONSOLE to bool
Date: Sat, 27 Dec 2025 12:25:06 -0800
Message-ID: <20251227202509.2084000-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227202509.2084000-1-rdunlap@infradead.org>
References: <20251227202509.2084000-1-rdunlap@infradead.org>
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
Cc: Fugang Duan <fugang.duan@nxp.com>
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
