Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A937F019;
	Fri,  1 May 2026 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677328; cv=none; b=aqaal/HwI0+GLJwHCDMNg3xIBgXYxk8hvtuoZNzC3r9BPU1o0JlPgO/TYdAAKI3/qpbcPQxxGg2fNYg7VBPxI9uxGAlJSwmXD6+IPJdheNk4MJHKwCQQWPeH2R5ZTNo+EQeWpt/sNdW281y1OzUjsIj9iPponMQTcr9jh8yURpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677328; c=relaxed/simple;
	bh=BOrGHLGx44hy3E1GUcOjQABCxBS0zDVxcsDcFMbUtOQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gyM+h90pdSdTRh1zKErheRHUhexy6TR3VVIBUNJQnrct5wU7Ch/pymzR/n7+zkCM8fB+DJHs0zKtpQccYn+0Q+TGQ7SVpancMvys5OmZ+lVvIAvET7lLMV++qc4GVOGN1zOqQtpPqUUAzKwU3q4N/6n3Evgp2wmsN+0REPyudsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 00AB192009E; Sat,  2 May 2026 01:15:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id F2D8692009D;
	Sat,  2 May 2026 00:15:25 +0100 (BST)
Date: Sat, 2 May 2026 00:15:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v2 10/10] MIPS: DEC: Ensure RTC platform device deregistration
 upon failure
In-Reply-To: <alpine.DEB.2.21.2604302336260.38805@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605012105320.11074@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604302336260.38805@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Switch RTC platform device registration from platform_device_register() 
to platform_add_devices() so as to make sure any failure will result in 
automatic device deregistration.

Fixes: fae67ad43114 ("arch/mips/dec: switch DECstation systems to rtc-cmos")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v1 (8/8),
<https://lore.kernel.org/r/alpine.DEB.2.21.2604110042130.29980@angie.orcam.me.uk/>.
---
 arch/mips/dec/platform.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

linux-mips-dec-platform-rtc-unregister.diff
Index: linux-macro/arch/mips/dec/platform.c
===================================================================
--- linux-macro.orig/arch/mips/dec/platform.c
+++ linux-macro/arch/mips/dec/platform.c
@@ -38,6 +38,10 @@ static struct platform_device dec_rtc_de
 	.num_resources = ARRAY_SIZE(dec_rtc_resources),
 };
 
+static struct platform_device *dec_rtc_devices[] __initdata = {
+	&dec_rtc_device,
+};
+
 static struct resource dec_dz_resources[] = {
 	{ .name = "dz", .flags = IORESOURCE_MEM, },
 	{ .name = "dz", .flags = IORESOURCE_IRQ, },
@@ -137,7 +141,7 @@ static int __init dec_add_devices(void)
 	}
 	num_zs = i;
 
-	ret1 = platform_device_register(&dec_rtc_device);
+	ret1 = platform_add_devices(dec_rtc_devices, 1);
 	ret2 = IS_ENABLED(CONFIG_32BIT) ?
 	       platform_add_devices(dec_dz_devices, num_dz) : 0;
 	ret3 = platform_add_devices(dec_zs_devices, num_zs);
