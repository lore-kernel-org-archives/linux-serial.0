Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2F35A3B1
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542023; cv=none; b=i8tTx1AGgcZxhULtc+mLdt7SvNdR1dgMcNXOkLYICtNKwLNyyAwNWMzO7VVNz8ky7zO0QqlKWUJJYSxJL2fOb3V5h1nnnClp8Jv5Tkyi4SW+hpZSe/kT4U+Iu/R+j5vMddp7yokbpNzSLcsbXRuWQbny5iNd1/hNzVMv7Zed65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542023; c=relaxed/simple;
	bh=hkxpKe0SXBxESz4zdGObY/hj9vh8GKNungvJ0a2BW+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBCiJdYQvUOjbOuc1XFUAcCYFa1dC9ohk4UeC7/P9rgmJV8qby7me6npyJ6rhAd/5vTHNRcjMrXGiZRbhm3BoWYBMMLJnO48sgjzAiT38Fj4FNHo74SfbTebL7VETiofqIGj4EkcUcYKXGzVe5skSvv9s0zOLNQ8ZwWberCzFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOe0L0++; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOe0L0++"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df964b6893so9866465ad.2
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790542021; x=1791146821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryZRJZuTPWZfnBV/TlZKfTdjR8/6L8XQUKUndimBZns=;
        b=FOe0L0++rFmU7kT3UnUN5GfLVxoaynbod9v9oVo6cErDMQmZQs/wVwaV5IfReW6K3c
         Ioj5Epau7CmU8tjxSPw8h574S3XLM0s5zICJFRyA1WLnvww3CVFvlsnhuqJuH342f/Gc
         n413KbCnigfGmJOhVn660UIDwIcFmqSnk1Q9JOYwifX8qCpCnzuhvOQkAuxnbXrzzBZx
         sHhn1MR67OVJr6d2lgDwB85i9pv9E4EBhJGr3835SZYSbNXTU01RNW8Xer9VG57Qs3UK
         7nS3TSAJsCIMNPQj2BY+wdf6QCgaWI3YKzwUF4ihnXayov+UBcGpgwluLUy9hOxgzkj4
         O14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790542021; x=1791146821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryZRJZuTPWZfnBV/TlZKfTdjR8/6L8XQUKUndimBZns=;
        b=V6G+98IvXkUN3Ia6B6lkfoJCriR1CfvmwCnRAjse2w8BmiHT86YrjohPQTEo28Iqwu
         pzccHpZSa2Q1ee1IMY43BnaLYeOzhEG9KsR7ekTBcdAlqQzEBWXppZQL7HL28X107F+p
         cfXxCDWTidqFvtKqAJJJAaG45HcNKXw7D5vp2tP7z1dlftyCl7emeCQZK3Y4qYNIfE/x
         skWf/ZgITriYVdFCKc7RtBgi/6Q1XsHv1xuoXUX9HTVX8B8rMJQjigTgWdlQ0CSo8R1a
         65CH3Cg+kZHatI4FfRHz0U0XhgyY3sekJLIdBzJnCdz6dhX6F+QJL/kCdh8C3v7J3byn
         Majg==
X-Gm-Message-State: AFq9FYJK5SteKq0jm3DP4HQl5LI7sEVl46V/kAFit7jOXWchhL6STRUc
	pJ0ohHrHWkHc31SMA3raAf1hx7s591oADJW17aypWZkFkTSywmg8hoq/aqcVT03a
X-Gm-Gg: AYBFou1BRx+7LwttspRzhzdDFuHuEdxrrvEVMBEqP5tZKDjoHkrZsgSoRwUNdDmvuUT
	+jaPlbBUtZrljdVDLZVddIh0M20WsUijy9IWaKTkGQMu5QddmPfdu83IRqPbhqTOrBm2Ow3Upem
	fSNXuNqkH5mu/6kKX4f6oNUKAQIvyaH2sX7wQiIlmeorgAYFXsw0vNWt1uCkpoqsjS1x7cpg/7Z
	67aQyzMhYAQyL7fUGLBWeYRAvWbaFlxfKcfcxeeYAjYCYGLAZ9mh99Dyr8JFTKXc6onY28UOrDG
	ywzC89P3LnotyZ5Vssp/2Ms0MUlETvZxI4VEuY1VuhH73Y0NNPz/jr+8SKNMu6+oAeZ7r3kaUci
	X9BQmTEjSffps1Rg1CQbC9jTb6NzzGvhe12OwRw/gZ3EXnqjTb0EZ1qjdLujnRWDLn35tr7n4jQ
	T2qA1H2NcanzwQKf6EOfuwRJwkD0xZzD9MVmhmtx1nWaizqlevT+1uL7DiA6kGdnGXUxFiz6Rfn
	LJmaaRIL7+8Nm8peD1N7DYc7zDVGTlsHqgZa0at7cbJDKwa0ScMYpQYwMA3LG0+jHFch7JDjT8X
	Oe5BMpk6CzaGO1lKx2ijCdtRTcPH080h7Onl3udR7JTY3ljK
X-Received: by 2002:a17:903:1aa7:b0:2dd:ad74:6d1d with SMTP id d9443c01a7336-2df7daacbdfmr95981625ad.26.1790542021386;
        Sun, 27 Sep 2026 13:47:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91443823sm31303465ad.57.2026.09.27.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:47:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH v2] serial: hvc: use modern IRQ acquisition API
Date: Sun, 27 Sep 2026 13:46:58 -0700
Message-ID: <20260927204658.24338-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use platform_get_irq_optional() to be able to handle potential
-EPROBE_DEFER and other errors. Move it earlier to avoid having to call
kfree() on the global array.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 402da9e7c534..fb9a566ca213 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -157,8 +156,9 @@ static int hvc_opal_probe(struct platform_device *dev)
 	struct hvc_struct *hp;
 	struct hvc_opal_priv *pv;
 	hv_protocol_t proto;
-	unsigned int termno, irq, boot = 0;
+	unsigned int termno, boot = 0;
 	const __be32 *reg;
+	int irq;
 
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
@@ -176,6 +176,10 @@ static int hvc_opal_probe(struct platform_device *dev)
 	reg = of_get_property(dev->dev.of_node, "reg", NULL);
 	termno = reg ? be32_to_cpup(reg) : 0;
 
+	irq = platform_get_irq_optional(dev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
 	/* Is it our boot one ? */
 	if (hvc_opal_privs[termno] == &hvc_opal_boot_priv) {
 		pv = hvc_opal_privs[termno];
@@ -209,8 +213,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node,
 		boot ? " (boot console)" : "");
 
-	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (!irq) {
+	if (irq < 0) {
 		pr_info("hvc%d: No interrupts property, using OPAL event\n",
 				termno);
 		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
-- 
2.55.0

