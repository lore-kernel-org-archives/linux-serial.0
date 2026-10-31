Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466612;
	b=Vc5PG4GQ29YZZ8AcNh/wLPuCK4wczQHx7XMCotaMy9opgPsB8kBpfOXx24CBRI33Rd6f
	 Gm5odk8J6TayZvZUVB/HojVbfnVBh62rdRgHKaX5HBIijQujnfQmFptpIvqaxX/GXKinu
	 erSCnxGT7wsCuAqBEXFTY6mCcUZYNzzqbFgB8fkRBmpOTw070htmPopAUX7sMt0eYUQ9a
	 S7p5ilXkXdxQIYflWIOYhIuXOr+tOCiTbmSbq5HJFyET3eZ5/9DaXiPPGwML7i4qFhCMH
	 P+W9kuX4XgdwUXw9cJtE9l/kdcofhagJjq5S0IxzEBNlOSQXcjB5JQV1pmYhUK2GyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466612;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4CTsh8nxRb2X8cmU0Jey+Z5jlVLC75ufMhXQQJivyZE=;
	b=st5fgdE9ec8ESrS5fWE47x/NpWvIvRW1eREztOGX8k0xnpdMF4uQdUKYU7W7psl8yT3r
	 R/678kvLgUEVgTisAhJ9ru1b93UN+NiaqaSp1DJUzNMJtyfZFQ3hGT0LxkPc3+ZoF7qZc
	 vn9AWqT1MpBLFwlbO6P/MuYInIEhK31nhaGbrcQwqJhSL3htfNCPmde7QKX6PqGwv61st
	 EapaM0KKOFv2roxzr8qZkjvsBOHy5nnBYMfkHIRn1oS4u2tqaOnBwwSwZWs3U3PlmeMyn
	 eoS82k2dR+isvTpnjwpknCI4yYKiBFWpcTZP3Qg/1sQqCvtJOVt1kurwLcEnNxgVVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zu9SzP/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793E606A31D;
	Sat, 31 Oct 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zu9SzP/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6427B1F00919;
	Sat, 31 Oct 2026 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466611;
	bh=4CTsh8nxRb2X8cmU0Jey+Z5jlVLC75ufMhXQQJivyZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zu9SzP/yYkVsnWGjkdYeUtFV57hncxTNx9UJ1zyn3xkJoHjHGeG8wDehR2anIgzj0
	 O3/z6kmk0opv/5EafMBzS6mfO7rQZWdGFBCdRWADeIb8BwuigUsqTK3BCuIRPXca42
	 NgC9sc4/BZB8VJaIGtIdE3NAkYWr+XRPQQ1jXYw+J4dBZKfd05mOpflgrcITXYL94b
	 KMlRZ6VDuUkaOz0zmolnATIxT9Pa/5HXCxttPpDT23HlfXris8f9qihhK7TW32oBRw
	 OLoHnESlP8hqx5uub0YyWAJtUTfmhh1td+zHKWoMccvggBOp3eABqTcyEtuOJ7SnKt
	 DPDpQFLAOgD5g==
From: Joshua Crofts <crofts@kernel.org>
Date: Sat, 31 Oct 2026 18:09:48 +0100
Subject: [PATCH 4/5] serial: port: remove redundant
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
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-4-7bdadcadc4dd@kernel.org>
References: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
In-Reply-To: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=799;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=0iA/K3T9xMXKK/WgdINwoyl/ULJr7C+Mzbqd5roxlfc=;
 b=pAcAxURFQmxpy8S9dcqOibIvP6niVBuKh3MMhpiovRL+x++aHTN/z1TBDmkQpIQz18aZzg2Jd
 zm8F4ICi7hEBu4C4Rok/VOcEQS/C9Sk5dKGH9Ga+bYH6qExqHGLgpAb
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/tty/serial/serial_port.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 2fc48cd63f6c..c6243b8fd58a 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -128,7 +128,6 @@ static int serial_port_probe(struct device *dev)
 
 static int serial_port_remove(struct device *dev)
 {
-	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
 	return 0;

-- 
2.56.0

