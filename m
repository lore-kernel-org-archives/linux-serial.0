Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429306;
	b=Osv965K1+D1y5m0CrT1nOMM5Z1ABeJQDPwNKqqnMvWrreVHhru5S2dT/tfaoNfsWPrzN
	 eN8hLlWLVnJ54iPtYmzNj96HJ+rkU1LgzAkjfGQ9mLS3reuhVeXd8w865CcyD92tw84Xk
	 o/pQkeV6GHc8anMcu2NBvlD7Hu6jEWZ5RkDj/wz2LNd6ZNSAUDHzciOa4obYQcC3Zu1py
	 sP1HzpfhjCGJNHlR7XI3B8d7pgBI1a2U2gtVG3BdbO+paIdWGuMN9ubM4JNxSySbkiYEc
	 k/s/FBUm3vVAQPNZOnuUY52xJWMwrYCYGdYsa+sF0TQDdJt6HeGoISe9qXzVIrUZMAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Chq+IJGSLoPBEVZuBAEdkqWQtRzkgjBsF6DmeMNI9hs=;
	b=A9mBb6lZr8cy/SRGs1bs2mAHEicLS8LJMOKodjOlpTAy5azODrLn+t1fGDuswuF8MADO
	 Dw7/VvEnAwjkZmnzeI6N44fvA1l2TfuSTm0UPnQ2Q+1KRZN7QURonmmJF/PuFfq8gbHzN
	 YpEhkR2hGhWBU6BNy4JOIa0xVNQ5SPUlkXBsUJKzuRNMUZy0fDBQUbhTPqAat5SmOvl62
	 jMIDSENa+l/gk7bqjry+t1deyr5Ke4FQkyujwmdCppsuynL8ndLuWjPrfvnL513nEovPZ
	 TNxu0sk4Z/k9lDPkXsMQOheI5plVPPMQ0aPRaCzOvCrI3GLgaHlwsMsPsFeYhmlR7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="nD3D/Rt/";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BC606A322
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B3BC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nD3D/Rt/
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1293477f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429303; x=1793034103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Chq+IJGSLoPBEVZuBAEdkqWQtRzkgjBsF6DmeMNI9hs=;
        b=nD3D/Rt/3v+UqLLyXS9zHDk88H0JNoDmJA/arQlN7rTSRQxnPOKtmfOuYwguJUWkg7
         V0IObNusxnDICmfrMBo8PSYE9lNwFDPjkGX+ZjbYU54RHl426EWA5C1xt+UONWXZKrAm
         kGlfNYnyB3vM4wAA9Ji1DFNRu0bGOJBVm96xPnp3RggmTQrDszu1u+viCedkUPQwYswX
         XJMp7OVqKKZuRTTJHh2uFcAEWQx1UzGtGU+aAIi2HbTGg9nnBgPp8yA5asj0bp+5KcHE
         DB29c9EMBSmNfhxl8L8Sg9YVdSlUHne+fhbyteFgeeFpoSMVQIjzq6QZMTqvAZ/xjGa3
         RPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429303; x=1793034103;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Chq+IJGSLoPBEVZuBAEdkqWQtRzkgjBsF6DmeMNI9hs=;
        b=APwcz2s3G/zPP4iI7cfPUTAggWhTgmi+YsFvBI2+KgS3cNujjPwOlHh9PygOpTiin4
         JJuBtEnwcTZJCCDSg/KTgAEPqndvOew8E4XJzH81RdySx5NmssAELyCW33lUcWQDfVIM
         WAkZkQrZZLxumpPOFpLGsKf2pZvgxqRlVpXfsgHr1QO2PDqDzWID/WbzINVs7K3boSyg
         nq/imqUmJ+T4d35lxXkLndWX9i/ZwDj4Im6wuFmRWwFEQmUry8i+HpPSSVSMLYyXvSEN
         19uTJ2RP7/wsq5McXJAFASiD1nceluV1cHCg7gLFmFaMDTb6eHUHTuN+j2dPdp2YppKo
         o6Xg==
