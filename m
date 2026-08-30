Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D42EF653
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080025; cv=none; b=DBtj0xbQQ3rKdQGmcuaM4jQJYixJWKKd3zP+ZTIE/W5mr4c58GhR8z7dpC8llz4L3SeN5nYAVFvmi9Oxa/4ScWVff2Y+wNeBYO0xVYp0atjIsIObscztdUYB91p4FkcN8h5TFkT9yCsThTr9mn+klUswq+rElgrUeOgtXWZFnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080025; c=relaxed/simple;
	bh=0QLvelCtKRHvSG/o9eUNBmUP9qh+Ju/deNVjrNnksbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbOdDASu3vlJY2fzusuaAxktW/3WSD4bbAeWoehBZB/ol6Qcq1XdLwzdokbjIepKJN97WazFPrHPoTzil/w6mv+Nm+rK493JnVsyVur/5/sohKrFhMO6eOI7/XsQpzURFQNpjNfayH3OKZk9fHXxNXY1wKUZ3/JofoicV801Qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPh3D8LH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPh3D8LH"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1670dad7a8so385445966b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788080022; x=1788684822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Xieco16JUGBtqYPcvPXgwiOrcIgYov6XOPWEyUzzGU=;
        b=QPh3D8LHjvo+uqJbWBQ90Owf3QLC0w2b2hgAzSJlhXcChXaaF2P1DdFjRbgZyi8NnG
         woHPY1nziurtqF6r5I+KJ0tK/D7YYzgfhPCxlstNN2t3c1V37cL4UuMVMeGxl9IMRRbI
         3VK3Ju1BAE78jKjIpHrvdpMKXJW1wnDjqn/x6R5Lm5Yp/7YSG7Ukt+8orWZwPJ59iahg
         B1B9X9GGGG87VB021hwhw8zUaX7bcv6kD9o5M/Sb9hfFjAQlhndjHhkIKnENz/KI5yGO
         yKULBJZale9g+HNvwiASvO6mJ47+k0dhJCDdYrdbfxikX2mraq2yualY0PH/wmhDiEkF
         Hljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788080022; x=1788684822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Xieco16JUGBtqYPcvPXgwiOrcIgYov6XOPWEyUzzGU=;
        b=SdkNj2I0AAZBff6Yr3oSfChSsjyT7T0Iz+RPTpmTKBgaQ0U/QHRz0LpFGRMhrrQKk5
         MJjCr82y13/SzOEr1ACuiLSHMNrM3ztJ0IKLa050VchyANEkU/QIg+ET/K63aqWyGzW/
         Q9Cj3C2DRy8tdhMvd55JdeQ6S3mdl3YvhTpn5YSOG4t0t2E04e0Bvml0+kL0XKlFrsbO
         KuzsuWsSjP5kQcusUK7y/ROlUUvS47oJRrTpuGyvDcGMqKLfeW9+kNvGDBfUqrTcknj0
         j74uJAmS7Tb77bMN3bOWYBXyOoKxRJXj8v2DtVxCgf4Ei2/P/Lhi3S+2MDkdhJPcr0Eo
         J96A==
X-Forwarded-Encrypted: i=1; AHgh+RrPr8YdAV6N7DXQ3ggo4DSaiWbQToYveKBoyqpUVVnHETuLdQm/Au6PN+PCa+F45HZVdwRtP9NqOIKtZng=@vger.kernel.org
X-Gm-Message-State: AFuF++nn/wlyYPpcdYkdiw4D64vPJ+kcquOjbHyG2ars9UflvsWh0+xB
	OfNiWk09AkwHyc/srHPlydZUYocjn4YM8DQfRU9wMWt+0a3uy/Zc+m5+8s4V4u2eX+19NQ==
X-Gm-Gg: AR+sD13KhzuZKkevLAFAj92QIH13YSlj8GO6z/NTd2RsGMQlhwSw6+0PP73aSRx77hR
	s2hgKrQ/hfPS5g32sxHSlqPjWRwXzE9205LqE0ErhuhLFcv8efci5STd0b/h7okYZ3Z0Wb2ucVK
	H5X3O3ptiSfsO8f/exdPP9tlImRU96Ye3SQpJsbdOdaES7f85lC19hzMRo87EzCkPoMPYQe8luG
	fRHJ7cqGFUSdmlTk5DsmTXjkOP/06LWQgz8c4AYh+PHt07xvzV0DSi5xytua3xbER2UjCTGbTlw
	yim7lCRDjXOlMEplIhcODXelUry2i9jA3mI7Y6ueBuNwR/SAKIO3Ue1w0ghGzvVXZxPc0yESTwM
	n7Ikc36yyPgQ9xfC50Qt3+V7sr9NgbZrpC/wywHBZJBhEzCbR7PokgNjjjo7bECIbtRnx+tAmYT
	ET6tehgD/h2N0odo318xepqsIddgGZXsJ0ON/v5lzurVoSNOhmMydtRhl5dGVKUhaJJElICYWZn
	XLYx5aMThinr57Ij7riJuwqMJLV
X-Received: by 2002:a17:906:730e:b0:c25:254:292e with SMTP id a640c23a62f3a-c25567a9274mr1216183466b.0.1788080021897;
        Sun, 30 Aug 2026 01:53:41 -0700 (PDT)
Received: from localhost (83-131-188-112.adsl.net.t-com.hr. [83.131.188.112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1febf3sm274995866b.52.2026.08.30.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 01:53:41 -0700 (PDT)
From: Dmitry Sinyavin <sinyavin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Dmitry Sinyavin <sinyavin@gmail.com>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: msm: select PM_OPP
Date: Sun, 30 Aug 2026 10:53:40 +0200
Message-ID: <20260830085340.2542624-1-sinyavin@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 173ebdedcd84 ("serial: msm: Use OPP table for DVFS support")
made the MSM serial driver unconditionally configure the core clock
through the OPP framework during probe.

When CONFIG_PM_OPP is disabled, devm_pm_opp_set_clkname() is a stub that
returns -EOPNOTSUPP, so every MSM serial port fails to probe. Select
PM_OPP to keep minimal configurations functional.

Fixes: 173ebdedcd84 ("serial: msm: Use OPP table for DVFS support")
Signed-off-by: Dmitry Sinyavin <sinyavin@gmail.com>
---
Tested with an ARM multi_v7_defconfig after forcing SERIAL_MSM=y and
PM_OPP=n. olddefconfig selected PM_OPP=y, and msm_serial.o built with
Clang and W=1.

 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index cf7dba473b20..bf680d22199b 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -904,6 +904,7 @@ config SERIAL_JSM
 config SERIAL_MSM
 	tristate "MSM on-chip serial port support"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select PM_OPP
 	select SERIAL_CORE
 
 config SERIAL_MSM_CONSOLE

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.53.0
