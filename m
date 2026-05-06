Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9D3B38AD;
	Wed,  6 May 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107382; cv=none; b=rcOVuZ4tm0ZDi1ppYGzR0yDD/adEpnpiqxbkW686JKCMq9DZKV5Oh75uO8JlvM8NtNkH3c09N26RrjZi5Z8/RPvWUD0LYT3rqJ1/dg5hgHeDZO6MzaGTLeBgU+kQAHKRNjXXAQxCvaRFgMdQqFHYs7vQX/OC+o+DgZXzv/7H3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107382; c=relaxed/simple;
	bh=O0gvqeHkUEtW2z4BjFkJKfc/kiKXZGkIl+n4sc4U31o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O+hTOm8XL4UL5JIaI+H3eMWEH+tXuI0aBn8hKag2O8RYXIarFhNN/ecyRgld6sOheHL1Bw8bT0Duj8JA+zx1d3w4OXZhxDXkF2W3KBjm83TYaSbLl5+Ci4OS4a11pG/oJQ6YUcs46ITes9xbGyyfhiZq41fyoggI2p0rUo6iUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DD6569200C1; Thu,  7 May 2026 00:42:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DAA0A9200C0;
	Wed,  6 May 2026 23:42:56 +0100 (BST)
Date: Wed, 6 May 2026 23:42:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v3 09/10] serial: dz: Enable modular build
In-Reply-To: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605062331420.46195@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605062240290.46195@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Enable modular build since the driver now has a proper module_exit() 
handler.  There's nothing specific to DZ hardware to prevent driver 
unloading and reloading from working.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v2,
<https://lore.kernel.org/r/alpine.DEB.2.21.2605012103360.11074@angie.orcam.me.uk/>.

No change from v1 (7/8),
<https://lore.kernel.org/r/alpine.DEB.2.21.2604130133470.29980@angie.orcam.me.uk/>.
---
 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-serial-dz-module.diff
Index: linux-macro/drivers/tty/serial/Kconfig
===================================================================
--- linux-macro.orig/drivers/tty/serial/Kconfig
+++ linux-macro/drivers/tty/serial/Kconfig
@@ -335,7 +335,7 @@ config SERIAL_MAX310X
 	  Say Y here if you want to support this ICs.
 
 config SERIAL_DZ
-	bool "DECstation DZ serial driver"
+	tristate "DECstation DZ serial driver"
 	depends on MACH_DECSTATION && 32BIT
 	select SERIAL_CORE
 	default y
