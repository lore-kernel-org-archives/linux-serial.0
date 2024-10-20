Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22099FC0A;
	Sun, 20 Oct 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447328; cv=none; b=MJkG6lRHZ+rZN7GGZGV/7yTEZOz0DumjYkkm67fMJzxfIU9rrppeq4lolJLqhuvyZrQd+Au3gW8inRQ5qoKuKlaW7dZSbBtavP0YMGAWzOQxm8ldPA8MKzsHG+hvYIOn+GleNAo8VD0d/Knck33nYSiw8LcavMIHwcK+wu5mn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447328; c=relaxed/simple;
	bh=m6r/u6nn0z2hqH3ks8cUNqKPx6n+R76j+TxMCz/3QnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGb/BZQhqbbFaPecjXDkmSNeJGWV5IeTM83tjripT1uzmIT/QRuSEoMavb0k/ujNUEsTm3nwWcjVaQbMAASrKkiBAwz3QOG3yWDiIfF51okravql9wNMESl0vR9KfreHzR7p/JTe3dQDd8UR5gPryad2pFAW5iAvWq8aNVwVH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXEX0NW5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXEX0NW5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so15989965e9.1;
        Sun, 20 Oct 2024 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729447324; x=1730052124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/mwlwjjwtoQhRvD/uWxXM/Y4o9ZU4631Nv77kKHaY4=;
        b=AXEX0NW5hKSUwNHExUpdz2R5JXgzSrQydtZFQvZppRcXbwLKBCNKL/DoRdR5hRk6V+
         k76Vhy2bdmCvLqY1PPZtq3Iwug2Uw1gVDx0Hc3DDiie9gAqROnzRjBYDGPSCFvD7wk7K
         Q5aobtls/b/G/S2h/fsrx57GeHy/9+wB9keHgIty6sehdWd1nQ2MiXwEpMMTrjLIuqc1
         V2UGfVyL0lciEuzTqaH7q5C70Z/2k8bBScLIamF11QhsXTJlZp1Ms0pYM1QqabHgHtWN
         CuWiwsQBxV4el4Qwp3dk08FPicOyR/X3NvCmDib09peBrcFX7d951O0NaUEXvfyUrMNq
         BqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729447324; x=1730052124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/mwlwjjwtoQhRvD/uWxXM/Y4o9ZU4631Nv77kKHaY4=;
        b=p87wlPtkW51GGiY5cKoSULdQ5WT6w4sd6PbCmjtSkW/4OzwvB2kEoCXAo+/49rBbPA
         Hv1npIGGdkHkBcJcm4giJ2q3WqgsJKCXTCU5pG6SHo3Gm1BqU9MU87hQtUIRG5/4ZE6a
         pfA3GRAhjleYCltt8xTDktun7evjSOAm8mOcsHoAhGtj2p3TVSzwdfPBLtO6EiER6iE9
         BFKUHJZvTD64WgF/lzc5xo6N3y9ZOKXZinHs/7zoA2qBNQaRunts8M9+S8DrGPH9Pa8Q
         rdi8EYQtkB0JD6jgVj3y9TIVv9ZU6FH7WA8geM70CrAJqbz0dTOH7O2Xz49JpYKIP2Xq
         DsDA==
X-Forwarded-Encrypted: i=1; AJvYcCUHp6cQvGQ8sUtz0nuZCIJEEybO9ZYnGYszCeKgldXsDojk5WOZYfO9vvlF0k8p/viYWDb7nh5k6n8RtemA@vger.kernel.org, AJvYcCVAh+wk7Ndx20gbEk5a99R9SGQ1t+3BclVoDyv2wmevbuEUlaj8E9RstrFVTAXXYi7+l+y5/QTB4GShoEgF@vger.kernel.org, AJvYcCXeBVpHUMcUcy2tZylU3ftVvZW9Jmb+2BwdUZq6fwx7uvOWtr2cEdSgKUBFvdAoH+ngYXEHSOZX39/n@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYKK3yJOmt1fh1QXsji+xDdbE8tZxV1sXRBUJhYSqo5BIT5U/
	4fDshyrHXg9z+kLONVQrh5eq7RcV2td5sghyWl3no6YheauZ0l0D
X-Google-Smtp-Source: AGHT+IF2KlJHlLBhH1K51KC+tGjI/jpHud5v4rP4jsKAXI8Ldbd6pwtY7BfboxMkzoJUTOT5iPxq6w==
X-Received: by 2002:a05:600c:45c3:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-4316161f58bmr79960115e9.5.1729447324276;
        Sun, 20 Oct 2024 11:02:04 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc57esm29922105e9.48.2024.10.20.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:02:03 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] tty: serial: samsung: Add Exynos8895 compatible
Date: Sun, 20 Oct 2024 21:01:59 +0300
Message-ID: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds serial driver support for Exynos8895 SoC. The main
difference from other exynos platforms is that fifosize is only
specified via the samsung,uart-fifosize DT property.

Newer Exynos platforms also specify fifosize via DT, so in such case
this compatible could be used with oneOf.

Ivaylo Ivanov (2):
  dt-bindings: serial: samsung: Add samsung,exynos8895-uart compatible
  tty: serial: samsung: Add Exynos8895 compatible

 .../bindings/serial/samsung_uart.yaml           | 17 +++++++++++++++++
 drivers/tty/serial/samsung_tty.c                | 13 +++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.43.0

