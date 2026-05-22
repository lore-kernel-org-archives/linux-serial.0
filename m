Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06A40FD98
	for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458488; cv=none; b=mGTL9r3CiDG0hSP/7cMKVt+4MHSbkjxqelin3KqOhnjSTwdKvEJ74dQi+eLEQZbcTaip0XpT6o++++ZzV4WwmduI+tfeq2nDacp4xy+tI32rvreoL0TmgagujM/Z30wZD09sEvODKI51sP4pVkx8ka3+To2iXv6e6rKagFR1IwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458488; c=relaxed/simple;
	bh=auClZft7VdNRE+QTLNJrHUjk+O/0nGgODOAHYjA9MXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QwUCNI027puWbqjNF5275tn95WmhPYjGiqbc/car1pccXB442vJDnWSQ7KYSvkA+JwqkZFJCrVssrckthiwcIPnHsDlt6ANa0cJiRK1J+DESCIFCZaJtSMolv+8/eQNMfChzDUE88SvCR+E3SXtFn4YfZAhDrmuMKFnr+EOruW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MRRmgZrT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MRRmgZrT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49041e84237so7727925e9.1
        for <linux-serial@vger.kernel.org>; Fri, 22 May 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779458476; x=1780063276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yc5bJxLqrJjZCtVBZCib+tWdN1ETOFhinbVuxikn2Hw=;
        b=MRRmgZrTHsPAN1Xb5Jr8oX/U8ecNIT+Av5k+dC+HGzCpplsXheV+XznAmikwQbL6Hb
         Id4XhZVMhCQWfX+Yd2si6UfHxZ47tMMyhP5FP10Xs4gS4S9VcotROMpOEOt79+AtCwjR
         8wtBek7ea0z9mo1p75955HP5asrOKXffV4NhBPx4XMefNH4auVBSa15q4vn0I0og5s6H
         yil43wZwWumSBJ5XDOsx/xGNKWXG6CSsyIA8bRbRmxQRSrNQenWKw3bH+oIqowEyRu7G
         F1Ki63aLNo4nHSW6MPj3DAU7wXSClvRs272FYM78P8nub/4Mo0IWMGoCN99JrC3LmJMt
         +a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779458476; x=1780063276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc5bJxLqrJjZCtVBZCib+tWdN1ETOFhinbVuxikn2Hw=;
        b=oSZxUhwpxjiER1SwWEEDmaq0SwnYvNMhhj8bDL+XtD0H3kUJoQ/msdHdVUx89XbiHp
         PERIEMH0T2+U4kpWPAJxTw+J48CcblI6g28ujrElIJpEFq4gCffz1YP/j7pJGhGSAPQ+
         PLwjkX3C7S9Y96ZisaQTXTSlTy8tH6W1EB71OcBeMqzlfUeTjPhEng9uISeGeTfQbXC6
         T3BdmrR7zhnTvJDFPj6Me+oCaZFyQgHYREy2+WL2MHDuKPIXvdSvM5ZD9oqbd0S4UKvV
         SteXitWQUXqTQc3TAWJtjXalr2xnAtlGvTXHimjluFTA1+LLcQ5N6njc6Mnb0aJRvbgG
         F8+w==
X-Forwarded-Encrypted: i=1; AFNElJ/SDGqKwAcjBRY9UwsxtzgAPiLyyuxN/XwGyA9LJo/dH/V+qZHrGvQgQCKx8ApR+2VPiN048vHhv0aqKjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJ4yVIrY4KeU48JvzumGZ+UluvqtKlBU8FFqSDUsWbKGRe7KQ
	MaLlzWdj03OA+U5pesYyHRn5Ev+gUUV0MONbdpNZoVw2/ZkZ6Jpdd1rRMqNCC6dnu3Q=
X-Gm-Gg: Acq92OHQLbdMy3SEqKT/H41AgIU90sW+TfZTz9VrsKJwvjBq44WJJgc20LMieOpVX0l
	mD+KwdsIxI1UJ2/exw1zu4rQ+MYPDBlAn4PNsgfEftsuayBiWfGhFuTEvxYi3LJ63okudP+1Kah
	2THYWCy2PbBR7hBULcqSezm+yhBMtdIEb8fh9xb1tHTnAtmTln3QL09ruF+ddJ/Ta9dFoVjVYi0
	J2bu/knKuQX1kFx1RbL+uagTl63OiWqUo4I93uPH4TnH/w3I659W7livOFtZGcOhzVfn+H2h7OU
	UoBCMcrBYTXXPHxn/e6njyJ4pBEzFqeaMzq6BldqzwpZKYE2m2Co+IGB0hQ1r4IGhCsfiZ1EjU/
	Gu7T8r8CfWFZoPfODKWOq96cr3Kd36pt8lo4BWMIEMgasAjL2ygYW8wrklGgO97pjpDI7bgX86y
	R9Y3vmT9qwD4ooCpVYSSE8Ikp0LGC7nqHPeu+//s7VQJVeWgd8aZvn7X1GTDuCcvKz1eFrA0oxn
	rE89JOzws2YHDNDjVVIvKRT7Q==
