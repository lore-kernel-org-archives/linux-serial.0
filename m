Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EC3BFAD4
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708108; cv=none; b=mXxWCUTUlztnQb29ymSCJ3xq52H6pRAGAgXpxLUiff4CKJVABF01bx3anGLgCm8peuXnIAFUMxNsaTrNu7+ARwsuQz/KVGd19Ge8pXDlIdZhXuIEOutlaV6Wuc4qh1eYpBOqcrR6ZsSzttWeG4Ll7DMgb0bYM9/yVyJcA91sUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708108; c=relaxed/simple;
	bh=L/sIeqo5TAzLfSgfOfVLZxiWCo79S6F2nfHSiF7e1AM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aNnaEcco16BBtaxFkNkNyd1vSWlPN0kErJrlz7B/D4wXLpSovDBoeBndRvBX5wfYaroFrDH9V9/PGCyuwAhJ6d7yRUuht0gC9v4NXRka6RfZtQSUCVXJhtgcO2Mh7l/A7MLKyBWxsZpzlzoCTlmY5KF7P+R7GCpeINGApH7TpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAObaNfE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAObaNfE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so75248105e9.2
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 14:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778708102; x=1779312902; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEBddq2I9/xi/Y/+09mKq1a+W0z/iD8O7FvkVZ5efms=;
        b=SAObaNfEA9eLIe9+FXZ+tQzaeC8gxl24K3LyD/fLXL55VjMH2rqgn+BnD5GGc3IKqS
         0DLvHY10ltxSkHjMdhgBXQ2/DDOtI8+GAy0EHqfRsxjkqs1of33i1E6YQM5c71aiAAnf
         YMvrcv5mvm7OXCcD1SrqfSmTFSZRGiZ8E5g0FT1X9JzA/ruGbzphgYM4CudZ0clqkEWV
         kCu9XfZLXwgVskiRGH4xQRR5465gCmuCH2USMNFevs736Z5FLE+GxJVcdgjuAOnwodI7
         nzK8RP9E9o28wkiSb9RBxgnNpl7Hb8+eaolVQqqqLKCfcFXhBd3+uwL8yAHxVYNV0mS6
         qYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708102; x=1779312902;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEBddq2I9/xi/Y/+09mKq1a+W0z/iD8O7FvkVZ5efms=;
        b=L7uuz1Jfl5+QaHF9JIkxjPQhIuCSN78ZndL/OIycbOlIYNg9OT8F5RUijJFcEZy8q/
         /eYAH94L4kkXn7smTyxxzLFw4gvDgzBegLPmXartICLJGNNYXIBHAGR2BTAyM1ADkZP0
         v6uOHecr/Xtqdt9SoXPmjYnZRT4E959sDMpyWoaEpK9dCyMABkamh9hSFPBTKlrGdkVF
         Zulgvejp+r/ocKsXTQbUNx1J8G6LeytsP69tC5hjLkt+7sn7eZfO4Sxh073fY3jozzax
         Pw2g8qfZ/4QyydlgLfpBHJIq5k4zX9lNaiKCeF4qosB9Vzdro+jv6Fe6PyMbZFblxMoV
         Hn/g==
X-Forwarded-Encrypted: i=1; AFNElJ+Cyrsb9MV2ypvDg71UJYizSRHBNSZGRPgZErZwv6GL5mjOieYE7kyUSRZtz3ZkVUwKVqSTZMPRb7PrbFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/4nJEaZQoHraSIAtYAlqG2Icu+2ofinJZ+XpOyKBmLlgmBaQ
	V8DLZNtonr6ViTJfI+iGEb37JbT4fHW+nrWdvw+F7CO6wTPi6/3VYy0F
X-Gm-Gg: Acq92OF8XicihWsCmMQxBNvUqXhRT+rW/8+XfQaG9y9gNjeO1BVkYC84tCQZnuc46hS
	C2mAldURdNOnZOgwjUD+V8vJFhOYv1S5uE7SJ71OKH+20JxWzKeednYuxLyDhE9IaIeI15b8DYz
	H4pC1LMeExC2ylT7oloOjld28+iSS2e0x8q9ZWRqJNli8U25exHW98pgOasmdUENHXUwYiaMDXE
	1HCLFLFLZsa3wCgYZ2JmF+G2u1k+oISEHHN3MczUMowHxlRdkRjwfZfiEbF6dOHi4+QkSSf1MrJ
	arRaOEAXVeaCs5bCdy5GPgTpPNqeKb2WtramXgd+J2qLK8MfCCFiayQHXRskVUOgzKewb7pAMKS
	8Nrv20cWNCYOa1/xseF42cD3COwfti+OceH+82nWHG7Ddcz2UwYekDub8No8V6lJ+aVwLd3Sb5C
	HXSfWgGR98hmUGHqwoPYj9huZwza6GjzOZ+9hpS8S8JHg=
