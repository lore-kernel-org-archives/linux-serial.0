Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588399;
	b=HM5P1xNyHmP0SWp6tS2yPJHdnee06TCI6hv/VCAGqFsCm1Ftsf6uYm/q7JbJcXX6j1ot
	 pik/01ia4fkgrhpKOjEK1KROQ8s+Ohi+Ac0KD42q8iTkSovLjbMOtRcUNFbltJ9rJceEo
	 /G1NypG3E/ThJRwxpTa+zkOYjxeRwD+50LTbREnXGztmmPge2t9eWdYzFQtgr+AI+jdbe
	 lN6wUvtCxVRSjDugHtGPwT2fsnrOZQyrnrM/6aL3z3mRwFIoC66aQXpDxQcTCLYrQojzc
	 OlOxTJ7i8kg2H1PXy+UEqPSk+KeumwzXb/+urGqrnkdpTE5W286jVTZPKTgXUOwl+uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
	b=v/zYUpaBykePV0oP5SHQOX1tgL1mpW32VRePNoTX1NF6t3Di+B/0hGAiUGh2s0/AULJJ
	 3VsgxAGJgQcjewXCNPZPPwJnk5G2XmvCYdsxEMGZrT6DMCnTMx0r2aWqAw3lqSOC7GAfi
	 3NxHhfY7kZH9AUtjsMpve3oVAg52UvsSDl0FvQbagjbtWwe2+QZm4UOcYKO0M5+fvKd6q
	 PMuKvnOr6oROC7LL++87mDJOfz28ElAoujYFPGPJenSfecgWKKmUxDVtOBgOkYvM1AIc0
	 S/itYXNnWl6Xu8ixuToqaGQxV1jcj1JyoHbUzBfhRl6qkAlyrGV2XELhSLAjtNuyuKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fyhfHnL2;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9A606A31B
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF9A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fyhfHnL2
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso587292f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588397; x=1793193197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
        b=fyhfHnL2vgB+Al2ATPFZaHH0oxN/5vfVtER8IQWKhOYBhNJT4FtRou7YxivrUyj3q/
         /nwzcxONL7tsdzu6Con8f7CAM2xMdFNlVyJAqfTIW8sh39WNInede+Y4Eg5Zh69OrGiJ
         IQM7UkpIOOctEq/2BwM7PDIPIPVVttoace+kvL4WGfc77/2A9+D6MtupCMTxRab/2Z8/
         Q2XNYMeslEdmJm0KY049Qy7mSASaa7hbwVcH5y0T1XQlCBZZ4M8Dd7wVCZBZmvJEzzf0
         fisK+iTfplb8kdiLOX/yhWZKbgqC3t4uWVJNU0xNe47VQ6+kMk8546NoIBfKmNiK2NI+
         XwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588397; x=1793193197;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
        b=JuIEhJV8xkoFhYivr/ZOqavEkKGAF1yTOHb0R81u8G/q78Sv5njOn3AUuvvjxp/Jv+
         vlL2vVI97TdVWv+7YLQX3B0o+3ojsJYgPsi407uJzDsexkjMTXL5GwFW0/a6c/yJgaWW
         o2c329rpD2hcfUVNufskITFxNj7OSw41BbJ1uWdrbdJWtEjEK+P7lp1SOZreCn56xLBH
         Ti4iMRjXESws1RQVK0hT/5UIbSSppoVTmrdtPyohmLhtrthe3m9kmhSkVNgR+SV4w0PV
         SngmyKdVa/BK1ZhvG2Rv2iSp8Qiy7ZURE4C2lhiDSjmebmUl/FxaDUYXvgoiTrEkyCQV
         Lk8w==
X-Forwarded-Encrypted: i=1; AKwUvBxMpYsWX8BxN3CeoNcHta0HBMMTOOKPSJ4vgI74uG4RmMukUWqYr0m8cT4yyvFZBPmCbPaz7zzU6gyejck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0KxyV+j6Ne+nTZBEU+z22LOJS0H6DulaS9oB+orp/mHKwfQM8
	FRSW9aPwlhOuR1Pw+oDbrglw4m2Npv9BFszMBoYbPM4JNBgK5kGB/qCs
