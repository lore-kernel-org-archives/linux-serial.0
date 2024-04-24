Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59A15696D
	for <linux-serial@vger.kernel.org>; Wed, 24 Apr 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938429; cv=none; b=SskmHbZdPxj+xmHi3mPOTJY2R2LlIUbprAKT83vX56slqZAJ0lKfMjNAPETbkmoYcd2soC0IqOMgOr/uVxsRgBZFrxaftGycrHSEcMmfnkSVRj11AkG5IBS9LcOnIpekDYR/e+Y2ew0VPkbpIqa+WJAC4DVXrNyzevKvHefXlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938429; c=relaxed/simple;
	bh=nvIPui2ny2LbHagQUrcXOUnm1wNFXZyyF3UpKRbeMkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BrOI2kBuVZsb+uSfeJ5+xTi8TFK4lblIemmkA04ji9PHhLRW9pucsEmkLOmC3rRMwlTsapoLz5QcrW/caMWHupM5tp3O09QFcj0/Q5hFMn/iEBOi26HOyOqjPmgQLYr+63aIojIXOn9fBUwau3L8yXGBJaFTQMIs/AY9mESN4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b=HDJwnIUq; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b="HDJwnIUq"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240424055011c49cbd2ab7ca720011
        for <linux-serial@vger.kernel.org>;
        Wed, 24 Apr 2024 07:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2vHGINbeeSfwsgWaZmnck2tclo2bm4vX2z5Axlbkzok=;
 b=HDJwnIUqO1418xKMoN5ekvJn0kW8nJx9BMhr2NG/hAeSmjMlQfUjO1Vu6RBskW29ENxssN
 ysFD/QROGZ1OyhxDQ7Vvefzk44D7h0eNlHuu9TooZPIMSePqISL5U0hQ0WpVRKsvsDKfPYpc
 ZBYq5eZ41B85m3AsesZ02cxghGoUY=;
From: "D. Starke" <daniel.starke@siemens.com>
To: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	j51569436@gmail.com,
	Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/2] tty: n_gsm: fix possible out-of-bounds in gsm0_receive()
Date: Wed, 24 Apr 2024 07:48:41 +0200
Message-Id: <20240424054842.7741-1-daniel.starke@siemens.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer

From: Daniel Starke <daniel.starke@siemens.com>

Assuming the following:
- side A configures the n_gsm in basic option mode
- side B sends the header of a basic option mode frame with data length 1
- side A switches to advanced option mode
- side B sends 2 data bytes which exceeds gsm->len
  Reason: gsm->len is not used in advanced option mode.
- side A switches to basic option mode
- side B keeps sending until gsm0_receive() writes past gsm->buf
  Reason: Neither gsm->state nor gsm->len have been reset after
  reconfiguration.

Fix this by changing gsm->count to gsm->len comparison from equal to less
than. Also add upper limit checks against the constant MAX_MRU in
gsm0_receive() and gsm1_receive() to harden against memory corruption of
gsm->len and gsm->mru.

All other checks remain as we still need to limit the data according to the
user configuration and actual payload size.

Reported-by: j51569436@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218708
Tested-by: j51569436@gmail.com
Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f5b0d91d32a7..7c697dab6f84 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2913,7 +2913,10 @@ static void gsm0_receive(struct gsm_mux *gsm, u8 c)
 		break;
 	case GSM_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len) {
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			/* Calculate final FCS for UI frames over all data */
 			if ((gsm->control & ~PF) != UIH) {
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
@@ -3026,7 +3029,7 @@ static void gsm1_receive(struct gsm_mux *gsm, u8 c)
 		gsm->state = GSM_DATA;
 		break;
 	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
 		} else
-- 
2.34.1

