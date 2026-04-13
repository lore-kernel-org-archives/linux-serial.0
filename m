Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0423EAB0;
	Mon, 13 Apr 2026 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776050909; cv=none; b=KK+Keqay0/owhyorYccuJTG6Vr5V82phHr+zDScx1vK8xxma435Y9m4CWi2pJIUg6bzDbDzT+SaQ6cwTbzfWFa5IFM9pkxofAZN09GCzL0zObE0zZHj/6T8GpsNPxAOhJjx7ofMStyMpZGxsIKnfi8K5/yM1IDwhFyKVxaClKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776050909; c=relaxed/simple;
	bh=emvE8RlhhU0V86UPkLLqP5M9FSUDraGz9EwYVizFvpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qj82RLqFDdaRCXlcbcR183+vty2gQTRWo2LlVGHGipXxXTGoIRiNpPQgWEISQDee+/wSJlJScM8/aYKV2NXOAqSF5e3ICbPdoW7eicnZRajSQyXMiFuZtBZATvJS14HEgwc7IEFP0hCGQJABSjpskbOI3NnQuPIFxUNA4Z2syXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A725B92009D; Mon, 13 Apr 2026 05:28:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A181292009B;
	Mon, 13 Apr 2026 04:28:27 +0100 (BST)
Date: Mon, 13 Apr 2026 04:28:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH 8/8] MIPS: DEC: Ensure RTC platform device deregistration
 upon failure
In-Reply-To: <alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2604110042130.29980@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2604102250060.29980@angie.orcam.me.uk>
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
