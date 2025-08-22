Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F92F549C;
	Fri, 22 Aug 2025 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859332; cv=none; b=lYIkowFbWZzpxqbk/56rAFz5i+J6ebihYkY1vJayF1oCmmXx8tfh0mPG2F4Ewadbm0v7yXejEkfQ1+WiFHDd9CMboQWQdZbMj7DzMDoMWD5diq0gZ4l0bgCPskEEZYIrZDSbuRj6GjixqFoHfsD493V0qVnsdYkIoWTL6qTIwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859332; c=relaxed/simple;
	bh=szj+3gfS6Z5W+fHoFy3+zV0zYzKZpjf7oq/V6EnguxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7zEqK6gUsFbhwh4x7rOFvCa9TlKgPIF+Sv7gkaUsXn4OibJB1IDKWx0xcb6BHIhhpMQ8LWvkxBQLLR3ZnKs9E3BddRppflmBSUv3/WPVkSsq7MG978RtqKv+995Wcy0LDX2j2XCx2XO/J4Vh9aEoQsB1SwYpTmIB8GfIjlUnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6nHErAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6nHErAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9732C4CEF1;
	Fri, 22 Aug 2025 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755859332;
	bh=szj+3gfS6Z5W+fHoFy3+zV0zYzKZpjf7oq/V6EnguxE=;
	h=From:To:Cc:Subject:Date:From;
	b=Z6nHErAm/pUPaakROjt3KPlw9luXcDWmN0nZs7orZiYiBR2etMYdDuTEiaIiVNd6i
	 LOO11n57I6grApgdgfPix4RAmYl5x2dQE6+0SiNHdXSYnosIMu1yX5BRWGd5Dq+kPx
	 5boOv0iWdR4VEZKFJOjsGdUu7hnjx695tnyxBQJ9/+pl+ENNm1sn4DNiAd+rX9Z/1C
	 +SSgdiqKwjxXO/ep1HOBM09E9v0f+RpioWsCO0w4C4jEyQuyJh7pnJOsusOr6EAJ99
	 +gsTAFnXKeBBo6gzvj7Vx0WVQD4tqc9WEKspZg0gYmfYA3Y/sVLR77DoAEvFi/BRCP
	 R6J0gkvSLGFCA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH] m68k: make HPDCA and HPAPCI bools
Date: Fri, 22 Aug 2025 12:42:08 +0200
Message-ID: <20250822104208.751191-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user -- 8250_hp300 -- tests for CONFIG_HPDCA and CONFIG_HPAPCI.
It does not test for *_MODULE variants. That means that if someone sets
the configs to =m, the code is not compiled at all.

There is actually no point having these as tristate. Switch them to
bool.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig.devices | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/Kconfig.devices b/arch/m68k/Kconfig.devices
index e6e3efac1840..e277f1bd2de1 100644
--- a/arch/m68k/Kconfig.devices
+++ b/arch/m68k/Kconfig.devices
@@ -105,14 +105,14 @@ config AMIGA_BUILTIN_SERIAL
 	  To compile this driver as a module, choose M here.
 
 config HPDCA
-	tristate "HP DCA serial support"
+	bool "HP DCA serial support"
 	depends on DIO && SERIAL_8250
 	help
 	  If you want to use the internal "DCA" serial ports on an HP300
 	  machine, say Y here.
 
 config HPAPCI
-	tristate "HP APCI serial support"
+	bool "HP APCI serial support"
 	depends on HP300 && SERIAL_8250
 	help
 	  If you want to use the internal "APCI" serial ports on an HP400
-- 
2.51.0

