Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE31B86DC;
	Wed,  7 Aug 2024 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017477; cv=none; b=ATEq7yCIt+LHYYuzHS8mrRqCPaN3gpr/rvUaX/0o9QpDVt2z/SOoMcQuAk+wpvCmFwLoCekTwPqmjA7sQX957IkCb9zryKvlp7PZEu+HmTWJEVw7a22b4lw8TrG2wmz8BhN3qUOFzDUMydSChManblAsjMKJQWNB7Mch7IDpnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017477; c=relaxed/simple;
	bh=D8qPoZcjswN1mW87RAp5NOpUz33kwlN3uBFE3i4AWR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/09Wley1Clm70j9j5PX3h94fqRkcDJ61kBSeKxzuntL9hmlMlAIySBcUsjivXCchl+gB+JT6vnbpSwIM4k1q+1gGpoZtc5cQOUTkPx6jSjbkXSDvMVUJKZ5fAL9wQytV1NUZMukcGghVx+ZWFD8MS+sf5qipcDglHZiqI83mGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izgIFQ6m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izgIFQ6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9ECC32782;
	Wed,  7 Aug 2024 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723017476;
	bh=D8qPoZcjswN1mW87RAp5NOpUz33kwlN3uBFE3i4AWR4=;
	h=From:To:Cc:Subject:Date:From;
	b=izgIFQ6mjPw6jxZIPu0OOnj2680O+pVuk/Rvfv6VrkLqfjYu0ojd0CQf/WtO9Nd3X
	 wAxI0Mk1AgeN9v3TOSGS4nbuRQuoorrSfVejOGekSY2AbTTx6pJYjvbV0Su6SRNEPY
	 cHSWRuBtO+X01dOlc1ZEB3gaFgUqDvCjM16qyeYotCjXzd/Y4/BjfYLZBES7HWcfXz
	 rtA/l05dMUlknYf33VmaWRu8JLvAeGz3LYuKSaUIFQOMByCvLyUDVfNEeWl9Jx9WI5
	 IM+gQ3psO479g96yqqlEUva/z9+zsdI4nWhqG7IP7h8m8azTUHpFSzURRQlruBZMXN
	 TMU+kySfRYONw==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: 8250_platform: remove ACPI_PTR() annotation
Date: Wed,  7 Aug 2024 09:57:43 +0200
Message-Id: <20240807075751.2206508-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The acpi_platform_serial_table[] array is defined globally without
an #ifdef check for CONFIG_ACPI, so ACPI_PTR() makes no sense
here:

drivers/tty/serial/8250/8250_platform.c:271:36: error: 'acpi_platform_serial_table' defined but not used [-Werror=unused-const-variable=]
  271 | static const struct acpi_device_id acpi_platform_serial_table[] = {

Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/8250_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
index 306b488aa996..c9ef988d58b3 100644
--- a/drivers/tty/serial/8250/8250_platform.c
+++ b/drivers/tty/serial/8250/8250_platform.c
@@ -281,7 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.resume		= serial8250_resume,
 	.driver		= {
 		.name	= "serial8250",
-		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
+		.acpi_match_table = acpi_platform_serial_table,
 	},
 };
 
-- 
2.39.2