X-Gm-Gg: AYBFou2HuWTyhpGSP6aw91hzw7ks4gjgSCScYfD7A3mcT2+Jm0lBfchPMWUj2SxvkTx
	C3YHuGyyZGAdldE1uZ4mg4zluXNHw49AfeokRnrEwDeO1A/CALbqx8D8nm+5EhznuTD/adaHXYq
	8oXEBSuaw88TbdrUHtrkqClCmepbpABjarMlj8vSfDoiFNEBxGhiLGW0uyRolFBdXctYZUe4UoE
	t6xrXJD9tONKptAxTOS7ztUKMVfXf2yNP9/Y/TneVWn8ril9TXkzhO979he33cqpPeVjJG3W0Vz
	YK5+5g+WvQhN0jGroXvb/SwKlrDL80pOjZQu2do9HrpH5Ux1Bs7x/d+3q6VfDaJy+NdwH84EpFH
	AgAQfLkwgREBUkWa9OLMloxM1dRF9cFO1E3arXDO0N9jJaenJ6omfNd/Rwjp5wQRrEPhPPR0V8G
	45gibWhLBwxEkVaKENqoTmjY7vWKR2KhkYqhG7Dk+rJgy+GM99vZruuI1HlYau9oR5urHIanm6/
	clhPF+3C5xI021BcnVAzf2lVqe6RNNNrDFirYyzsZFldaW9jcEoJuh1hmDuy1nTRjejDfx9fh+w
	VZVffh9C5gTLlraN
X-Received: by 2002:a5d:584d:0:b0:48e:28bd:e010 with SMTP id ffacd0b85a97d-48e28bde4b0mr2656500f8f.7.1792588396895;
        Wed, 21 Oct 2026 06:13:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:16 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/4] Fix transmit handling on SCI/RSCI ports
Date: Wed, 21 Oct 2026 14:13:12 +0100
Message-Id: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGm62GoC/y3Myw6CMBCF4Vchs7ZNW+TmyvcwxNAywhAF0hGik
 r67lbj8Tk7+DRg9IcMp2cDjSkzTGGEOCbi+GTsU1EaDUSbXyijRmeV+ZUfCRucqxyazGcT77PF
 Grz11qaN74ufk33t51b/1H9GVLpROK3ks0lKVQgtLwyLbhuXwOdtZehyRo9z0gDqE8AUHqvtvp
 QAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=2681;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=UKJg4b3SfR4kpP4oWIhEOgnGd98EBh9C3fKOCKd2yt0=;
 b=1NJHANvhrv+QQW8+t8rXZ8HELSt/2/6SELbVExz3/VnizRqtcgP50eKAy6UNf7GUmJoRz4YZ+
 q/+dgXcBcwsClSnKfz2cjoBWXVbYCRRGKs/PsjrY89rZYZBKgXjI3nE
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

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

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
CC: linux-renesas-soc@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Changes in v2:
 * Updated commit header and description for patch#2 and #3.
 * Take the port lock before reading the control register, so the
   read-modify-write in sci_tx_end_interrupt() is protected.
 * Extended the pending-data check in sci_tx_end_interrupt() to cover
   x_char and a stopped port, not only a non-empty xmit kfifo.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
- Link to v1: https://lore.kernel.org/r/20261019170139.473808-1-biju.das.jz@bp.renesas.com

---
Au Dang (2):
      serial: sh-sci: Skip TDxE clear when hardware clears it automatically
      serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI

Biju Das (2):
      serial: sh-sci: Drop TE disable at end of transmission on SCI
      serial: sh-sci: Keep TX enabled on TEI while data is pending

 drivers/tty/serial/rsci.c          |  2 ++
 drivers/tty/serial/sh-sci-common.h |  4 ++++
 drivers/tty/serial/sh-sci.c        | 45 +++++++++++++++++++++++++-------------
 3 files changed, 36 insertions(+), 15 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

