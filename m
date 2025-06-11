Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A12620CD;
	Wed, 11 Jun 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636211; cv=none; b=pnG1DeSG//lynAsNkOdJDqOtS9gQ0zNrvA7LplwwHgMJGrpbaWDPwO6KeifmWdLcqRtjhDi4oro1jSWQm2Jm1S3HH7dxKq+Z+n3wvqVBnHkaDLaNpdT+se+K+7w+2PYnQAzplKAArFa0i9aDBGsuCCBsseJOv4fx1x/KBfoyWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636211; c=relaxed/simple;
	bh=yxtl7EkAbzex+676ZNuv1dtaZF4rmNGRTIkf1D3Ud1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD0bu8Z8LigphlHswkMiFGsI8PMYr8KG28zIiBaJkZtjQwbyhLwBNG7RTsZq1FIpymUHIFyzM9yJZVpGUOy1DvzJt6I0YwWtdMg+2L5X+Wvtgh7tiCB3xlj/Qzqic/CmrvI8/KJa++1l2behLkZM8elkTfI3r3s6ApfTs2TRcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNUOYO7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNUOYO7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863D8C4CEEE;
	Wed, 11 Jun 2025 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636211;
	bh=yxtl7EkAbzex+676ZNuv1dtaZF4rmNGRTIkf1D3Ud1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNUOYO7fgfGC6GZ+qBkpFyS167m1YE+R5rSbIl9pzS0PKWVB2GP5whyUKGJFTfaO6
	 dWF1dYOGPR+3vhRLVo26E3rrCxpb5v3wKCog5JfbU+rggD6CZjYG9H9k1/7ilYnjL6
	 aoNo/OgvGoB8OrX0Wvck31pFeaLwSDQLDlAYHG9gxAPQv28I6swlx3rcsnawbna8MC
	 04Y85mry8Heh/bArpPqF0O39h3HYfLztHrnyXyWArr2qPViq2DmGZl0g7dNDnOPlVs
	 q7ui1Nm3XUc5qGGz3/J4vDcj7BqdMKsS0ZS1pxaqOaPYOR50uBIU0/YohflJ+0DsSi
	 NspBeOWDUssPw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 03/33] powerpc/legacy_serial: use %pa for phys_addr_t prints
Date: Wed, 11 Jun 2025 12:02:49 +0200
Message-ID: <20250611100319.186924-4-jirislaby@kernel.org>
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

It makes the code easier to read as casts are not needed.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/legacy_serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index d9080189c28c..a874eb8e000b 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -153,10 +153,9 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	}
 
 	printk(KERN_DEBUG "Found legacy serial port %d for %pOF\n", index, np);
-	printk(KERN_DEBUG "  %s=%llx, taddr=%llx, irq=%lx, clk=%d, speed=%d\n",
+	printk(KERN_DEBUG "  %s=%pa, taddr=%pa, irq=%lx, clk=%d, speed=%d\n",
 	       (iotype == UPIO_PORT) ? "port" : "mem",
-	       (unsigned long long)base, (unsigned long long)taddr, irq,
-	       legacy_port->uartclk, legacy_info->speed);
+	       &base, &taddr, irq, legacy_port->uartclk, legacy_info->speed);
 
 	return index;
 }
-- 
2.49.0