X-Received: by 2002:a7b:c7ca:0:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-4904b8956c5mr3635125e9.11.1779458476216;
        Fri, 22 May 2026 07:01:16 -0700 (PDT)
Received: from localhost (p200300f65f47db04fdedbb26b9ad100d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:fded:bb26:b9ad:100d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490428d4d8asm16740125e9.16.2026.05.22.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:01:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Florian Eckert <fe@dev.tdt.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1] serial: 8250_exar: Consistently define pci_device_ids using named initializers
Date: Fri, 22 May 2026 16:01:03 +0200
Message-ID: <20260522140103.769262-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=auClZft7VdNRE+QTLNJrHUjk+O/0nGgODOAHYjA9MXg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiyBxPk1gWIMhTdX5Zcu3uumtvz+s0dabl4cy0U7nNZ4K i1Tnze/k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJOLtyMCx0XbrH/jnfh3nb 1wnmvQjRnJVh0OFRZu/yuvixotvWtRnmO+zWBd+ZUJN7V2SWXbaSRdfEu/8cXrRXhVyJr/QLFBE v1ekRKolQvnaJ61RS5Wll7mj9fy8cwq/m6H+V3G8i4FjiHrlI/2PonRlK9507by59oZd5Uzl0gS zTHpl17aWWkWUFczb/UuH61zj3m+X5NNMVOkdkp6ZKJR0994DbVGBeC6u52UTbxhSem6EKSmp2C X0rwnaWxTVoum84Xe+WdL+TP7X4ejgbL493vORi16hfSR2pM7bdYs36/jkjaFvoId0Vdk9UPNil TrIpVDQfey/oU317ZrP6+SMl7grcKtPsZSz+mpvb3wYA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the struct pci_device_id array were
initialized by list expressions. This isn't easily readable if you're
not into PCI, still more given that it's hidden in macros. Using named
initializers is more explicit and thus easier to parse for a human. And
it's also more robust against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
pci_device_id that replaces .driver_data by an anonymous union.

Also drop a few explicit zeros that are not needed and improve
indention.

This change doesn't introduce changes to the compiled pci_device_id
array. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/8250/8250_exar.c | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index c682c0d0dffa..f9a14eaa13cb 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -1642,14 +1642,14 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
-#define CTI_EXAR_DEVICE(devid, bd) {                    \
-	PCI_DEVICE_SUB(                                 \
-		PCI_VENDOR_ID_EXAR,                     \
-		PCI_DEVICE_ID_EXAR_##devid,             \
-		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
-		PCI_ANY_ID), 0, 0,                      \
-		(kernel_ulong_t)&bd                     \
-	}
+#define CTI_EXAR_DEVICE(devid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_SUBVENDOR_ID_CONNECT_TECH,		\
+		PCI_ANY_ID),				\
+	.driver_data = (kernel_ulong_t)&bd		\
+}
 
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }
 
@@ -1658,18 +1658,18 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		PCI_VENDOR_ID_EXAR,			\
 		PCI_DEVICE_ID_EXAR_##devid,		\
 		PCI_SUBVENDOR_ID_IBM,			\
-		PCI_SUBDEVICE_ID_IBM_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd			\
-	}
+		PCI_SUBDEVICE_ID_IBM_##sdevid),		\
+	.driver_data = (kernel_ulong_t)&bd		\
+}
 
 #define USR_DEVICE(devid, sdevid, bd) {			\
 	PCI_DEVICE_SUB(					\
 		PCI_VENDOR_ID_USR,			\
 		PCI_DEVICE_ID_EXAR_##devid,		\
 		PCI_VENDOR_ID_EXAR,			\
-		PCI_SUBDEVICE_ID_USR_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd			\
-	}
+		PCI_SUBDEVICE_ID_USR_##sdevid),		\
+	.driver_data = (kernel_ulong_t)&bd		\
+}
 
 static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
@@ -1726,7 +1726,7 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
-	{ 0, }
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

