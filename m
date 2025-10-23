Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE42D3226
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216209; cv=none; b=SIzr0VWHUswoSn4k2VkerZ51a3xz3vy0NmurF2CccapYblefvq6tn8Ys6ISQYPW5QpnL9f7TxcTpVwsa+OugFxJ5+pFzcZ99ZMLf5gF2AD4dOfhEzdiCx4jfJBGTSKhOWhUGD72kMO1kyfiIZjDtAV6tUptCUzMyGysEqZDShzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216209; c=relaxed/simple;
	bh=yfiZ/v4sjNEPealFn/6obw9kLQ8DcjpygkxhwfB5aQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iun23wa69ES5fU0e7AcBks2+6I7NHbDHYcnAH5KMZE7b0JAEvcBE8Cyixyw1qn7933WHzjRm0Ze9OwreDo5+Nz5l79EpSEToC4J7Jp16zpZgHLiBbhsltRggTtkMGUXc6cZD1OWyye429lxzo6UWa8l26pPXmp4B/yAdo07zwfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgtmlB1Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgtmlB1Q"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso580941a12.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216207; x=1761821007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oimtdy4jzaui5mD86nBtASLISt4Nnfmett/2NBvJrk4=;
        b=GgtmlB1QZQNg5PWJMc9C5LDGB0XRumfVb4tvMDijqYHJyexYH3wNrYJ3bzl2x1SMTC
         WHo5wca33LktR9OPfq6PYwLanBverSSm89YgO3hho44cKK2v1/6jRmkDfw8osCDItn7E
         ZSqkHnkqUAH4yl/j1RuUKl3fMggBu5UBNuOpvMoJiqshxujT1whbl7DJCX8vvRXcbR9Q
         wOVT6oWJROy/nMeAfgY6/Af/1OFTCMGrXuFfqNrrNQhBIx2zifmpVmwvqX4Kz5rUGCQW
         y0ve86SzAYMBkbVGfp3BxUa1eAjSKmoVFPxpMWjhqJKQUd5CAh//PXjpNg0NORtcnI8E
         ARiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216207; x=1761821007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oimtdy4jzaui5mD86nBtASLISt4Nnfmett/2NBvJrk4=;
        b=IkO4GGSjm/70xICDzIVvo//snSSLMTaAlamFZcGCSrmo7AZckcLD/CMhBEHCZTZGe/
         ukCjemojYz2G4VgXo+rv7R1oo0T4uENn+iRlFlaq+h/VbIdMDl5NVQ1sfjVu5VlflUA0
         oA0+fj1g8dtsyrBBPnJsXPnMip352b/O/kaXxrECPlS9ODAZyVvkcOrx58SYJ4mdUcKQ
         vFrUXEMGLrMNCFh3tUFf9dTBpjzw5PBfi5CLNGnRjQNILC7RVxOdUqUwzeeZMFOO4sH8
         1mJF4Qn7JL4/oF4XbHleZLRvENy7th6FjfiMXmj5dt9pjhfzFgkS6pZn/AuDlBSbZOhA
         wX3A==
X-Forwarded-Encrypted: i=1; AJvYcCUz+jOQxyavUzyvzP1Y6p7rahGj6LEd2X08mQoh2H5BH6XvTuUjNTJjgZe6owmHoh6minnjlyL2IM6zQBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcCwea7tWDBzvJI2JECumeK/JKi9e7DffblK6c/CBS8z29vFp
	syyg7drbyBOMjk6zv+Y/eWUB7US3IXINd4AmpB5A6rMzuveJSO0/VSES
X-Gm-Gg: ASbGnctQ72tYGe7n5cU9wJXPNGdpUolYvL/mfkfzeTwY5Qt2CAmxYUrUByn3fIctlCj
	QyAJwrMgm/BKfRB+1de6GqEUlNHKNHUsddosNNfitWGDOQt1i0Og40/uNr0yaNv0GdF1J/mNdSS
	NUfBmuKPN89m51LSQhw2hY25aDK5lEmbSUbjCOQEDhUOcEicV/RMEEcdj9pdvN2MQAmhbji6HUE
	9DMG5+JzqRyTTe5sCpTaYgJ//u1tYe1XzNdKnRdTuY2UZbLmebmWQD5TkLRX/iZiQpRFZZ+7KIs
	AO8TkbSGknh8/EN2+eUO7ZnkNZ4KwPvAwT5ZYWfi+Hu18igZiW9i4xUI8rCaJqV1A1Q0aXcGprh
	pqKs+4umq+6tpwK45HE0RajvWdJ6iYE49Ndp+OO8Jej/X/lpAexAEfTn/Ia/qN2ofv+N0BmSPlK
	Hz4QJmHjRnvtMmsjsnfVI=
X-Google-Smtp-Source: AGHT+IH/gs6+8CFlO2G87tCtAtLvUgrD/2n3++PXEeHzzYkJTjhzcKeN8bij7zgjnMAfHtOTCePOQg==
X-Received: by 2002:a17:903:19e6:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-290c9c8a5b0mr338020675ad.1.1761216207465;
        Thu, 23 Oct 2025 03:43:27 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm19240945ad.34.2025.10.23.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:43:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] SH-SCI serial driver code cleanup
Date: Thu, 23 Oct 2025 11:43:11 +0100
Message-ID: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series contains two patches for the SH-SCI serial driver.
The first patch sorts the include files alphabetically, which has no
impact on code behavior. The second patch merges the contents of sh-sci.h
into sh-sci.c to reduce file clutter and improve maintainability.

v1->v2:
- Sorted the include files alphabetically in the first patch.

Cheers,
Prabhakar

Lad Prabhakar (2):
  serial: sh-sci: Sort include files alphabetically
  serial: sh-sci: Merge sh-sci.h into sh-sci.c

 drivers/tty/serial/sh-sci.c | 184 +++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/sh-sci.h | 178 ----------------------------------
 2 files changed, 179 insertions(+), 183 deletions(-)
 delete mode 100644 drivers/tty/serial/sh-sci.h

-- 
2.43.0

