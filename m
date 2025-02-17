Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C8130A7D;
	Mon, 17 Feb 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765281; cv=none; b=iGFqxMMTyaGk9KjiwfCQZdgXBBI4tiL5Srmj/h/E4joqQ9Ya6GpfWf7ZOO2WEpDP6HjuBnjPsb8C1XAK9ySAhU2d0H8RZpFzDUnVrCWPb+ZDysxnwFg/9I1I+zMnEVgss3YXFoPGfZC43RstgoHTc74d6v7uKYNRg5afGdo9MDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765281; c=relaxed/simple;
	bh=lPClXNApoNzbWFxTd0Jl+OkdjiTXoZi3ipz9N7g6AYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDyq3u7i5IlQqYjWdXjZXmxrUtQGXumlwfSEIaUX+0te+4DgtPdAqaUP6P/bx6p10qZihWaD4KBZx+fYp2cpqjMuZBFZtfXjIn8RYtrF9VVWjfeYTYJUyVvp9TuUWju7KwObtQcQOAJo8xJ+gTaXeEzhnQbMA69422LpLd7YsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVR2UGnq; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVR2UGnq"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be3f230436so384657085a.3;
        Sun, 16 Feb 2025 20:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739765278; x=1740370078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyUwS1JvUY9BoSWB5K0IfUZRbnCJPsGbjmmiXW4NDXM=;
        b=kVR2UGnq1bOKw1y9qMQY0Nm48yzqpQ/DHVFa9OPZtm/eAFT1kSvIC43daYqnk7I1QZ
         lRa2EyrpG9sqoNIm6O88XqGP/+VshTuFWuJM8LGYI+x2ZpOsXuNhuSbTBo3SrPOLdoZq
         epPeJNBXughdZ+xeot4EGcloe1Hq7rpTr1WH0no3H0OcaG4yuVY01Ovj3fE4ZrSGr65g
         mfu22hp0dsimNGYRMJbKF5ymLnFR5liwdsGU/YHzlZsP7H+pB4hTuBX3dWPEj7fv3GvR
         NIxFkdhY/6OP7NrCb2N3QhLChqJTPczc7zmNBPYgLoBL/UPKshGKguYr9PyhtMzVosi/
         dR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765278; x=1740370078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyUwS1JvUY9BoSWB5K0IfUZRbnCJPsGbjmmiXW4NDXM=;
        b=hlpm+OtCaXXigXVRcdrA4wp5/N9XDW4i3+zozoVsPDC0nSj4x7aTOPZjKEdDBFBAET
         KkEMsIYygrOcnvBISnqXF5reJUMDk1tN1M3bdNbM4zZObTTCzeloe99wiuUPCYJpmmw3
         zSAkt4rVLklpXsv5GtykMpXejaHDxXb4Jf1O3rt09EyVPbuFvqxN+53/t17ePrLhkE8/
         31A5nP2KQos4NVBI4JcnbCXNJGEojVUG3BO1UMvyZit0VNv5eas/5JGhRl83Jjt1eh2h
         EhiOr8IOUXkFGIyqjrX4jJDkDv2EXxcyFoLwlVDM5KMfDJqIqghkmOvERCeAF6wuw/tR
         AIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWeEQP5Wh3Jy0q7VFZGVtVSozJI++4XX2wRvmAE2lRNWVRleSY3kNJ9z6zlBP6NshYhMb+X/XiyqBG4SWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7U6ImvmHcXkNORBCbNGMspoACVPt0BOcPj8Kugzx6vxCsnov
	90K3H1DiaYzBTRnH0F710EGdI4j9pvwEETaPT35VWMKTa5l7Y/oa25M3Z3Gw
X-Gm-Gg: ASbGnctBrb4mqOioy1NJgd7469+tsPjFOIRBWW4v8gtHo4WGZiE4sASIo96TqCC4mmY
	YhceFzij1XPD2x85MnxVCyh0oMqKMwY8xYQczl/PHvDkV5PoIgdGnRRvflQnf8yWylrRJyCjYeX
	ZZGjG7T19+EaGfZC06T6Gn6dF/lsxWKWZgZ04eRKs/XjM01UskJOO8i5rWFupfMU4ggVvYbz2Mj
	tqHP8XS0/lyJNk+WrDnYgm3jDylg8KZtrn695TnPnI1n4SScbLhjwMNHHkP+TqRFjqFjxLlgi7F
	rs60dIMucF9Kyu2DLKFKCszHi4BkfeVfDmAeq38cq0qllYl+WSnlUQ==
X-Google-Smtp-Source: AGHT+IFXIKMkELurCyFOxnEw1HlMACU2XjcyBrp72UpEcJXg6XKcnWohf6tTKrT59+E8/h2RNZoQKw==
X-Received: by 2002:a05:620a:44c2:b0:7c0:61e4:40fd with SMTP id af79cd13be357-7c08a9e04b1mr1194394285a.31.1739765277817;
        Sun, 16 Feb 2025 20:07:57 -0800 (PST)
Received: from nerdopolis2.mynetworksettings.com ([2600:4040:5e66:a800:3bda:f60d:1567:d3d0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861537sm488465085a.67.2025.02.16.20.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:07:56 -0800 (PST)
From: adamsimonelli@gmail.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Simonelli <adamsimonelli@gmail.com>
Subject: [PATCH v2 0/2] Optionally allow ttynull to be selected as a default console
Date: Sun, 16 Feb 2025 23:07:46 -0500
Message-ID: <20250217040748.2017975-1-adamsimonelli@gmail.com>
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

v2:
    rebase

Adam Simonelli (2):
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be loaded sooner.

 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/Makefile  |  3 ++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.45.2