X-Forwarded-Encrypted: i=1; AKwUvBw7ETZQ2hGEDqPbQ0qngjWCnDdXfPKqggfhfcRWIl4t+4kynYZFTkqqeYW/3CFCgwB/rJ77OE/jkWrySMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0fLpiJrF+y/nigZxX+24hxvn7jMdV0oc9/omAcoWcIlW1Ac84
	ito0ZU7ZXIpLWXgJj85q5r+U1nd83kMiIVvVLbwSbJfD7puQLRDxz/tw
X-Gm-Gg: AYBFou015GFktiSmYHZT+hXUL8Y31wy4L32ITk/3vthPUq8b4KKtN7bTdmzOrJLQdPG
	vTexBvVJnuE8m6Gf5UjcFiypsCYELZlJBddzGCvxXSzA8n/4NB8+VbfIJNI9X6eQNz39goPpfAm
	d7ZHGZfM/OYoNP84qSsl8g/gsWBKaXgDHpkJKOrS3/7MrLSsZ7i0QxLnEhMI0DPMQC3hmsQ9xv5
	Fl4XU6nmCD5JsgYH+6oz5iSqwEA1aa0QTQjF8qJH/2KANugsuFwH70YcOZh+SMAOG9r2rkKqFg7
	5BxVMrDemhqLIfnna4SAeRgJt0cTC7vJ1LYvLSiDJPYwRIL8DblZTd3MDABLQTAHF+0a2vDaF2W
	wU4G1HTmbqu0qu9fSDyQhTW7FISuwmkBJ9rzTWQO/nQRFhQfRpqgzlgq6XPX27Gn0MRkw9kREsL
	/aPJipvpQkoSK4iy76qipqS18C9G8WF5+G9j9ef3STkoIR3WZwWilJz3Nbh2Mw17gjuZ1l8RyuF
	lyDljooK9Mbg3WsV0y3ULmPgcTEHX9419ijO+2L5DEi6+gMXUjhyRAT
X-Received: by 2002:a05:6000:22c9:b0:48b:451:4f19 with SMTP id ffacd0b85a97d-48e07fe3d59mr19938200f8f.51.1792429303334;
        Mon, 19 Oct 2026 10:01:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:1439:c865:be43:6676])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm101784f8f.40.2026.10.19.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:01:42 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Au Dang <au.dang.jx@renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/4] Fix transmit handling on SCI/RSCI ports
Date: Mon, 19 Oct 2026 18:01:08 +0100
Message-ID: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

This series fixes several transmit problems on the SCI (PORT_SCI) and
RSCI ports of the sh-sci driver, seen on Renesas RZ SoCs:

 - Patch 1 removes the code that disables TE at the end of a
   transmission on SCI, which the hardware manual does not describe.
 - Patch 2 stops the TEI handler from turning the transmitter off
   while the xmit kfifo still holds data, which could stall or lose
   output. It also covers the TE handling that patch 1 no longer does
   in sci_transmit_chars().
 - Patch 3 skips the software clear of the TDxE flag on SCI, since
   hardware clears it on a TDR write and the extra clear caused a
   spurious TXI and a duplicated last character.
 - Patch 4 forces a TE toggle when restoring SCSCR in the console
   write path on SCI, so the TXI that restarts an interrupted drain is
   generated. Without it the RZ/G2UL console can hang during boot.

Au Dang (2):
  serial: sh-sci: Skip TDxE status clear for PORT_SCI
  serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI

Biju Das (2):
  serial: sh-sci: Drop TE disable at end of transmission on SCI
  serial: sh-sci: Don’t disable TX on TEI while the xmit kfifo still
    holds data

 drivers/tty/serial/rsci.c          |  2 ++
 drivers/tty/serial/sh-sci-common.h |  2 ++
 drivers/tty/serial/sh-sci.c        | 43 +++++++++++++++++++-----------
 3 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.43.0

