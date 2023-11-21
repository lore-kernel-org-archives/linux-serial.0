Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7E168C5
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSr8LW23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A90DC433C9;
	Tue, 21 Nov 2023 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700562995;
	bh=ePkHUZAKxjj2Jg7Kd1bP4Zaca9R79v2WfPvnz48hE58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSr8LW23lkduPYNmLdvejeBcSGnX9RJR0zXrL9jAmtu1B5ILBicrMjDEy/tRd+NjK
	 4lHDLPMlklSJFPU++1VqEuDxFqh5/TAZHGhBMCPDeSLnBTmTh9C3gTNVPdzQAWugto
	 QGz0ZTh+MtevAO69oPRBC/JKG5rjDd1HIQlCzyWmddz7mPRVFJiF27rR5i387P/JTR
	 uVVS8K9ZSpE/Oi0P/vuUhYd1mMT8870Tw+lHIcB7gQtUXVYEX+GDenGe0JJTg/qwYB
	 G4tgTJHIM+esBxeD40Y8/Ik+3m6vxIAAf/r3UpKFmdZS3vD9l0Pem7VT3NfNCLbRxt
	 EgpYsk0KNj1Rg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 2/6] tty: ipwireless: remove unused ipw_dev::attribute_memory
Date: Tue, 21 Nov 2023 11:36:22 +0100
Message-ID: <20231121103626.17772-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
References: <20231121103626.17772-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-struct [1] found ipw_dev::attribute_memory unused.

As far as I can see it was never used since the driver merge. Drop it.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
---
 drivers/tty/ipwireless/main.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/ipwireless/main.h b/drivers/tty/ipwireless/main.h
index 73818bb64416..a5728a5b3f83 100644
--- a/drivers/tty/ipwireless/main.h
+++ b/drivers/tty/ipwireless/main.h
@@ -49,9 +49,6 @@ struct ipw_dev {
 
 	void __iomem *common_memory;
 
-	/* Reference to attribute memory, containing CIS data */
-	void *attribute_memory;
-
 	/* Hardware context */
 	struct ipw_hardware *hardware;
 	/* Network layer context */
-- 
2.42.1

