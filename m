Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608141DDC2A;
	Mon,  8 Sep 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324752; cv=none; b=jkkqYTxq38ZhuG8OYB3tVt1SDYiTLDODMCtyO+gOq4ZNNEbH+CU+6Mx6A3h17HiMW/89qEtZgdEKlwq+O3LusfPbfjK61EXYsaGpfY6jiVV75J5ZfrnJI0jcLLvM+vuW6+3m2Ry4Vdfr9xcbRdPM5KvNPQGjLOLeY8ZqwHKNNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324752; c=relaxed/simple;
	bh=2tzQ2xIm9jkK5PEpR0qKT3Dtvn3u+D1CotDGqedcQkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1Q3VIoTxmgoA3JnX5l50/6A5p2NrLhyB3UetDK+Bsu42AJJeb9NpVFzML2u/RbAbJkZViU+MxIfRLVl9BeLR9fpMyfTbt87e6qPLiEK/hc3tPi7E9FcW08vdp6u8g660EuBJPJNQd4BcITtkwncRtllxwUkcV/iPtSS3UlhRBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B5DC4CEF1;
	Mon,  8 Sep 2025 09:45:49 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philip Blundell <philb@gnu.org>,
	Kars de Jong <jongk@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/2] tty: serial: 8250: Rework HP300 serial Kconfig logic
Date: Mon,  8 Sep 2025 11:45:40 +0200
Message-ID: <cover.1757323858.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

The HP300 serial driver has a long-standing configuration issue: when
SERIAL_8250 and HP300 are enabled, but none of HPDCA and HPAPCI is
built-in:

    drivers/tty/serial/8250/8250_hp300.c:24:2: warning: #warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure? [-Wcpp]
       24 | #warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
	  |  ^~~~~~~

This series fixes this by reworking the Kconfig logic to make invalid
configurations impossible, after moving the HP300 serial suboptions to
where they really belong.  It is meant as a replacement for "[PATCH]
m68k: make HPDCA and HPAPCI bools" [1], and was compile-tested only.

Anyone who can test this one real hardware?
Probably we should add the following to hp300_defconfig:

    +CONFIG_SERIAL_8250=y
    +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
    +# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
    +CONFIG_SERIAL_8250_CONSOLE=y
    +CONFIG_SERIAL_8250_HPDCA=y
    +CONFIG_SERIAL_8250_HPAPCI=y

Thanks for your comments!

[1] https://lore.kernel.org/all/20250822104208.751191-1-jirislaby@kernel.org

Geert Uytterhoeven (2):
  tty: serial: 8250: Move HP300/400 serial Kconfig options
  tty: serial: 8250: Rework HP300 serial Kconfig logic

 arch/m68k/Kconfig.devices            | 14 -------------
 drivers/tty/serial/8250/8250_hp300.c | 30 ++++++++++++----------------
 drivers/tty/serial/8250/Kconfig      | 16 ++++++++++++++-
 3 files changed, 28 insertions(+), 32 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
