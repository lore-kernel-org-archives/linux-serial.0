Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.120.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521807;
	b=J2C7XH9j2ONh78gXI6YjPQFhbcxAV1A/4n5txL5naPo8dS1rsTKqydr2desjhX6TKxV+
	 GJd6dKPl2zaaxAVToJUJORBYBx0XiL03zyjsUrG5D5yAwy6pxjYtp2F8A6vdGPKTLUavz
	 NONG7nu0nNrugOb1MKx53uL8sldV5WjWTMyw+LSZ7QJMXUTXqF/wwf+2RoYV5ZXy7ogYW
	 NyLQn7bXOLSpGQuFL4vzny9ZFV0cAPNCbFUHfemUKW3uA5GDVkBod+Rx1m4nsksq1SkgI
	 44Tlol6uDJ7GeBd1FLykeCUxf16TQ4rVa0bBC4wRQ4dxZxNmJ/kPUFxk0GHMtoIDjTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521807;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam_score:X-Spam_bar;
	bh=cEn1babex7vsPIR//sAAYZvUTJJgy5z5f00WEVTHUFI=;
	b=mFjJRzCSR3v/OxLlCMnbc2xH/x01UzpgDAH2QqGC8tsCIAYlmyaUbpacCMvocLBZHOTX
	 WVzSDVwwaghU9JfnqlhZlIWnnc6LUWN5sPbDIMf/PTMqZgvZlbyZxbxvjvvMSZmPA2jCE
	 AD/Iu09ZbTB4ZgYgylLjmfU7wa815TG9QAY30CwCIfA/hOIb1Lf5fPNWWBhoHWYxWKulf
	 J0yH6jPf3Xtq0n/6bMaJrpA5GiMpgq55MQKy7As7AyKAjg8FLtZgwCb+pmjdpPpGoLLvv
	 9qQKYnwBKnFByqP+LfbmtKjEQdm9u3aFM7ZNQxpvEeB93eC6d9rEAbn/8EsS5RZLPCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hugovil.com;
	spf=pass smtp.mailfrom=hugovil.com;
	dkim=pass header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=QhoSSkTG;
	arc=none smtp.remote-ip=162.243.120.170
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB31606A31F;
	Tue, 20 Oct 2026 18:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB31606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hugovil.com header.i=@hugovil.com header.a=rsa-sha256 header.s=default header.b=QhoSSkTG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=cEn1babex7vsPIR//sAAYZvUTJJgy5z5f00WEVTHUFI=; b=QhoSSkTGY+yTUEj51GwsJxb8dJ
	eKrdg88VSi52mh58P9Im7Gcs1m2h8WSWWhxtUQN5Ba+I/ITscb7z+mF+BzGlKHsuJtyWsoVa98mLf
	j6beOb213/BDC6SCOY5TqrRrRoozwQMC4uxNICv18we4+sazs4d4Mpo2UxbDw94s5lwE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xJEnw-000000000nG-1pMy;
	Tue, 20 Oct 2026 14:43:18 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: hugo@hugovil.com,
	gregkh@suse.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 0/5] serial: core: fixes and improvements to uart_get_baud_rate()
Date: Tue, 20 Oct 2026 14:41:16 -0400
Message-ID: <20261020184131.2893575-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

serial: core: fixes and improvements to uart_get_baud_rate()

Hello,
this patch series brings fixes and improvements to uart_get_baud_rate()

This is in part based on discussions following Hui patches submission [1]
to fix a divide by zero fault originating from uart_get_baud_rate().

Patch 1 is the fix for the above mentioned bug, as suggested by Hui
but with much improved comments, bug report and reproduce steps so that is is
easier to follow and understand. In original discussion, it was suggested by
Ilpo and me that when rate gets lowered, it should alter the termios to prevent
what is here seem as "old" having an invalid value. This is not handled by this
series at the moment, as this may be more complex than anticipated.

Patch 2 is another fix for a potential divide by zero scenario.

Patch 3 removes any possibility for the function to return zero baud rate
if the loop exits without a valid baud rate. History has shown that for
this function, there was often unforeseen or unanticipated conditions
that made the loop exit unexpectedly with a zero baud rate.

Patch 4 is a small improvement in readability to avoid a redundant baud
assignment without any UPF_SPD_* flags. It could be merged with the refactor
patch if deemed appropriate.

Patch 5 is a refactoring of uart_get_baud_rate() to make it easier to
understand and analyze, and more linear, as with the current loop is is
sometimes not easy to fully grasp what is happening. But in the end, I
am not sure it is worth it as the loop makes things more efficient and
simpler. I include the patch for discussion, but it may be removed from
this series.

Tested the changes on a custom board with imx uart and two SC16IS752 DUART
over a SPI interface using a Variscite IMX6 SOM.

Link: https://lore.kernel.org/all/20260930125901.778868-1-benquike@gmail.com/ [1]

Thank you.

Hugo Villeneuve (5):
  serial: core: fix division by zero if old termios is present but has
    invalid rate
  serial: core: clip out-of-range baud rate to min/max, not min+1/max-1
  serial: core: always return in-range baud rate even in case of failure
  serial: core: avoid redundant baud assignment without any UPF_SPD_*
    flags
  serial: core: refactor uart_get_baud_rate() for readability

 drivers/tty/serial/serial_core.c | 113 ++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 48 deletions(-)


base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
-- 
2.47.3

