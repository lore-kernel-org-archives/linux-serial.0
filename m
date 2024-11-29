Received: from sonic310-15.consmr.mail.bf2.yahoo.com (sonic310-15.consmr.mail.bf2.yahoo.com [74.6.135.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2952914
	for <linux-serial@vger.kernel.org>; Fri, 29 Nov 2024 04:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854378; cv=none; b=fd85jz+tMX8XejKjd1ehYCgOWVzIzWeUYghPm23MA+S4HU1spx+LamArlfTEsYd9Dvu6Pz6xjJppjArVTwryLxmi12AqRZdm7QveC/XpII1C1xNQ/+HTelAA5eGZATZDwgwLg7fg/LqhV5qjFjsEiZrzUyexma5yGtFqgs+8pVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854378; c=relaxed/simple;
	bh=/GYS3tyk6ohx/hpEoVAYc20lAtMbm/H6RZw+6ZfaHj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS0yVZTPzKXEv4hRHOKlLSU9uIWGdGgXMMuSLu8Uy/WRnFBBrHv8dtXITajn+LLkCvfSQubniMNgm8nHsGHGho7Ck3/gHvrOo+u9aX/yYGFGUxzBePyG4snrzMwcIlVPxlYvhm3iHxeDc/IG3Ir+MgWFi80GWVU/indnUnCld5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=Zk7aDRXk; arc=none smtp.client-ip=74.6.135.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="Zk7aDRXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732854369; bh=mnpaswUcNfqc5Ew93OTCuZPe99F1ItTwUwh/LKE14ZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Zk7aDRXkyjv6hZjAXECPTZVp+mxsjeizWvKrv/x07DjWb1des4zbYMtPgiOr4hUyDFxa+mkKMuV16vNdvE3QtSiRL1acviAn/zqKvxSQ7iKfmyeVwNZVqEUVVWEU0e+K5gXfO04pXiGZYDzTuYf1M2AQde2DLEk+th3lSjRdwFzFlm9vjYSpuBnUSmy4QJMjWKuTazmfGd7CE4cJ3zNM3tXU1PTr0SwiVJ00TYs9U39OWFz5QK6XdVb2Y2xHQmcJTVkcdLnjowi6Ctdu16r/3lEC+44joliaQu6sRFy9tksowCtiz6Qw6U1RYyMM3SKJQ7b69P/o0txtYe95/BbhyA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732854369; bh=AR/du2tOsQ1diLDR9ONgqr6zgoR6VgcGeK+Mj7JJEcc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=goPIrPMqfJ3XyAWewoyl0xZyXgacQAPcr0Q8wBgovIH33IhrKqPGAUHcAcSPZQVeTGPPc0Ze90o2MuQWEZWfvfkUbrsB+WHDFSV+ls8G7XMrlMONEhElY7kNGE1tFifema7AFEQGzaKeXPBce4zxM/KYow+GMF8VSoRCthocmA7P3J0zrQCYUphCNcEkJo1Nk+u5wgri3z0p3bH+LJRf/yaiwmzPfHJnKLJq4Nntz15Bqd/ozpJy7im1Pi8hT1xv4j2KX5A3y139hYYxSe/gG14cDnLO1dvxwLsp1vrNIwbqZyGZmBCKQs0Rm00QMS46fV3BoIgDyF/jO7vcLLXMjQ==
X-YMail-OSG: H2x0rF8VM1kOb4Al08UiVihAI2bnLOSgpTEIEwTpRz6.yzPcRe2i6aotVmLMnLZ
 7ZAyZ7Eu3mmLEbH7QRlZtg4b.9cWvtwPpi2bEvKSSWu0L2D0eydEIo6ymVa4epN5c3qqHCTCWHVh
 O_ajIvY0kmig84phz.TuWjRg.pjXEDxdhDI7dZURjXZKjAa4oABsHWeUiBX4eRpvFQOpenMvlOtr
 My22cxsoZ8fyJ5kKkp1uVINsXDXS7bvnqt2McxhGjzTMWUhahj4UeoGTH8PNLMFYVqF1GhPY1Wpq
 IRQrEunh5tiQ5NwT8G.baexCzduBdFIY6GQBHg3MNKCRQQg63DEWZXwG6jW7pScwe47VgG4DEPzV
 Jk_Po2qCUSxW0rHrpmRKA88DKUdkxE8Gkwn_m1lHwPOQrYmk3wjR6UTH2EW64VDno_IYQWqd68wT
 SZQbLHY_YYPNgHXppG0BNcqSziRL04vyYPptyu2fN2xCvIIJ.x3n84vJqGae6QobC6.cAiohRXDO
 x3EVzcC56xBLsmbb8At60gYKGfHavso8paUrfmUp06D0tpOfF8c4vskqj5O2cxJz0ET7oRJbwhkh
 Wvly.g0bhmQNXOSMRojKrKOzl17SXu5CrBWF5VxXSLKNkVT4.ObpXo3_ZAWQOojtpicoA1qj6_TO
 5X7QNaMtwpIJ_ryoK6vLxui8WNIE9qCJ3.Voc3sDS97O0SjsZJzcerf0vt28R_2ttOKSVtqpttCN
 2Y1N1aMXqkgbLkMV6ntHHeAy2hzwnBNhCj3KE7qZeu8bzc5Sb0IqmisziGZXxf0NnNHyxVmav2rI
 mjqi31duylmbYUI2QxpKmYzau3nns.vXl1LCI9PzoA0INPxWJpl_5Xgly0lB0zC_6IhblWWYMy2E
 U4g0ErUC_SrHNtyT39.TWGpIYa6hiZzc38zdiKtclj_cSQQPedFHzuUO8pW3rJTJMB7ETqxbjUu.
 bVVRlLpPUS.yYJ.opUQtf0xxLKzfr6IpklbNMvCvnL5gD51O1Pk5uxmy.WEP5v0Xs7cYSm8CqLut
 cax7GNqgnx0HQVAWxHSll4kYz9amEnIMSXLpJAwgNRkT1EMnJyrOSbadHXcikBTMCjn4eu_rTbJ9
 YcCWOwiJtgAiG_GOBSscNK_.Do1H5nwYEr1SSY8c_bEnbx2VFvGQ4AT9_fzWssJcrO1woExFoDIv
 Ew3cDeAPvGM76uC24i2MwpeclGdOQHlxchF0WTgLX3TZRXsQcYy8bWCKn4u482u2RF6ksxwnB85_
 nX_OzsRR1XoIh0HXLmBPiy4RuI0oHSAAbpIezyZxwgIos3mlVGJWfZ2HJA7Fe2G2Z2LYVB1zK7x6
 BllHAhdlKcM7EWUKZJGQf2eVLqbiWBLJCg6IYVCGLn2OgA.D9da3VR4iYrQ0zNWAXDFeluX7vkZ7
 QSwT_8td22Nv4Qphg1ihNq8X_TAb.ZP6OsII53ANH6T_nZ6al56HhXbbVJepxCmpkwzgbjmsPsJn
 nH_5G2jiQTIY5Mo9s5QLoRfVMBLYNetsusLc.26zjhOM8eiNiFjTalhoen3q33b9pulzGtAF3jw6
 G50bB2HrgYvMUnr4hsnuahp2f820ug_vlmvxcUd3BFFE13SjSnmgcMTDUB0ntN3yfmV346.SVx82
 df_ZC47AkIe015I_a64v.0o_gbEwvodXH9RkfNNPlhaUrOVBigVczQC8BIFACrKh49dlPMiu3JSx
 1bJyKLnoRDOS6bJw8GkTNiCWtRHiOu7MuwNiFrAHbSq0xhvAsu.rDeDodYQG2OSj1nUAaayL0etN
 ps5LcqqlFnHvmHeEYYzUDw8IAnUXGec6BwlSOP_Wy7q9fz9VPx3nLtzsnDDQo3QtLSIs5JfsmU4z
 0TiWmMN5hY_P31kdMpA4OSvry8AOy5o.n92JX4eqVO51hSfxC_v4At5qv2.YySc_KPrXzG644B4z
 yLMFp16w4QoLkFFVFpTvaH.RmeqAjZO6x68VNd.d66RC.Zw2EMEUgAcnwmQZGJEEaIUhRHMELrg7
 dJfbG6eeEEk5MjmgQq5M5JPEq9UllJxBAXCglryqug1dG6nUnXZU1OYrqrba68pV0dtTq.QaFv86
 q_DX0XFYdaunW_cPpBB_LV54UmgUV9AzwDXgwnMCjAWvE5lKuU9t.Yr.Nt2NVWw1oG7OPhJIu2YK
 WNHCNLOfhCovHj2aL8PumdfxY2JksQr14E1Dmp3LN4.pHmHcgMA0T10lzfR1aEvR.XqsX7w8sYP_
 O27PsPTF7R59xksQGXJGot2ORR0EFdJMnhr2t_uj0u0YkAyhNU8o9FbgG61puIqmG_pEve6c3yyk
 fXJrnObsD0sU-
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: ca1826b7-3d04-4018-9831-c93515cd764e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 Nov 2024 04:26:09 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af1c0b40292d512b9d850181f2953147;
          Fri, 29 Nov 2024 04:15:58 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: n3rdopolis <bluescreen_avenger@verizon.net>
Subject: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used as a console device
Date: Thu, 28 Nov 2024 23:15:48 -0500
Message-ID: <20241129041549.778959-2-bluescreen_avenger@verizon.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
initialized by console_initcall() and selected as a possible console
device.
Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
---
 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63a494d36a1f..afe4e7722d4c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -383,7 +383,23 @@ config NULL_TTY
 	  available or desired.
 
 	  In order to use this driver, you should redirect the console to this
-	  TTY, or boot the kernel with console=ttynull.
+	  TTY, boot the kernel with console=ttynull, or enable
+	  CONFIG_NULL_TTY_CONSOLE.
+
+	  If unsure, say N.
+
+config NULL_TTY_CONSOLE
+        bool "Supports /dev/ttynull as a console automatically"
+        depends on NULL_TTY=y && !VT_CONSOLE
+	help
+	  Say Y here if you want the NULL TTY to be used as a /dev/console
+	  device.
+
+	  This is useful for userspace applications that expect a working
+	  console device, without changing the kernel boot options, such as a
+	  distribuition or environment that historically had CONFIG_VT_CONSOLE
+	  enabled, and have now disabled it, but still need /dev/console to be
+	  working for userspace applications.
 
 	  If unsure, say N.
 
diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 6b2f7208b564..8ba629ae426b 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -57,6 +57,10 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
 static struct console ttynull_console = {
 	.name = "ttynull",
 	.device = ttynull_device,
+#ifdef CONFIG_NULL_TTY_CONSOLE
+	.index = -1,
+	.flags = CON_PRINTBUFFER,
+#endif
 };
 
 static int __init ttynull_init(void)
@@ -90,10 +94,20 @@ static int __init ttynull_init(void)
 	}
 
 	ttynull_driver = driver;
-	register_console(&ttynull_console);
+	if (!console_is_registered(&ttynull_console))
+		register_console(&ttynull_console);
+
+	return 0;
+}
 
+#ifdef CONFIG_NULL_TTY_CONSOLE
+static int __init ttynull_register(void)
+{
+	register_console(&ttynull_console);
 	return 0;
 }
+console_initcall(ttynull_register);
+#endif
 
 static void __exit ttynull_exit(void)
 {
-- 
2.45.2

