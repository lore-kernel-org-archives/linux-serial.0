Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4E370D41
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440514; cv=none; b=C/+q+tqakQEO75UPyDzPyZpsotrVBQcEMZZgb/adhza2yx4AOxV5xPE7E6JtK/0e4WbdTUqnnxKEFQXNKMuTeUtRNok2IN1tY1QNR9VPg+C/GFlgQjbKoqrYXD+it+WKBwQzd5OlfWkSVKm3m7zOcxjEHV1+pnd5rHa9CjZeVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440514; c=relaxed/simple;
	bh=ZVg9bxqPxMdWSnt3gVsmlNcem8zaoQtHe+2Osgh9lqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/3MDoeq3D61QzKxZPa8Sz6GjkBi7ClOuojBkznMmTXGuQM1pwwNm59+lRX2lkx4yLDqTIi2/OB0ybVlRSojpLL+eQMg043YGCj8YdOsbfx3CgMMh7WRRhNr8qRmlEmwMI8/Fgfj77wJ6mcouyAhTJWmffD1WOhO089Kvx3KncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaokSbxU; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaokSbxU"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d77b3455bbso220935eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440510; x=1791045310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=teOH1PedO9uc8B4td73aFmI743ZwvMaIOd8MGTSTScY=;
        b=aaokSbxUETeqcgg14lRimL4c/M4RngAb2JZihXdrLNUiT4F+AFWFAq+bCmI7/lwFYy
         XrsAwSb/M5q545gDryj6WU25SNHIfqi5mSXjXCDEDTsI2/Z0UstwREV+l2voSI3Yx465
         ixIsk6SHjFm5oAGG7bPljrXnb1VMUYrH8kF9awQEXx4smymlDAVa9JjwVPhQUXUoMApx
         SsLH9SZ5yQ026ypG6hjBHbxR0rCLxchDPUUEYCUDXQsddfuAVr5Z4ksEuIWRkJFOQRcB
         hpEA+h3UA2z/8edWIIbebs/roz6l8HMgsdhykOWhRLRMZnC9SIO8i0zVRxZ+gGubD9ER
         +Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440510; x=1791045310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=teOH1PedO9uc8B4td73aFmI743ZwvMaIOd8MGTSTScY=;
        b=b5ThXQjKEkymM08d6nqJcnMws4ZxRUni2p/iSYdylWBQv8roE0MHyBatdKq4rtFOq9
         z/S0KKjVY7OlEAR3e7MgVPN0SSIY/fOKC2gyRnP+mMhY7A+yFitEXf4ahAwPO9l1av/j
         zKR0ESvHNPwHo79U7+QNKcQyHQniMHVyKWLOyYJFzFJH85KSlMMlJxnOwUW32U415ES2
         7uUZTyIJ0ADLQTOEEadDzQJAu7ROXNhc9+cVKyeVzpFAvoudam1PRIkP6u9pqzgn7zT1
         YXmB1zC1pLNY4by4mk7nsH2HH2kgxxHPlYMYxHHAlL1mXcN4hYtYHPrq7kSvQeaiRAJ6
         eQFw==
X-Forwarded-Encrypted: i=1; AKwUvBz7s7LbGYWKg0XTiZc6rQQpO7SppYI18IQvxANm39KJ6o/g2S8oJFyC8rqvJA48T99uQBQrwrL7KPL3BLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lXCcp+U63/IoJtVZguJ9EdMJjJqmILnxYX04PNuHmzbV6zMdyb
	wekpHzhFSalB9quHJBFpqg2iVGlutgtGaqft2C8pe/e1DecSuhaLPo6coAbeCjBv
X-Gm-Gg: AYBFou2TDjjYU0hLu3suYLxJK/PWpEqsPDMLqICcdLtjlfUGl5/xMZ411xEtNb1jieH
	j12CE4obU+tIhFavZ5LeI30Eixt8Zz+DwWeAeWl7JotUXYUh+dnwj1AKejr0oBEo81MdT2j5ERX
	aqmXlDCRpy+kG7P7RWi/sQY/Nmr1N4Yq7WOSI4c+exlKsaurTTdMuMwF8YHf16P9gEELJPk+K38
	+QnVnGXF/Q64gA7ZMVGGbDgNwuUD0yxtwIN9S4EZbgz+5QWeF+hVBl8uyScDkOCi8hFqlMbWJvf
	Ba/CsJyeJBfZDP+TQaifA/CZ4z9oNjgiRW3JBHr/oUF80aBMSzGdGslFXeR02qZ7sCj1F/svxHN
	EkeK3+efxiszLCQl9JV6GtsAwBVlD64RI2sxiSnWXB+EgqWHdCMkWAi35PP02abQqKqP3me/nWb
	obkrLA9+O76tApdkKQdeOXyTnpm9cKdQtS6oqRDgK5iF+ppaSOL9Ws71W+r+QCERY80a9eM09w/
	Q/e8IP9/gw+nDIzGbsgP4mmJFuE+0w/dYwcIm52
X-Received: by 2002:a05:6820:1524:b0:6ba:1356:2038 with SMTP id 006d021491bc7-6d440eea797mr10087219eaf.65.1790440509673;
        Sat, 26 Sep 2026 09:35:09 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4933501183bsm4462176fac.5.2026.09.26.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:35:07 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: u.kleine-koenig@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] serial: 8250: Fix section mismatch with CONFIG_MODULES=n
Date: Sat, 26 Sep 2026 11:35:06 -0500
Message-ID: <20260926163506.487201-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without CONFIG_MODULES, __init_or_module means __init, so
serial8250_pnp_exit() and serial8250_hub6_exit() end up in .init.text.
They are also called from serial8250_exit(), which is __exit, and
modpost warns:

  WARNING: modpost: vmlinux: section mismatch in reference: serial8250_exit+0x2a (section: .exit.text) -> serial8250_pnp_exit (section: .init.text)

The exit code never runs in such a kernel, so nothing breaks at runtime.
But a function that is called from both __init and __exit code can't
carry either annotation, so drop it.

Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
Fixes: 4cf187f9dea9 ("serial: 8250: pnp: Annotate init and exit functions for conditional discarding")
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on tty-next bf961847813d:
    - x86_64 defconfig with MODULES=n warns for serial8250_pnp_exit(), and
      i386 defconfig with MODULES=n, ISA and SERIAL_8250_HUB6 also warns for
      serial8250_hub6_exit(). Neither warns before a300273c458c. With this
      patch both build without warnings, and so does x86_64 defconfig.
    - Both MODULES=n kernels still register ttyS0 through 8250_pnp in QEMU.

 drivers/tty/serial/8250/8250_hub6.c | 2 +-
 drivers/tty/serial/8250/8250_pnp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 4d4c54c951cb..848d9723ac56 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -54,7 +54,7 @@ int __init serial8250_hub6_init(void)
 	return platform_device_register(&hub6_device);
 }
 
-void __init_or_module serial8250_hub6_exit(void)
+void serial8250_hub6_exit(void)
 {
 	platform_device_unregister(&hub6_device);
 }
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 7decf62400ab..a6257cd6e246 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -531,7 +531,7 @@ int __init serial8250_pnp_init(void)
 	return pnp_register_driver(&serial_pnp_driver);
 }
 
-void __init_or_module serial8250_pnp_exit(void)
+void serial8250_pnp_exit(void)
 {
 	pnp_unregister_driver(&serial_pnp_driver);
 }

base-commit: bf961847813d9edcb5a9c089714069428d141fa9
-- 
2.55.0

