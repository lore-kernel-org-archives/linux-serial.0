Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CAC273FD;
	Fri, 17 Jan 2025 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088476; cv=none; b=eppwhpkpXXyWMlaWBLk57cOw/acMt6S5olxpkLZQpJHJmtvTHwO7kCz50Z7EL4yjD3GFX0uffTR0EcW+eoPwYNN13ubE3fZrMV5pfJlX9HGg+YtNfptNa2JAfvKAYwRLZKhDf+sLXi9wbXuly0YqlcOyHuYwUqmwFTs2Xk5xVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088476; c=relaxed/simple;
	bh=7MQHiuMAV9+vRrgc3f/3UGIrvD7rP59vPSlKb/jxq7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+katkJwpB9PjQPiakBp7ELeEhTSOQtIjVSFY8C58p9xKgYWoPeswsyrBd8FrNPIyD5mteB7vJYWeUbe3Qfju5A/ZmTu9VCk03biKNTWHudWsMey2f6U3i1XRf7jSmf2i6RwWTjqQX/0vzKJodG8EePPzeyB5k4H7e1WPPn+5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jys+5u8r; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jys+5u8r"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a17055e6so19937731cf.3;
        Thu, 16 Jan 2025 20:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737088473; x=1737693273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkLZvCKpMNg6f4YvmDZSEEZjCi5oiumDkm9+yb98w8Y=;
        b=Jys+5u8r5gRpRdzmQ3w3d4mVuXbSP70U+BRxF6yaSZWTLdMozcVvf/Wcg8i1Ad6Uv9
         lXdK/JeBLnF4vKAM/DupQbIRMJSekmAHp+CuKazd4eWfkGeNRoOE/3nu8AdENm0taNFL
         FjNelqxSLjScVtSNqP5Fo0DNaHjILETGGzwfIf76e10ESYyNfi8SRoz3gRbOZrr7RmDg
         rczwxk+h/wH9s3UKw6v/5qQGzpElE1nj+S9SkfBfXgvA87eq7Yjw4LoF+3+FXLc+CAjL
         boH3IwWuqsR/I9w+Q2qjNvfeG82r5G3Wlqx6xP58QeecuafY28AcOUicD+AS9l7L12rh
         JEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737088473; x=1737693273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkLZvCKpMNg6f4YvmDZSEEZjCi5oiumDkm9+yb98w8Y=;
        b=jvtQ/ZBYYEVICGfNc1PMP3cjJNexsYT6yLecduem1IhmUpVm1ultxLEQT73GBOxTfw
         FPK7W+0NjCKQaUwCIXVy2bErb5iZQhkgeF+49PxREBETJ5s1jz1cHIGieUe3pW+T+EGd
         WfZNNAIlq3rV9c/uGaRqIDIzqnxIW9MGSHmEnrYdRkh6ccUaqxPDubOD+yb7hzsUHfW+
         A4+vqwWCc4HErMjga42oo0gs4HfAeTZvkYb1Fw/dbITcr5JJAWlJ7SkIJldJ4NkoZrhQ
         JOkqtlByJQjayJbqT329I1TRX540rpJlW5FyOF3M+A5VRV2IQr8iX7NvrlYHDjnhu+v2
         nv7A==
X-Forwarded-Encrypted: i=1; AJvYcCVdvZzzEYmZaaIy7mCczP9ZdbRpcYvGJL6TvY1tFzCm6MLe7jCZSAFX9PT2csuR4riifkDP+zGq1IzIas4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcviVjXRy+w6ySevnlj0xzIG+Y+DZZcsAyQmRbqsAbDxf8mWW
	+6ohHDGndzX5HAWSTjNtKp79OsTClrm2loFASUec9IkCmS1SoY1EbmMq1a/9
X-Gm-Gg: ASbGncvhZNmNxQ+ML4a9mCWokFsOu87lPPeNaq0Wi3TXIvX05V7w5rTTvKYC081EYYm
	ySACCNNciRVJkLoll1ZJSEHdOgTvfpaIM23hzzDHtrqYcnAyg+h7R30PK9clDoqLtQUoclQkN5q
	nb1e2ANNTZ1HY4GoT7FgcDxrQicdDIyFnwxY/X3PIIPnnsG9+e1l2iFeXenJQ/+Uh6JsujrDORd
	DcSmskZ2rzD3Ql/Z8aYCYPtGZqRq+3RMJZOJE40HoQJWbJJjuqgiMyL1L5aXUaNFsWK3xv2/eUL
	pFou2R+DyK9NLgXciGBiiQSDiuv+BK9HJRMvHjYT+RpZZf9vHJyDhv3nHzU=
X-Google-Smtp-Source: AGHT+IGXyESXqs7HnNcYBW5u0zXNoqRgSgi7xdvFNXgKQlAOApho1+LwOaJ8mWetFAl/ZzCzs84Lew==
X-Received: by 2002:a05:622a:1455:b0:467:6710:bbf5 with SMTP id d75a77b69052e-46e12b57378mr20325111cf.41.1737088473338;
        Thu, 16 Jan 2025 20:34:33 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com (pool-96-238-19-91.prvdri.fios.verizon.net. [96.238.19.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10404a2dsm7514911cf.52.2025.01.16.20.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 20:34:32 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH 0/2] Optionally allow ttynull to be selected as a default console
Date: Thu, 16 Jan 2025 23:34:25 -0500
Message-ID: <20250117043427.1512743-1-adamsimonelli@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adam Simonelli <adamsimonelli@gmail.com>

When switching to a CONFIG_VT=n world, at least on x86 systems,
/dev/console becomes /dev/ttyS0. This can cause some undesired effects.
/dev/console's behavior is now tied to the physical /dev/ttyS0, which when
disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
and users who upgrade to a theoretical vt-less kernel from their
distribution who have a device such as a science instrument connected to
their /dev/ttyS0 port will suddenly see it receive kernel log messages.

When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
the ttynull device to be leveraged as the default console. Distributions
that had CONFIG_VT turned on before will be able to leverage this option
to where /dev/console is still backed by a psuedo device, avoiding these
issues, without needing to enable the entire VT subsystem.

Adam Simonelli (2):
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be loaded sooner.

 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/Makefile  |  3 ++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.45.2

