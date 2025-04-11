Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CB20DD6B
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386267; cv=none; b=tSA1zR1/WSoDMOVmbUnbUeEVt+nQr2vH204ulAm5ztYwAFhaxOWAHUcwQ4eOkkHifQwHc2weCJTv+Mjg9XhfjGZghAQGqZpez2k/y0naj14dQZIitiN5uMLCVWSBXliHaXEJ8FURpx8vtHnfLlsd1XNRRUuHuWI8CCCOy7nTna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386267; c=relaxed/simple;
	bh=2wgs8xkLPcDzrMkx5fPptVOf8gKg9PkOJJY3p/JCOtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKK/y6WvTU80PgFvy7jBEoZCVybS3ogGRY6Xiur/itS9ji7DQ9fMqOntbSxWiQRDANngasdK9D3dwKIi2sBABNbmWfCID5CsNVBbJRyccmThZHK255JDGXmAQKP5TOgKlyhzBvGEzzFb75g+F080374wMVM+WYSxdD77JTwlFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=La62plsp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="La62plsp"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso18118535ab.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744386265; x=1744991065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2r1c/vOhjgtnKBMGLqUCUilpq9yxWP4WtszcGjN9x5E=;
        b=La62plsp+VYYlfiiDPGdu3r5WjNlfltaD9Sxk3FEvgxDTjjrzcm7aP54H7fIj9FDAH
         8R3ooLXpA1wPZiH2qwApaSQGqnS4UgLX8XIw44y7cVDyCl0UZLPXM8n+4W5/nCNEehin
         041+VdhdvJW37i7DJ1rrwChvp5e9aDR6TERIKHy/rmInbjm0ErGyJGiitrQ5h0kAi0bS
         EOWUoB083qeTSVanZn3fA5XPNanoXG21YY0Km4KXECEl/vEuRLuA1B//7sr7PMfK67Xr
         9O1ZDYHHPx6/3xtcKeYRq3NH+8g4IR5rSRMtiUxkKTcSkOIzWVulF4YJYq3afra0r5ZZ
         3nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386265; x=1744991065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r1c/vOhjgtnKBMGLqUCUilpq9yxWP4WtszcGjN9x5E=;
        b=bkpudE9E1ocGZeQL9QS0k63LClyoXgs6XH78lBbfDtLw/jE6m+MUUEj1IlCk2lktND
         u1P/j6s+gDzc9m3kqcX+OAHKMSKhU+BYqb3+kOkLh02zMe8Vxz4tWNsz6dJhjPGqOYK7
         Xm5d0Lp3peOx9rXvLvXhtYelJIQakVKcgR8vB0XmVm9P64V/XWJVkKDqU2OHbtFDXQa3
         OQNfh0yqaJVKZkVJ4WSP9zkze6pAcvehsWZlyONAmUcXgQDx5o8LLKD61B5qYzqUtNIS
         ICLevjwsm3SxKZR45HoufN32OYOKRQdISkR+tzVbjURJ/pLqA5u5MLwiijK4fCisXytH
         PNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWZe+eC+duNjWM1PNS2bM4096wcwGJxw1M6Fkv7cfYa1/Do9I/GaG/7g4PeuLL5QSLQxd8K+bSldsNIzP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydFGCtPkKLcn0/Kn2VvxeuJCDxpKtlc7COsnAnkffNObVG+OWn
	/JqrCUL/bGUH0hIdtUhHIFe4qytW+hJ6VM89azAEPnqpBX+TCQQuO0NDNfPgT1A=
X-Gm-Gg: ASbGncuIdVE50M1X5CR53yOc4zb/EzKfzXSAmHZWNk5ROr8kCGla4C+xd8afuKTvyhN
	lWcXOtnvAWFwuTpBFs8+d0Dwr3LQz8FpEzB4C5Lex73OeOMJxD8ngi8wLbF2wk5nYUfeZs8Otdp
	pgjgg5TECFPCUm3Fl1+qGgjlC/mzEFY8xoWUpK/kWSkEolW/lClXa4DGkBysCBr45IdgLqKxWYs
	zc+htZmWBj5Qqc+XZ+bDdckF18aWNqxDnvpVgn+GyWP6FhSWLaFh62jABNDab8h05PEABq+SQ2x
	upw8jDeTuvXizXO9kyfQduaJ0TFOc7Y5wqJLBh6+KFpfB6hAFvkvXUM2BdWU90gb1Q5JO6ts0JI
	/Pq/Yl/NlpJC2jA==
X-Google-Smtp-Source: AGHT+IFK5sdaLIBjH4lJHrLTb46aftzH6TysHI0IthYxIBi/kqyaLNxSazBe9csKjIFKMCbouX8yUw==
X-Received: by 2002:a05:6e02:3601:b0:3d0:4bce:cfa8 with SMTP id e9e14a558f8ab-3d7ec1dc7f4mr34974745ab.3.1744386264887;
        Fri, 11 Apr 2025 08:44:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf812dsm1276326173.18.2025.04.11.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:44:24 -0700 (PDT)
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
Subject: [PATCH v3 0/3] serial: 8250_of: support an optional bus clock
Date: Fri, 11 Apr 2025 10:44:15 -0500
Message-ID: <20250411154419.1379529-1-elder@riscstar.com>
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

Changes between v2 and v3:
  - A third patch was added to disable the bus clock on suspend and
    enable it again on resume, as requested by Yixun Lan
  - Rob's Reviewed-by tag has been added to patch 1
  - The first two patches are otherwise identical to what was in v2

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20250409192213.1130181-1-elder@riscstar.com/

Changes between v1 and v2:
  - The DT binding was fixed to properly define the number of clocks and
    clock names based on the compatible string, as suggested by Rob Herring
  - Logic to look up the optional bus clock was changed as requested
    by Andy Shevchenko
  - The bus clock pointer (which was never used after it was enabled)
    was renmoved from the of_serial_info structure

Here is the first version of this series:
  https://lore.kernel.org/lkml/20250408175146.979557-1-elder@riscstar.com/

					-Alex
Alex Elder (3):
  dt-bindings: serial: 8250: support an optional second clock
  serial: 8250_of: add support for an optional bus clock
  serial: 8250_of: manage bus clock in suspend/resume

 .../devicetree/bindings/serial/8250.yaml      | 30 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_of.c             | 13 +++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.45.2

