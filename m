Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736A26980C;
	Wed, 11 Jun 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636216; cv=none; b=I8FevkhiuTYDKmibuq+7y04lCkuQiWt9+nDtFqF7gJArzGH/nRxZ9KCq1rq0E9nSxd5J/5JIGqiLoA1PdFXbg+Pc3fZ9s87hPTU8plvBQ4W39/EuEIXvhIF/Pbj2laRtDR9h2pgPwQlCOcYufanXCemfl9dA13ApTyxhc/8TWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636216; c=relaxed/simple;
	bh=xpdDYrvECMUpAFvfX9wlypgtkzObQJ4+g7Id2+pjsRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWBAlj8GOO+rgvV/A9WFcUbRBtgIp+zaMpJ89TzVkGc/KS7EutuWSjdi9Cwi8YXdxHpBVaJVDE0zrxNy92bfez2GiWhABvGWpY94IrmxP5pXryUNGC968LHsixeOb1rzD527+ABYkht+8hXL/HmqCOTWdpmd5OAMS4iIhDb1tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/uBsIAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/uBsIAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC70EC4CEF2;
	Wed, 11 Jun 2025 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636215;
	bh=xpdDYrvECMUpAFvfX9wlypgtkzObQJ4+g7Id2+pjsRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/uBsIAOyPBot3EUTqSSUaJTbkIUqq3Tv1y31ih14lKsxANAk2Dg2UX8StEuqONUK
	 +AX7H5qsHobFYOtAAYp6ZB3dnuaWUyxC9bStGISrVs0LS1eVyxHXKjn4JrVEOj5xfA
	 P5pG7dQfyc22j8OMseUj5QlZpZS5vTLVi90ZIkzZrolUpJWVtWDIILnnwkKa+0kBP7
	 rOjxmVTriix+ZE5zKM/rtJf7C49KOOlxqc9LZj90uxuwjUL2CfnzSIW57kD+lw7G5Q
	 0/47f36oj9kPpZuC2Ghl+ZdlbaKM2UsMXbtcpR1oHOu9yX8iaVUZnFlMe8xdP6c725
	 FZr3MowarnW9Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/33] powerpc/powermac: remove unneeded tty includes
Date: Wed, 11 Jun 2025 12:02:51 +0200
Message-ID: <20250611100319.186924-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All these includes must have been cut & pasted. The code does not use
any tty or vt functionality at all.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/powermac/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index e119ced05d10..eb092f293113 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -28,13 +28,11 @@
 #include <linux/ptrace.h>
 #include <linux/export.h>
 #include <linux/user.h>
-#include <linux/tty.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/major.h>
 #include <linux/initrd.h>
-#include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/adb.h>
-- 
2.49.0

