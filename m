Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0244BC93
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480595; cv=none; b=tNLykJdxwFgj4yoVEJ/rblCm22g2Xxq/SoSuxzki1WvIQ9w4s1KmhwTaxQhU/IP/uYzyZMTor7K/6i5vEpI/CGKCNuJw5Xv6NPbNbsnjXvabqMWSXdgfrTc9YBkewUDaPhFJ2AG63xkdZptn1FrbI7QW+bnuUy44DrV0LDVcVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480595; c=relaxed/simple;
	bh=h0GCPRfZ56Gxbea6qEAfu6YkFn6TF7RVgzes+iDvugM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6XTjw5wH/uTfEs8rSVKeVisQaoHScWBZDO99hRWpvP2huxYhY8armUNk6m35jXZjC79qjuhuCzWsnKUESWCWhTWrAN7HHxrvQuGfxDDfL2yNCEAoE/Hf+jf4DBC9J1GGZ8N0UruxAsREHdYeEBVphHcqLx93e2fcZYyduenpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ANYc6we3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ANYc6we3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso116404875e9.2
        for <linux-serial@vger.kernel.org>; Wed, 03 Jun 2026 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780480588; x=1781085388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uaAmYFcDIpEYne8PHc2ww/mb9Tv4n8AUl2bEA6Ewd1A=;
        b=ANYc6we33voJJAis1M49KWFYU+GAnXkVehYZiFfab9qf3ryIjTbLjsVmorVntPnSDw
         ZfJwlYaWVpwafnPNBdaeb8EutJ40ScaqSbppz3H9ZoiIo0/A9w1WXgw93Q3E6rWCNLW2
         NmjI1q9b/UvnE4Nvp8znkskLN7GracQHcT7UoHelg9BiPtk5CQwUKrl4JcK0SiJOyKSU
         lnogNOXw29vGtcJjKeDga0zVqaIDLnJ4dDSaBrCsnIA6RlwnbswVnR3flqgn4w4WeM+p
         xzf2hA0W737F9LEFxJ1q57nnluXte4Y+tgClcQ5BiQZrb7wignHClDWa070hyEPZMw/d
         FKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480588; x=1781085388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaAmYFcDIpEYne8PHc2ww/mb9Tv4n8AUl2bEA6Ewd1A=;
        b=NgVSUeAMXEOALPbdywqYWx5fp6GZ4GVKW0/D/Cl0LrLsqxrwJ+3m6YSsiTYY2V0tQL
         vMGhTgb2kY+2pqpMVLEVxoN5+QlDVhB2ghxhpvzD4eUxos0890yIdj/YVTg8a0FvfkCK
         6UzeC8+DL5WcVwhcu+86s+Hzm1SGffP8Ji5YdXQCNqBQrjZieblbBcixvz1uCM9rjCIN
         T/UVtFm/ZD6oq1VOKtPWBQeRDLTRE5kXBFUAlHZFCoucigBfFWGQ09mJx6zW6xYNC8uT
         ingkqx49e3mlst9C1aKqrzERG0p29bBVQbBLw+FCQ7Tw0L279F8XUr+E0yv+x9Bs3NKp
         B5KA==
X-Forwarded-Encrypted: i=1; AFNElJ9s4mcf0GQDbc/G6diC4O2wy/UZeO0XjItkkYr0kmilxjV8S+/N0EY2FuXmdNFGhD83++Lw9dojG8MBObw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIqsInR9QqkvStMmc8jPsgLtEJWacmkn59bIs7Bfy1cg5AKNL
	ZNrH3A7VZtTIOLQPUXvIC//185sl9pNIypmMQxFTWxnF0PY3ELbCWM1zIWELHc7P1aI=
