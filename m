Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5122563;
	Sat,  5 Apr 2025 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743827960; cv=none; b=Cyhk15yO1P9ZeZbS1kp/kQYf6Dw4DbsQa1uuex7piIE55Mg+JzeyRcD5e0wkFjt8POb1XwnhnosGs+9UrEexupGRUnRNrii+iSQWy8+hZFukTQqErsrHYyajwV7zDH6K5o9EAvJAJqr1ySE3twqpTOJTrkuoNxU9BNsaErQFUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743827960; c=relaxed/simple;
	bh=wmOMCCnjvhHX3NGqHSnd6OWKOA85b9D/AlIdrZZnjlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxF1Svkf1vOAXejUI8zg6PQDpVz7Ipaw9Wqxt/wmU69gPd3AwvsA+O2nYxTinhszI5sFT/J1U8yQtlK3HVyAQl4hnixpev6evBo5Bez9dOvyrUldYsNZLwZjdyKGv5MZZY5PSMZwoIm7ueU/YkJcXCaxlqGeSDdCKiHW5+fATyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6LCAkYu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6LCAkYu"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af589091049so1801283a12.1;
        Fri, 04 Apr 2025 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743827957; x=1744432757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrWZGwWQGkVkJ73F/kcmRnf0IHKJhsNVWipXcUGTA3M=;
        b=h6LCAkYurP3sA+NFHU+eoc8IKfpo1MwizX4NZKRb9g1GnD6MnjbM+SjgMi2AqhG+zR
         05CVdTSicWN5nzGiDTsO8ncvP40z7h7BLc+BEiqSz2OQbaR3LEYkw49dJddxNcArmEv+
         AK+myhVovcRi6nLylLHg4lFUYgXmPQuB2Y1OU24Xi6OgiAr5S9EySYIwzfonokjfardq
         7I8/t+bK8Hx+y9CH9dWTBGy08fo5xuDXkMHZGOJltMbUqsSf1WkvDDyets0NpIhoENVe
         d4Q15NUbGmI87DbHBxx3Tv2Tb62/yReWAV8CiIoL95SPfi46mor+fKy9SsTIx81pS3S1
         CM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743827957; x=1744432757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrWZGwWQGkVkJ73F/kcmRnf0IHKJhsNVWipXcUGTA3M=;
        b=AVqYplXIgYyJr3M5EzRPDObzztgLFp5jTNEfWbHY5SDXRWuvzqgI2M8Ymr72vPXyjh
         yHdEjWnLp7lLvnt1CQvluIgM2l8CgusdFuofL+sR8DlqgM3i0fn5CI5Z2Z/pvgN32E+5
         VoFEljJzAktmlarN7lwqNsZJz5r8FOtP4aa0NWGTFKL7alrYGh76DOh6TRgcoHwsQknn
         HY/g/MJ08ROrDCSCQ7ONTLup4m7ro0L3FfkGEHkTHXtju8F0nmfFpL2MD1KF8BVN+/KI
         AsrwRmuVFNkziwcEQj5zBPAtPdvI7wdBK50SqCYNWRp8BpRMXA9/cFc0Y+8XUlKURZeo
         8NMg==
X-Forwarded-Encrypted: i=1; AJvYcCXmTdpyFw5yCVnroeZ5DrcFBtO7Rovz6jSvLxfjvVFAPFX9a90OlI0ep/hnhcPt2hFQyGyf1QHvixbLZl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1CT9U1K9A3Q7A+/AsCsarMpemVEyODu6wOlJGHDo4sDTna4R
	QuZ/rrEGPRYtgY0DBZPv1WbReJ5AiMW7OrmzvDr6c9S5qaey1uvT
X-Gm-Gg: ASbGncuwvbE3VN9odL5Qy4/0vj6l2wFQvyjVr8UspmhRpL1j1/M5gTzRkFkh82cGaDS
	UP67ohjKeTOXLlVqimUP/yyYuUjsjMwuVvzhO3X1Bs0OxftJUu3ihufNLhoxuzS0sV5RbtV0Bxb
	Ld/5Br/SjKJztE53vGu7eePu+ePJmMEpvYcOP6yzzxouj/Fswp3+VcveF8EYocKMrBbWOLAWVxR
	Cy0bVgu5FKZvG3TQWghvAJ9bUC3+iWBJHDJWfRtsd9DWRjOE/QPeXpkRGImCfCFB9Hm2CUoMVb3
	jr9CvrHXiliBH9ROTxT9BJKT6tUYXH5OvGN8I36mKULNhnu7/NFSNLS7+dVIIQX7iSmnBXLmfze
	qFFrXoxEuHRNLB3LYjjmhW2HnM3vPxek=
X-Google-Smtp-Source: AGHT+IHVf1Jyf2BIztCcwsxW1K4NHjTJ2Z2WJWU7kqHEvmpDKO53+ZaFJC/SwIG7i3Th3My/VqCZfg==
X-Received: by 2002:a17:903:1209:b0:224:76f:9e4a with SMTP id d9443c01a7336-22a8a05b5cdmr77779355ad.14.1743827957269;
        Fri, 04 Apr 2025 21:39:17 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978771190sm41441795ad.211.2025.04.04.21.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 21:39:16 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v4 0/2] serial: sifive: Convert sifive console to nbcon
Date: Sat,  5 Apr 2025 13:38:33 +0900
Message-Id: <20250405043833.397020-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is v4 of series converting sifive console to nbcon.

The first patch fixes the issue which was pointed out by John [0] 
that the driver has been accessing SIFIVE_SERIAL_IE_OFFS register 
on its ->startup() and ->shutdown() without port lock synchronization 
against ->write().

The fix on the first patch still applies to the second patch which 
converts the console to nbcon as ->write_thread() holds port lock
and ->write_atomic() checks for the console ownership.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/84sen2fo4b.fsf@jogness.linutronix.de/

---

Changes since v1:
[1] https://lore.kernel.org/lkml/20250323060603.388621-1-ryotkkr98@gmail.com/

- Thank you John for the feedback!
- Add a patch for synchronizing startup()/shutdown() vs write(). 
- Add <Reviewed-by> by John.

Changes since v2:
[2] https://lore.kernel.org/all/20250330003058.386447-1-ryotkkr98@gmail.com/ 

- Add Cc stable for the first patch.

Changes since v3:
[3] https://lore.kernel.org/all/20250330110957.392460-1-ryotkkr98@gmail.com/

- Avoid using return statement on return-void function. Thanks Sebastian 
  for pointing out!

---

Ryo Takakura (2):
  serial: sifive: lock port in startup()/shutdown() callbacks
  serial: sifive: Switch to nbcon console

 drivers/tty/serial/sifive.c | 93 +++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

-- 
2.34.1

