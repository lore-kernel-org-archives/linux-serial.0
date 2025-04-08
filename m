Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDC23E227
	for <linux-serial@vger.kernel.org>; Tue,  8 Apr 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134713; cv=none; b=EvyNRNyfqQUURDfgJiNe3RkAEJ7VArw6Oh+iuhQzwbb4achAhoaZQWUsXgvTf2wkuaLQrFtBKNkuz3urgO0Rp5+13hgZOkxv1KxqKtemWG4IgVv9h8reOYb2f4ptIGph0fjQUsqoEb9lP4kchzkijaZBNZSoLX+sAxJYtDytCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134713; c=relaxed/simple;
	bh=LUAaQpYmHZr2x8IcCyxqSCkpOZjk7GLcZ6iYEadmxbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ldril3VvHo383pQnzqZOf+gVMLz/1Rbe1rJWtbN7y4KYwSKT4VzarTd9yJrBO8UkUG6fAeEsrxSsIQcpOH4Ky/F5BZYSdcT5vXAnuPdjZ+fLMCpDHnhPi58qK0B0V9p7gmGEx1sKgZg2+U9ftCvUIBIB14lln47hZmaAWFmXIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1UuQVUMj; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1UuQVUMj"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d46fddf357so20698445ab.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2025 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744134710; x=1744739510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvGZNr8yAkgwxgzEHlIxH9XT7UuZH9oRFwm3lKyD2fw=;
        b=1UuQVUMjZxymk8a7ggJmPWd6K/v/uzv+CNOzV+b4P4j4FLwIEVcNWu+2x9ZR9mcWS2
         sdVPh835kG9hkRehxtttGl77qHPYoB0bOF0nnB7C42r3GQzlqfoXQgTQ5sB9jh1UYaee
         UphRM0eKApiPF5gGQv0cj1fo4+mHoFlIjbnR2Dix3F4MS9vnaiYZBJ9kb3xOssmRJK7c
         ZWBEUWaZumyPn9M7GlqOh4d4KCHmMgFFWQ3eq2gKw3pAH2ilIV7htAxxLsLobZWE0lRn
         a5Or1yEfusZeVcDJOW8gPVDJyLguve0sHKqoeEjgXEKYsRQinfE8t+ZSnFixjgocA2/O
         1nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744134710; x=1744739510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvGZNr8yAkgwxgzEHlIxH9XT7UuZH9oRFwm3lKyD2fw=;
        b=jIGPnjZhxmYxCeo6i1OiTogqNySHm3SvdhkbyZ2aVLvLOuIoSlCNL4gmq52fkwvCws
         5wfyQQHhRI96VJL4ohT65fg62a/qJXzLQDFzZXvatLLm2LUm4Rq3sQbzQCqKe4lzUdok
         VZ4DzID0nceVDXkN48W9Iuk02uqEN/YKsl/8XHKpExNkQLrGM84796jwICibrZEE+oYG
         PmzRTRvRnAr2bduaRBPtXYQoiLks6RGrj7AfahaNb5dNWk/ACHIlEkHalqgbVB2C9GXP
         iC2ddHNs4bl6dNGovYJr7VtmTTc5UsZqZjieBqXfNNA/CfiySq6pJcIO/EDoVSmqZIyU
         8hug==
X-Forwarded-Encrypted: i=1; AJvYcCVPXMd3BV8R/68UdyBucVTbOTdHWqW/S1pzouSOBu93LX5pNxyuaDoJ974CPx5l4ZHPB21VF0tSIkW8Vgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmKTdwF5VthBV4w01A7L7sXENWxa53uoyJJHBr6BIP6D6mljnS
	Ri1INKhFz8W/HxI20Tj2Do35kvHtwP1tm/xlLfFS/gQgzFH5+fuh9OuIGJcUfPA=
X-Gm-Gg: ASbGncsGA2nIQP0ogiB3R/LtWJS3NdKfL/dagEPUCZfKGWhignm+UZVP0VxKvW3D0b7
	g/UuCxW1EZR2cQHb8glfGreCAV7qNefgymTQiOW0KcNMb/+RWDCC2PzLHwkqkE6r/jw7lozANlo
	zEMQhfp5PVFRkHtclbsKU/kBTduyv75aqu4LFVqjpoIQ6kGUUxyCGj633JTMTiJ2FTTFS0UL7ui
	dgekv1bvUtKL8QCvC7bXCvclEbu0vjdOUDXc3C6YsEwDfqhqvyV7oFgj2zfe5hy6RqR9n0U56ah
	feALCjlZYvYqWill1Mt9YZklYRYMSne29qDRPkQczKdPmf4x+cpcFBg6D61i3RxJRrjohiSbred
	foPrIaKCMlLN2EjP62A==
X-Google-Smtp-Source: AGHT+IFrFQFeWwluR9916XoDwk7qLK/YcvMXzppSoOv4/49mKNfrTo4IKuB+tZmx7E3ipEdOGJkdyw==
X-Received: by 2002:a05:6e02:4401:10b0:3d2:b154:49dc with SMTP id e9e14a558f8ab-3d6e52f60b0mr131530745ab.5.1744134710141;
        Tue, 08 Apr 2025 10:51:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f44e26fcsm595914173.120.2025.04.08.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:51:49 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250_of: support an optional bus clock
Date: Tue,  8 Apr 2025 12:51:41 -0500
Message-ID: <20250408175146.979557-1-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART hardware requires a bus clock to be enabled in addition
to the primary function clock.

This series makes it possible to specify both clocks via DTS.  If a
bus clock is required, it and the primary clock are fetched by name.

					-Alex

Alex Elder (2):
  dt-bindings: serial: 8250: support an optional second clock
  serial: 8250_of: add support for an optional bus clock

 .../devicetree/bindings/serial/8250.yaml      |  6 ++++-
 drivers/tty/serial/8250/8250_of.c             | 25 +++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.45.2

