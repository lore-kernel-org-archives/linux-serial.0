Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810031E823
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444002; cv=none; b=mXFkfk3E/MKsmUQNvKC/ptggProBDyJ6V6tGr0DjvsXnSYlG4q1Vkkuz1e0pDWsJDOK3O0nwcDwttZPt6+6njPsfhRObxKdfpFbWHnsSfPWgoR3cQriO+ZRR3wu+/W6iXx2rbMClml2DoMXNLANAbyNeLIrh0MHkYlp4i9nkQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444002; c=relaxed/simple;
	bh=qjlZJ639bP4madGVmc2k1ZgbLWYVq7n6GdvWsoP1Veo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njOwF1vnZxyxYYzGxxQ3VLj2GtEyieuAEHcLkBVafH/R6ZstRPyPclx5uHNb/uyrgxR2s4yw0xZffze9TBJe1ec826i9PXP5TfB6khcI4I3JpLyMSRJOjxrglurYIC9OuNNunkS5YiT85Nbc/DpioeamyVsnUYXAXVYHIQWh3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pyubcm4Y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyubcm4Y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so3951075e9.0
        for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790443998; x=1791048798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=paso3MHh8XUGJdfP/nJDVx+gtPLafb5aKnJ/gNlnGsk=;
        b=Pyubcm4YIY+aDJXWA6Cqq5iehVgJmKHC4f0kCxJw2HKChLvKHzwigGm8vmmSXSJGAp
         hYzBtV4Txms39gUuvLgd6r9auiWQGe/WPfyFfhI/+QgVZhufh9Hkn1a8i3+qU/ojI4qS
         2YD3WdO34hBNgbRWNIhFMWkmr38EYzsScwvEL5aB0bOy1lBTxLrpDNhf3S70SdgZg1mk
         srmFl92EJHhzVx+WgzJLpZA6QjtLvTSh45J3/2AAcu/Aeb7wESqxJnHb6+lqgTu208DC
         Gzug7vLcszZldEtT2+viT+RQdx/nH1w3JoKCLn/CWMT2SvSv4JJu2dbbSN4DHveg9VSA
         URtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790443998; x=1791048798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=paso3MHh8XUGJdfP/nJDVx+gtPLafb5aKnJ/gNlnGsk=;
        b=rXjadXmNyZbTKrqmnt2PKI++2kgOW77jscF57bEWJZHePvnr+Bl7183jKL3DHqH+8D
         pp3rE1uJMIOxC61G235UXFIwbOWFfVejRWWWwvSRcCX239SMzLg3d42qBItbDrynvwbI
         SVkYK/k+jdiH4pbmbAKxc7bmYiIwoL13iZEHuRqAk06mhhntT9OQbiIHC2wqUb3HWX+V
         WHucaqsiDbiHkPq6bSuf0PNEUiKWuBC/Z3G3qX6UHZspl52TZY7o7R2qVrsTCaOakqqx
         ff3ofoloilQYDg2sXfdlLB5lui/4zrWE+XU+b8KMrrXFEH7+9zHSIV1CwParMA7bK7NB
         3qZw==
X-Forwarded-Encrypted: i=1; AKwUvBxDNb7ztSoaevhfdAH27e0Cwz0xBMyhE7WlEvbLuXUUXCXE3m0QPMihVqOwXx27vsRVHGryibE7bJhtm9g=@vger.kernel.org
X-Gm-Message-State: AFuF++m1ysNzladEzvID64Pjj1ypmlRLY9CXKs8wNITXxoLQJ7ZlIkAI
	GmgUfePxOMTyN6Knun2IvOE7CEh3S60xowHQeANHUsO+cWMoXEQfcf0A
X-Gm-Gg: AYBFou1KLoKd4T3FrDIPIDx/x/hgKS2o0JcT1XEfYBqvzfmmmZRqUkTCqgWVvfYEA47
	JVosu8bCrR3AEm3rsyOqJjyJEXg+NtujLrqz7pWg9eldQphh8pu2Z3/EAxZQL94CaAffnkbrqt+
	Dx0HmUIoC74fuL1+oLR03HZspdEPAylRrlp5tz3gMATzLBjdtyUqi7aDH0Yj8Ky0qTFMzXsamXx
	//V+JwMKwjJkYHEWUGhVPpfUFO3/x0XfTolWsEs/FZrlGM9/TcLjBWMGyH7Gjg+9YSYeLMe/BAj
	H9nFa+0gDGmehdK8enns4ff++F9CZK1vgiCjJ0XPkoGKjVbr45hhParQVjjds7nFeUxfcGjvY6S
	MJgGMNlZGTCKKZt6A9+qEFoQWZ8YArcLQ2jjjNBuKXQn84pJdb0hPJ85V0KJt4UGR2mO2+N0b9N
	LMhv6HgkvhbMOzfpGJJc+f7uG7kAyHkLC1BxGWSgyNdSteIR83F25Jh57mpypM5BwCpl0qKwImM
	UUMsre/m0J6qws8dqSiROhjdwHoEKnQlW9SK9rLjkdTgo1I4nGTHEGR2cC9+05DMAw=
X-Received: by 2002:a05:600c:1389:b0:49f:dcc8:c735 with SMTP id 5b1f17b1804b1-49fe66f4c7dmr153040265e9.18.1790443998088;
        Sat, 26 Sep 2026 10:33:18 -0700 (PDT)
Received: from moosama76.. ([102.44.245.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de4de4sm246200495e9.8.2026.09.26.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:33:17 -0700 (PDT)
From: Mohamed Osama <mohamed.osama189110@gmail.com>
To: ojeda@kernel.org
Cc: boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	longman@redhat.com,
	lyude@redhat.com,
	linux-block@vger.kernel.org,
	linux-serial@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] rust: add DropGuard
Date: Sat, 26 Sep 2026 20:33:10 +0300
Message-ID: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Rust kernel DropGuard API and migrate the existing ScopeGuard
users in the block, serdev, and locking code.

DropGuard runs a FnOnce callback when dropped and provides dismiss() to
take ownership of the wrapped value without running the cleanup callback.

Changes since v2:
- Clarified why DropGuard is added alongside the existing ScopeGuard.
- Fixed the core imports in mem.rs to follow the Rust kernel import style.

The series was previously tested with:
- make LLVM=1 rustfmtcheck
- make LLVM=1 rustdoc
- make LLVM=1 -j$(nproc)
- git diff --check
- scripts/checkpatch.pl

The changes in v3 are limited to the import style and commit-message
clarification.

Mohamed Osama (5):
  rust: add DropGuard KUnit test configuration
  rust: mem: add DropGuard
  rust: block: gen_disk: use DropGuard
  rust: serdev: use DropGuard
  rust: sync: lock: use DropGuard

 rust/kernel/Kconfig.test         |  10 +++
 rust/kernel/block/mq/gen_disk.rs |  11 +--
 rust/kernel/mem.rs               | 121 +++++++++++++++++++++++++++++++
 rust/kernel/serdev.rs            |  10 +--
 rust/kernel/sync/lock.rs         |   5 +-
 5 files changed, 144 insertions(+), 13 deletions(-)

-- 
2.43.0

