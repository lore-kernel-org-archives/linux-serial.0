Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15C3161A1;
	Thu, 13 Aug 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617319; cv=none; b=YP8uSH48qInQecckYiVHPcPPxhSK17s71cJN1vUAZHP0wzqGbunu8ZHKSjEwrWBU9cBZyx1AKRwbxMxsoCaIfw2YwXCNUp2M7PGdsDwytBxlTngprvzmMtgf/vd1FBIKdBfvuQFsl2yO/Yz2VgZHLaMwxFKr+UuLP4re1vQcHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617319; c=relaxed/simple;
	bh=m4IK5A6uMQBmAy+o9teDn/7/PweXDg8a0NW5miwlr8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE2vPQRTckoMBTSRuXrpYXJzIqYVezCYNejBEgHGfjpc0KZUM25yq6zfA/8Zcch1Hk49sDTM7GK8tXcWDzOPJeH6kcP55H3fUrl6xcQwHj1gWlXS8/IxqxX+DsLhOKiV0rcD5BK0q8aNKnQFH5vbGpr31jnRk2nnoSeueP/wgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPWwCJHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPWwCJHh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0D0EC2BCF5;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786617318;
	bh=m4IK5A6uMQBmAy+o9teDn/7/PweXDg8a0NW5miwlr8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kPWwCJHhBHubFOTCfuP0FJigxQGkQe+D74z137hbHT8PpmvyBb3ELjHuu1Bkd9pzY
	 OZ5Fmq08MIOopWCGUZgabeFfBRtu82b34hJDuiwMwf48QxnAQ2WJ4hByrOwenh0Vxv
	 S5KJMrhYqit6ZCSJmJG/ukIx6QMXNWWoO54lQ9nbjR7c4z/zNHX8L7sI8cF6a2OU3F
	 eQD1HOBBYo7hQVW8plmweiNoi78fhQ2PcpldJ/UBtU4soOMVVvc5HbVQ/zyxlRCxlR
	 HYaOOAjdiJfseGDy2xWy678T/KUbAZ/ijqLWbr3yFOAiw4jHxixbAz6CdSbF3GGZed
	 HdASVZdm8RvBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E7C5CFDB;
	Thu, 13 Aug 2026 10:35:18 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 13 Aug 2026 18:35:12 +0800
Subject: [PATCH v3 1/2] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-cv75-v3-c-v3-1-9352b3fd6026@ambarella.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
In-Reply-To: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617317; l=853;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=gkrEC2gJHozNyHLXYCYlviD2HquMAPSKys0NOMPGcf8=;
 b=AZcisJRhZUGKxnenk9hSf4dSjj4a9SPEam+Td5pDcvpq+1Om3XhHg36QrKL/dGVmgseF98WwH
 VI+dhge8ehnAEKWLHXFS4cGPLWlv46rEcKGM23fdMrycc2qIVnI3m9e
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
binding.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..cec5c679f1a9 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - ambarella,cv75-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.34.1


