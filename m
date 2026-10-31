Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466615;
	b=4XFdEjT+X+bHtgjQn42lXumayigqtQ9lud4hj3xGjE3iKl6mwz1aS2aJaJAuMmhFPxwR
	 Yq2w9UCfHmFxv4hm0rCkpxCQ10MRX2bA2gu0TGukxQ3XUjRVW4QeUnIz3PpNORbJTEtKh
	 65xeyoxE+JEPZSTIhh++ZJ+qU/R7GifUQUH/yX5BczV5yMC7NOvPJjJZVCeBTMN1CzpF0
	 hiDuy0vb+pcf99qey5TmiIoysw6AaNbJgRa0HuhrySiSQ+VOsxyzZTEHoakuiUuPNGLnZ
	 FVXdzoBTdRx1NzJQLlvGjaVUyWSmepvzxJgQi8nr7jadNGXppALxiYh5t96kZSXT80w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466615;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iBtZ+8x+9hsMF2RGzIf/j7mP7lqK838eZOHrYT6mP7A=;
	b=YGOgTtX+tS/6fY/tqnA6Pt8P5Wv/UthudLwY6LjsYtN3NcFPk9h44vOfpXqiYtPRDPji
	 xZShaFV/AViKyWt6sw1KMGKTQqb4sUMa4VEfuZAqnBAqLHJMwltQY5k1XQb6vCWG9Go7K
	 rSnf95x9+URNDvclC5OXqMNrj6xPwHN0XY39LDbGv5YyqktZB/lSAgI+Od0H9jDMsIvFD
	 zGmZ0zpjPYGYbkqTuucplaNHfEy88+KEOe8qN1wsraZX7ZcFyh4SZrqJpRrl2tR2apqvq
	 0rfCmV5ojxzCL1Ddi8qqrSjkqScWMnQ7miCTXDpHouNAGpBVCuTTXerNhSsWe7XDcyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c0h/Q8p9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE8606A326;
	Sat, 31 Oct 2026 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0h/Q8p9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B58D1F00A1C;
	Sat, 31 Oct 2026 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466614;
	bh=iBtZ+8x+9hsMF2RGzIf/j7mP7lqK838eZOHrYT6mP7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c0h/Q8p9hVCQz45IKlhRwOBJeFegWtEuxzkAp2REt55hfjLJWaE/J4WML49lNsMB0
	 KtAKXjxtIhY2vtkrs0rLwHjOY4+55AL2hbiKv0nzUdyiY6OM9LmTU4Uq+tQL3sb4J7
	 +it1SZXiOmeyVtcdSNNWbr+L2ewiTE/R7clzwqtVsYCY+wr8ZY/m2h7/69I7Y0H10S
	 T08CbVXQ1ud0hawtF9+fw3oWCCYVhpqTsbl6sNBB99aSJRMMP6fTFC06OYZoqa/M/V
	 cgC77Io/6n7op10dyf3QnET/U4FVndx8ZLgH2Kvb0q3uboaJPpm2ymTTJv2Zzk6Lm5
	 eO4HOoozWpngg==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 31 Oct 2026 18:09:49 +0100
Subject: [PATCH 5/5] serial: uartlite: remove redundant
 pm_runtime_dont_use_autosuspend() calls
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
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-5-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=846;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=mLeFYhwf3vQCJZ2IaX6xBHLUPjV63sPKWbZxuVLBLCs=;
 b=LPGQnS3CnIiH3EjafGjL8Rzp5cjrGL2VVHmjnYrEcroAxHodSxBBYC4Aj7QxIe+yXVCKa7SBE
 F0znZV6oZq+DlZl2/6yKf82m2sBb08B09sxwIV5plLuo/dDhnfs3lgp
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/tty/serial/uartlite.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 6240c3d4dfd7..e7e2fd2b7c59 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -898,7 +898,6 @@ static void ulite_remove(struct platform_device *pdev)
 	ulite_release(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 /* work with hotplug and coldplug */

-- 
2.56.0

