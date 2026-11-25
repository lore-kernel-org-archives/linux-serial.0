Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631348;
	b=Ntr1Y/4l4lfBLwgauxtxPJ4KbFvL66sfMmIfYf9hW6eSemUZJh4X0CZ97hlXm6FzaGGv
	 0x7ls9P9BTAJuH67MgRO/yFEsZd9+2DLMMD/GrEg6nnb67thw/L584zNTxqRCH5E0eAIW
	 h0G3RDdWFvMUNWEhiUCsfq0wNzAzzrfOphmpJl461ZsZjV2s52V6tVkFfNSVPhZfl5+w3
	 VUqDZWJU0JpTFlGQxEhXKsF/i7+WQivKiYctd8DnAEtLqIHcp1V77l5rTyHTNFjbvxlsn
	 vpArzHBtKMjWWgFlP5VQ/JhSTH8w6YHzT7Rp0vovqER87zyu+QYdZiB+LBtasMZF/Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BbqA7dzUFNRRH3i43l3ktiNJhr4jSjUq5g8IQF9/Igw=;
	b=nTgfefxdsZWX21bhhU3Ucki61LXgbIIFeO3+RitiVICtw+nDbA4XwvWroz+BbJdApr7n
	 F5Nn41x3YTkdI/7h91W40xPAdxBGZ34LIKX0z0mCJEPt6VgK+9Lbxmbe0X/RCEQOLu6Ty
	 F0X2mwZNPFBlcVDUDmIv3FMu16qIo6G8jdqYwzIJqFWOPOGgW2j8xtPC9ZpfScKLqEjFN
	 zY2ffh6+af5rbRZWCpRSaB/fatBI8fagiTyc7Wkv3AYw3hm9VNq2xQ0n/8ZauzkR65Og/
	 Hc/dJw91ZggLW+tJp6XGK/VjBbOdjHZWxSs4Ya5xIEVtGht6NJkJPvgBnory4eJHKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTsgbGfh;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D387606A323
	for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 18:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D387606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTsgbGfh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so738249eec.0
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2026 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795631347; x=1796236147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbqA7dzUFNRRH3i43l3ktiNJhr4jSjUq5g8IQF9/Igw=;
        b=NTsgbGfhTXGh+A1YKsQyEZSPadXbqYBhPvtMwI/4vatcNfcNkaYYd2k3wGpFI6atXH
         5IK2WFXWtYmCG/cHmvu47nJ+qnkpkaaIYTKSigj0sGqgBBvIH78C9kwwrZ2PFHf9yvEP
         dKAYG+pMBR1UKIanZ/bDZPBlpko1JTkvEc0rHdpXs29yntcu0dx3z5S/sh0yuH/euBKV
         1eDZd8j1p1qFGaqmlStbvBXqYTV+B07j1ZzixQcN9eQY4gUw8DlJgt5QUUY3QAnchjys
         dfaHYfZqbnTaoyWYQH9TW6end5if2pZcQa+HcqtGk/ohMDbzy2WjOuc0Ls9AWyNPm0dO
         ZSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795631347; x=1796236147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbqA7dzUFNRRH3i43l3ktiNJhr4jSjUq5g8IQF9/Igw=;
        b=jhYSIhfQbLsA1+I4nQfpae+YlFHfMhjgIwrna3dIvS/FwvAOvN8v5XQqiZ8oGwoFs/
         E7t2HO2JH8y1225F206opYBiPiop33HmThgFNxdiJRg74BuwW3/K7iUwAYhY/qh9gKuG
         ixhIguuYTZhpJSkXaNSzpM/oSPxBg5HS7sV9PZsjxtGNbAxUVuzrOPYDzfqHunil8UHm
         0ktD3AACJu6b5GgJ/LKMdw7qu6oIHdL66iFVfJnD4OLj3ilm4ofR+Y3E6Z+RF6u4EL3s
         3bDpbe+fTpU0L6k7vAIotPNBH5799GsYWnGaJS5brbBFAEwPyiPeB5PjXOPusUANNG1W
         f/yQ==
