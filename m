Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22F1E282B;
	Wed,  9 Oct 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517159; cv=none; b=qPCvQuzUPdpLa/WO3CzWat7QY94R91jA/e+41kbFzHzH4w6fgUEmh9PaQAuCIUi65mYRFBMdWPFI3uZGUf8FGfaGz862zv5fR8bsy0zjCfZBH8bLmcTcsXGR93w2/X1dXqpQL67vSt16e25mPs+dVLkOBk1yCxZQ+TU4Gzm3sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517159; c=relaxed/simple;
	bh=rSnkf6AzN1stli715Dvd/eCIAIPoikgjlJs78kTVG34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEPOf0S3D41+rIiRKtKbxi8b5tG2SItl/GSEiC0IkARwZIPs8itSLH4mateCCn718hwQcYt47vEDhiP+zsQ6OYuBlnDjsaJg8GchTaxrCy85jhd+6nF2193p5nv1m9nKhsibgwHPcDMKQHD7V3Sa7SJM18NEktwPOeR04lKnu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsIGYjoW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsIGYjoW"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b7259be6fso3371405ad.0;
        Wed, 09 Oct 2024 16:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517158; x=1729121958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7YDVGuCGzfm2yKn8XXH6Zv5BAq55NN1l2El92j++bwE=;
        b=XsIGYjoW3H10Pd0jCcMChC9duj3Abps5REHECVfwn8k4QH/Ik4x5yN0YqGnxT+sWFz
         PCPF98TopM4cagFFbSOa+zJ54sxnaieCSwUNJkdLkeUSka4DFmZ7mjaWOdow755Mji42
         XSvyy0tVeX2SYFcKBehOCQokYhosdBglBj0OA4BEoW609OCd3iUsSIOdQaLZjDc91BOG
         Y99IzY2mtotHjs07jrQxMSc5ASm/A3pgVJPXZplHJy8Tm5Evn9q3xXJ6DAzsZTEak5UB
         n3o1kaVhEJ8ZIm4qPGnuMWJUlZv9Q/8+taLB5kuPC9TPTXOtpyfu1JV6NH1689FlWBBP
         47KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517158; x=1729121958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YDVGuCGzfm2yKn8XXH6Zv5BAq55NN1l2El92j++bwE=;
        b=S3Mi+E5TFYpQVetw9kSW5oZ37RxCeMBkt+slvFVdYHo3DM1TJp4iZBUXVtrUGB7NGm
         HK7AjJjsKNxv3M7F0+q71nxoSpNMScOCGM7uGRIW69KIMT89CmJq72vHqEDeOFBzBgbY
         cGWruYc5pnIm7P/e7NKdFeAmc3M0EeO3h8Kee/Xs01BS68fmMDVRffYpujeKGamoVuUb
         bpIBp+tTvWoB5vQtqXISHU0b0+6KVVQ0CoJKKf1w6GEI+ldCtNvlF1+rhgGtQvYfrcuN
         n369Or3X20wC3UE5tCWFwfWktkjUmRU9rNqv/PwGj/HYmQPQEF5OOCXDuQNltvbeVFea
         NlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU703UeAhbi5gx9tXaWopBKe0yDu4tMIkK3Was6yNIf2aYATxY65kVS2skOlT2Cw/Mv4fHpibMoIzS4@vger.kernel.org, AJvYcCUhMiJKeLzhc4+FCWRjfZVIs8eVbWJ+hKmEWwl8zjOVEZjfz9iGpTqvCXJrol60CsQFGCs5TyVU7FBW+hTK@vger.kernel.org, AJvYcCWCnjjKWP5HBnLi/CUh9Pm3/yW9H1I6Xi6QVVmdOyIvQKAvIWdTzDGox4PRSCVAgih3n0EbEHseWgAHWoGk@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPYeymuvI34fvyB10bOwbAonS7iHFylwJ9k3aX0GK13H9TiFM
	BAK1BX475ymkmpn8QLBtSAPpKlhPa0LI/iwsN8sy9CSDmhDeNXZI
X-Google-Smtp-Source: AGHT+IFwVVyJJA9t3xXddWLFUsO9r8hffb9ogg4a0pigMHQ92EYSNpcj53Uo1V1aEcW82g4GITTM9g==
X-Received: by 2002:a17:902:e845:b0:20b:8c13:533f with SMTP id d9443c01a7336-20c637341f2mr54030135ad.24.1728517157805;
        Wed, 09 Oct 2024 16:39:17 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138ca835sm75542885ad.68.2024.10.09.16.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 16:39:17 -0700 (PDT)
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
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250_dw: Introduce SG2044 uart support.
Date: Thu, 10 Oct 2024 07:39:04 +0800
Message-ID: <20241009233908.153188-1-inochiama@gmail.com>
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

Inochi Amaoto (2):
  dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
  serial: 8250_dw: Add Sophgo SG2044 quirk

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml        | 4 ++++
 drivers/tty/serial/8250/8250_dw.c                           | 6 ++++++
 2 files changed, 10 insertions(+)

--
2.47.0