X-Gm-Gg: Acq92OHNHAy4J1rOpK/vmiUorUJ2fgar+A2rozbiezE/RoAmqENs5eEtw8+YVhAbg+s
	r6uWP4DCcahNtUZP/vc+ZyNoWLWILadPgY9+lZ9eAvdJHbQ3B17PcV5uZpL3jYFXFzxTQDIxToz
	fKbriqeWn22FIi1+872BycEARhJo1oscdIWiWzu6mEO43aV8Xx9aIgnW8OpBKb8FBKZzzPqeAF2
	yCuWokCCpNH9zIc39vfeyPexAJlzkkV6efPFYSGYeb5prpRACqQRuxahfWaDTS3Ygk/Zi0lrdSG
	XFaGjGnASc6ySqUrAme2fKnj2A7Of43ZAAA0dQ3ITQiBH6jqCwIxXks3bAx4H9curq3LQn8UGTp
	S5sb/5Z23Mr70N21CFjxk62AG4520g7VkXkWuyw3d+winVAtfbkwNRJpis/I3q8Snri0u1xUmj8
	hZcmrF+ZQ3wGMrOcIVlwKDjOENEG4+rb+u
X-Received: by 2002:a05:600c:5288:b0:490:6237:521b with SMTP id 5b1f17b1804b1-490b5ed0021mr43592885e9.27.1780480587687;
        Wed, 03 Jun 2026 02:56:27 -0700 (PDT)
Received: from localhost ([90.85.134.233])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b6162289sm46455705e9.6.2026.06.03.02.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:56:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Florian Eckert <fe@dev.tdt.de>,
	=?utf-8?q?Martin_Roukala_=28n=C3=A9_Peres=29?= <martin.roukala@mupuf.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: Don't specify conflicting values to pci_device_id members
Date: Wed,  3 Jun 2026 11:56:16 +0200
Message-ID: <20260603095616.937968-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=h0GCPRfZ56Gxbea6qEAfu6YkFn6TF7RVgzes+iDvugM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqH/pAX3O/RrbBlXEAYQhu7mzHOhWwxKz/IA69c JY4vDOjjFyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCah/6QAAKCRCPgPtYfRL+ TrvmB/481bkMr0Jy484kMJNcMO6QvmZHKju5WwH474C6i+WGqlgxAFe34YOf0JM+/mgz1ExlloR BX9UVUGYuJYImdefZiR/OLhj6nNo3K2GSrVLEYSNsBiONnaO4CEAU3IJuRAVHkKiYWQ/+VNyveL 8ozTLqPo3qUHZiube7rBvgQ0N+RCYg6xRCd3XJcDogRZmBxzaeqpN9HFcYpsv3prEijT9H/wSB4 OynZnkNGphqnf16s0hzyqvpikK44KlH+aVvnucwQbcULkEjDMz/3ltWS1/m6UhLK7Qz8IOsEPh/ lEgJ+syCno3X48EKrs3r6cBAD4/kd1LvLQitdoDZv43RFdU2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The PCI_VDEVICE macro assigns 0 to .class and .class_mask to allow the
next value in the initializer to define the value for .driver_data.

So the construct

	{
		PCI_VDEVICE(INTASHIELD, 0x0D21),
		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
		.class_mask = 0xffff00,
		.driver_data = pbn_b2_4_115200,
	},

introduced in commit 44e55f1f3088 ("serial: 8250_pci: Consistently
define pci_device_ids using named initializers") has conflicting
assignments. In only some configurations (i.e. W=1 for me) that makes
the compiler unhappy.

So convert the two affected items to PCI_DEVICE which doesn't have that
hidden assigment to .class and .class_mask.

Fixes: 44e55f1f3088 ("serial: 8250_pci: Consistently define pci_device_ids using named initializers")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3e5bc9e8d269..58b4e525bdb6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5394,12 +5394,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * Brainboxes UC-260/271/701/756
 	 */
 	{
-		PCI_VDEVICE(INTASHIELD, 0x0D21),
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0D21),
 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
 		.class_mask = 0xffff00,
 		.driver_data = pbn_b2_4_115200,
 	}, {
-		PCI_VDEVICE(INTASHIELD, 0x0E34),
+		PCI_DEVICE(PCI_VENDOR_ID_INTASHIELD, 0x0E34),
 		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
 		.class_mask = 0xffff00,
 		.driver_data = pbn_b2_4_115200,

base-commit: 44e55f1f3088e4a471a943fbcf087ea7783a0199
-- 
2.47.3

