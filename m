Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBF155316;
	Sat,  7 Sep 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707691; cv=none; b=duaU0+pg1L8eZBSJ4n8rRldxTfpHa9KaLkYzWHj8jua9orBms/xYmf3+YaYlbPsLcglbzwwvANQ//kFu37p2omvAli64xuXdV06D8X9OFzg6IufzxlNZDne8C6PbyTIdpmB2i8IbhwxY/cTJK7dm5LEEZF82jQBF/xfgIIGKJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707691; c=relaxed/simple;
	bh=CMbPPbLNgy/m8UF1G8Q+fRyhtoggVjJ/GN50xwDHbGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mab9wN6w9PuzTWNDcVM0HLpRtikZBOuie5B/m3HS9EzAVPzscG7jSWnDKjsSd1ZFgYyjaUKz5+xQY/UGVYf3KWfvbckFM8kxzX61NJYkdyNigyLOCVlbTtJy6zNPaBLlfI/KokpaaPs5djeaayj/8+Q1wepP0qpxcT7cWI3K8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRr8CeNa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRr8CeNa"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso1367577b3a.3;
        Sat, 07 Sep 2024 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725707689; x=1726312489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKR2MN+/NUaZxZIfTkNVZ56kkqFXX80mnZeMHh4iTEs=;
        b=iRr8CeNaoOR8dj3HzgQyZByGs2A7so0F9rRToCZrxoZtXxVoix0xSTGAkWPHtsRnyK
         bWtsh6Zsjm5RtNUuHjClw6rMHOvQn+hfNUjhOQH0I1n4mFzMK9ABOeiLgR+acsJ51FZr
         iKjutqpM6kOOpEoBfoGvMdcT8M12BFU+jdj2V4jO/oLo/LEYE71TxdD9Lm8YcVuXjvsw
         EGv01EPOb6/tf5ex6F+FF3eiUj6+U1SGEUKhP/JdYvG2IyZWldXRRDu++QXfaUDG4ptS
         xIQVsP5Sd7sOB7W0PzbkuReO6ACwUJ3wkcuPNqd5kteBURgN60L2fuPFNJT/AWE5hD4N
         OolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725707689; x=1726312489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKR2MN+/NUaZxZIfTkNVZ56kkqFXX80mnZeMHh4iTEs=;
        b=HIyZJDGHUsGnqo7QvxM9YPnEK4Ts8KK6Piit89DHemb8kp9BrHQrNTSXaCfK7ZTuD1
         WP4yb33vzOTtroPq7sJT20Pz2fhHp+RURLpEA3icOAz5Zsz/c3ctBxp7ESgr5zXzU3aU
         oB5pIqqsTkAEUWWMaTbD5m8SBhK9oyiQOKT34yQFK2aqXieLEVth1xK94YmtWk9uQ0b+
         1iagdgHcBWVN+5dQsPsLCPWUpkZY8W2gsp4wuQZhIs7wEr1KGW/ffzKhaQsTKOnGwbMS
         cj9nicOgE9b6DW3zJi6BRTHwuDreIwRATwqSFSoOpP33D+pNsNWgX4MS9Xm4j0/1Uv5/
         og4A==
X-Forwarded-Encrypted: i=1; AJvYcCUWr41Oz1QWZ6HKW8eiV9BY9H/Pv3pLcKxgDn7YD24mKrrEcaQiPyOZOUhrFFxaMvmdfwV77NE+1/HNdci5@vger.kernel.org, AJvYcCWiXPLmwQpmEEZVyi8ia/OjgkjREEiuamC2qXdZfWry8SNBmj3as7ZE4eBbg1pCQvVpcYOWflQ+mWV9Gi4=@vger.kernel.org, AJvYcCWudk2k/oQC2Ph79nhVSMiiKkT+8frYt5wAHro5tRTRe8tCTLCXTskpruKzy7MyQsE/1oGhWtagnTRLzpPVRh3LMJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KdGF3W0nd1bvJJqSxGCljGHz2JUcNC/6OmnTs8Wi/fdxOKGq
	61mbUEcZBpUs/JsACbzPd1P3cU/KIqTW+U292XQ7CPMdhwVZwzoQ
X-Google-Smtp-Source: AGHT+IEVgpMhIznnZffwI8DGtxdM5a4u1Tgb2XXQnWibOIoCrdJztBLvI3V7Zkjt9HqU+ZMPtzePiQ==
X-Received: by 2002:a17:903:124d:b0:206:99a8:526c with SMTP id d9443c01a7336-2070c196865mr33981715ad.41.1725707689216;
        Sat, 07 Sep 2024 04:14:49 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710e1addbsm7186955ad.58.2024.09.07.04.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 04:14:48 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/2] tty: serial: samsung: Serial fixes for Apple A7-A11 SoCs
Date: Sat,  7 Sep 2024 19:06:43 +0800
Message-ID: <20240907111431.2970-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes issues with serial on A7-A11 SoCs. The changes do not
seem to affect existing M1 and up users so they can be applied
unconditionally.

Firstly, these SoCs require 32-bit writes on the serial port. This only
manifested in earlycon as reg-io-width in device tree is consulted for
normal serial writes.

Secondly, A7-A9 SoCs seems to use different bits for RXTO and RXTO
enable. Accessing these bits in addition to the original RXTO and RXTO
enable bits will allow serial rx to work correctly on those SoCs.

Nick Chan

---

Nick Chan (2):
  tty: serial: samsung: Fix A7-A11 serial earlycon SError
  tty: serial: samsung: Fix serial rx on Apple A7-A9

 drivers/tty/serial/samsung_tty.c | 23 ++++++++++++++++-------
 include/linux/serial_s3c.h       | 18 +++++++++++-------
 2 files changed, 27 insertions(+), 14 deletions(-)


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0

