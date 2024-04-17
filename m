Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120480614
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344674; cv=none; b=uWHrG+P2p6IGK9ZX0k/971eLWpyCCieebDTo+TGLwwyZ2TKm/ChmU/nDRIuB/mjowXf5tZJNaAT2lhKyGyx6yfe4+/LQB7BqWjTQxUgS2pdU160CVgarrtPQHu7h4pS+a12MqvEpzJR7LwtDZ1XJ/C9VD53Hba2pnFwoOEsLrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344674; c=relaxed/simple;
	bh=Vy9RxpGJFkyUUn1WJcrbkWAi2j1VMThp4FrzwrvO4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BS4VU9iLt9jv39I5/1qOxswVyv7CQB4bm9FXqcgmPEofZYchzmuG96nCJiusSc9dmxXTmck90KLt6OgrhAspsu2FgrRljNF/zZl/yWAni89GTAqA8xsZGzc6iRZHhJDD7bWpDpBHy2RkKkhspiCAFDlGSlZ9gr45e8mnbNMV6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DD-0004ol-PA; Wed, 17 Apr 2024 11:04:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DB-00ClGE-Q8; Wed, 17 Apr 2024 11:04:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx1DB-002hLw-2J;
	Wed, 17 Apr 2024 11:04:13 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel@pengutronix.de,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] serial: stm32: Two fixes
Date: Wed, 17 Apr 2024 11:03:26 +0200
Message-ID: <cover.1713344161.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Vy9RxpGJFkyUUn1WJcrbkWAi2j1VMThp4FrzwrvO4aY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmH5BfsTno6WspytFGVGdPtgzDOQ57SnStMVreu xnM2THkVyGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZh+QXwAKCRCPgPtYfRL+ ThT0B/44IBFxXJkLjJrE/ZG1oW5gVoGKgsjniS6CKQaN3sKpXtV58WnkjbVzW/iQNtUyNH0oVKj CU5w+Uf2f1Ht2+HFLei+OBZKtRczvYGbg03N34JytZkuIw1OOTwcSm180aqgAnRE5tDtX8+Y34t 0OcAyitQ9FFpZWu/mUTFdkg9bzAmq3AckFCC1TH5cChVcTfAjCKybeMY8zO4mcau9DLGik+y/25 uOSzEFI95gj+Z18uL3fend9iOdVqaiXwfs2AxeeZTx8o+dlVjttT/2SYFBWYl4UFxDFg0aQJ7il DA66aUf0nvLSJGXlsz5mywjXv95Hq3AfrGhJ+Mp9ZR2jzwBA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Hello,

this series contains to fixes that target v6.9 and IMHO should also get
backported to stable. For that reason I added a Cc: stable line to both
patches.

The first patch isn't very critical, it only improves the driver's
behaviour if another problem pops up in the future that results in an
unhandled irq. The second fixes a real problem for me.

Best regards
Uwe

Uwe Kleine-König (2):
  serial: stm32: Return IRQ_NONE in the ISR if no handling happend
  serial: stm32: Reset .throttled state in .startup()

 drivers/tty/serial/stm32-usart.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

base-commit: 4eab358930711bbeb85bf5ee267d0d42d3394c2c
-- 
2.43.0

