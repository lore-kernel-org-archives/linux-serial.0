Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993F4519A1
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597421; cv=none; b=QnRlemBkTsoGuxNdWVmdVEpR58s21u6hehExxBOjZTjTeUPMreQbuak575a6/Oq7+YCAj6McwLRVl4B5UT115BW9qFnFYm0EH8dtEU3yZB6Rc/fKrlb/JVIH2vClKpJTmsStW9Lz/Kmau+o56Acm5iAmgtsiQ/YnFhJQr/h4OuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597421; c=relaxed/simple;
	bh=wgggDzjHY+Ah8vECxyGt8Xj8OVmFIHcQoKQNaP/el0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ud5eVRDWkgVNYlS0shnr1sy8Z4QpxT+tVfbbU0GAptcTY8Hr8JxsNqnOBOIhmelXXqU1fv2pG1H/EwiBmfPs8sFXHIsZvtCHzMXO3qkPJkxyqVUjAwLxqE3XBDY544m7X0NCPPkd/zMqtLCYw7CPLsv6SV2n4l7SFC3q3SJqJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqQL3s4Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqQL3s4Q"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so14419845e9.1
        for <linux-serial@vger.kernel.org>; Sat, 05 Sep 2026 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597416; x=1789202216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ynaw8qDzMXNFxXhqOFzgHygfT9MJ5kBajiEceTkzYr8=;
        b=TqQL3s4QiteOfHmMHxZLjjyRG4GapJvfOYGHiHSO3Enuk8RdI7KMBObTUXWSnnD/Uk
         qc4aV5VIx7EgUnDw1fW5Ejr63JYchP3dn4955UOtBXX5+DbtWwzO0Ptefryy3vG/HKdw
         v7GYox9BiJkZnmmrYHQv+SqHrX8tUlPYhD6NLtitgdxhmfU1TlRYzyfAm0M7CMapUO1k
         DzaSlDG2HPzlhCAMYH8O3J/D8orB5NdAjihEfyFjJZT1SSaIz1iQ5kHkEyUHkxB+DGGr
         DwvI86rIF1I9pgc7RsykIsuanhkg7Nglz7TXXnO9xVrvJgTOUAPF3JLlka+OQsVRwp/L
         n0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597416; x=1789202216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ynaw8qDzMXNFxXhqOFzgHygfT9MJ5kBajiEceTkzYr8=;
        b=oed3ToaL5lN6dofK8fOCQKf/BQ0Vpq1MpAOihcGjkLLK31KJFVRq1oppoLKGP2BpRi
         X9z1/FEqE5X8fREpXr7rzL0PNUDhK+UrAeAtq1Rx8Lh9FqkUrK6YZVyoc/4jH/2i0w/y
         hSG4T1etBsC1S83Yx1Az3B8dmPMlwL8V4c6I5DQKn18eM3NpsAQMN7itCcwRIZnbfSlv
         VoY+PDKmbLhFJch2einbmQIVE9NfxMRSc/rd0R2PVY25abFaycl+tiJ+Z/hkkh2pwjiu
         LVHW6QG0/KJMzZoAFhYNf6Kn4xJA3/qYF5NcoXt6V9T3NW0NfFCod8D5XUjRmWT61TZ0
         OF4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwyZBQbo1XknjSAA/tVVaF34n/yGJ5Dbio2keXoPdmd6FhNyRWkjjRW+0X56DO6G5rbNm4RT3vw9EoZR78=@vger.kernel.org
X-Gm-Message-State: AFuF++lXSuLyo/eQScq+qjNcUjSKeScmo7fjq6DGls6TDbHyRWpUHrXH
	V3DxafFm5CSADb27xWLweDNCbT8A6a7siUJmOaLkzOxUr77APwPAty/A
X-Gm-Gg: AYBFou15bpkN7CfTil1PWNTQOBWzuKMG8d6GLNcY+22U5PpfB/bUn4wrMuejo2Kl02v
	4o3nJCT+wuiIja8NFNvcb24obMbH6pfzgaG3MEQFFupdFpGUF5YMcG/VIUcLOdPqBFZ1U5ipVtc
	SHF0++WU2bFqf/aoIP1mPZN3Mku7DxPTwriZWLQnDnN/iFn9aXU1dEY8Ot91BUHDxQwPUWvrRla
	IWf0kVhrUkFFBc5jz6Zzj7NjjbXYpSHSNkisEvwy1kilVV6R4/4VIS5B9YkWjPdjlJ3QWJ1CsLs
	hFdoGT55zwpCSQn/dSwyskGnCS8oaAhxr5rkqZ63mNnEiV9mNkrvwKKDYol1+DQRx1G7UyWe515
	UIv5rOv9EEa/AZLHao7BeZfMl0jbGwpegOrHBCq4m/6LfYivgEquSjT6Gk87u5N04fCZSwccaLr
	N86Y31pB6a2z4LX2IA6NBSAZb8gzMb0cbo4PaSgoanq5XsllzjmcubwqOO66V2Gz242sexQK32p
	4qvVmWUElT/3tIKXLTzDeMRKxiMbarDAwR84X1oD6chIadboMRDBxtEcTh27mxk5WpKZFb+srUK
	p6BF5s6UuJRY6Ss5CcYAcPVXlYBNj8KqwMcDzgFpqlmSXKORt6McXl22MnyprnJr+UI=
X-Received: by 2002:a05:600c:524b:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49cfa20cd2cmr88077965e9.31.1788597415955;
        Sat, 05 Sep 2026 01:36:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm517436035e9.0.2026.09.05.01.36.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 01:36:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-serial@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] Documentation: rs485: Pull uart_get_rs485_mode() from serial_core.c
Date: Sat,  5 Sep 2026 10:36:48 +0200
Message-Id: <20260905083648.39026-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial-rs485.rst asks include/uapi/linux/serial.h for both struct
serial_rs485 and uart_get_rs485_mode(). The function and its kernel-doc
comment live in drivers/tty/serial/serial_core.c, so the directive has
never rendered it and the section shows only the structure.

Add a second directive for serial_core.c.

Fixes: 0f4648a1a6d3 ("Documentation: rs485: Mention uart_get_rs485_mode()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/driver-api/serial/serial-rs485.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index f53043d21071..98d8d83718c6 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -50,7 +50,10 @@ RS485 Serial Communications
    matching to the current configuration.
 
 .. kernel-doc:: include/uapi/linux/serial.h
-   :identifiers: serial_rs485 uart_get_rs485_mode
+   :identifiers: serial_rs485
+
+.. kernel-doc:: drivers/tty/serial/serial_core.c
+   :identifiers: uart_get_rs485_mode
 
 4. Usage from user-level
 ========================
-- 
2.53.0

