Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4223BE;
	Sun, 30 Mar 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743294698; cv=none; b=AQD1CG4YlMrVm2X7ZVgL/Jx3k2Zda+opqJClGOHio3E5ryT4vbwYNedZX2rLS4nFukf7f6J5M4/qJDgRCq4fwzFoqatARjWAmnAh/GJAYeZdw272uMCs+fjI17Ghk+42q6FMNksp5Vz55ZKu73S5+JTOU7+UDwF3RKkJU/5wxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743294698; c=relaxed/simple;
	bh=isoKbfAHNzLky7XIAHoTR8T1AwEEoAMUQtj1R54nwQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bT0FjKcWqIlD4NnLJNPddHn4iOWg0ETdMV0sK7sjjWkRvc+lakxmsVLLydNSHKxrPn9HeSlfb7TW0ZMVSvfKiKaze0RXh7FCpqeF/QaK5sYp+4SMxD0NC2Jty8SpG99f9GKz3/mMjT1h+NyX6iFHvZpqGstTT+77J84RBAY8aMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+xvcGaz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+xvcGaz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301c4850194so4556179a91.2;
        Sat, 29 Mar 2025 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743294696; x=1743899496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8sX9JQgcjDM5B2WbHLYXAKpNL5V5b9vaaWmdqn5sl8=;
        b=a+xvcGazK/qQHOynMH9pr2wQGavkokJLpZJwem+4CldMIqNW0exGKvsseqaazEIcws
         mbVKF9EOc9gwMfnfx6u13TUMe+URunjghguACIDNBritXTHiNYuu8y68WFOvF6SShrtM
         QpwI2ZyiJrdkdKMRDKibrMFdo2Pg9XSFE1kcJyDUvVdGZBJnwdzsSiEAuRqx0IPRppZY
         3ML0+MvbxF6Chx+EDrBOXge7fQ1anyorjaH33+zSa5Cs2EUtYzs001KI0Oq2icgZdePN
         Ov0ZPJMnpe1NzlEwdEv5uHcYugQIvifh5rPDIEqPiBG7ywvufoLp7Ni98Ac3/052pMMQ
         gL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743294696; x=1743899496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8sX9JQgcjDM5B2WbHLYXAKpNL5V5b9vaaWmdqn5sl8=;
        b=MlNjRJNKfJd5+0zx+DJUYhcDiipgg0FSm4Xs7ELNAeRns9bv3YlANzdSrFdPidPFmV
         GvqYjUYvkLgRfcta8B06YvwFuPL/wlxT+0KNGs2s1m9NUyuZCitC3x3tbFfxRezZyfHp
         qS97pZYw3NmT8V2r+BQtv/eKtHqGTC7ED2WFYN3YUOEOlovSEmTS/ko34VVnJUZTGDEl
         3cpQfeLyLSuy5C1sI+1YkWkxjw8vKRL1j1E/U4s6HBNfSrovWn8PKwKKuPhjIBdISVHT
         NYv5eCYVpLQiB97PIre5zLeFfw1eP6DPkuAh9jrR6mo5nzjxtnkmBLiPy8WNSNYUpv2N
         kHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdfIhiXuiG22rEzrP14SRXtD8eovreJ9iBBHTQwuw1WwRt9e5hOddJTGTUkamclpkPIGP0BgA4/gqKqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Cu5RMWFxxMU/I4OWkHb6WEXFX6dK0HGjdSXoT17zehk/2kNa
	D0cJaO5ffr/MlyM0it1vchr8k9UReMbvO/RIS9cXS5AgNoTLH2ES
X-Gm-Gg: ASbGnctl9JH1jNFFwmEf7mcaGuhGg7GHQaId12dl9mg3W2LvLnJMDP4EHpqqeP+T0pg
	PLUBwjHoMMc3QnD8SD2ktxdtIY3LEhGlobH0r+WIc9hm7+y2Aitrx6sM2KtkR0lYz9p4S+MSfFN
	DypSOosKWkkt9ivjENcRTW+yFhYizSz5TRK8QT+tQyslBOUO3OY8dPl1dSitDyGhUDnhj0R8I3c
	XT4cL8/Cle54s5lQgmTeyF59yxVSiF8k/ByKK64vUwAYZLPzMVe6I9lZZwRMHl34QRkmeNSxSY0
	C0iTaR5nUlNEkORUZb4QjHgOyaljqcwYvB4uuLjvnFeYt3GacNBTrvebNK3rqJLU6nYhYRdWS1l
	q14Ksqw5DnD/+1UUT+VrcNht85vnxle4=
X-Google-Smtp-Source: AGHT+IFjOYlNIkklCiPR6SNYbKSePzshOfqmakMpfEqa1st5hBR7yRveiAYE76V57DWiH0YclLcTpQ==
X-Received: by 2002:a17:90b:56c8:b0:2fa:1e3e:9be5 with SMTP id 98e67ed59e1d1-30531e89c4cmr8376057a91.0.1743294695638;
        Sat, 29 Mar 2025 17:31:35 -0700 (PDT)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd497csm7466308a91.5.2025.03.29.17.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 17:31:35 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v2 0/2] serial: sifive: Convert sifive console to nbcon
Date: Sun, 30 Mar 2025 09:30:58 +0900
Message-Id: <20250330003058.386447-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series convert sifive console to nbcon.

The first patch fixes the issue which was pointed out by John [0] 
that the driver has been accessing SIFIVE_SERIAL_IE_OFFS register 
on its ->startup() and ->shutdown() without port lock synchronization 
against ->write().

The fix on the first patch still applies to the second patch which 
converts the console to nbcon as ->write_thread() holds port lock
and ->write_atomic() checks for the console ownership.

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/84sen2fo4b.fsf@jogness.linutronix.de/

---

Changes since v1:
[1] https://lore.kernel.org/lkml/20250323060603.388621-1-ryotkkr98@gmail.com/

- Thank you John for the feedback!
- Add a patch for synchronizing startup()/shutdown() vs write(). 
- Add <Reviewed-by> by John.

---

Ryo Takakura (2):
  serial: sifive: lock port in startup()/shutdown() callbacks
  serial: sifive: Switch to nbcon console

 drivers/tty/serial/sifive.c | 93 +++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

-- 
2.34.1

