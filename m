Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910844582C9
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699197; cv=none; b=DjdvIGc8GwmtLSzC1RQ8OEHaxwI8SKgnq0L6+WOoN9UcQhwQ6ImQbr64oyhpibGm9j9UrzENw6hflUe1NCR47PN/bc+q4RFWbOr3h7pqcEyX9Ay3r+elimz9SY3JxVEabn1hm0XaAsH3E/xl6VAxop9384NoSo5ylBHOQ/0720I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699197; c=relaxed/simple;
	bh=5KIERkDO+HlhHSdvzBGvTr9FjN7MIY3k2P/iCYcBWwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LzMTylWpOJs8puf3PtDt3SHXAfFI2YXlsws6u8sslLB1tNF+6+3JP/cSbOHj2hT3JNtd7mWyBx5IMoCHY8cGqrufcT44xAADGEI85JHNzc8H68yFuO08zLCjx/X8ilb9N6eBtv+7eanKdIXRxvKwESQtLtRigoEIuj9HPblJX4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Esk6nkF6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Esk6nkF6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so495616f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786699193; x=1787303993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJiEsb6zIhgbWZRrYo4J9Gyf65qzWC2WnyItBGhEY6s=;
        b=Esk6nkF6NIffjtTR1ukV3HELEBR7YILLk+fG7WBRAMoQm+on4LKVTqxERGwdpaS72J
         fpDdM1GJ2HKtfBw88bhYcPuy32EdZsVX2UkdSVOFUNkud9CLoqoMCyfM7xykN68T8gGC
         LGZ1DviVA56TfRtpOiZj19gu2RZnE/DK8Xjctq1i6GzykHQQ9lhEg4g+ocW39YgB2dpr
         6TAY7WFwyL7y5oOmO/FsvNp9mMJLQsX/hBcj6FU3jf94Yg2WVsqiV77f/LJMx6GMAlk9
         q/7bk1g0IU1CbfnlsojbfSL+YUDL4DJWykgYMdkb5ZCfwI47IRsbW1WYvs+ZzHi9FQWW
         KmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699193; x=1787303993;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJiEsb6zIhgbWZRrYo4J9Gyf65qzWC2WnyItBGhEY6s=;
        b=lPa4y1UaNR3H26VRIQivR+9ko/xq2TatWsKRCKDROAageiTG8wlLqW7TM7p8fAKItD
         679SKpPpus/45h5TAvqSxt6XuOzxs1Ng+Wzw+UQxpLVFozrSQpuy5jUMu2e/oyCJ08zd
         cAuYIKxvBvsUQgmi2/HkujCf8134CCXZIg53sxxVi60//EEWMTLXH081oMqwF0UKNBs4
         +yc7gLxMN6ekLVgIfrO8O4tSOdzd9bkQrR01muH/EuA+cAH7vpOAgEp871E4Y7WPZNa4
         5EwUsmJQe8enISREBxcK6vQ8H4UmCH8twxhuhUsUhReKiHAOROyeZB/mxyVjfraE0ApX
         HvJg==
X-Forwarded-Encrypted: i=1; AHgh+RphQ+xlLxQXeHmlgAw06pOmH/a2tj+Dq5XHp6A0tmpMu5jErid5drzqbOCZurVqQ5Ub7C5PpPyGz/dyQ3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQC9lwKutZvXTngP4trx7WgvH5Jh2Wgbm4mgOLlIYs/HWRsxi
	hjV6txLgT+nLVCVVvvkOvydwIT5KHrZObia1/W+uaHQj99U2Y/5MdBAT91ePDrJZB8U=
X-Gm-Gg: AR+sD13JVhCQ7Jzr24rRUvPEhI7OWmyGrJr1PH+yigkoQvzNVDG1M42RrwVoVhd2wcD
	vUUrbfMRlRw0rnYDOykPvOpgYxytu7OzcmkjPz1CtfRGQoWQy/CFs2RD1CNP5nhFYg/jxIgCBNv
	lnC0iMCxlUkN0KUD9dnAxjZ5As0ppJ9oy7cwLxQD2Ept9EKUUhxROzjIoTlMJKyZsvyBaqyUz8S
	1zWgX0FTDnRxOHYkjbDDMLVU2VX0FHKcwHLYeJMG2hcdPEwsjTRkR3kikTTClLKKeV15h9/asqw
	DQdkEG0RLLgwI+B8e9GGgv/iHNCI7Z1q4fHIGZ/0QKwO724zZE9RuCF/eXMf7Rlx+hZ20KhwMfl
	JwPl+p3lufoIdaUbT0UXgvfiA0XCi6hjvtp5b2c4nbNWfowrDWYPWQ+uwxn7BQ+I476tQkPXIv/
	R/LY//b6aFzssu9U8625nyYWkQ/DIv4CR6+Mt2U/eLM8xNBuM1BiDXSpOqyJpLFbZ9dnv7NZe6k
	7jqDVLrsIlwSiA/v4ZDhth+vO2B1HZWEKJUACntSGPrD/4iz0HiiH12BrB3YwQ=
