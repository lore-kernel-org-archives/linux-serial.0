Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17D3FDBFD;
	Thu,  6 Aug 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013678; cv=none; b=k6arkR33yVPFsfwVUkRCjrkXlmvFEz0pHCqc/pxOAAC3+WOtGGN3JxuF27ifygxj966h9scqCn27SIhuoK9vBaKCVA+FHbBPoBqClt35OMkFAL5GbyyigP4R6td+sOPUhZ/H91Q4EuOoz2jgmYOiKgmbFma5ZBAQhcoFIHg+X4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013678; c=relaxed/simple;
	bh=/c90qsbFyTNgAZLk3hx9/yHx1ewqppTvtm3GlIlF+98=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=MDJ4stca7RgaTJINTpoUljTC4mtm2lEB/ASRBQviJKvBpgDDMHs6QN1H2b+4yX+uQQDdmtKDlhj5JVBoLazc0pUTCF1jF72wUe0Vy8ZZsZQTRPVuSohxn4Z5lLvEZdobqjV3XzDgQaYE7VQ/gFrUdx9wj6gbA/JrBPA+TxS0pxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F29B092009D; Thu,  6 Aug 2026 12:54:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EBD1592009C;
	Thu,  6 Aug 2026 11:54:34 +0100 (BST)
Date: Thu, 6 Aug 2026 11:54:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PATCH v3] MAINTAINERS: Add self for the sb1250-duart serial
 driver
Message-ID: <alpine.DEB.2.21.2608060423110.55540@angie.orcam.me.uk>
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
Changes from v2 (6/6),
<https://lore.kernel.org/r/alpine.DEB.2.21.2605241637170.1450@angie.orcam.me.uk/>:

- Post separately.

New change in v2.
---
 MAINTAINERS |    5 +++++
 1 file changed, 5 insertions(+)

linux-serial-sb1250-duart-maintainers.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -24199,6 +24199,11 @@ R:	Marc Murphy <marc.murphy@sancloud.com
 S:	Supported
 F:	arch/arm/boot/dts/ti/omap/am335x-sancloud*
 
+SB1250-DUART BROADCOM SOC SERIAL DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+S:	Maintained
+F:	drivers/tty/serial/sb1250-duart.c
+
 SBOM
 M:	Luis Augenstein <luis.augenstein@tngtech.com>
 M:	Maximilian Huber <maximilian.huber@tngtech.com>
