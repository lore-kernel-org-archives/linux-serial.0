Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EF3ADB98
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701588; cv=none; b=a+OYO87C7c6DTT9vPQnQv+iysGvCRZtbAFLT1/I7eBcOXeZsi0bKcJ4PRneBEcFjgTD4yO6iggpQU9PwnMcTk2osp/AVDAexqLfWR5LMIdyDJxsQZN4Ep/OPW5DE7tSoHTofsjCHEEN/f7PXqdH7B18uO1Rys+bLRpF+2SCQbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701588; c=relaxed/simple;
	bh=NQ+y1ICl3PawbvzxObGCrZ51PsEgmYueMUZEFc+mFz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQtTolKBHsUEEuMK37aeWRtLMwa3kzJJ6523ZliKCSoGYL0xixocp5KY0v/1n15uLU0oe3+dlM/ne7vJDk+tPdDrqlC4rTH7c0KDmIbq6a2a4xE/Z8jhwhNkX5txl7m8TKTJr92hlC4gRLgpd5TgFuwDri42EFrwU1F6x+exgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=awopcEca; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="awopcEca"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998590d392so8789255e9.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786701579; x=1787306379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWni7/P1TLeaS1L80x7kHaCDaly3I+Mnlc0rRJa7lOQ=;
        b=awopcEcapgB21/i0HC4D3xUJGbx1jPcFjeVWLjjQTEo4HjBkKxBxRtYNyckWhdSX4W
         Vhru/Elk+kb0bpHJnIUUMAnCxLBNkQcyvRWRNlnXuw26RXgfpRDI5zjqtZAsWDUk//in
         QI1VVsvt2Iqli3BOakFkz/aSZ4GXlHMPIWHsDwz8qtuxXyjlP8nylsxiLmdX0gfNDFH9
         wNTmfFbkMbQ+FH/IHPQhP9M2sa9adKdbWethXcWGuCaDEmcixr5ams9uq5sG3yfBrdZF
         E6Ednn/S/7DHHca7TREI7F/6djF8B7jaTuUyS36Y+2hq9UgrikziLHW5C7Kaf/PR4ADN
         z+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701579; x=1787306379;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWni7/P1TLeaS1L80x7kHaCDaly3I+Mnlc0rRJa7lOQ=;
        b=A5PzrlE8moMRevzP9tir5KnToGR+fcTlpy6F7Zo6n76gHmCCYerVH7Iuf+XH/vj1T/
         FAyEJm3F7OsrJI9nU7mp9RAysQRphoFMn2MZLeUkw2fFIehs0LsQ6HArz0c5Hpwgl9ta
         6jVJmZ3FjC8RBMSM7acakbxQ0alO8xAYCGey2YSh2w4RD25/MUos8KYvkXIMCOpICmXb
         Nk3hD+p+lUzYpks92UG/G4VYJQ/w0uK5IaaDbfYmiv6f/Sl9hDFwfzQcJCAdpkt+4gmI
         kPD8Nbq+OqAzsplOOM6XOiar7hetubt7W5cqPvq95ssZJTDgYe03p8Xh1Xnslr9dwJ2A
         VbBg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0prdVbrocf9mqAtpp7UPV7o26CnaQ2YGa5/KPqU1AhmUTi5jfjDwXPype3bNh3jo7sIce8nhyGowoDZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfTJtp0wE2vjml4sOkaIjr3bJ5o6NlcewhaXD4YB+h5M5Zt9+
	RbcF/cs0N8UYZfJ5ap1JxhsoBYl9fEm+Tr+mvH70YwwOai8zLMZlWm4OGefD6Gncxac=
