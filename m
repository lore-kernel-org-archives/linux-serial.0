Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94F10A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYRRTJ2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2524FC433D9;
	Wed,  6 Dec 2023 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848270;
	bh=1ogJNRCRUSjNVsxhxIxRKhd/3MM0E+QpvFM4Un0/0KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYRRTJ2Ex+COXZInEvSuWRBkCj4G2MDfBBEm10lA/6YWME/zUfsKGjeiIcbMF7H7S
	 VLRXViRHFcM99MJo4maY01ypfdfSRY6mo6b3CKNQ4x2lmjDZYoRVbLGkXL0rz/jBuj
	 FwqHudifLvhhqB2Zk2yQ1EOEnoezkMg31Z8DvnYSAlfUzN1ulFLoXtSbVyp6m7wb8M
	 DMJmKjDVFHeRJ7KCAeMMskuXzDs/OKe0aKoT5RFN2aQq14xId7E8M/zJGKEyFkpv51
	 KIUWiCmI3f2ODm5M2WtjKWEpU4mPQF0ZVCV24Q4raYZuGK4Oo5eScD7UV6qeaesYk8
	 QbF1R2OmgsiQA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 14/27] tty: m68k: nfcon: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:59 +0100
Message-ID: <20231206073712.17776-15-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/emu/nfcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 3a74d493eb3e..17b2987c2bf5 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -23,9 +23,9 @@ static int stderr_id;
 static struct tty_port nfcon_tty_port;
 static struct tty_driver *nfcon_tty_driver;
 
-static void nfputs(const char *str, unsigned int count)
+static void nfputs(const u8 *str, size_t count)
 {
-	char buf[68];
+	u8 buf[68];
 	unsigned long phys = virt_to_phys(buf);
 
 	buf[64] = 0;
-- 
2.43.0

