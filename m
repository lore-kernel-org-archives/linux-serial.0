Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50342F3E;
	Fri, 10 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530765; cv=none; b=tO1QdO31oPzeYY0W66AhQeQnAhgWVPzSOBkQG/obQ4WZhD+PyQNg27h0O3ieh1ENCJA8y3y2rMQh1y6sjHkVx5ccUM337W42mWHnWbpKmtTgiPTIM4cEgGe/2mrriN7OM57xmThZ1UXPTQ7a35SAfUJBPlM4+Px4ExgjFbLRoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530765; c=relaxed/simple;
	bh=EWXiWj6f/XJZiM4qvtGi3vKem6l5b2RKhA0uvGGe7s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PtU89HwFVgPoOWHj5Dmed0HXf5llNXeeLkCVMLpfbgevuupRbkZLx1W2n5iy/+qVQhGLSWAHDQzfgN1WdbFqa1tVorwhlv/WdJr7m2le4AEx3eCfmi8WofVFvC0dDtuoPjW5gVxpVEYRqKwNrYZ07MbJEFkdUfD2Dd9c+/htQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Eu8EWYov; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Eu8EWYov"
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 109532675D;
	Fri, 10 Jan 2025 17:39:22 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id B6A0C3E9D7;
	Fri, 10 Jan 2025 17:39:13 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 3CBB940186;
	Fri, 10 Jan 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1736530752; bh=EWXiWj6f/XJZiM4qvtGi3vKem6l5b2RKhA0uvGGe7s8=;
	h=From:Date:Subject:To:Cc:From;
	b=Eu8EWYovSbZJ0B1w/UAXo3W0Ew9klI2syEvO7J4/lCXIO013EAx0/luZ5mY0hfEBW
	 gA9/iPjBk9MzZ6HVRMRFjI8J+S90Qg2b/wuRcPGGSNMCJTlpgpZHUiGUOzxyPXS0S6
	 MqBTj3TJmRpLDU6JhrfzcjB0q2wmqhne5cvVcONY=
Received: from ProArtB550-CREATOR. (unknown [58.32.41.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id E4A0F4069D;
	Fri, 10 Jan 2025 17:39:09 +0000 (UTC)
From: Kexy Biscuit <kexybiscuit@aosc.io>
Date: Sat, 11 Jan 2025 01:38:51 +0800
Subject: [PATCH] tty: mips_ejtag_fdc: Fix another passing incompatible
 pointer type warning
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250111-mips_ejtag_fdc-fix-v1-1-f4282a5ce239@aosc.io>
X-B4-Tracking: v=1; b=H4sIACpbgWcC/x2MQQqAIBAAvxJ7TnAjD/WVCMlabYNMNCIQ/550n
 IGZDIkiU4KxyRDp4cSXr4BtA+u+eEeCt8rQyU5JRBQnh6TpuBen7bYKy6/oB2PQKLJoLNQwRKr
 6n05zKR+fIuFLZAAAAA==
X-Change-ID: 20250111-mips_ejtag_fdc-fix-49bb1b5ef1bf
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Serge Semin <fancer.lancer@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Kexy Biscuit <kexybiscuit@aosc.io>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,alpha.franken.de];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[kexybiscuit.aosc.io:server fail];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3CBB940186

mips_ejtag_fdc_encode() method was changed to accept u8** since
ce7cbd9a6c81, but not all occurrences were changed to adapt it.

Some of the warnings or errors was fixed in a previous commit, this
commit fixes one more of them.

drivers/tty/mips_ejtag_fdc.c: In function ‘kgdbfdc_push_one’:
drivers/tty/mips_ejtag_fdc.c:1224:38: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
 1224 |         word = mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, 1);
      |                                      ^~~~
      |                                      |
      |                                      const char **
drivers/tty/mips_ejtag_fdc.c:216:57: note: expected ‘const u8 **’ {aka ‘const unsigned char **’} but argument is of type ‘const char **’
  216 | static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
      |                                              ~~~~~~~~~~~^~~~

Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
Fixes: 188942f05ce4 ("tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning")
Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
---
 drivers/tty/mips_ejtag_fdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index afbf7738c7c47c3377560a3288fa95083dd1c6b0..1cc775e74f92d2c5e7a7b4bb500ff2ae758da8e0 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1215,7 +1215,7 @@ static int kgdbfdc_read_char(void)
 /* push an FDC word from write buffer to TX FIFO */
 static void kgdbfdc_push_one(void)
 {
-	const char *bufs[1] = { kgdbfdc_wbuf };
+	const u8 *bufs[1] = { kgdbfdc_wbuf };
 	struct fdc_word word;
 	void __iomem *regs;
 	unsigned int i;

---
base-commit: 2144da25584eb10b84252230319b5783f6a83041
change-id: 20250111-mips_ejtag_fdc-fix-49bb1b5ef1bf

Best regards,
-- 
Kexy Biscuit <kexybiscuit@aosc.io>