X-Received: by 2002:a05:600c:810a:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-49987985df1mr52566375e9.15.1786699192794;
        Fri, 14 Aug 2026 02:19:52 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4815f2c6115sm6509725f8f.32.2026.08.14.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:19:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-doc@vger.kernel.org,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Abinash Singh <abinashsinghlalotra@gmail.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	Kees Cook <kees@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <eg@keba.com>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 0/7] serial: Some yak shaving
Date: Fri, 14 Aug 2026 11:19:26 +0200
Message-ID: <cover.1786697789.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5KIERkDO+HlhHSdvzBGvTr9FjN7MIY3k2P/iCYcBWwk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqy6uwvKU78ZJU2aWHKqfH/97lb2LQwyex5Wip6zYdye1 cAvk3y9k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJbIpm/6dyqDs4fuZn7z1T Obvce+7rGFpUbJi6SD+1hPNXdoeV+jThWXvkvM6p31tzatYxvqzceT9l3RlMmFsfx5mzqH6r8HL QuNl7UOtcxfTYZo5Fzcaih/42Fe+3Pnut60/pnu1SrOzeNw+8WS12Zt8tdakHwY9NdE3Cvqcv+/ zTRXCTsoZmtq+oxUFzb+9lOs0eQVKrzafJdtRsXJ/Yde2JWELj2gPmLI5nnbhnWTLXqMo9FJk46 dHPxssTo64qV71lXHTOyTG1I2Df+qBslWMhPbb3p13j4XerXppmIyIl4NB4v3aieeYPV6fXFi+K DrzT1n7eZ7G4gt1PbMZ0ofqXG1Oi3R/OmGxu8vDBfJM5AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

v2 of this series can be found at
https://lore.kernel.org/linux-serial/cover.1785832297.git.u.kleine-koenig@baylibre.com
. Changes since then:

 - Drop "serial: txx9: Simplify knowing that .iotype is always
   UPIO_PORT" as the assumption that .iotype is always UPIO_PORT proved
   to be wrong. Thanks to Atsushi Nemoto and Geert Uytterhoeven for
   finding and proving that.
 - Reworked commit log of "serial: txx9: Drop usage of
   uart_match_port()" and add a code comment to justify the comparison.
 - Fix a build issue in "serial: 8250: hub6: Add cleanup code"
 - Added tags received in v2. Andy liked the v2 series in reply to the
   cover letter. I applied his Ack to all patches but "serial: txx9:
   Drop usage of uart_match_port()" as this changed. I would expect he
   agrees to this patch, too, but I'm conservative here.
 - (trivially) rebase to yesterday's next
 - Drop Alan Cox from Cc:, fix email address for Russell King

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (7):
  serial: txx9: Drop noop probe function and dangerous remove callback
  serial: txx9: Drop usage of uart_match_port()
  serial: 8250: Make uart_match_port() a 8250 specific function
  serial: 8250: Simplify serial8250_match_port()
  serial: 8250: Fix corner case for port matching
  serial: 8250: hub6: Add cleanup code
  serial: 8250: pnp: Annotate init and exit functions for conditional
    discarding

 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/8250/8250.h             | 10 +++-
 drivers/tty/serial/8250/8250_core.c        | 25 ++++++++-
 drivers/tty/serial/8250/8250_hub6.c        | 11 ++--
 drivers/tty/serial/8250/8250_platform.c    |  9 +++-
 drivers/tty/serial/8250/8250_pnp.c         |  4 +-
 drivers/tty/serial/8250/Kconfig            |  4 +-
 drivers/tty/serial/8250/Makefile           |  2 +-
 drivers/tty/serial/serial_core.c           | 27 ----------
 drivers/tty/serial/serial_txx9.c           | 62 ++++------------------
 include/linux/serial_core.h                |  2 -
 11 files changed, 61 insertions(+), 97 deletions(-)


base-commit: 2697ef8943c9985c14708a6429e21812693857b2
-- 
2.55.0.11.g153666a7d9bb

