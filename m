Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601334;
	b=GC+dcak9C8l6njH2/54gkYMMYmsYInuunVYmVaCbgRcfvieYzluRBqJ/eeH+hGDL31Al
	 SVMku/8zMglavnhwjPaiIwn0J66gwnTbTEX3cVIApzdUQbYPGH2a+uCjOvcuwXnCkkIb5
	 l2fzYBPHGudlVIFvF3aYlmGVXvJzOn2RhHJpvIgMwZ7WswCXPia1kAUBz+A86GoWf2lBq
	 Dat9dTjnKbm7aNfGq24MbpYhaA6DQLh8jVNoLXVHRcgDtIgys9AJ5lpQKYYttE2rTGxWt
	 3170RsEu0OilkwKBH7ZG7sFREJRNEoBWGfSgf6HoA9gB1gm0d9Mls26ip3bLLt6g95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=pd4p9Qxa5In9+g0/BQUXMOqoumqz2LbPkIrCjX+8XUM=;
	b=LqqH0wJfbmS0jwqQ8BLuwdIKV3nZ6ZfUoH0O25wZchADxnwgURMn6Pa10mQ7SY80Kaf0
	 wlhKl43Sx+RfLZTVYnulaujG+78YdIgcnrY3YvwgKcArIXD1Y5oCK0KqdQKvozi41Oq0O
	 974FMyCN60Wy8f1EXjpVI9QlzDQRYx18U5J+8FAMR8X10IurYeA5TziUFfWw4adx/XJcN
	 xprWpSzGoYYuU2wNiUeEv85R44KklcVKe9rfgfaO4GCjwuwo2/nazjxn1jGDPQGs6bRSt
	 kPQr6s1WDGGEiDpJyQOZeScYpcH8L8+kSiTBDGuNCpIBtZY2QZ4rdgwoBjIlWNiw32g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gnXcrLC4;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A68606A331
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 10:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A68606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gnXcrLC4
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3834663f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 02:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795601332; x=1796206132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pd4p9Qxa5In9+g0/BQUXMOqoumqz2LbPkIrCjX+8XUM=;
        b=gnXcrLC4UV8y66NqdecdJRF/U3V8p6Wl0VxduYa1e2L2SFGYK2MQge7sf8kS3GwtMJ
         NWsB7iqA6pZ6BusMcetcOHELyLMVf7gEVu0lg7e2SJ7NpiicSG0QmpIa0Gw+N9iheFuC
         ieKwC+IlTydp9yU8+oaCW8+6Wc5anueeo3W9iprvK1uswp5+ZwAuYVrKpZCaaAO+NXet
         z6KMWlLbllQNTNHFUFKUsUrgkMKY+DlKPMGHGkWdm8w3/YfLhB0dWdEAsaoCowmAeoq2
         o7IhogI9+TTnlL8mA7zaj18w3VFD7xDqBUA97jwOvu9ljoECWSgdLillCwgOSWSLznxA
         Kptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601332; x=1796206132;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pd4p9Qxa5In9+g0/BQUXMOqoumqz2LbPkIrCjX+8XUM=;
        b=GGx/d8AcxlSQ/S5BLFA7iNwmtc6xj50Hy7sOyYE1N9+5y0ueM+zfunK8QVdBqOABVF
         /pcRseie49pEzS/d3McB5ZYU1++6GYteF8fzTwAibAY/eFQkh9lfbz4vfjfjdJ8fpO42
         Kl3kYU/0pLSN/plTaCB3GnGkcpxwYSyw+HsciKEWDLMaSTeGlbblOyuFzjntdkczD7W+
         YKxJLLxaU+CfuLgsAWWpvkKY9vrICCdnGybDnhKOFRHT/O1HBzHdmv5qD1cdWsu5CwQ+
         0A0d6cR0ugFyzVmwXEUkD1e6/1hkZBB8kjSX4bgGBped39bGmPBhNCKCl4spPJFY1mvw
         kLQA==
X-Forwarded-Encrypted: i=1; AL+hErFWXOoSMEc5cAWaMbUNfoYVXrdoGpQz8T7SS5cPZNqK9frPmyGywzl/4e0qpAyZ8fb6ljR3L+r/ZK+qQFs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/okJnpL7FmnX+EPto5ZJEKeEA4EPCW15z5+VP4H3JgnPSWLcVH
	hwT3LVIMaikIuw0990QxAsyYfCOIMyjky7bHwjidVAptnaBOFE4W1P6GihIVnxeaw/0VUxM4snE
	gdw9q
