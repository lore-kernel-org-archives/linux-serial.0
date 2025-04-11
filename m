Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D785258CE6
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403916; cv=none; b=pbB4U9X6OkZjE3DzA9XlNk4Y1dzQcDyxrAZOJXVhFQxLhMqeGQczblhp7SesGbc7wBZjio9YXtRwDpAKdLWpjx82hTR378nBJ0cYIKGBKeLuuMur89lke6ut9vnVSkSOFRM0OXyJCB267OgmlXwa1K7Zj0mT8lzVaBb2LOGXQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403916; c=relaxed/simple;
	bh=jP2gH2HxizlXVnfCoefiIXX50CVQy/awrI7TNYRAzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imMZlg0DmS6C/48fdkUZrEmDA4PufwBSUCV3RyN/e3apwOvp1OnJ71pyiRAbAHbfomnIo6v3ph8b7qsq70ydaDzRMA0Jmya6JL88HuRWwnBHaZx6cc5L0YpkoIfVHc7YIpAU2weyjWtyxJRXSDw/HZvUw/K1OSDjadPWrwb1KVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=HuZd3vAa; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="HuZd3vAa"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d58908c43fso6987835ab.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 13:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744403913; x=1745008713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ZInTEwsl47QZUkjk8fk2tvbcX5FPggXx8vW7X4elk=;
        b=HuZd3vAaKxn6C6d2hH42QD+cWH/9GKh1OwWI/pMjqPJC+IRTZ1mAelTWKHMFQxSF5D
         YEqy0dAByDxGN3L/ycvXZlkAmy2IBGSiYBuPCQMAMdkoGNUIZinNE9jt8IUJw9D0FHSf
         kZjoS6NS3fSNpLV4tteaZPIprDaGB+uqM5Q2q2Ok5fZNkIhvlP2ndUS4FAxOyIO/8I/d
         nC4oqP+EkmZGgAfUnLT1ijAjlVlJo24Zlgj9sI9QB2ydIqBPgfgkeOrOqkF3tgNO3aPv
         +kdAcQEE/zuZPxeZos7cEOfkQR339aWkEphL0R5MGTEFetaDAiuqONimvOzmpAmdVAoM
         gNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403913; x=1745008713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2ZInTEwsl47QZUkjk8fk2tvbcX5FPggXx8vW7X4elk=;
        b=LFPdUrQHODEd8xvDAbxdrAiAp5c8siDjVgnuwh7ONYESaC+ETkpduBuwVlBb/3qpHD
         Kwhk09t9v4K8b6NoEw08S8AA5/Uzp4VXN+Bgq37x6vi56YZ0Qo7S+0iDLUimawjSbYxf
         SwMZMM0dxFf9P/uuxqKa4qKsmX2ijIX7chyCJPs/rtDtlOE4FNgw027yAeCZdZK3rNZb
         XB/O3oeCw1CiJN+dEyvmEEvpDlU601dsfF52lf70CKrVM0++B+G5IgPoeVzYvyeRINYm
         Gp63WPyOeeDcgUa7wOH52j2bpal5/hxMbZ21ip/xFw/J+M0dz0fNXLTkDhYZGzvDWdjV
         j4CA==
X-Forwarded-Encrypted: i=1; AJvYcCXZEFu5R2JJ2Ha4CNZaU0lIB0Bd7sCra1wzVVs6IKGZylNZP6La1A3pOr8X4of8VRxuBqvXk9V7+TqyCr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+2faa7qIT2rUVv0rh2LmkUeH55pCgHdPffQH6rGL1yu2j4zBo
	aol/7QBQIBS0L1NFCb2m9n9/LAhGrXF62PgN5ziOatUSRcM0OU37VPFNZ7a8/v4=
X-Gm-Gg: ASbGncuWHlCoetVB490gsLmOnJ5EvudIck7zqhf+h4f+4G+zeisUVxve01WbYIdJx7r
	buskenP7ED0MGWChES10MkpdZqTfDYa4jxN4TE9pzGtL2aaHV6Jl0XG7KjNeB7RIpeDWB2dMA3L
	oQdX81DaDAVx+7vGOJVruxpFxP6X4Kp3lug0hM3hvJ0MXyuA/2q00bvd+8FwEHAPZGIdbA6u2Iw
	VUM/kz8gWIwLS2Kmgvvr3vmNrbi9kbhzYOusjb+7Xw/MubeJ730myEklHB8pddbeNb7DtSIEP8n
	/HryO2404DZaa1w4QzNHj06yhc6N3NSQ/fvDx7orMs1IGPRZ3EpIlJk68VAdRbEDZnH7WOIC4yS
	P6iyZf2EwSSVnIB+CkKpquQLu
X-Google-Smtp-Source: AGHT+IF64rFuEmhScHDoMsL9QXFX4Agysz2oW5sGUVVn3Q82xJQ20AI5xuTlCrtn92K/dBEu6SxbnQ==
X-Received: by 2002:a92:c267:0:b0:3d6:cb9b:cbe9 with SMTP id e9e14a558f8ab-3d7ec1caab5mr44116655ab.5.1744403913131;
        Fri, 11 Apr 2025 13:38:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2ea1esm1420787173.123.2025.04.11.13.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:38:32 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andy.shevchenko@gmail.com,
	dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] serial: 8250_of: support an optional bus clock
Date: Fri, 11 Apr 2025 15:38:24 -0500
Message-ID: <20250411203828.1491595-1-elder@riscstar.com>
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

This code is available here:
  https://github.com/riscstar/linux/tree/outgoing/serial-v4

Changes between v3 and v4:
  - I simplified the third patch by reusing the local variable, as
    suggested by Andy Shevchenko
  - The first two patches are identical to what was in v3

Here is version 3 of this series:
  https://lore.kernel.org/lkml/20250411154419.1379529-1-elder@riscstar.com/

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
 drivers/tty/serial/8250/8250_of.c             | 15 +++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.45.2