X-Gm-Gg: AR+sD11U5mRdQ5SZA9XXkJZKcmfok7VSuwv2wNe9ydYzh66TSgp6n6Fs0cIEwY3KRoM
	z9syTj7XtFGDD9EBqX5Wbzo7SkJaGuXx3PyQxvekT0sMLayyIuz+qWwDZSz+y1YK8j52WCPz6NS
	D1G/xDT9684lfhnmO1ZvRjMU9rxpJ895cmiOdLMwB8m0YCFAmsulXN3GGYZNFYihBjbZVD4gF8u
	Y+B9Hw9g7fWvq9rqwiwKIbEd/jREWziJyEJtaLIBxjHnd2/EAx+APsxeZ43Z81YmAaoVWDkMyC6
	BD0sFMRW+ebHLUGkINvqSR2nsgF+a4opa9jSdelYVP9KsJxlEY9mJ0mm0sZTdgBKO/4njU6Yw2W
	sqsN/EtHWFiIlOTR7o/b0tt+hQbR++QciLzzhpNwlYPG0MepbAycw5JVkntIG61ym6/jq7tp6or
	CcLCdbKkqTdK8PweEtrTF4cYW4LVH0nx/gmjRhjBRMPMdWmgNf3zjksswEajDLGXd+kM4KUqQDa
	r7/BwQ9A+3KjtbyXS/UbtNwttM3h6HzKif6m/wALp6LQ18hvqUC
X-Received: by 2002:a7b:c013:0:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-49987941a3fmr41196345e9.3.1786701578768;
        Fri, 14 Aug 2026 02:59:38 -0700 (PDT)
Received: from localhost (p200300f65f017104e65cfeae4f257a65.dip0.t-ipconnect.de. [2003:f6:5f01:7104:e65c:feae:4f25:7a65])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499899afa63sm18236605e9.1.2026.08.14.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:59:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	=?utf-8?q?Martin_Roukala_=28n=C3=A9_Peres=29?= <martin.roukala@mupuf.org>,
	Lukas Wunner <lukas@wunner.de>,
	Magne Bruno <magne.bruno@addi-data.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_pci: Catch up on new pci_device_id entry without named initializer
Date: Fri, 14 Aug 2026 11:59:31 +0200
Message-ID: <20260814095931.1871387-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=NQ+y1ICl3PawbvzxObGCrZ51PsEgmYueMUZEFc+mFz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqfucEKMghmq786+C2HTkEv6fdcKLFZkwU6oWuH qRWTk3njR+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCan7nBAAKCRCPgPtYfRL+ TlrUB/9YrPblhBJSHd+o0YYWA2N4lHjPWFD8LYUtcIJ2+j+hSy+DbiDQ/xmhSoSv0zqaURxmskQ nKqafs2568QqEoZ1xBk3Drj69tbqg/gHNfANlCkh8+Ar0guiXX+HsH7Z/aQC09iwB579ecQSsgb egNbKU/t1FOPCKOUr0d1H/DSrcyOZN+J0BFwYwc6PSaOTvYVmWy6v6/4qfom0rSPSpfvlBDB71J ZXsWweyWw4WR+tXK56Tc3yrYduzv4rORxfV6cHFEDToSfvFNor4tzkWh0BcJ7kNlcYqec8wBkIc BXdU/zEXdTHGJaMRYYrGDB3QU6qEeVK6DTpb/IyYvo/Z2EJ/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When the patch that became 0481a041e956 ("serial: 8250: split Moxa PCIe
serial board support out of 8250_pci") was created, commit 44e55f1f3088
("serial: 8250_pci: Consistently define pci_device_ids using named
initializers") wasn't applied yet and thus added an assignment to
.driver_data without using a named initializer. Adapt the assignment to
make the array consistent again and re-prepare the driver for the planned
change to struct pci_device_id.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

if you prefer it, feel free to squash this change into 0481a041e956.
Otherwise I don't think this change justifies a Fixes: trailer, but
still it would be nice to get this in during the upcoming merge window.

Best regards
Uwe

 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c24a59896982..6e53d6d72a8e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3894,7 +3894,7 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(PERICOM), },
 
 	/* Moxa devices */
-	{ PCI_VDEVICE(MOXA, PCI_ANY_ID), REPORT_8250_CONFIG(MOXA), },
+	{ PCI_VDEVICE(MOXA, PCI_ANY_ID), .driver_data = REPORT_8250_CONFIG(MOXA), },
 
 	/* End of the black list */
 	{ }

base-commit: 0481a041e9569dfc2448ba4c6cb30335fcb8430f
-- 
2.55.0.11.g153666a7d9bb

