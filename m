Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFD1A285
	for <linux-serial@vger.kernel.org>; Sat,  6 Jun 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765420; cv=none; b=Qf8ZS48caCCEDMJ50n2gCw9c159srEyOZBeYSjox2JRBLMRYQJ/MeQgNqRvRO0VVsC5iz3trnrWfz7KR8knlKXU+LH203+1dyawUDbKf4xgGDMG1Jj/YS7SmGZKk/yoDZUrBPX1jsCxcsJpYq29aUtDSI+2t84xGYezY2fgiH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765420; c=relaxed/simple;
	bh=H446K/7KgdT9qXbPeowydu9cBUFhDnTPMsIkSN1Ikpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erBLxwJmNtsgO377ASUWV+mJCit8Le4lCtgYO9UfBquSGVxCgAweHptmmBVCOad/Mm8kzR0BBY0qodKi7WkPLa8D8VVe7EQhW88/VgeTZHPn0pi3HFWY6lpOn4GIyB11+hThoVeeTbq8mbYiZouD26MWNGPUaqAAzfOlUZ9xQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUgimSX3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUgimSX3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915bf8800a2so41452685a.0
        for <linux-serial@vger.kernel.org>; Sat, 06 Jun 2026 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780765418; x=1781370218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcV9UXiai8KQeY9VGfmbLVC6lT6RH+nUco+ZyzsOUwM=;
        b=lUgimSX3eCm3GcgM101hsfVPuKl77uffO2fbRP/Dh8zhIhZ2vfdWlANEGgIEkJqN/v
         +QnG4bFZM9uTg0C6PYXlbt2cO59lTvhUAfQt/gYiTsCcBfTj3qKYzAftE/POfkaogtEx
         ryn1f0OpB4cH+qGiZgCE+R82TulF7NCxJ3gBaRM2GRxrxussEQM1nBBdLglAC4rxmP4V
         Qf36UnwNoal24pJ2MWB+M1uzPo6lFN6qNGPFqPHqKhLLpb6T2AdQpITEaZEkdB5QIx0+
         5hyvpOlja26HHELX0A/uee/zqmBVIyPhSmVeN+M0hXdMwSJs/CQth20vjt9PyzInhvSY
         qsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780765418; x=1781370218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcV9UXiai8KQeY9VGfmbLVC6lT6RH+nUco+ZyzsOUwM=;
        b=BDsT2uFGMEmD0r+PJBeaqlxnpM5qFTV5JlaqmcwKRb/koAM1gpsDMwfqP91sk5J1UB
         YVDF/atwiy8GmJfLjZCV2SbUBi9CQH2YdVfy5MlHfCO/2SnXMUTjk7GAYYec8O+rRvbf
         HtS1d6FNINFok4Q0M5IezgLkXxxpiNrXIr0Ifqw1e9B7wZuSblw3vx9ECl/VL6qlds0B
         gwpdSw0pghse65nwgAGHLMGJKOXnvawPchxoNF0UZuBnAC4PlM9cm30YL8t2oRElhRSf
         PrCSd9sAJyPQ9Qlc4XefMT8F8OePVdiPRQb5gjFhfcybnCEBmJNHZCqi6MF591QH9rJn
         MYBQ==
X-Gm-Message-State: AOJu0YwNHm8H9o2/C3jZNqzlK/Cr4xnsBTDx6M28yJVGjQpZbFFX82iQ
	EFbLcWGGG/IY3uLiSv5Ik+dToQNy5ZRbmsUtHw0fd7dtp3kFaeh1bRTk
X-Gm-Gg: Acq92OHPze6hIBODDpkSldJAm+pdtrE5PSIqhkmPBkpkDbgDCIJbZXA516MDvTdWNPc
	ioVuBpGBZxFzBzxdr7cylfG+bi+EPKWmTMe9JTEb+ERxhPAUmrCyxdZ8P1Db0t4XdMEpso2QbW9
	zw9cnmODia+Fkq9TBdYF5TE+aqUMcxOXbGkA4bM0NnNT28DLH4z5ZRFJqBPL9HPlPKIU3vFNyEe
	UNGjbTjCxEgIjN2cE5Y2KNu0jFvP9wl7Pkl2wfteS+dzARIFT1G+lB2S7kFX7uFJSqBzl+Y803z
	2QhW4VwXIzcRGMwrAnJtMwDtoVxRHl9zaGxrbiIJGRUT1jtebaa1rDjrnCrhtEjsKQ9sfAAWF4w
	J0tDQ80zhWCMCwEViT3HKIgWkzbJQsOrImvkrFNWDf/Ps9AMjSYuQsivQcwwxzMOj3n9RNV9MP6
	vP+Hx3VUPLTE8hHaODAW5UrfkYYEvdgQDWpfhPDFycemKgEzmyobi3jdP8nl+ZhuTiKmgaDWaPr
	+j67H/6KM8XXc2+iWvz7e6HaipgkYc=
X-Received: by 2002:a05:620a:3910:b0:914:c01e:6f8e with SMTP id af79cd13be357-915a9db9e00mr1538199185a.42.1780765417782;
        Sat, 06 Jun 2026 10:03:37 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdcb3c5sm117443606d6.21.2026.06.06.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:03:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: n_gsm: bound the EA scan in gsm_control_rls()
Date: Sat,  6 Jun 2026 13:03:23 -0400
Message-ID: <20260606170323.1522340-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

gsm_control_rls() walks the control message looking for the end of the
EA-encoded address, but it dereferences each byte before checking the
remaining length:

	int len = clen;
	const u8 *dp = data;

	while (gsm_read_ea(&addr, *dp++) == 0) {
		len--;
		if (len == 0)
			return;
	}

When a malformed RLS control message decodes to a control length of
zero, len starts at 0, the loop reads *dp before testing len, len
underflows to -1, and the "if (len == 0)" test never fires. The scan
then keeps reading forward through gsm->buf (kmalloc(MAX_MRU + 1)) until
it happens upon a byte whose EA bit is set, reading past the end of the
allocation.

A two byte DLCI 0 UIH control frame carrying CMD_RLS with an encoded
length of zero reaches this from the receive path. KASAN reports a
slab-out-of-bounds read in gsm_control_rls() (inlined into
gsm_dlci_command()) when the bytes that follow the message in gsm->buf
do not terminate the scan before the end of the buffer.

The sibling control handlers gsm_control_modem() and gsm_dlci_data()
already reject a too short message before walking it; gsm_control_rls()
was missed. Bound the EA scan by the remaining length so a zero length
message returns without dereferencing past the data.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/tty/n_gsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b1..4f8f2ce038bc8 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1806,12 +1806,12 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 	int len = clen;
 	const u8 *dp = data;
 
-	while (gsm_read_ea(&addr, *dp++) == 0) {
+	while (len > 0) {
+		if (gsm_read_ea(&addr, *dp++))
+			break;
 		len--;
-		if (len == 0)
-			return;
 	}
-	/* Must be at least one byte following ea */
+	/* Must be at least one byte following the EA */
 	len--;
 	if (len <= 0)
 		return;

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

