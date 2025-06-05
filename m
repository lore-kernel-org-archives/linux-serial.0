Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6736D;
	Thu,  5 Jun 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749082152; cv=none; b=gcyTB5iBuYETQju+jWFWaCfSCUe1EDjnKW+zmamlNsapdVfk1F58EZfXg1FG3qM3OnKR2bFOfMDwd9bh3DI9avVyUP9341Ffi9kQzbFVX50daD7/Ty58THnYW+VIUg+WPpGcxYXhdhaFnyXctEh7n/kEUEi0udnZuw8dq/BHag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749082152; c=relaxed/simple;
	bh=A+RZmgsrxtuSox57ZTAqyxC6Tj6CIRVoZcEv3Jpovaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZU/dkgjdKKm8He4V8odc9S4hZSs2wrGAxwoQ9/EelVL2SxEfLjMBFsRUqeS1s1o9z3uJiHyXIe5bz4PuLl6/gE4/dgoC1OcU526K0nkDtuflsSV0ORNNvB0y+BjlKNSHTRwzZH+a8O9tmUvj/8Uf/ixcwi3eTH5ArUdVJZRKvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5TFpfSb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5TFpfSb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5903bceffso3871991cf.3;
        Wed, 04 Jun 2025 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749082150; x=1749686950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhAm9Ru4hxpsou3o64mWUOvWKx3D3uWZ7WU7XX715pI=;
        b=c5TFpfSb08QPvnv/JjcI2fc3pyeQzr9K5CWueiv8SZk5ZPmM+OUG3Vvm1aapq5p4KD
         FdHWyt2M2Xa1uK+tPceg3mEagXim5mUfE+JIz1b7ZSYQetK4d3VWHL3sAGG0WNfExxwa
         JYPG9rSHL04H4gtE49Z2Bk9AascJpUY8IFMl/4K9aWROW1m9K9I9MYov0kB4LU+DvRdf
         DFqpIGaqF4LBbsyDuEbHuy2+ojUyoC4uybeLt/VGIeyatGgqWfacHngX1bXigFDwGp1U
         vEUt8DtP+P/aC9RA7fCqIr1nWGimajWbbdwLVoELK0b85sRREjr9dyzapaYZTDT3QXcR
         /s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749082150; x=1749686950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhAm9Ru4hxpsou3o64mWUOvWKx3D3uWZ7WU7XX715pI=;
        b=tbpLke/s4vrh8E8KocfAhf56tj+TLTswwXsBSZ7CmFRel62vDwdgD13Xku1sDowv9a
         DU3pPiOIAtpO8FCK2t0HVf74BHeRnfksHRBV5lxhSJ2rffzy6DIc0TS1AW+M1D+0p5ko
         qGcdEgsHBEdmjExlOTnB5p+EeUn5pvi9MkncbSWfaxJlH98/ko0YoCoMiiekqAUAIr3Y
         Z3mQuecCwUt1Tb6TzXrx0GefkqiH2qJaTYIedcj1ITHkEmKxF8xwBa7O6wBcETjz2qwC
         iBGB5eIrkdd2QRCJKkDHmFjsnmsj2eO7lQHgK0arpeQYeTodDQblVNsD9nQbiB6ZmT6I
         L7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6g0b07F1fohNqvmNXmkAQ02Zz5RWIa+iygiOqRiet+qF8bCUqpsNkrhotvwxliGeYPx8kh0PwraXQYbM=@vger.kernel.org, AJvYcCX8BP+hBpH8rsvUO32kAqtNxvIlwq4CALWFVJ/A3M0iC/DMuANTWoG4JeF/U8DaHuJPLjyqdRgDOdKI/fU0@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0NlDHgHEMP7XDPE92Ga8qICJJiZdjUtFlkNNI54mSCUkg2xY
	/0b4M5ajkmGwts1bkm5Bqr3BEOkLloHhZ/ItTCOh+HkfFk2ZcwcDWBJQpA9JCyxl
X-Gm-Gg: ASbGncvEhx50d1yZZwUbzsQJnPDv6E6ug2pwU9IZnwjrB81fXQwBs3NL95ZR3cPU2sb
	KN9p+Lqf866GQMHb47zEeWLTTHWOHavz7g1oE/daGQ7LxEYBvpA2Tep4ZGhHpe45PvaINVLZoQS
	vExZjs195mh6RbZQTO3YDpFUKj4QX+onGoGp9EaPmFK/g1+muvNywKF/EcdvZl8uqZageXcRHDM
	rsja6VgcuDcNlzueTXtatu/mOu+rgqEtSKDKjHpGqjRmfvHCNVc+nWfYkYd+0tl27LfL9H/UoMf
	2O8yBDSCD0zulKFtPXVHoGuPEF+Mat8+o5LGTzOBPlXD9AD3HZ1WlUwdmp6kD/LxiYx6q9QPQuA
	tCkhzSuymNn+282Pf
X-Google-Smtp-Source: AGHT+IEq2yryETuB+7PsA2RWKRoqJ5BSjEsJ1mwURZ3Q7KqUbWuTa8vFNf7WHvRL85nZ/O1X9Xb3hg==
X-Received: by 2002:a05:622a:5984:b0:494:a099:daee with SMTP id d75a77b69052e-4a5a6876380mr73522241cf.19.1749082149980;
        Wed, 04 Jun 2025 17:09:09 -0700 (PDT)
Received: from node.. (dhcp-24-53-249-184.cable.user.start.ca. [24.53.249.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358eef6csm102740471cf.48.2025.06.04.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 17:09:09 -0700 (PDT)
From: shanmukh.iyer@gmail.com
X-Google-Original-From: shanmukh.iyer@polymtl.ca
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	trivial@kernel.org,
	Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
Subject: [PATCH] drivers/tty/moxa: Fix spelling mistake in comment
Date: Wed,  4 Jun 2025 20:09:03 -0400
Message-Id: <20250605000903.74242-1-shanmukh.iyer@polymtl.ca>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>

Corrected to "maximum" as my very first patch to the kernel.
Just to get used to the contribution workflow.

Signed-off-by: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
---
 drivers/tty/moxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 329b30fac8fc..d32fb37e2e1c 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1628,9 +1628,9 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *
  *           return:    0       : this port is invalid or baud < 50
  *                      50 - 115200 : the real baud rate set to the port, if
- *                                    the argument baud is large than maximun
+ *                                    the argument baud is large than maximum
  *                                    available baud rate, the real setting
- *                                    baud rate will be the maximun baud rate.
+ *                                    baud rate will be the maximum baud rate.
  *
  *
  *      Function 12:    Configure the port.
-- 
2.34.1

