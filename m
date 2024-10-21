Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BF1D1F51;
	Mon, 21 Oct 2024 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495609; cv=none; b=oSm3MwW49C5k+IYDxci3B+jpO07FOSRzEEgg4EMc9QgcmW2eJsZe2ODpe2ZTOD9RiJMzA2dI/t1MoLA2mJBOfI2UoX9SUGsJQgqCGjRPjApeYA01zHQMoE+H2+fO5mvwCKXF4LBejAGk7IoL4sQ7RQnLpd2aLhZl/dQs0XwSHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495609; c=relaxed/simple;
	bh=gcp91JUoPs0k9rrxG2Nw+dNiRa34pHWsEoX7HNT6/kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJFO6NH+L/+cn4dxCRkU51ghoAtHaJBAXC+lsrxeOURg+yS8VMuYF2wI38HHT7k1E+hDD+0c9/MrJ8r4xDNxkGu90r6+51quXFTYWEbXMIKghexpioP1xL5tWqtvzHKd7FT97hNWsskQtG+0XnluQ79IfGEeuvnqLUpUuqJzB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4tEa+v3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4tEa+v3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71ec997ad06so404335b3a.3;
        Mon, 21 Oct 2024 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495607; x=1730100407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4j1C+M3vH4yYgJravAN3BbrEjhxeaomVoGP3HhhhDJ0=;
        b=c4tEa+v3KUS5WHDZbqCbKvK8VBzBG48AZoHoD6Mkxhf/Yn2fBm6MwHF+Un2xa2R3Hp
         oxGNPg4tbrJg8LuTPfbPOih6zXl9HTKc0sLv5vMxPhIBipbknjWQBLR2aSOhYsS/dO+4
         +LY6sPs6ATSXeMjqK+ylsbp7hd5pAYT+9YjQDv9pGAJMSq49OKtpCHLKksb7h/ip7KWO
         vrhbQj3t6VTWKAOLPE8McCab9tFHnrXNm1AoBTViyhpztzTTGO8SPAG/iv7fPm3warRL
         xhVktkQFTqc7VaoAkuP6DPsc4WrPqiWuiZRtEJpQsRwqsKvpHcfyWqTJ4NR+MM56tl40
         Gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495607; x=1730100407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j1C+M3vH4yYgJravAN3BbrEjhxeaomVoGP3HhhhDJ0=;
        b=X9aHg2iyPZQt2c47N1DHKOyCn7kIpLKzeJIWZ4+TOtP3JVzj7MNibIjIom/WkqPgcJ
         nf0XavEwvUKAZ88QYRzWMDdLtIKwTGzzlzLBMAONsBG+OHMIwCFc6oSNyK45qc5XMu25
         x8gag1q4LQ5T1HQH7WVS3Oshvg4knMu8ep8JiQp7NoOmXzpvq1oPztrx9suFCgt0XDvw
         dCLfGATurAPebZSQuau5+cMZWdHSE3P/RW+GlAJUgjQ4lihqZJpJh1gJuckaj92tPwZ9
         4BfJ+5R7eGAWUCjrKsh/kOzpuON8/DMK9USvqlaLsoyGcaUKvU0RtdKFTwJQeJCSMeCx
         sS/g==
X-Forwarded-Encrypted: i=1; AJvYcCU0hyLPxAnTeINapDotmg1ZVWXhPZ/tU0il+e/VjyqrsRYRa5mxq0zXrOkAxnV38kCEgZh3CmXQ6MTGnRZ0@vger.kernel.org, AJvYcCU6zCjeOFcGupog1zo0wMnaok6+gDyFC9Nsq7hKdHOd8J1Pe94tdV6irSFImz7qFGBc5w6kxKQ3GAjA@vger.kernel.org, AJvYcCU961du6twPw80qdVtDiBdT3/KxOEKP0FT3ivHmfe0lKJqXpj0NDRPvSvaDHHsJ1Il+dBb+edoHnr9iqjQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZwk07qZ1l+aR47cblojysnp6ferM+yrp+TG+FgJL5o3UDZJp
	rsnZOwJoy6INBBEkMYq1Ru6aRUcT062ZMsWYXnJd34/c8a2j9mWV
X-Google-Smtp-Source: AGHT+IHqb73yFzexKFbAhuZdRp0bva1gxzmjy3KtNaUbjHVdxYDfeC9SLwusYN3X4iYo7hlJCIpGAA==
X-Received: by 2002:a05:6a00:c93:b0:71e:4c2f:5bed with SMTP id d2e1a72fcca58-71ea330c78dmr14610957b3a.20.1729495606604;
        Mon, 21 Oct 2024 00:26:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1356a24sm2263650b3a.96.2024.10.21.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:26:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] serial: 8250_dw: Introduce SG2044 uart support.
Date: Mon, 21 Oct 2024 15:26:04 +0800
Message-ID: <20241021072606.585878-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SG2044 relys on an internal divisor when calculating bitrate, which
means a wrong clock for the most common bitrates. So a quirk is needed
for this uart device to skip the set rate call and only relys on the
internal UART divisor.

Changed from v1:
1. patch 1: improve the bindings commit message.
2. patch 2: rename jh7100 quirk and rename the quirk to
            dw8250_skip_set_rate_data.

Inochi Amaoto (2):
  dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
  serial: 8250_dw: Add Sophgo SG2044 quirk

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml         | 4 ++++
 drivers/tty/serial/8250/8250_dw.c                            | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--
2.47.0

