Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431752BE7DF;
	Wed,  6 Aug 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511018; cv=none; b=pCOvNsSGsBdav93lMvO/RXUCQZX+/SUBVNF3lN630CN/8QPJCd4yqvDOnQhIDi7s+GMg+IQXBOC1ppQzLChaJ4qNlg0PLATJadCmwnXnwA3376hemHPw5L3UjEeAFYYZru1zgDMaHJ5fp6oTU6KCHMOA7ZfXnhwkrr/1HljZBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511018; c=relaxed/simple;
	bh=2xHMqZHIMPlKDA6tesGYp0kgcpqBPjYtPnsFUve+6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtnkGTLyTW1XKUgZWwcroMNt22Pni+k2fccmv/E1yW9j+MRK30HjPAfMQvcy7zkQjB2exHimNiuxp37GxvJg4MDue/AHqskhcBKehOYVzRcbB4zaPYt9Jmz5hKOq6G6DVIGhpCD5G7XP7gZneZQJo3CuBWZvpovLQsGqISrWSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le9bHgYr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le9bHgYr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bdea88e12so348155b3a.0;
        Wed, 06 Aug 2025 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754511015; x=1755115815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I//q3akbwLjNiQDpnbN4pvpbNnx0BFWvRrJA19wLk5Y=;
        b=Le9bHgYrukcBWSuo6dJ+IhI5lPG37P6AwU+RUjKeI4A+EpjkjCk2aJhcHh6LG6Zxch
         x1ZHfMNqfkhbWwLatgaK8X0OOh1EFc6AUF2x6WLWDtiLjIOGu2qnMbAJ5RLGhVGd2QCR
         gSlXaSC6h55rN4FDlbYcpiR+M7kQPW+gFLpn3EwQmIGYuUK0UtRCbT7SOD3VHh+3zKoi
         mpLnWloLD0IDTTxH2XX0mte4jixbDwMCN4+4z1MijGA/6thgolkiluzpSTPpXPY2ItW+
         S4F6wFuPIS48GM+5py+kamswLw58fBNFxtLyCBIU5VOH9Iw3ULLEbFDFjCQ4wbxMn+sE
         3pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511015; x=1755115815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I//q3akbwLjNiQDpnbN4pvpbNnx0BFWvRrJA19wLk5Y=;
        b=Ooo4VI/XdC0WXxiZrgYi62QrhqYtL0vAJnXsciRnTA46MNbmN52kiIQWpkgtF3+z2Z
         UuUQ1gyX7xqeLv763PAHgHbvBQARwKNJfBLNgxckUesz7zVyUEasQDAbSS7C79aoRK3Q
         JowSYyOsSbhmtYGhDdr892PdavmK9UyOK+Rb8p/MF2bozZ3M++LuBOIAR+Ba+IHlKWb/
         zE0cvwUnjkj8x6kc+xW+USyYIQ46ssF1RgqLaUAJqC7Hxw8xNGJxuAVyBkZ4/jzlv1Lg
         s5V3vvRg11IKswhmEaOwczygU6PUaklTLDc/7G7Y9IUaoPIcOBut/A0xUnJ1b66y/zs2
         HSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU69r6R9BopM2nsCeoKIouA0SBCcgXLdWT18x7BJ5NkJepuBV+YmSa7TxU1ax2Scnd6TuxR/iC9kP+/RCI=@vger.kernel.org, AJvYcCWtyf4c5YOpjJ2iZo0e3iM5KJjUWwiF6i6Rpdslh9n461OV/gsnjd+0j7GHU1mQe/fJSBi0Ju7hbNNp8wGr@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqEqYhmaloh1xB6kqfdd41C01v0Zh0xy8uvnfzYM72a2QV3nD
	fQ3fd0HHYAkZn7+eesYPer1lyJYCOqtMVdxxmDpGyKShIay4PZUmOjGR
X-Gm-Gg: ASbGncuS+8tzP6o1BRdXm+MCkqFW38dkLOLB+hn4axTa2m5bf+OSvkVV+0zrXn0c/pz
	UCOpZUssRGHDmym1O+yA2umafMXiUV9+ACYbaTRbQ6lxujApZ3wgSIClqI2oubE5kO+EzieA4Jf
	LKyy1YRhJH6RpAwW2Qxg9KaZfzwJTD0PFF1bZoMuMW/PrZXXfYhwS0cra/d71QBmT5iHy/yZ5wa
	J0it2dla8R+tkCMjc788xN4bv2CqDFUkBU19b1k3SxLaHX6MF/LzhzkttyvCHuaNPynpE/DPTaM
	CrPSkcH4hfth6w32bvpMmA0oR7JXvmmhPm1l90YG/T4z/13jddC6/dM8jO+6D8AOcrKPnz53354
	xMHNqoiLEW6P9sG3btBD9LmEwTh1lDU5j
X-Google-Smtp-Source: AGHT+IFQvGVbKKCncF6pknXFqDydGZ0JLthM7aDbn/oIytpA2C7vZoA/ShGZDgr+69MFzx2TufndnA==
X-Received: by 2002:a05:6a00:3d53:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-76c3881990fmr458664b3a.7.1754511015521;
        Wed, 06 Aug 2025 13:10:15 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c397b87d5sm38882b3a.96.2025.08.06.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:10:15 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: abinashsinghlalotra@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	sunilvl@ventanamicro.com,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v2 0/2] serial: 8250_platform: Reduce stack usage in probe functions
Date: Thu,  7 Aug 2025 01:40:45 +0530
Message-ID: <20250806201047.754240-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
References: <aJKDp1LBpzswp5lX@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I’m very happy and grateful to receive such valuable feedback and
support from you all.I’ve carefully reviewed the comments and
have applied the suggested changes in this v2 series.
Please let me know if there is anything else I can
improve or correct further. I truly appreciate your
time and guidance.

Changes in v2:
- Use kzalloc() instead of kmalloc() + memset()
- Removed unnecessary NULL initialization
- Fixed include ordering
- Improved subject line clarity

Thank you very much !

Best regards,
Abinash

Abinash Singh (2):
  serial: 8250_platform: Reduce stack usage in serial8250_probe_acpi()
  serial: 8250_platform: Reduce stack usage in
    serial8250_probe_platform()

 drivers/tty/serial/8250/8250_platform.c | 87 +++++++++++++------------
 1 file changed, 46 insertions(+), 41 deletions(-)

-- 
2.50.1

