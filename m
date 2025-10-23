Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3201DF248
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183685; cv=none; b=YrfY/GrFKjOK2wEnFsHYgLy2mMEd+Vp/bK3XZFmKft4WSQ+p024VFs+5GDeKhzDmxdRzRQmZaYrC49D0vNBdv168IoBVJ3xhVHlhZlO9DIP7LC02UNIRmXGKGJz0q9krrl8ppHVw4v9ygzsdZsB2GPBb+iGij6zaIlFaXhh3baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183685; c=relaxed/simple;
	bh=3DPT2ECsqKwSg7ut66ATTn1BaxmhelGSo8EQZCwNbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe2ivr534WL550z36BmbPGcB4vd8UgaTQjubA1PFZcVkmZyYGWsR5gZL7XVVoBpjcOc/lZaIzMxu6KBuCywlfmOsPkh+Fe2dfTzGI9P7phORYHz5+vT+0r3P3Kg4DsQwgWHqvH9Gk7quAMY63iqjWSz4WFeNrsYgk0VZcnYkHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqDyfHpu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqDyfHpu"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33067909400so203177a91.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Oct 2025 18:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761183683; x=1761788483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rzb/oNr7wFTg3J3xnm5Y3CrcceSpW2kAmCmptqc3yeI=;
        b=XqDyfHpuooR3x++ZQSBr1J31EcP/WamdJg9K/A2UQKrYKP7bxyJ8DrxBXUmNm44P9q
         0aSoZp+xMb0OWvC42IS67IuxrMKDxM12OX+WBV+lBwaw00163q/lnz8oP1ZACDbjv9pO
         O5MJR3BxnlwQV8Sz2BadAp5ukfXrNqbXcKcK4Ayz7hRaxblAmlfxQcqJ0JBQKmjgbKS0
         FxYCSl0J3fRAR04UaCTs6/yvDyvfnKpopbr2aJ0JUQVN1gv/DmOjZe/vyKIJty9XPN9i
         c8vgBm1ctz+ic5q4yXP4yvq5CEZPAuH2xYT6TL7zPnjWLEtIbKtXELXupgZnBQv23EMa
         iWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761183683; x=1761788483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rzb/oNr7wFTg3J3xnm5Y3CrcceSpW2kAmCmptqc3yeI=;
        b=n8AfdyHEq+/9HSMne8z0sdCUI6BS757IGbLx4yeylerQPIiOXyRyipuAt8sewv9r79
         QehkI+10pQEb6c8H1e8TzJaVcm6UKgdD4ZMo/l6cKjKbh/rkl2i3lodNZfGPrHqFzDmJ
         ot9mIFC2yEgOjvEGxsEiQMgNEuDQCLhQsghLxUCkbLHM1xiu75bqpzYeMjdixgbHD5TR
         4Ryk2WZZ6R8REh/giyHW7Pg616UfcDtHqav0Wgl4KilQNxIGrNMumgIwZWazE/AcuGLa
         abccCFGT1ZxW8jq71QUobSlx5gqvNtMP+q4ejAKsbbigbbn7t43WuiVyJsPc/0MSZWCL
         YTiw==
X-Forwarded-Encrypted: i=1; AJvYcCVZKgk+2oz4zV7dmQGZM/L03gokUmEPEFgggObN62qu8euroexIGr00esmRiZNHUYKkOvQgBsflRT5VbUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5TTe+DsOSZk4YPmkv1Zl/ogJ7VxZV8lQW5nSzCfsdoxB2aWF
	qtILTy+9v9EDUSnNkCMxcZEQGRKMl+JcdWQm7lP+yQpbgtzX4fJvWGB4
X-Gm-Gg: ASbGncuGVAWb4QXqXeMAKNC0BMv/2D0OxA1LK3Nm+lCKLL+/eQRTzBK3LnThUKrbw2w
	nhMDLxY6HtMAPVEQ7nl/2l+uJEdUfeOPAynsyeG7EUDcOz3V4agDrQP8VE6K7Qs2SmsaMEHO4PL
	OnrLNHxOXG4t3dYwRtHk9koL9CPRHqinBNZhs+dYoQr3EAb/pBoiIZ6xsJ8c0aYtq/fZ4qqiHkS
	8k+K8kfsjT8nE0vje5clsVSCceYQ5k7zoy6o5VgNsUj+9J/3gUCvo+/9Ha1TIWGOgjVEgEUBjYj
	7m8wLJZvr73FEZLaoWXugCPahsSwQZTHRMbb03Bpni7w+9qQqP9DKTeiHL17CYnCK5WtCDIsTyN
	dmQbIDbN1FG4iargvqRblwUmB/HTVyQfCW8zOYFMhVWgUnetSE9hA+WXA1xd1jN2LII+PVkw+6O
	dO+tMjgZ+1Td5Dng==
X-Google-Smtp-Source: AGHT+IHyIRvXdVYrV9i1IVQ4yrLt8Zz4b5Hm+8BXHKO49Yornhmp/WfuLPUMpzo6U7zGSqIeB8W5IA==
X-Received: by 2002:a17:90b:1e08:b0:32e:f1c:e778 with SMTP id 98e67ed59e1d1-33fafb9755cmr1009728a91.3.1761183682871;
        Wed, 22 Oct 2025 18:41:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37c14sm570651a91.2.2025.10.22.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:41:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 486D3424180B; Thu, 23 Oct 2025 08:41:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Cengiz Can <cengiz@kernel.wtf>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Anselm=20Sch=C3=BCler?= <mail@anselmschueler.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
Date: Thu, 23 Oct 2025 08:41:02 +0700
Message-ID: <20251023014102.16777-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=bagasdotme@gmail.com; h=from:subject; bh=3DPT2ECsqKwSg7ut66ATTn1BaxmhelGSo8EQZCwNbgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/211kX76SnvR916miWyZ/tkj95O0t+uypJyp4usrAu tDwZ9rVjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkgDYjw6dzlhqiFdpOd44n XA9++W2B8643hTMc3qVPVCiQO2H5QICR4Xz0QtUjU0W1Pzun6xx6fXCZxZwbffv6e911nOSVV5w /zgcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

/proc/sysrq-trigger usage documentation (in "On all" section) states
that it is not recommended to write extra characters to it. The sentence
may imply a contradiction to previous sentence which writes that such
characters are ignored.

Rewrite the description.

Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  - Keep /proc/sysrq-trigger future API change note (Tomas)

Anselm: Do you object to the rewrite?

[1]: https://lore.kernel.org/linux-doc/20251016103609.33897-2-bagasdotme@gmail.com/

 Documentation/admin-guide/sysrq.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 9c7aa817adc72d..a88266b171aa17 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -75,16 +75,15 @@ On other
 	submit a patch to be included in this section.
 
 On all
-	Write a single character to /proc/sysrq-trigger.
-	Only the first character is processed, the rest of the string is
-	ignored. However, it is not recommended to write any extra characters
-	as the behavior is undefined and might change in the future versions.
-	E.g.::
+	Write a single character to /proc/sysrq-trigger. E.g.::
 
 		echo t > /proc/sysrq-trigger
 
-	Alternatively, write multiple characters prepended by underscore.
-	This way, all characters will be processed. E.g.::
+	Only the first character is processed; any following characters are
+	ignored for now, which might change in the future.
+
+	Alternatively, to write multiple characters, prepend them with an
+	underscore so that these all will be processed. E.g.::
 
 		echo _reisub > /proc/sysrq-trigger
 

base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8
-- 
An old man doll... just what I always wanted! - Clara

