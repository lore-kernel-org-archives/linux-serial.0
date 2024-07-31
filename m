Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF116DEC7;
	Wed, 31 Jul 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453246; cv=none; b=Rj/HokR1J/ewu0jHCJ0OKizHFPlhf7gnK/Pk6N6Maz12xsDZyY2WF2zdruKFw0OfgGl/CxM+aIAn9zmWgIPkPaLFYtkI7wVsKVG64vNxo73mGRb37hdz4L4Ay0+OM7ZJoOIdvmjiGOyr5NxS5xqGSq4Dsp5DOSZlmK6Rpfo19Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453246; c=relaxed/simple;
	bh=b7SvptSMOHNJYamugBMBGO1kci3QMT70Txvg+hEaukY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHjhXui6eFRbLQc8WSmfrbvwHk5wy0HVtJ1BPnZuIDYQBq6wCc7w6fnXe1803om22E2ZiLXRGbQ+Ow76+9m6avSiU19mWElf7HzpX0B6uBD3KBLtHlk9TQ75CVYvtmXXSWYMasOSUGcGlOu0le4detj7dYMKAXwAuuMJa6wziNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4M3MWER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4M3MWER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8961C116B1;
	Wed, 31 Jul 2024 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453246;
	bh=b7SvptSMOHNJYamugBMBGO1kci3QMT70Txvg+hEaukY=;
	h=From:To:Cc:Subject:Date:From;
	b=W4M3MWERZp2LfWHc96outvV0T4lg2qLuMBbPmRb6Bnx+IAc6Pov2BJDQd1lbB41xh
	 Unv3DNDX/p6VIFjRE943r6BaWiIny9C7tSKtLTq49XACROKqme8L9UMuOFOT8KIvsA
	 Ks8RnD90oZ+Ocrh2FvSWjbpMXGb2e9gHtpybeVYxVH0gH54dqZpmkbhzrJ2bHG5+OF
	 lccmom1spWCgvcpLVmpVaplxFfCwd0dOx7YW0HFArMdtjoNrhgFzhQBYjmMU30pZcf
	 drgJaereX3TrPDu+8MyuB6bUcO2+yWP20iRlFU46R7lIP9R7AVLZLZSzVOZWu9ac1Q
	 WGu1sdGYDZSTw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serdev: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:55 -0600
Message-ID: <20240731191312.1710417-17-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 8913cdd675f6..ebf0bbc2cff2 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -529,7 +529,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	bool found = false;
 
 	for_each_available_child_of_node(ctrl->dev.of_node, node) {
-		if (!of_get_property(node, "compatible", NULL))
+		if (!of_property_present(node, "compatible"))
 			continue;
 
 		dev_dbg(&ctrl->dev, "adding child %pOF\n", node);
-- 
2.43.0

