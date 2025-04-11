Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03004204C02;
	Fri, 11 Apr 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372270; cv=none; b=WB/QZ2jNhJ6BcSqR6eKj1Tou19ZcoRsDme0a2RRXJ6G2cPnXu5Z1LDsSuZ2rGrEoG9Y5NDwhSfldHcqiJDwdGB4YNQE2yFn5nB4Lry6yroV/V1p1B44qO5FSRk3pTNNRViWQq49ZrR2DoSKLt7XetbWfpIbKHmI74jMeTcf+Nuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372270; c=relaxed/simple;
	bh=AtueuoOlmqi+gLWbZfWo0/v6QJx5lOXGeHniFzuHKgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/73Q5JgIEbfX9WjPfoK2UVpmQdpm+nQQ/v8F9JBmPqKMugA4o5vfj+xKbqKGpOovtrztjmrYFKB8PyvBQi7/6eM5lR45qunLSfoTci0sdapDb+eiJ9skRqMAKz7B4NI15lef9Sha6oGtsOsBjaoz1yQ9zMJxg0/9AjEMkHTSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPBRwiM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPBRwiM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30828fc17adso299858a91.1;
        Fri, 11 Apr 2025 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744372268; x=1744977068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qc9XUnFnXiP4+KXniiG6Mpox6n5EbScrsD7BSlOmYoI=;
        b=WjPBRwiMYS3PPFhnrHnl3gtZCL6iXhaTwF+NmgJ9XpPqucpI4YnCbCS7y/9uWbyqjC
         BZwWT1oPkf8FYtVscbPZFlC7ImQjpDOD9UlTFwEmcNNdMsoTNj457EwIsEryX+siWHti
         5fw92K1ledT1WvgJp2db637K51S1XU9gDZFpX/3LeSJ9r/HLCZTeN7k/966SE1l99sSV
         5GG2E41xqPKJUVYmpOmtg1TzqhYrr2Zpd/5DKHJGJTTof4oHzICb9kOod0HB0pDUXJDe
         3q7rXqu7/Y2dCNQ2FL6dJVdXpAw2mQ+/Iyf9Ajw89CQbQEC1LKaY7boovgZR8ySJIP1x
         pLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744372268; x=1744977068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qc9XUnFnXiP4+KXniiG6Mpox6n5EbScrsD7BSlOmYoI=;
        b=gJ3OLPS2yAIHHT5P7kGx71tbY+jAhtnxbB7fvMD2RZfbo8H9bqpgH78FU1JCbm09nj
         +KtdvS35Ocewt9o8MXmRAz9PiCxByspKn4kni1zUNJ4bN6BJbpelETikStl+j6GRUIc5
         s3cvXncxB+mRXQdjqqgnjqAmrLsUztbUe8c8HwcDCUYFxV3xabVIjl8lxtJjJW98jGYt
         d7aLDQkp9kIlCJkM+6mbfQZxYnMidy9Mw8ON9ANDEA0xKWTwgi+x9LtiGT4udrH46klC
         XI7mtI0wvT+U79y9BMfU6AXWh8U+KTX7W0M8IHEMAjKbe+2iFWYz5gldQyL+1YSM2MvB
         tIvw==
X-Forwarded-Encrypted: i=1; AJvYcCV+tqP2Uou0A+KIWjpVD0XD6PX2XpHEHOdeBHkGX5p+tmKgsmfiqw736Wi2YYZmLdimPKdvIixITIiRbiQ=@vger.kernel.org, AJvYcCXX3oOxxp3V9QBhpMV29u5vdblRxjbYJju0CujW07apr/wEfZenYTGDqe7q0gFDS8jAzuOuU3MAEeMehkkU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4OKJvoNbg966JacSZh9nMj/Q5LCGDXkcS0boBEevhffYMMlg
	9pHmLfsi14FhzkWfPDGsIE+grOrO4eshSoNQQAQBCdIqn5T3r4W7jJTek0ec
X-Gm-Gg: ASbGncvHAQicLGYkkeqIW8mmlMsiGqZVAB01u+d120dAC0euMPEEATLewrEcvpxqIQB
	vIPbT4WFq8RiSXCpEJMb7X1h1s4qMg1Mq6/3ovSene+CNFcrpvjhVzfGON4cF0+BM5aiRM5aXBE
	rpXCzkXHmu2YllsigFnHEhjO2qhmO3NhX/XkeAsDzQ7QxOpwkzgjISE31qT6oAanJ3G+l0/jjHA
	oStkPaCmZKcIZKQE+gDKucajl0a8yh0piSEm8IzBoHlyp7p4v+5S3s8WfD4JrUB+VbTPJGLfoSs
	Y2Q9ai1MrRzH0mJ6lHpF6A0TzHgaYSGptd45oUjoIZesLkhB/WP65TkpcbuKPepfY5dptGE=
X-Google-Smtp-Source: AGHT+IHHjyG3dH0HF2+qKwo5SaUhp464KTvBTRpqh1hB11GI5qcHK1cV9kKFVYLsFPsHk7RMgiV20Q==
X-Received: by 2002:a17:90b:5643:b0:2ff:62f3:5b19 with SMTP id 98e67ed59e1d1-30823633eacmr4055660a91.13.1744372268149;
        Fri, 11 Apr 2025 04:51:08 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c992aasm46916265ad.157.2025.04.11.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:51:07 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	arnd@kernel.org,
	cang1@live.co.uk,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] tty: serial: 8250: Fix uninitialized variable warnings in pci_oxsemi_tornado_get_divisor
Date: Fri, 11 Apr 2025 17:20:48 +0530
Message-Id: <20250411115048.34948-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:

drivers/tty/serial/8250/8250_pci.c:1233 pci_oxsemi_tornado_get_divisor()
error: uninitialized symbol 'tcr'.
drivers/tty/serial/8250/8250_pci.c:1234 pci_oxsemi_tornado_get_divisor()
error: uninitialized symbol 'quot'.
drivers/tty/serial/8250/8250_pci.c:1238 pci_oxsemi_tornado_get_divisor()
error: uninitialized symbol 'quot'.
drivers/tty/serial/8250/8250_pci.c:1242 pci_oxsemi_tornado_get_divisor()
error: uninitialized symbol 'cpr'.
drivers/tty/serial/8250/8250_pci.c:1252 pci_oxsemi_tornado_get_divisor()
error: uninitialized symbol 'cpr'.

Fix uninitialized variable usage in pci_oxsemi_tornado_get_divisor() that
was triggering sparse warnings and potential undefined behavior. The
variables tcr, cpr, and quot were used before being explicitly assigned
values, leading to smatch warning in multiple lines of the function.

Initialize quot to 1, tcr to 16, and cpr to OXSEMI_TORNADO_CPR_DEF at the
point of declaration. This ensures safe fallback values are used when these
variables are not conditionally set later in the function, avoiding
uninitialized access.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 73c200127b08..ba4dedccc29e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1187,9 +1187,9 @@ static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
 	unsigned int sdiv = DIV_ROUND_CLOSEST(sclk, baud);
 	unsigned int best_squot;
 	unsigned int squot;
-	unsigned int quot;
-	u16 cpr;
-	u8 tcr;
+	unsigned int quot = 1;
+	u16 cpr = OXSEMI_TORNADO_CPR_DEF;  /* Default Control Prescaler Register */
+	u8 tcr = 16;  /* Typical default value for the Timer Control Register */
 	int i;
 
 	/* Old custom speed handling.  */
-- 
2.34.1

