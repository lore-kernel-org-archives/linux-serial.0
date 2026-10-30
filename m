Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350514;
	b=J9oROlHIm2Io/XN/G1g3EV54JB93I1DKTpD9LByLMXIyKJS6I4JooCoMl48uMHKemoeP
	 rM0/jU3lwgVbwV0eHLSm8dDT7BEh0qBi/HHWLA/jFpswzDTvnXYIOL9Mcw8aBDy7R6m/B
	 Wh/P0mseq1HsELd75Bcm8uUJk5Fgk+QIJRkqQ9LINTRp7Zw91tSF9LXs7WGQkvZ33kXoM
	 Tl6dwhDvW4oyr0ZRoKpqPphsTXOBUg1pNDKlPX4qLEz8vMS+bCqDP0FbC+OL8SkGBd71R
	 Xgok0fslkFCWryqGYyaIv5+j/9FxuloJC8tIdJnjwLuqsNUUlVonjKzm7fUFseb05EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350514;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UcWne/32HAfL8NydSVfK4K9513ieBrDLwTP0ICYFJCw=;
	b=DmZP2W0kuwY/EDfOmUdzDgNnAmtgDCdyHcXj0AC/cjIVGl7J3vysMTgHlwQj6rizDXQc
	 bGEk8nYtLnFQcphBPCsaKto7LaUoU5Xz8Kv66TYIiHd7W98hVYheHUbMvDU55uoRWGtl9
	 r0/0m2ZzYOEWiU9+NLqXHvn79fBMDA13+GDWBtnl8GV81vSVo178P0n9DfvaFMiGXb6le
	 tNixxuAUtPZJznH85/H8WZOsEtyvz8pQy7nPxctdWiGw0Ybew7h7nBD+ZF4XqWdAWatpf
	 0KfyFb+cGQ2w+ycGmVytck5AW8stjV/h9tsMrImCin7XE0a21m+KYTaJYbxwUiDMQ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IMJbL7Ar;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2419606A31C;
	Fri, 30 Oct 2026 08:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2419606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=IMJbL7Ar
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=IMJbL7Ar/hahL7/Nx9eiG/xTrEZs+avqc4xrRI/PVaUk6THsYe+wn3DK1qq+sa+Pw8gm/j483AiG0
	 VTVRmGf5BRQTJz0tAY9iYYOqTOiPnMuGSuxCXObrNnKmnVmJM9zoD60potOfzyYXTg24JfTTe4575q
	 Y6H2TRFt7aQaVf0I=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ae45b6f502-4f1f8;
	Fri, 30 Oct 2026 16:55:11 +0800 (CST)
X-RM-TRANSID:2ee16ae45b6f502-4f1f8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86ae45b6e2fe-576d1;
	Fri, 30 Oct 2026 16:55:11 +0800 (CST)
X-RM-TRANSID:2ee86ae45b6e2fe-576d1
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Fri, 30 Oct 2026 16:55:07 +0800
Message-ID: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sc16is7xx_probe() enables the clock with clk_prepare_enable() early in
the probe path. If the resulting clock frequency cannot be determined
(neither from the clock itself, nor from the "clock-frequency" property
or platform data), the driver bails out with -EINVAL, but it does so
with a plain return, leaving the clock prepared and enabled.

All the later error paths of the probe already jump to the out_clk
label to disable the clock. Do the same here.

Fixes: cb1b206cff46 ("serial: sc16is7xx: Use devm_clk_get_optional()")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index fba588559..e464c6d72 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1619,10 +1619,12 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 			freq = uartclk;
 		if (pfreq)
 			freq = *pfreq;
-		if (freq)
+		if (freq) {
 			dev_dbg(dev, "Clock frequency: %luHz\n", freq);
-		else
-			return -EINVAL;
+		} else {
+			ret = -EINVAL;
+			goto out_clk;
+		}
 	}
 
 	s->devtype = devtype;
-- 