X-Gm-Gg: AZFdTZdSqnXyRN1vY8NErx6vOcw2pra5e7gOBjCvMV58/mJdX0YYhwn3/gbIUG4a5JW
	tl9W6txy/BtF1mu6reTunEQjAOHBBU24/WDLvIIQL30ZStCJdZTOqH4inIK4Mq1Y6vyfrB7DFJp
	Ei9m4ttfE8VrvJxHA/c4/SxqQoHKoF8Mwru58DHsPATEcK7TrlRV55OnyogANR1BCxcWtp7/0sT
	cj8oVN/mSusaXBnnEKc9YtAg6IoV8O94d1qO8pJko4TD5UWSzDWfaacsLeaFIe3MNUZXia/ACdd
	ACRHCrElLi8SSRXVbfOOAJg76kwBARgnDf9g5/M4tSZ59fbMmS/X+gHEqKPnZaiLIB80qTBpQqE
	ZGqczw3VvGwbKwCbN0TljnhBVVA9IAlwzoqYcSfh6DDjtrIS7lgyIVrml1xC3B3q8PaqKtEd9FS
	Rt8uECSLZxiUARwFH2enRD0WCXUWMJWsdFGsp7zcHsJZ9v6IWUsqxopG15ivcrGoc/92P7fIzvJ
	fwalwbCAVd+4wuJt1t6LNVKiZ0Y0OgJfuLyjan27CcSkyn5dWcacGmW3rUxYYuYlFrvhPNYH701
	DvRWtdE47zSN1x1/26yB63Q2KxFMtJrRZxZ4vhK01bGMJ72FaGNk5w0PgZcVkh4fzWPR/z1aNwI
	6cFk6O0uewtIOWtt/
X-Received: by 2002:a05:6000:298d:10b0:492:9630:6a7f with SMTP id ffacd0b85a97d-4abb5db7829mr23954805f8f.55.1795601332561;
        Wed, 25 Nov 2026 02:08:52 -0800 (PST)
Received: from localhost (p200300f65f19a9043ef7230869dfba63.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3ef7:2308:69df:ba63])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4b8e564e39asm4042375f8f.57.2026.11.25.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:08:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>,
	Joachim Knorr <joachim.knorr@ziehl-abegg.de>,
	Martin Fuzzey <martin.fuzzey@flowbird.group>,
	Luca Fresi <luca.fresi@bithiatec.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 1/2] serial: sc16is7xx: Drop usage of <linux/mod_devicetable.h>
Date: Wed, 25 Nov 2026 11:08:38 +0100
Message-ID:  <000a0bfa98500f315a49fd4780e9b4e193f12840.1795601260.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
References: <cover.1795601260.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rRCGx+2Zzp5KY20/ogaPkQ2ONt60PW1toE9sxiV9SRg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBrOo0C/aWXDpbR3nOqyoR/XeK6RdbNl+m5ieC hRpom1ZEe2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawazqAAKCRCPgPtYfRL+ ThWgCACX2nncM3OEtJ3WHAKSpeO6gklZpEAZONEEv3Y63bqfZPc8JAy3UJYQY/qIKWWhZX8zs// 8bL8Ts0v/wCdbA6zb+6cRtO298PlrqAhoV8dZqt3Y+K+MgOpdvatYQQLRzuAXmsJsEsBMuZrEql X+kH8qejifGsnIVkm0hEN+q3K9IOyV1U4VPVYdZwz1Y1XSKk573KElD7zhaoqerTFAHjYhTRW9B WbV2VYcjcc8EuV3jkb63rgY65teKFnxyMaEePJRa9S1vVbR2u9B/9ajp9RDVDqUPQsJi8JKlbLj Ufn5Sewx2YCOLmeC6MG0OLVNe+J9YM+Aa13X0oWQCCt/6NvY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

drivers/tty/serial/sc16is7xx.h only used of_device_id from the various
structures provided transitively by <linux/mod_devicetable.h>.

The consumers of drivers/tty/serial/sc16is7xx.h (i.e.
drivers/tty/serial/sc16is7xx{,_i2c,_spi}.c) only use of_device_id,
i2c_device_id and spi_device_id. The latter two are already provided by
<linux/i2c.h> and <linux/spi/spi.h> respectively. So it's enough to
replace the broad #include by <linux/device-id/of.h> in the header.

This reduces the amount of transitively included headers (and thus
useless build dependencies) a lot. (Supporting statistics on top of
next-20261124 for an x86_64 allmodconfig build:

	before:
	$ wc -l drivers/tty/serial/sc16is7xx.i drivers/tty/serial/.sc16is7xx.o.cmd
	  71313 drivers/tty/serial/sc16is7xx.i
	   1387 drivers/tty/serial/.sc16is7xx.o.cmd

	after:
	$ wc -l drivers/tty/serial/sc16is7xx.i drivers/tty/serial/.sc16is7xx.o.cmd
	  70392 drivers/tty/serial/sc16is7xx.i
	   1330 drivers/tty/serial/.sc16is7xx.o.cmd
)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/sc16is7xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
index 9c584d6d3593..fb3b23ae2aff 100644
--- a/drivers/tty/serial/sc16is7xx.h
+++ b/drivers/tty/serial/sc16is7xx.h
@@ -4,7 +4,7 @@
 #ifndef _SC16IS7XX_H_
 #define _SC16IS7XX_H_
 
-#include <linux/mod_devicetable.h>
+#include <linux/device-id/of.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
-- 
2.47.3

