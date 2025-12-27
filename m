Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFD325727;
	Sat, 27 Dec 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766867115; cv=none; b=kXlI0MEVwkrb3Ef66Pwo1TaYspReggfVoPMCVQz+YEFyEO9g5ul5VR4Zc3bZmngYZRucx4yEqvoRBG/bOn0ESJHk+ji1/YoG5fTrAXyING5ZxD5uSabSrUUJf9oKmKo3RfqbQ4GUUBNIAiy+G8YxqlmyoGMhPDCryiqhzzVmDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766867115; c=relaxed/simple;
	bh=BtsWonIyvIdYBDa1xnrDls0MHmgofbhcRTfu0KdsRgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYDMC7KXIM5bWoss3LqjbKLYNFjIgD4PDEQF6mPi6IxXOWgIWXWWqQT/Ae4ceD05rvIkUwZTuofDe+okTQUtv7WsZIW5KNbgMlRr2pUFhbU/4BrjqhL9Yxa6Rv83bCYUEyYgbhzGXD6p51Xtxe+MPP2dTF4uK6pduIFWdtr8HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t2Yotdem; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t2Yotdem"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jCuqEg6oYhrqyaKXMUmng5TxqxLK2sFom3R7K0zcxak=; b=t2YotdemTKQXvtGwkp646j/0sz
	r6EHPx/K0E+qcY6s6Ys6KX4ahneXPjDZRmJQEt4Kd7WsOvPOhFqMsSwd7o79elzY2xYEhk9nCb35B
	vHAN7T1mZgLnU/XxgcmwsH+dAvWFRy4zbmOyr0tmn7YXlrX2qUzR6ixjsXpFVzgIgoXBYTalFDP3x
	ObbOpKC0KsCLuBqOJx7oIiNyMlhV5iBWwv+pMKW9cbajX6YKa0i5HBfWXeBdOodA0sYsYA8QVtoMs
	wpOyl4GUExBKgPPnch/e+MVnvHY5BwIeDJ7zxh7XeryX1S1uU0ZN1/L+pSlPxLnF4CXdbWbjnyx7J
	5Dr7oABA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZaqd-00000002C4U-49GG;
	Sat, 27 Dec 2025 20:25:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-serial@vger.kernel.org
Subject: [PATCH 4/4] serial: SH_SCI: improve "DMA support" prompt
Date: Sat, 27 Dec 2025 12:25:09 -0800
Message-ID: <20251227202509.2084000-5-rdunlap@infradead.org>
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

Having a prompt of "DMA support" suddenly appear during a
"make oldconfig" can be confusing. Add a little helpful text to
the prompt message.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-serial@vger.kernel.org

 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251219.orig/drivers/tty/serial/Kconfig
+++ linux-next-20251219/drivers/tty/serial/Kconfig
@@ -671,7 +671,7 @@ config SERIAL_SH_SCI_EARLYCON
 	default ARCH_RENESAS
 
 config SERIAL_SH_SCI_DMA
-	bool "DMA support" if EXPERT
+	bool "DMA support on SuperH SCI(F)" if EXPERT
 	depends on SERIAL_SH_SCI && DMA_ENGINE
 	default ARCH_RENESAS
 
