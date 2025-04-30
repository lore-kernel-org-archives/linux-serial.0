Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A312192F8
	for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016165; cv=none; b=MWyKO/JMKhYlDRDHHn4nL1302RkUr/GhXGj7BNuteZK7e7K6ZmCuOF2voBc6scOyppmOzZYuD/3llm3gvII2EE+8q/kaVw4Ib1kzjQhS14JDvs4lej290BQMztTBWqjbFtTF5rWumQmLMlCIjCl8YYHwBAPnbr8xlbhm+TYV1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016165; c=relaxed/simple;
	bh=65YaHnPW1syjynifrJVzhjCU7krexJAzh8rYWDgDGYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mASP+vrk8fOClsXXCknxigj2Gazopnfu7UHYocKqY2QZQDTDZFrEV+2zR0eq0yoEjckWPrY0dU/hyO/n/aHC2nSCJei04Eem3PnDmaphfVxjY3D+D7I1/+VfEAOqvYwem+5HWILduAVp6WVQt2zQYBK+4eIB5KIbn9KK6zr2EPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=t/f3CgWJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="t/f3CgWJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so65895085e9.1
        for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1746016160; x=1746620960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hin90Q/qlFrY1uw8hPFIj/AZ5kwtshzSEzUknrcF5Y=;
        b=t/f3CgWJYostu1N+d1eN/RuSZX4U6Y1tAYQdRcjwhmew9I0Rey/2JjdpyJEkP3MhUE
         tu6GM9eXXjCy1GOjMKDSThxJGtcKXmzU+E068WcrZOUMZKtTsC7TWF8hA3v9gx2AYQwD
         M6xee8MgTN4dY8TBTIIuFC5fN0c2hXbPur21veWq9ey4C8ndaQylNxDxQ+nAU/4XhdYm
         Mis7kwVzZTjJHZ9uwOT3o1tVxIW1ILF1/+F2Q0i8W6RES8t9OOSruN/VifGFAL3GFMoH
         Lm+GkbW1gyL38w2Mp6u2P2JTqe/ZpE3DOndjQsWo43D3edw63OJs889Us9qfgYMALMgV
         uULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016160; x=1746620960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Hin90Q/qlFrY1uw8hPFIj/AZ5kwtshzSEzUknrcF5Y=;
        b=rCqNoatbCM4c5IlnkmmKZSVHsBgnwG7t48QTFpfSkiMiH3HNXTnh00RkJeX/kHLAsX
         XsTAwIcFw4Z17HVVrpy37Dp0VTSDa5192jkemfmsKbmHKOiO+5Cy57JOC7NcsnB1nEih
         WiQoW1My8KUb1PUQNcs7MwSKK68mCC/5o3XVE70yvY5xOjUsbLP+0jCkptda5AeULlCC
         sCLkgrBA1uUsPLwjS4fmGG1LOC9KkKaEc2RM/F44YgV/iuopYrxMsCDmLA0jf05OyYHz
         5JEBGe4C6HDvEhRFacNB0OyzO2qoW0TM24kLVfUsNXUuNuTkSoocDNvX/8Dep4PHMZma
         CqKg==
X-Forwarded-Encrypted: i=1; AJvYcCVRL4v65lcukvXxu5rdfGPoPuNHV5KcWyeyAGoCGPiGRobqgYTt3nj6RBHk3w9M83Cl74OxlFxTW8wK4Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGLW3/fHJOn/f5cGCs5JkZAmtoKdDFuJRhifAfl9cWJDtRKnS
	bOdbm2h9ajzhzw5YumR9vuqYVP3O2P8KKWrjaguhyZsQt2Izp1cR4uqooYvb+iVr/dK/bbjQlVI
	0i8I=
X-Gm-Gg: ASbGncvSsjIb8Dw6HofOe8YvqalbgdG14TEtav8HhKdJUD4wYREHxHw4Cvv7YydEcPI
	n09M3T44o3cG5JTzps+jlGIEuohYBHdbP/TjZ2D49pB8O+DYTi+cDcVWtcVPkO1vAIsaYqtRCXC
	VPBOJnAk/C7mAbOPSG3MZKw1yD5Jo2hPPwaVPwbFQ990xPqfi1ZKsb9vVIJkAxs5Yuc7AumRfNM
	6MoVeESKyMcTqe/EWnN78D6jJYoOnLRNqlbnQEzo34F0y8Xie3pEWBvZENFA8N90cEZD0Omvsrr
	9JquDjfFtrZzisZoyAN7Q6Pyo5N8p4/Qr/t7KiSfjg==
X-Google-Smtp-Source: AGHT+IEcVop7LCHK+PW7qs+wyQUaCY++bj3vcdHwg7JuOrBDny/qNmv6fx8+wazaQUivLi52v9gpWg==
X-Received: by 2002:a05:600c:4703:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441b1f3aa00mr28328895e9.17.1746016160460;
        Wed, 30 Apr 2025 05:29:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6298:7254:d3df:f23e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2bbf046sm22914175e9.35.2025.04.30.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:29:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Nicolas Pitre <npitre@baylibre.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] vt: add new dynamically generated files to .gitignore
Date: Wed, 30 Apr 2025 14:29:17 +0200
Message-ID: <20250430122917.72105-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add new dynamically generated headers to the local .gitignore.

Fixes: b11a041179e7 ("vt: introduce gen_ucs_width_table.py to create ucs_width_table.h")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/tty/vt/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
index 0221709b177d..49ce44edad65 100644
--- a/drivers/tty/vt/.gitignore
+++ b/drivers/tty/vt/.gitignore
@@ -2,3 +2,5 @@
 /conmakehash
 /consolemap_deftbl.c
 /defkeymap.c
+/ucs_recompose_table.h
+/ucs_width_table.h
-- 
2.45.2

