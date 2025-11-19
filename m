Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B60332EBC;
	Wed, 19 Nov 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592173; cv=none; b=jykhkwMPiFWR1OV2lCqVcgWLLKEx6nPW7aCYYo2wljdv5kL7btNOaLOR5LmXWV6mSHYXxdxK+GxZ8GFWP+SGOAhTAd2X2idsLJH5IWsYXOcfDhcCm9dw8fzT5s3erB4wTptKRIAwSwiPxCfZWMz0Yjt41J0yPvSFKIszq4nbUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592173; c=relaxed/simple;
	bh=T0Sxp6xsTa8WHrZCPbphVeR1iBAUpsGRCq/LGdqVZ7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qM/zo+ajYS3/IeF+OpyKKItfQRaMy+ZnLKGNYG8dpFe7HufDIQYqc1faV8Zc2Bt054QB6ggJuCVLXXTZiqHBW6OWQP7Rk+XzPp67RjNgQ8oL2uUcSC60gaDITPlYzvbg/q9LJZpL9kzJQr0Snnp0p7+3eVQJs3rcZAj9zgAcuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=2QQoyEmF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="2QQoyEmF"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsz-006yvY-CN; Wed, 19 Nov 2025 23:42:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=kajQNevhoLguN2aApJmIevDLTauYCAm5/mL/qG+eV6w=; b=2QQoyEmF89XnRHRftzYQ3PCMno
	j8slCyBoubJF4Z+hMjOecF3xZQOoc395Mx5+XcCxFu9p46TImC1VgYqxrVCejxPrsilkTX5pKhozr
	QkAWo3Nw7BVXcgdfnFADk2LmDf6/x8bM2NspHWc6ut3qUMxJC8Soz48/1vh8OLKYuJTMv2KG4v9bG
	OWYSx9Bh4tpmi4k1DFxUYTmFeZQLeoHV10+u53JB28l6E6HqKWN8N1ARPyzZWUwPyLSAEa50jyE2s
	5dyKrg1fCbxEDzZWx72ZQwM1p74tntZC5G2VK9j0dCMqvPJCkvPyCCT50liutIYbfQ5byu/nfuDOl
	bMQsXtVA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsz-00086B-3c; Wed, 19 Nov 2025 23:42:49 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsh-00Fos6-JE; Wed, 19 Nov 2025 23:42:31 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 27/44] drivers/tty/vt: use umin() instead of min_t(u16, ...) for row/col limits
Date: Wed, 19 Nov 2025 22:41:23 +0000
Message-Id: <20251119224140.8616-28-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The row/column bounds (for a screen window box) are changed from
'offset one' to 'offset zero' and bound to the screen size using:
	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
This has the side effect of converting zero to the limit.

A check I'm adding to min_t() reports that (u16)(v->xs - 1) (etc)
discards signiticant bits (because v->xs is promoted to 'int' before
the addition).
If v->xs is zero (it comes from userspace) it converts -1 to 0xffff.
This is then bounded to 'vc->vc_cols - 1' which will be fine.

Replace with:
	v->xs = umin(v->xs - 1, vc->vc_cols - 1);
which again converts a -1 to unsigned - this time to 0xffffffff,
with the same overall effect.

Whether zero is meant to mean the 'maximum size' is unknown.
I can't find any documentation for the ioctl and it pre-dates git.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/tty/vt/selection.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 07d3b93975d3..13f4e48b4142 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -348,10 +348,11 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
 		return 0;
 	}
 
-	v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
-	v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
-	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
-	v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
+	/* Historically 0 => max value */
+	v->xs = umin(v->xs - 1, vc->vc_cols - 1);
+	v->ys = umin(v->ys - 1, vc->vc_rows - 1);
+	v->xe = umin(v->xe - 1, vc->vc_cols - 1);
+	v->ye = umin(v->ye - 1, vc->vc_rows - 1);
 
 	if (mouse_reporting() && (v->sel_mode & TIOCL_SELMOUSEREPORT)) {
 		mouse_report(tty, v->sel_mode & TIOCL_SELBUTTONMASK, v->xs,
-- 
2.39.5

