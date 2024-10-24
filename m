Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0F158862;
	Thu, 24 Oct 2024 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750891; cv=none; b=jBvy8Jbg3DC67aIB4BHXb6p64ygsRM9Z/0bBulZbul0JXEEuhpzoBrqa3xb/P/D+i5n6G61MH5Bh9qsvqwjQ7eECIa+cS7fnjQxapYUy4wxo2nom/oux7cXdTLLRbyiAm535pivMDHrI+WkqJ42I6p2FKBvTSldxW3ChRoM1p60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750891; c=relaxed/simple;
	bh=zjdRAM3+B0fHHnv9z2n5vLwdmjBLqdMCyxaBsi5vyxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YagjL5gljb0D9OhjpwJejPYKj36u27RkiUmuDybq4ToJ4jrIkSoOB8ho+Nt4zd+i+5N81ChRlvzmbvBUeFrwDzKK4FNo50MtLHVbfoQSJA0Ysl2RXKccEPbTk/hcZ3sgsTkE9u13aVo2L82hDWJb9lz23W8dQYvz8WB+8l64m6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzg7VnwY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzg7VnwY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e625b00bcso419202b3a.3;
        Wed, 23 Oct 2024 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750889; x=1730355689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4nEvqW9fLhXxDii9vep5FesFUn6q0T5hajwCKZq+J0=;
        b=gzg7VnwYjJOARcH48hTzxKUe0Z6leycr2acfpqBTne6xS9N03lB2bXKBljTA2v5rOl
         h1OYjs6vu8TmEjo1T91yL8SENAelsaBz6B1yycOGloCBlEYtMPMkRF+2ZffXVgOwLO7S
         Kakh0DlSt+M0hkeHtKXc487C8D9nMY633B867rBVEKI4HKbjVBJDoH8eTdFH0Rv56PkC
         RxrElOe82y+/0XkJVuvlxPDN4bwDuHW0vqFjEsbOANZr+QJLUMbMNfwOtF73FOEq9/nl
         It2nfVhNAktw9cgyR7XKjxBMGzXlPvE05JlUuED7DbC4gchpZzxDZB6Q0dCPKia8RZXp
         R0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750889; x=1730355689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4nEvqW9fLhXxDii9vep5FesFUn6q0T5hajwCKZq+J0=;
        b=d+tJyr9F8JSq73SdBQtUPdE0Dqfajd8JRalBCxqzVOcjb04UcH341mSY4MVpPcyfuv
         MNEIk/8C2dTHnusEbnkPoUQhVJdXqSyQ9eGSJTatyN7xydWPE1w3RkUi4wMt8imx0HLM
         Uq71XQBscntzS/fwjZlP2RSGMtb6WeT/Ej8B7oKPS2iCP49Ec+G4b0XRm1bsqXfLblF1
         DX5qQOSIVEIWdsgNjiCYlolw2OgaEAPS9TwYEQeZGlHBofOA+/Fmh7BSkmwkNifjNaUg
         To+Cl92Wc1Ygxgo0LtBdai0678upF3TPCp8rlvshuofUAo98gaq9Y+xPF5VK65sRbXCI
         EpUA==
X-Forwarded-Encrypted: i=1; AJvYcCWq0rwJXIjJ9mCf8ZvksV3Z6c6uU6z77STU2rHv6eJaNw8Yn7By1YEh+6rBhuIdB5ll8N5oO87/C890Iosh@vger.kernel.org, AJvYcCWsbHHgJBS0RhTZk+Iucdf7hQONocURduNc8+HMBN9ROs4BhnvPg9yTNVm1V5HeKfNMEhSypPrtEJSV@vger.kernel.org, AJvYcCXVOr5tR33+crSDXpo0THW89SYceTuHmt+Ix5dQzVbigM0qqK9YtNSW/7+VzLIwFtFWvPZzhL1qScz0e/En@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEem3+Mo18u6hhu9Jw6zfli9aaFHW9EvmG3LPvOBaufPJWba+
	K8pD2i4n4S8p43J+zaJQPvl7Mdtrpw/fn9ptfNlbmCYBkldt+5Wy
X-Google-Smtp-Source: AGHT+IEMd+aK3RmvP9zA1UR+zfF7vh6KGqHTBpZsv4u2gw/qihAXA7q52QRbb04tV94hvDyTdiugcA==
X-Received: by 2002:a05:6a00:4f90:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-72030b61826mr6992531b3a.21.1729750889306;
        Wed, 23 Oct 2024 23:21:29 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141b799sm7267231b3a.192.2024.10.23.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:21:28 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] serial: 8250_dw: Introduce SG2044 uart support.
Date: Thu, 24 Oct 2024 14:21:00 +0800
Message-ID: <20241024062105.782330-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SG2044 relys on an internal divisor when calculating bitrate, which
means a wrong clock for the most common bitrates. So a quirk is needed
for this uart device to skip the set rate call and only relys on the
internal UART divisor.


Changed from v1:
1. patch 1: improve the bindings commit message.
2. patch 2: rename jh7100 quirk and rename the quirk to
            dw8250_skip_set_rate_data.

Changed from v2:
1. patch 1: add a new patch to merge the vendor specific compatibles
2. patch 2: adopt the new patch.

Inochi Amaoto (3):
  dt-bindings: serial: snps,dw-apb-uart: merge duplicate compatible
    entry.
  dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
  serial: 8250_dw: Add Sophgo SG2044 quirk

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml  | 11 +++--------
 drivers/tty/serial/8250/8250_dw.c                     |  5 +++--
 2 files changed, 6 insertions(+), 10 deletions(-)

--
2.47.0

