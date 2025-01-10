Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492820ADFF;
	Fri, 10 Jan 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509952; cv=none; b=ROYxI8Wpl5Xyh3D2JhuuD6nUPnQ3A5x34OwvrfXc8X+OJS2YznoEjHWiavGQqJFv/cgLTh4PQLQqVvH4ziiMbRAsh1k6BM35qSRACvyR71W8ZIo3TBOtw+T1UlQtLCn2GI1u2G/bxlV4qqPkpkulASx/Y9h+8VAWeJ+RLugxsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509952; c=relaxed/simple;
	bh=hmAi2vCJocjvP3V0uFcZ0PUGalUzZ7LflIPfJsoCCrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RD9hMkjThWjua0ipGCQUMn60PqmrqegXJkdqWwwddeMnOupglQwsb1CCIForC21ifT699v5pwAu4uoL0e5jZIEPyvZjJovXRPlxla9EeYdt/HOw31Fj43daaIkwyywxz8w8u/imm4he3dfnknFhPM4ZBCFnb3Nv00LXJFpmcW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNAp0yol; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNAp0yol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D0C4CED6;
	Fri, 10 Jan 2025 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736509951;
	bh=hmAi2vCJocjvP3V0uFcZ0PUGalUzZ7LflIPfJsoCCrg=;
	h=From:To:Cc:Subject:Date:From;
	b=TNAp0yolHjvLObgJ1qSBz8eVOgln4llh9H5EBqqunPesiCerooxwTry4E/ViKQMs2
	 OsWXITerKIQN9c5Fv1mR+svIrpOXkYadSp3gk5mAMdD1qD6tdD00OrIY/sl8Do25yu
	 JG9wilECAIGnxzHCdIdvCMixZyNUnu6Rh/XMyI+As+XEW95sEYfOCare5f156xSrDc
	 xP0TVWYpSEAyfxN7N02zmEuYTMf+8bSRHRcXANaT30aF+Aq1FJcy6i6ax6DZPnXRGD
	 k4VXASOKQRjgPbXQVZCGwBrUvcAITJfemMvzbhGGx86rImMhwhZ2w6zz+cXXTfBD8p
	 br8v6VEdQl3yg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] tty: mips_ejtag_fdc: fix one more u8 warning
Date: Fri, 10 Jan 2025 12:52:28 +0100
Message-ID: <20250110115228.603980-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LKP robot complains about:
   drivers/tty/mips_ejtag_fdc.c:1224:31: error: incompatible pointer types passing 'const char *[1]' to parameter of type 'const u8 **' (aka 'const unsigned char **')

Fix this by turning the missing pieces (fetch from kgdbfdc_wbuf) to u8
too. Note the filling part (kgdbfdc_write_char()) already receives and
stores u8 to kgdbfdc_wbuf.

Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501101327.oGdWbmuk-lkp@intel.com/
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mips_ejtag_fdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index afbf7738c7c4..58b28be63c79 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -1154,7 +1154,7 @@ static char kgdbfdc_rbuf[4];
 
 /* write buffer to allow compaction */
 static unsigned int kgdbfdc_wbuflen;
-static char kgdbfdc_wbuf[4];
+static u8 kgdbfdc_wbuf[4];
 
 static void __iomem *kgdbfdc_setup(void)
 {
@@ -1215,7 +1215,7 @@ static int kgdbfdc_read_char(void)
 /* push an FDC word from write buffer to TX FIFO */
 static void kgdbfdc_push_one(void)
 {
-	const char *bufs[1] = { kgdbfdc_wbuf };
+	const u8 *bufs[1] = { kgdbfdc_wbuf };
 	struct fdc_word word;
 	void __iomem *regs;
 	unsigned int i;
-- 
2.47.1

