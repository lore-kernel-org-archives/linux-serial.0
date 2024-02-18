Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F118AF1
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246489; cv=none; b=ELh2bbFdWCmSGOdGerfKMKJbMRqrCwvua6b3SW6pZyq7aaWgPXJgd3oGiXRc6IkT/t5iRl2TSAUtoer5yEaqr8EmgoIG5cZKVFTFj1i7T5LJSftnS7kkoOiHAHnLvttmLrB6da97YVYUobX3KyE4cY2dmRvNqvzxmj7fucXmL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246489; c=relaxed/simple;
	bh=h+0ZGScaLrNdGs2wclVFRPWZOTX/ANIChGB7vJFsviE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oy2eEbCAYv3gMoB+CnnCpIL2cdyEjX2bpnfo192/M/py7JirGK5eVXw7Z1saXIpp7whxOGM3Muk6IPUa4CEr9eYdsNV9FQN2dHNYADzE8B7/bqg4E6mj2mEZ0vjyQbD9W93Tp/1hmPzXYfdIjkcL6Yx1A2KbPEfSY9TqXG6gjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwY-0005AJ-VP; Sun, 18 Feb 2024 09:54:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwX-001Pw3-09; Sun, 18 Feb 2024 09:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbcwW-00754t-2v;
	Sun, 18 Feb 2024 09:54:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: kernel@pengutronix.de,
	linux-serial@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] tty: Convert to platform remove callback returning void
Date: Sun, 18 Feb 2024 09:53:53 +0100
Message-ID: <cover.1708246007.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=h+0ZGScaLrNdGs2wclVFRPWZOTX/ANIChGB7vJFsviE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0cWjpEAlLY8o1XXD7nfN/lZ55YZVshuP4/FYW +jt35309EyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdHFowAKCRCPgPtYfRL+ TpwdB/0bhqlANQOM4y96wrfEDTIIjejFIR6yasoSEWzq7/i7+tu/zz1ejaRUHZIy7y2kPFjmmLV 6PLzkbYcH9nx/r4bGdbpbIwA6yoZxExDa3vtr6ccy2jtXCZyw5Q5tHdhaDzcZFbenYGWou/maih PbBuxsbdC6D6cYBuc4EILKuT9aZlYap1+Up3WKB+syV+Xyce9Jz/6WPnjfMAAbk1sjDef1gRhgW h10/BL/0tE6cIWUSCoOlmwb85AOSJpq+8Jat4Sc7y3dbsb6QGGDKKla3vnTzEW7vgrlwEFIJG9k tRta704q/F/CGGnqX98LPl/IJfu5Aodhbep6newfAhPbaqje
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

Hello,

this series converts all remaining (three) drivers below drivers/tty to
struct platform_driver::remove_new(). See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

Two conversations are trivial, because their .remove() callbacks
returned zero unconditionally. The pmac_zilog serial driver had an error
path in its remove callback that however was never taken and so could be
dropped.

There are no interdependencies between these patches, so they could be
picked up individually. However I'd expect them to go in all together
via Greg's tree.

Uwe Kleine-König (3):
  tty: amiserial: Convert to platform remove callback returning void
  tty: goldfish: Convert to platform remove callback returning void
  serial: pmac_zilog: Convert to platform remove callback returning void

 drivers/tty/amiserial.c         | 6 ++----
 drivers/tty/goldfish.c          | 5 ++---
 drivers/tty/serial/pmac_zilog.c | 9 ++-------
 3 files changed, 6 insertions(+), 14 deletions(-)

base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
-- 
2.43.0

