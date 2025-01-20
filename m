Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AF1E0E08
	for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378584; cv=none; b=CR4SfHRlVmy4dmsM8O8PaFlzWTuJJsK0qkklJ8Q1wmJ9BNYdbmkk0Pj3kXjvxohHcUEOXuCcIbdb5hcwMd40rkujYiBFja1xLYBuiRWctHihOQ1FBiG5l7VUiCDGzSfzA/R5UeuMeY6X0O4clugeeKQijrMhFg0Mck+LQK9HG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378584; c=relaxed/simple;
	bh=RCB/8QFJLXN/Bvnu7MJq6UWEKwNseTf4j7qbhIfJFtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4Mdw3jiWCK8TgkQzIvfNXQHrbSBF3T/IO46jsMG6KWSFZIrJI5q7xUUQnmU9jbUPQObm1lqRF7+VW9xWudwusTgT9ZY9vMecgohQb3x1A6yJtIQQgmbjV5E0Ion+Rbka/VlMAlCxYUO1QbnxkTWXhVvYN4yz+5D2iIOf8fk0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=b6eP8YCc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b6eP8YCc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43624b2d453so48636205e9.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 05:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737378580; x=1737983380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a416PcI8wZ9gcBX9UsQxmuZkXXjRlkA6cjWw4TTO1wY=;
        b=b6eP8YCcm+E/m5NmyXAq/bJdRxdEDY/ny6C/9EuBT5l4phSgK1cUexDvQB4H4ApucI
         Y4S/r56LMCPAfg0pzOUkxLjQwcxoPspVk93D1wrCAN8+Gk8WKaq8D2Mh7yE8DMwCpRx2
         L1JcOFActUqN08bquuq8WfiFz5VLXLRtmyRdnl0fscd/A0zs8KkecsqQfxXc7dET7OYB
         xrF2HzPGkGG4VI/OyjQqX39Le0Zh7ZWMX5YA8/fFbdeiAMfUzhT/qtPxn3r7drzgao82
         wfRsllbvMMxgSEbj5Afx2mzQbXUwmXCWNc5fvx51Pe2gKZAciCtMdtGpVRebZHWYDyVk
         CyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378580; x=1737983380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a416PcI8wZ9gcBX9UsQxmuZkXXjRlkA6cjWw4TTO1wY=;
        b=YBSOq8eK/ARC5SqpPN0nYtfW2VQGxJe3EPRzV6lS9UK4s7LcSmVsHRjZN6/GoyxPbT
         PQwySjhlqxe+aMoRZOctC9bS1AXq6E9hMoMuflIga7q1DkL/NCgk7aUJW4j+2tTmdtYS
         PbXWLxW4qVS7KE5+YXRmaPoXza7XnKJvIIUq5BSMEBuRNCgnCs6PXYll6gNP3f7RNB76
         K3uVHoqXUwtLzqu+zHXA5+ZSPYPG+EYVyrwuSDQbaTAQAHBYiyv6OL4Dg6i/0Sila9TE
         aiHP+XdCZGscSiWCXpVW69gxB9ejBDKsNQjEKMugHoY03wQklakuHd26yIfXeIgP6oUp
         6mXw==
X-Forwarded-Encrypted: i=1; AJvYcCWLIslgxqMi6iGg3Zeju/9vrAVtNLTz+RF7hCcMtl6Jpv7G/9K0+o3rcY5n3B+m1LMi+42BWHAtpux/vMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOAHNUxXp03kOWFkKoN5iplfiii+xCo4+6NktybCIYWn4Ft4g
	W73mW8R8+JRyzdIAhDdyZUyUhlpaXq6OtDcUtoUbSZ6gC1CiuI3JgqkVEwZEZWA=
X-Gm-Gg: ASbGncu0RFCI2olJKkEGuTq9SL7zx2leegHibYbaUqlrTJV1TurgPOIuZ5Z75Uc5nsM
	UAk+FFAlSWWJDTufKmrgszUmEAIKWG+tLRLAwA3YAe3gGPxYphJptiLMVEwknUU+nrGtNXGMCmS
	OlxH/t+M70mIwNCuQoVWSUNXMbzXCa7jh4XnPAJY7DKOb5z0+9kNrCi+rGSQdP9Qu2RBQ1Ccctw
	nAWMbYkHQjHRL8vo5zhM338vAr5sBad0ylae6XAnYjV6BTQQT9Uifpds/OZmRCA+o4QLZW59eva
	bMdPI/AUFam7qbHDHIjmyyY=
X-Google-Smtp-Source: AGHT+IEPjik3VZUJ6CmE0J98JO4vcQ2ybXVpIlvV3ZU8Ro+DH8D2RI1e7TjwF4W1DTgLYD6sVjRPxA==
X-Received: by 2002:a05:600c:4f47:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-43891453ab8mr109138045e9.28.1737378579928;
        Mon, 20 Jan 2025 05:09:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm138001955e9.17.2025.01.20.05.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:09:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	claudiu.beznea.uj@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 0/4] Add support for the rest of Renesas RZ/G3S serial interfaces
Date: Mon, 20 Jan 2025 15:09:32 +0200
Message-ID: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

The Renesas RZ/G3S SoC has 6 serial interfaces. One of them is used
as debug console (and it is already enabled in the current code base).
Series adds support for the remaining ones.

Patches:
-    01/04 - extends suspend to RAM support on the serial driver for
             the RZ/G3S SoC
- 02-04/04 - add device tree support

Merge strategy, if any:
- patch 01/04 can go through the serial tree
- patches 02-04/04 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v4:
- dropped fixes and clock patches as they were applied independently
- dropped DT patches that were already applied
- addressed review comments

Changes in v3:
- in patch "serial: sh-sci: Check if TX data was written to device in
  .tx_empty()":
-- check the status of the DMA transaction in tx_empty()
-- changed the variable name that tracks if TX occurred

Changes in v2:
- drop patch "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
  from v1 as it was already applied
- used bool instead of atomic_t in patch
  "serial: sh-sci: Check if TX data was written to device in .tx_empty()"


Claudiu Beznea (4):
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

 arch/arm64/boot/dts/renesas/Makefile          |  3 ++
 .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 +++++++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +------
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 13 +++++
 drivers/tty/serial/sh-sci.c                   | 53 +++++++++++++++----
 6 files changed, 149 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.43.0

