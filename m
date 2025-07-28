Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCB198851
	for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667086; cv=none; b=nxqrPCHK9n7JvgWtxVepWnABAE5lsw+RREr/QBe8jBBUuVlCpQIqZh1BF6l1BeexvGT22K0rVaRnz08hZbDXjOwXetIJZ0h84YFNBvSP/PztvZXniPWZau2dXjV6t4vW0i+VyAdKFTudnuXRsRCnQJUk2V8+XuN80mHdU6rGmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667086; c=relaxed/simple;
	bh=3vlZGc/DHNfl1nX+4w/9/X0vKZTTie393s6G3A8xs7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QmvjmY+hip4HSVh2ncWH7svHfChmAMmHawiqeIOze15T0Sh0cNxwVBCUmfGm9Aco86bJnK//ExbmME+o17SkChQmrXTfyzvpQVWxIiHJ5CoJmguA/TJM5MzmZKsX09f4/oQwrXljb3qzqngwpmOjALsYjzs/yfAUdNHhiDeJRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=HSkvjIAj; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="HSkvjIAj"
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 691E6104C1D0
	for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 07:14:35 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 691E6104C1D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753667075; bh=3vlZGc/DHNfl1nX+4w/9/X0vKZTTie393s6G3A8xs7c=;
	h=Date:From:To:Cc:Subject:From;
	b=HSkvjIAj0FH9lAPypfS+1zGszzrC0pimomPqngMfp1bHxDkCeNwe/gQoHUxlLunls
	 BLXI+tP2XiZjJHfNHXijAHJHv4Q2u+9mdDHQVv7ubE4vfVddLoQS7Rbp1+I61v5tFe
	 WqUQXrjD4a0QETW0BNZocPts/xs7C60SJvUkTwmY=
Received: (qmail 10676 invoked by uid 510); 28 Jul 2025 07:14:35 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.718594 secs; 28 Jul 2025 07:14:35 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 28 Jul 2025 07:14:31 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id CF33B36003B;
	Mon, 28 Jul 2025 07:14:30 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 900A31E8128E;
	Mon, 28 Jul 2025 07:14:30 +0530 (IST)
Date: Mon, 28 Jul 2025 07:14:25 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com, john.ogness@linutronix.de,
	pmladek@suse.com, johan@kernel.org, namcao@linutronix.de,
	timur@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] tty: serial: ucc_uart: use WARN_ON() instead of BUG()
Message-ID: <aIbV+WbhFMDamaiW@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace BUG() with WARN_ON() as recommended in
Documentation/process/deprecated.rst
Fix system entering into unstable/break/undebuggable state due to use
of BUG(). Follow strict suggestions as per [1] [2].

Link: https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/ [2]
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/tty/serial/ucc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 0613f8c11ab1..6214ab1b67cb 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -223,7 +223,7 @@ static inline dma_addr_t cpu2qe_addr(void *addr, struct uart_qe_port *qe_port)
 
 	/* something nasty happened */
 	printk(KERN_ERR "%s: addr=%p\n", __func__, addr);
-	BUG();
+	WARN_ON(1);
 	return 0;
 }
 
@@ -242,7 +242,7 @@ static inline void *qe2cpu_addr(dma_addr_t addr, struct uart_qe_port *qe_port)
 
 	/* something nasty happened */
 	printk(KERN_ERR "%s: addr=%llx\n", __func__, (u64)addr);
-	BUG();
+	WARN_ON(1);
 	return NULL;
 }
 
-- 
2.34.1