X-Gm-Message-State: APuU4Z8eREMzuMXgcI1onWTgzktHpBK9HDWqiT72OYbnyK7dXah6//PB
	ZAk4Q0kMg0k2SOJ/Ji9HH0v3WLZr5gHodGZlJYsrBX09zAzdIkgKKfTd
X-Gm-Gg: AZFdTZczO3aUDvF/KnCRce81YKd4m/QAg8N6qtTmw8oIe49m4sUrJhajzBmjB3Y35fz
	3l7JCWXur3fPq+ZIka7QplSaiR3/LRXm5TNtUa+JWrk/u8LWZvIrPf9oImdAfT9cKWDnrqh+y4a
	WHb6No33Gpqqo9EjiHH6yObTKJG0s5o1mrmu5TgBeNxw76s9GVPtPOrf5B0uAj+MuQUqMb6edI/
	XvGwn9Id+7jxALvDHHFkCe0ZQULiRTzEoG6pAWDTvMMA5PgqQ8ZGBIWbjagXRIuZnuIfC6GS3v2
	4IMrZHGTDjRErsib0x6Y4UE15+mG14MrDtwuXwc+3A3cyka8GM/cm50QazJLN+Kz9B0ZnrlTazX
	nRpddso0xfMzk8CCd/koW8DcJmF6aOpllQI8c6u4rfJgS3w8FLdyB1GU0Q5I8nu9TwLEqzSNorK
	ZYBhXTw8c9b6ryR/kwbPI7+F1YluhS2rW4FitlAFsPceQuKhwt0moj+Sc4MOe7FpbtZOg1S9p0G
	PnwJH04BN+hcNt+cOUFqzZ3smi5PMjfx/99PfFzcUeVcgDORmKNt3tdD/5b65NpxTZUz5kMVeqC
	Te7ti0v1tKeA32lGkdmn
X-Received: by 2002:a05:693c:88c7:10b0:386:b3aa:77f0 with SMTP id 5a478bee46e88-386b3aa7d6emr9851203eec.18.1795631347123;
        Wed, 25 Nov 2026 10:29:07 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm14094564eec.17.2026.11.25.10.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:29:06 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] vt: Escape the CUR_ prefix in the cursor kernel-doc
Date: Wed, 25 Nov 2026 18:29:03 +0000
Message-ID: <20261125182903.2396749-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A trailing underscore is how reST writes a link to a target, so `CUR_`
in the prose is read as a reference to a target named "cur" and the
build fails for the three cursor helpers:

  drivers/tty/vt/vt.c:276: ERROR: Unknown target name: "cur"

The same line appears in vc_cursor_start() and vc_cursor_end().  Wrap
the prefix in double backticks, which is how the rest of the kernel
marks a literal, and all three render without an error.

Verification: before the change, each of

  $ ./scripts/kernel-doc -rst -function vc_cursor_valid_size \
        drivers/tty/vt/vt.c > x.rst
  $ rst2pseudoxml x.rst

reports "Unknown target name: \"cur\"" once, and vc_cursor_start and
vc_cursor_end do the same; after it, none of the three reports anything.
kernel-doc -none on the file is silent both ways.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/tty/vt/vt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6a6eb8b2a6de..14b7214ec105 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -273,9 +273,9 @@ EXPORT_SYMBOL_GPL(vc_font_size);
  * vc_cursor_valid_size - Computes a valid cursor size from the given value
  * @cursor_size: The size constant of cursor pattern
  *
- * The argument given in @cursor_size is one of the CUR_ constants, as stored
- * in struct @vc_data.vc_cursor_type. For unknown values, the helper draws the
- * default cursor or an underline dash.
+ * The argument given in @cursor_size is one of the ``CUR_`` constants, as
+ * stored in struct @vc_data.vc_cursor_type. For unknown values, the helper
+ * draws the default cursor or an underline dash.
  *
  * Returns:
  * A valid cursor size for the given size value
@@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_valid_size);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the ``CUR_`` constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_start);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the ``CUR_`` constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

