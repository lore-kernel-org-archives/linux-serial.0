Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083837;
	b=xguVonM3C3wo8AMUMOsOtT+tZ9Po3CCPa7jlcvhDaABnnEbkew/tDjsUvxpIbGT0RZ7f
	 iwFtALfmXgBC6iErpXc+h7qIpCTaMs1EMacB2XyS34Sl3Dk9RUAD0QXgsdd6FnboBcIFH
	 ORu3zFy7cv/IzqXb7QcC2AGBbiIC86W9xUcd86FDk8ks28Vq6ExDn0I/QIa0CTqK5VIfK
	 mmwkQAeIAxVAU9VmhbfVTxjOPVFDitra3mpSnMG4iYXjSvWdc/W+DservkQI1FyA5GkgQ
	 /2d3Ya2jXRnlpVvRwCemzoNI9jclq/jUP90PMQ6cnA/04Rc53hHtWHe9e0AOeYpCKvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083837;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=HHodHl7+LK+fJe9vqOLBRvvxXoceupLm/0Zr4G329/k=;
	b=oFuaCDbLpM+6Y7ErANnbkup5iNku6bak21G8zaVxTiHW6QSomjX2ibVYiXN1VHHW+rLU
	 geRR4Td5M/7UATKyPzV8pJF875GKlZ76vehjjcWluZYWaIPJ6KMTPHIIrtKCu6adbrqCS
	 ZcTV7JbIgf3VVXGtOPoFddE3kDsikZrBSWhc58EIEAQIJ2gV0dqPTRmDQYljLtierTGVg
	 oNa/FGZPdF6N4rJ2EzdiYjHz2DAm6xHdCGTHYil8Z6EgrtFrqPTVIOiFq6gTm6azny3XV
	 MDkH6pD6EIsInhJs6z0078A/Ibjcx4j+yF/i+yJoVmXdDs/EKPALpJZWB3tEWfr76rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JmEQmclL;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1E606A31A;
	Tue, 27 Oct 2026 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JmEQmclL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793083828;
	bh=HHodHl7+LK+fJe9vqOLBRvvxXoceupLm/0Zr4G329/k=;
	h=From:Date:Subject:To:Cc;
	b=JmEQmclLOzQB9nNt5Tx7jOvYswzbWVRAomcyCTNDO5GurKdiAPP7g8JllVtzpD2qh
	 d46/1ll2kjW4P5uOhl1fRzEELLjZCTwywLdLAWzs1XOOeMETkcwaCmvsLMHciW+WQR
	 /XOnA9eCpXLh6Sp2GesI9iP+z30F0U3O4bgKRomyx8sleNRC7w27UMfod93vciWd6a
	 EUaG+OGEGltv4kvfkTzs4vug2ioYcWiKjfk2Eo/l+fUvugmVumHKTpjvNyQG8Bc7dV
	 JMVNZrjFP+7LtgO1tAtbBGnu2iYPwpo3PtQvpG6cff9OwtoQm5r120n+QXEouwrGDa
	 k/jp86i531THA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 3003B64AB5; Tue, 27 Oct 2026 14:50:28 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Tue, 27 Oct 2026 14:50:24 +0800
Subject: [PATCH] tty: Correct tty_operations @remove description
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
Message-Id: <20261027-dev-tty-remove-doc-v1-1-e4272aa01ddc@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAK9J4GoC/x3MSw5AMBRG4a3IHbsJjfdWxID2xx1QaaUhYu8aw
 29wzkMeTuCpSx5yCOLF7hF5mpBex30Bi4kmlakqz1TNBoHP82aHzQawsZonNG1Vjm1RaFAMD4d
 Zrn/aD+/7AffTy/xkAAAA
X-Change-ID: 20261027-dev-tty-remove-doc-be8965a944ce
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Description says that @remove is used in conjunction with itself,
seemingly an unadjusted copy from the description of @install.
Replace @remove's reference to itself with @install.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 include/linux/tty_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 40ae3bb13e11a22390906d6307bcd52ab7f98c76..26fd80dc39e2ffbf06e1520ee242e8e9084efd56 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -135,7 +135,7 @@ enum tty_driver_subtype {
  * @remove: ``void ()(struct tty_driver *self, struct tty_struct *tty)``
  *
  *	Remove a closed @tty from the @self's internal tables. Used in
- *	conjunction with @lookup and @remove methods.
+ *	conjunction with @lookup and @install methods.
  *
  *	Optional method. Default behaviour is to use the @self->ttys array.
  *

---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261027-dev-tty-remove-doc-be8965a944ce

Best regards,
-- 
James Lee <james@codeconstruct.com.au>

