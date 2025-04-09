Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29381E500C
	for <linux-serial@vger.kernel.org>; Wed,  9 Apr 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226540; cv=none; b=Fz/RGHlZPvajQePIbF9XnjxQQku6wVfCkMtmAQJ+yZDcM6mLqF30iUYnDoWQyj4jecs3dl1A2ZVISFLG16AMJxmFB3/Zhoo3Ls1cLpx1OxxYCNlAWKLRtJIKwrm0Q4sJI6W9EVtN0uq/iBzZOV5gdNGwN9Qix1qxL0mGu9Y0cFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226540; c=relaxed/simple;
	bh=cmNctPgE5CTHw/tO9Zr51B/dhnA9zRrqJS02ywdELvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYWyvkbDt7pmBPFh0LUCB+TrUUlRKQm8rtVY3GZLJo5HoL3pPdGvA3cUq9Q3AP49Ma07Glzg0ZWt2bjgXQtC4lG0LjyeYsVHvGbeKrDnhIHetAMtLzlQGlKX45uv46/uUiayTEoRzKvpqAt4B0AnxHzK7KwFhXgBi3Sc1iO1uWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=TwCQYgO4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="TwCQYgO4"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86117e5adb3so3062539f.2
        for <linux-serial@vger.kernel.org>; Wed, 09 Apr 2025 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744226538; x=1744831338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpmhxAFcMMXA3ewYDfoakLRc7cttBGIU/Z/F5aA9aBU=;
        b=TwCQYgO4jiAJYKPKOYVkWwyHzgY07PbApO/vuPDHe67VdgC+gjstcmXmm7bV1ByEo4
         7koxdgONZlbBiDVdP6amSXsR+tqG/T3SC5bRvDQTT4UrTgamSMEXnk/SrJopJx1sWYx7
         QndNfvqPUwWx2aMrcCMEv6wDoBzqK916sapi7JEqFrpk+GG7eIUOVHxlNdSDwH1pv4+t
         nEjick0WVMilIlUkuQWuM+zPVTqeOMMN/59/xEgJ6QcrlWgBHKKDGklOQSgYbg2Hhzdx
         wxrhIugZPrea6Bo753xVbXPWe7r0cR4O7casjRRa7KgRjK9pSNnCUmrPfM24VvwFcqXN
         D/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744226538; x=1744831338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpmhxAFcMMXA3ewYDfoakLRc7cttBGIU/Z/F5aA9aBU=;
        b=AlJPQzvBnhVyez5jN0SPXD6c3i4h2WXl6q5M6olLKfg9Z70AHJ3Zta3Ka9uvMv2hZ3
         mddV6jcnggmMoULkEy2aBRCwy1VIzpL1LgxGc0H0sE5hGR/0Qc/pF+9XaoH47qXsxUfA
         t/zo8daP+mVEc0Yg6JDCSDEob3+W57j7CQFwF1QMFVg0aWR08+7qZiqbnWAN212YH7oc
         pKxISTNFhOLKV9uHf7ZBiQ9U1H4ihLJoMb4F7JRaT/1UpKzmJYyDUxHDx3LC9qHVCQmu
         CUJe9dHTQLrc4VcCjIq8+Sux7+r18QLuFqjhlG26n2fISecBYYp9XHzJchZ9yD4MpFx/
         lLLA==
X-Forwarded-Encrypted: i=1; AJvYcCU/4EI3/k7r3Z7P/XWTa8OCDtWasVVt5ONsm59d7r45wLu1NUkqWfqwBgixKzb/9VztSMuB+SSNRZTq3tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKH1/fRDG1fxnRM+d2JWsVxT3yqwG9OvVU5Kxa2UZVrNJ2GkEB
	KhvrcTxftqY8FcpA3Z7W4ArVX3ojGXYFy++mHLleMRaPdxrIxief5R1zTRvscB4=
X-Gm-Gg: ASbGncukGZLeInRWjwArNzFpvROkob0xd+vFYeGVBZ8QjNGvhbTYauxNLRvp2DsWiHf
	hbpKG9dWy3m+i1jI0OO6sSMuLqG0hJcm6smAxIHLrXowLl5JtybW1k8yLptAU7QPNaPbp6Q4ru6
	osYEaGpiFLGqckKh1NSLyjufmTgDDXmr7t669iKIAG3vdsViivLPiMfI6Xmyu8HgA3nTHfngk5f
	ndy9VAAllDywc9zI06dG10Z1Ir4QiBVpDFhOIpJhoQ/pKsCHJjJIEbbM8wRjqNeU9ZGaypdbvO0
	HkVfX/HJSRdTzHvBayp1zVb2AmUmaNVtn/bbZyun8H4BgikQCU2KDprnbwPRROWmTvJObFzwOGZ
	cbW34iBsuEPWqqA==
X-Google-Smtp-Source: AGHT+IHBIdM0sFVSXLsUHTwEjKCRbcHIGbDh+GVFxWpuuQ8TjUX92cXZCZ725TWzNK6m0iuJUoVS1w==
X-Received: by 2002:a05:6602:481a:b0:85b:45c4:571e with SMTP id ca18e2360f4ac-8616edbb21cmr9242139f.9.1744226538068;
        Wed, 09 Apr 2025 12:22:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf81bcsm373459173.10.2025.04.09.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:22:17 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250_of: support an optional bus clock
Date: Wed,  9 Apr 2025 14:22:10 -0500
Message-ID: <20250409192213.1130181-1-elder@riscstar.com>
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

Since the first version, the DT binding (which had errors) was updated
to properly define the number of clocks and clock names, dependent on
the compatible string as suggested by Rob Herring.

The logic that looks up the optional bus clock has also been changed, as
requested by Andy Shevchenko.  In addition, the bus clock pointer (which
was never used after it was enabled) is no longer stored in the
of_serial_info structure.

Here is the first version of this series:
  https://lore.kernel.org/lkml/20250408175146.979557-1-elder@riscstar.com/

					-Alex

Alex Elder (2):
  dt-bindings: serial: 8250: support an optional second clock
  serial: 8250_of: add support for an optional bus clock

 .../devicetree/bindings/serial/8250.yaml      | 30 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_of.c             | 11 ++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.45.2

