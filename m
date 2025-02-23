Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7E79F5;
	Sun, 23 Feb 2025 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740287695; cv=none; b=aCN+vIAWnnu2A/VzNh7VH9En+GY/G+y8thh73PEdanoxyz8sjp8h4LsnBqJskWv3Ogv8wc2Ep4v4U5rYvYLAyC5EtFMuSaIy69E6rhJ7TDdzKMbs2bj6D4IrNIB9vpemjn3NyMyErQlLCtNxHlJu6qyEO2Ap2k/WwyFc6yk6k7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740287695; c=relaxed/simple;
	bh=ncpsk9cNOqw6vrSIu71sFLiOveirNsnmEz9xFM6JhCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2cxou+xZ+kV/xoqcY62bXJVJbWNAFS39AMWWwZqxKI8JqusVk8wmrbvjlHoSoIyiCdYm5AAjBgxCrOu19sU+7HNj2LeeKyiCDpIlNOCR7MReDlLOPEIMRLuo0uKqU4CXWaG98nP2788+L6ZVtjE09gAafybewVymTsl9BYn8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkeQ2178; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkeQ2178"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e6621960eeso44225616d6.0;
        Sat, 22 Feb 2025 21:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740287693; x=1740892493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRQUbg+xoHD7DWqFb3wzBs78IxHIABHzJMvizHN1NaE=;
        b=DkeQ2178ntUYOYL8K6H5Kt2hcu/1rQHyISAQ3kF10EQYabQhNDRxXCvfX4u7qyHc66
         GkPlEz+3dL8U7kEKPTPeLiRjYV6TOXDHUzfqbEtQPAeFHXNTEmQ2qp+PkdVKQyAWQasD
         MIluzzWOS9ZJ3uljLnBIU9M0Nh7D4ZjYQHCdtZVxQHoV2CSw0q4jmr11myRY3FOMXXxs
         dxZhvBj0FTwoimg0Q7Plyu9pqtA0pGLIjb8WKXfaB4UkSMMUqvPiiDnaw+CV6Ey0Sj7r
         maR6Y6LeO1s7vfPITQS5aqU73gWvKDGNOO9kFppbTjCQXSSheJEFgFqjR51oNle7EVqF
         Ixmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740287693; x=1740892493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRQUbg+xoHD7DWqFb3wzBs78IxHIABHzJMvizHN1NaE=;
        b=YfMI1egoT449fVsvM+8WzoeXkesridcnCCNNI6upJmk9XzgH8rlDinw4Wwr2pUhzbc
         OAV57556RmatYLdThMSWJV7cv2xv7IlZ5P99IP14IdfFFmAR3JX2Ut5csT0t2W05jqhJ
         p9YYX6HgpQ2C9RIUUnlSyFGkFCvexif0naReWw3P/qlORjV+54QfMqb4AZC5VgS7oyHp
         kpZ0OJ2fCkWFvqiiPyd3aVsD5Jj1WBY7vSY5976tA8Ri/VFMqQgK/lKvrkyt748ARUlB
         xG98rI8dC2v7f8IwZK3uytHkxFFajWYOsl0IPd84HSI4dCUTfvSlKGU28vbEM/mfLv+t
         fU/w==
X-Forwarded-Encrypted: i=1; AJvYcCXBjg3+4BAytE+lfof0jbVPkYAxCWaleUwqVJUz2PsZ/iA60bvD1xg0o6VB5G11mFiTzTbX0p5SudEGaOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztaX7FwfvHzlmAn/dhniOed6zKj4d0dH/oAYw2LM1/vFSsf8h9
	9Pj3DmMjdHDJykQ0MvMObFVnyNG0dAK9GixmpwjTEZJsWgXqMijHf9OcSI/W
X-Gm-Gg: ASbGnctBJGr1RE3vJwVkmVtFD0B5WcYLbOyHjjwHrFBgj8Z/D6LMp9pWzc0ca6Z8jkE
	/AqVd5Sc78A0gwZJViU5ezTwP3RrvEHXztWCOgKQEE6Xyg28nUrsSASwJJnEMI/ZwrTvcF+/V36
	vYO7u8eTxm4sF/1L6KUrqhIbQrrMAowYpO0ZKNrcekQ5Gd4Mj4zRkXiGMk7ZOHJVo1zJbhRpVuJ
	9DtQKIhym4bNGiwu8CCr4E7inGey1oW06uWuUxQVNfOOz2xxaJIpG03YkXmm/54Cv5BxVmtrd9E
	jGkKTB+kAG/JTZNJ07oZJPMrTATeDPRafO1H+fTZrMfr8AVzS8p4odJDkVG4kxu1
X-Google-Smtp-Source: AGHT+IET6xAa/SEY/3GfkeWrsVpAnq/XGp53o0woBBOM6jwjhJVNSI6LsOcSfK3cJ8B/XM010+eOsQ==
X-Received: by 2002:ad4:5baa:0:b0:6e4:31d9:b357 with SMTP id 6a1803df08f44-6e6a257da1dmr173578506d6.1.1740287692853;
        Sat, 22 Feb 2025 21:14:52 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:104d:377c:5733:f5b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d784e99sm118544836d6.28.2025.02.22.21.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:14:52 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v3 0/2] Optionally allow ttynull to be selected as a default console
Date: Sun, 23 Feb 2025 00:14:39 -0500
Message-ID: <20250223051441.1861603-1-adamsimonelli@gmail.com>
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
  tty: Change order of ttynull to be linked sooner if enabled as a
    console.

 drivers/tty/Kconfig   | 15 ++++++++++++++-
 drivers/tty/Makefile  | 10 ++++++++++
 drivers/tty/ttynull.c | 20 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.45.2

