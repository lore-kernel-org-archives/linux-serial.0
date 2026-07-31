Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9243B9D8C;
	Fri, 31 Jul 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490793; cv=none; b=XDxjKmo+epLv0OtJI/NaxzlT/xzNH6WE1GRESox9UcKUgxGH1xb5O3prN3QfB6ajRwdEIN/UdYqxb8CQPqFLOo04a1JTvft6T9pJhD594PiliCvSJVZ+JXgR9tvy5AyKMGYA+TMTwMVghv47IKHhfU1oqaPAEWRo9MdTdeD7Tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490793; c=relaxed/simple;
	bh=xQ57vSGhfk+spwSnO7P+psnMJ//Su5Tt12ziizj7xNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUmbbHwztb+39RVJr1mmQBZhmmmOSJ6ZZ831ZN2UUYWqXFnspAS3hmABhkQCf+XxmAnxjTC+y+a++KrQkU1DPN3wYT+3EMHAOcH1SUxQqE9xVwG7Lsb2v68xVVKt7kyE2PKBeS7qaR/IZ+dit6yP6wk2XoJYkGqwP91UVwv0H/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOaw//U+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOaw//U+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C01991F000E9;
	Fri, 31 Jul 2026 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490791;
	bh=dT/pxT080sVpjDaix5JB0lJEcHzpIeZgjHJASWqeng4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eOaw//U+R1dX9vodh5yPy0D/vD7hqUL19/CTjlY+gNyGVVrXDmTPjS5gwQkNgJbMg
	 NSZtReRXy+KUISWau4tA8ST3Pk7LRLmLvPcffr7z/d8hDKkZOkneWbFDgIe4DdQrZM
	 3uFhqLPe1j5ClGOLU106u4E99ziPaqwr9nSZuzpD4PiJRsmKKU+PHGQ2zN33bcNEv4
	 V1mzWIKwKeHZ4zOMMA5MC+CUfT+yb1IP/SGCMcl9zl280UhRj2oajy3K9STqLZW5+M
	 HMSJDxvQis+T/+KKWRm2chtvKFosC+1eQ1P1FLtO9pl6albuOWIOR4einJCOooE2cN
	 0eRTj4VQHEkAA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 6/6] serial: 8250: pnp: Annotate init and exit functions for conditional discarding
Date: Fri, 31 Jul 2026 11:39:09 +0200
Message-ID:  <8db68a66238fec8be60620ff78e8e02b8f139c4f.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=ukleinek@kernel.org; h=from:subject:message-id; bh=xQ57vSGhfk+spwSnO7P+psnMJ//Su5Tt12ziizj7xNo=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGpsbU6hFkpnwCTs92laVg459iW95s9es3sY5J+q7A4vH4wQz 4kBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqbG1OAAoJEI+A+1h9Ev5OpyAH/1zE D94KegFZyP78iBFbhmX+EZkD40b4C0uMi9V0zJ6Bvq/BddvLGdADJ8irgitKt5xwdx34j0IBHUW TDz3RWq0o7M23ugErvpt3LSyJ6M4c89hweSgTH9uKOzRuQ/0XZwznA+P3NIpF1QsOSxfhEPuVUz DdSzOa2gP5LNyXMKdJ1yIaw+4xWjUWh9N1BJTw21uKMubWtdt+tng3OX0d3cBDP/44t1Oj6rzVJ JhsxbhDFSAcJjC+BuNGdQKPvc3ksVfF41Dugg4vNIElc0QXNyWOQlm/aaPrBIbCTHpBQFjBOFmf Wn0i9l5aDh0ZI3qmROKTXrXUTc/LUtsoQMa1bPo=
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

serial8250_pnp_init() is only called from serial8250_init() which is
marked with __init, so the pnp init function can also get the same
marking. serial8250_pnp_exit() is only called from __init and __exit
code, so __init_or_module is appropriate for that.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index b39f005f11cf..e142f4296062 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -526,12 +526,12 @@ static struct pnp_driver serial_pnp_driver = {
 	.id_table	= pnp_dev_table,
 };
 
-int serial8250_pnp_init(void)
+int __init serial8250_pnp_init(void)
 {
 	return pnp_register_driver(&serial_pnp_driver);
 }
 
-void serial8250_pnp_exit(void)
+void __init_or_module serial8250_pnp_exit(void)
 {
 	pnp_unregister_driver(&serial_pnp_driver);
 }
-- 
2.55.0.11.g153666a7d9bb