X-Received: by 2002:a05:600c:6217:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-48fce9d92bbmr70751895e9.14.1778708102024;
        Wed, 13 May 2026 14:35:02 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb1fee9csm2553055e9.0.2026.05.13.14.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:35:01 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Subject: [PATCH 0/2] amba/serial: amba-pl011: Bring back zx29 UART support
Date: Thu, 14 May 2026 00:34:55 +0300
Message-Id: <20260514-zx29uart-v1-0-68470ecc3977@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/uBGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3aoKI8vSxKIS3dQ0E5PENHNjQ2NLAyWg8oKi1LTMCrBR0bG1tQD
 /2TtwWgAAAA==
X-Change-ID: 20260513-zx29uart-ef44af731390
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=L/sIeqo5TAzLfSgfOfVLZxiWCo79S6F2nfHSiF7e1AM=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBqBO6Dl3/1/DRcjANJ0f1RNC59xVDm3d1kR5c9s
 i/RNdUzi7iJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCagTugxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiITwQ/8CHj2/Yi3yO54KxxakskmiteBJ8oXFPG
 ZqES5WVnpQrdzLVVy+LfILJin+nX9wMOj19hqwt234T6LsWXs0+Ry49fL9U6IOrEEqFUHisCLNu
 PKVJrWlwdmBZxpqhwE+FIo6NZp/M8KF9L7KUbHNCiG3pHaFOWwlICzkoROoFFhNlFkCxQ0Y4FXi
 qK7GN4yqcCb+VavGI1COzepQQvshWATUgkZbQDT18DU8cb4dYzXVJ+wcYmnyObBPlWtxLNvn4UQ
 x8c3IOpCXCPLbdjbpHNqbk6QsvQDldyYK0nQP0B0UDhZQETjtu/FsG+gLOhTT0b8s/dpAF+inRA
 rcdhCuuvOVzVF12r5g/SMWai9mhVXhWtvod4jfasfZKdcHi5TGHSPwHVxiImXz2YIPh+2CsIC1+
 LnSQn3vBTF+Sv4zCg4e7PcNicp3lNYtL1BkRZUTuAOod1y2agvhhlvK0Ywy72DqWbtxbgJniSFd
 j2XNnTyGdQvHGinTNt9pdOyXlmSLK8wZjAzdWnR1Mqij8wxZzNv9Oq1B8m53fSSgmh86zf/6alR
 ktyncFPy1U52AjUdVWScq8G9QShYGHTj/5WhbIdxFw3DzYsML3dvbyFTBy2bN0JglkCNtnHpGbS
 cISdk1NoUdw4ODYUIijTMcFYLT53Bh00d2FqxjlAH2Oj5eSL0BYg=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on code removed in commit 89d4f98ae90d ("ARM: remove zte
zx platform"). It was previously discussed and reviewed on the 
linux-arm-kernel mailing list as part of my patchset to add initial 
support for ZTE's zx297520v3 router board. I am sending the two UART 
driver patches to linux-serial. The rest goes through the soc list.

Note that the first patch (LLDEBUG) uses a Kconfig symbol introduced by 
my platform patch, which was sent to the soc mailing list. I don't know 
what the correct way to handle this is. I can delay/resend this patchset 
after the soc changes are merged.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
Stefan Dösinger (2):
      ARM: zte: Add support for zx29 low level debug
      amba/serial: amba-pl011: Bring back zx29 UART support

 arch/arm/Kconfig.debug          | 12 ++++++++++++
 arch/arm/include/debug/pl01x.S  |  9 +++++++++
 drivers/tty/serial/amba-pl011.c | 42 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260513-zx29uart-ef44af731390

Best regards,
-- 
Stefan Dösinger <stefandoesinger@gmail.com>

