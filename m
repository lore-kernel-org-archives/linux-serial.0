Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170923B3BF2;
	Sun, 24 May 2026 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664358; cv=none; b=VVMsS0DHLEnB5VslGVKLjK7H4xqt2/Ob/4dNF0uXoSyrZrbsMI4IypX7MVIzqAmpCHLC9qiL9cgsmFjuoSc2VFPNUK3YlEVyoMgPrjZDdC44V2bsjFC38TavsflcEqxpSeJCoeFmxHjH+RssDRF+w/LcRhjkLXILodYU/R2MO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664358; c=relaxed/simple;
	bh=5NMfh6aMaAzIdfTqrok+ogFVcaOO0Qo/oCPcajGXADI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uDi6onp3FubO6OSXrPQd4lNmqwNconuZ4t+MCG471cb1HBzyMNndsWP26YZ/MZCiFDgKqyqeCbKXCPXEqJBReUbgC8s+Xq78ML3sL1w4BFJgkpe+FqphGN4+uct9Hedy6s9Os56Kf2EpKIvfuEWiaBmiIT/371ASqdhOQf94ilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 273329200BF; Mon, 25 May 2026 01:12:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 23A3B9200B4;
	Mon, 25 May 2026 00:12:36 +0100 (BST)
Date: Mon, 25 May 2026 00:12:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Elena Reshetova <elena.reshetova@intel.com>, 
    David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>, 
    Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add self for the sb1250-duart serial
 driver
In-Reply-To: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605241637170.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

I wrote this driver and seem to have been the main remaining user now.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v2.
---
 MAINTAINERS |    5 +++++
 1 file changed, 5 insertions(+)

linux-serial-sb1250-duart-maintainers.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -23658,6 +23658,11 @@ R:	Marc Murphy <marc.murphy@sancloud.com
 S:	Supported
 F:	arch/arm/boot/dts/ti/omap/am335x-sancloud*
 
+SB1250-DUART BROADCOM SOC SERIAL DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+S:	Maintained
+F:	drivers/tty/serial/sb1250-duart.c
+
 SC1200 WDT DRIVER
 M:	Zwane Mwaikambo <zwanem@gmail.com>
 S:	Maintained
