Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E610A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMhtaGNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02493C433CD;
	Wed,  6 Dec 2023 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848272;
	bh=ca5oZR3Z/IhdfX0APKb53oRCnzdx5d5CBkRj2hy/ASY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMhtaGNOBrG38TV6foFHCSkoltzMauWUjoUeaDVHPuRG8fMUsJBWAbDf8DxOwYWts
	 SEjxd9hgOVGcJd9cQQXU+EkIp9JecT14LGBqg49oZ1aQ4nrnjgX2yUkvGhjqEjOyl5
	 fCEuFl8yJjhobXfbHjZ3T+hdm/l7yePI6kZpUMv8zTc09eMWEtbUZ7Ai/pWm/BZMXH
	 1uL++wmUkvTq83AWv0WnTpGswnflvG8SSnZQsDxRLOpS6zW1sDrccjAw30SeZRX9p/
	 xNwQT14M4vLmtx1kayXlmakvhQcYJ1PcqropU7yczRj/Xi9NYDj4unJgGD7veOaCGU
	 fQ5qCACVPjksQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/27] tty: mips_ejtag_fdc: use u8 for character pointers
Date: Wed,  6 Dec 2023 08:37:00 +0100
Message-ID: <20231206073712.17776-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mips_ejtag_fdc_encode() and mips_ejtag_fdc_put_chan() declare arrays of
pointers to characters. Switch their types from char to u8 to conform
to the current tty layer types for characters.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mips_ejtag_fdc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 369ec71c24ef..aac80b69a069 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -213,16 +213,16 @@ struct fdc_word {
  */
 
 /* ranges >= 1 && sizes[0] >= 1 */
-static struct fdc_word mips_ejtag_fdc_encode(const char **ptrs,
+static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
 					     unsigned int *sizes,
 					     unsigned int ranges)
 {
 	struct fdc_word word = { 0, 0 };
-	const char **ptrs_end = ptrs + ranges;
+	const u8 **ptrs_end = ptrs + ranges;
 
 	for (; ptrs < ptrs_end; ++ptrs) {
-		const char *ptr = *(ptrs++);
-		const char *end = ptr + *(sizes++);
+		const u8 *ptr = *(ptrs++);
+		const u8 *end = ptr + *(sizes++);
 
 		for (; ptr < end; ++ptr) {
 			word.word |= (u8)*ptr << (8*word.bytes);
@@ -417,7 +417,7 @@ static unsigned int mips_ejtag_fdc_put_chan(struct mips_ejtag_fdc_tty *priv,
 {
 	struct mips_ejtag_fdc_tty_port *dport;
 	struct tty_struct *tty;
-	const char *ptrs[2];
+	const u8 *ptrs[2];
 	unsigned int sizes[2] = { 0 };
 	struct fdc_word word = { .bytes = 0 };
 	unsigned long flags;
-- 
2.43.0

