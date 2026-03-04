Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2842C9D;
	Wed,  4 Mar 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608791; cv=none; b=Ww4842R3q8HLzPZ6l3HZBy4mlck23Jq9+NLU8SEMBnEeKSsj8aOiovaiuWyEAuqmOpWlMPGMlMZJ56qW+muHPpSF5KV9CSowWsG4+3Zp8PH6SUhQH1H19lH9fu/Hu7Tz9m81ohtO8DCuaOMUK7ORVGYp7frRJtPD4h+NceQpy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608791; c=relaxed/simple;
	bh=4KgE52dPbV2gpFs6aV7KA/62JEm9ltLn1ws2XcJrOx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lC2XvxdFCuYU40I/aDRKiv1pLQEig78rfmWM45RWZqyIW8HPMfKt/kWyF2Ew1dgyzZhlombgX/LzFcOOk3WAnrvgqmF8DerZBKMfGEIxc3fp4sKtfwbz15EOOaC/o8XdJmklX7Hp8BBgow0ikGLH4GjW3oEHvIVeFwo6enu2Gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj9/H7hv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj9/H7hv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94209C19423;
	Wed,  4 Mar 2026 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772608790;
	bh=4KgE52dPbV2gpFs6aV7KA/62JEm9ltLn1ws2XcJrOx0=;
	h=From:Date:Subject:To:Cc:From;
	b=sj9/H7hvP2BZf6uYdbl2QPhcIeyhJSKZbtMDLBtw6OqZzR1mghPPLUUOAim9zL3Vk
	 C+zeUUwnz7NotcDmn4Q5s9QjrPtY8TVW0D+e6YUM4D0oGmvZLNlEqKojl5DLtehzom
	 jsKQ3nZ/SOwVyCd3BzSMSQY5fL/tAy1eLoJF255S8piB/F7NLR/mKzx7ZfmqjxQQ2w
	 F5ZyNwl8s4R5BN+gSqyHdfNoER/fSJ/pl2QNBelLcWND8oTfCP6P7FfSnoYXCV2oh/
	 f6uhravbUNyFqE5lmTTOV6Dxk3JKj/KoQH6ZzZbbPkT6HMG8bsaDW4oNkuq+SRG/MI
	 h3inKHxK9PWaw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 04 Mar 2026 07:19:39 +0000
Subject: [PATCH] dt-bindings: serial: 8250: spacemit: fix clock property
 for K3 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-01-uart-clock-names-v1-1-338483f04a8b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAArdp2kC/x3MTQ5AMBBA4avIrE3SHyxcRSwmNZigpEUkjbtrL
 L/FewkiB+EIbZEg8C1Rdp+hywLcTH5ilCEbjDKNsqpCpfGicKJbd7egp40j1rWuGqutGYggl0f
 gUZ7/2vXv+wEJDhPGZQAAAA==
X-Change-ID: 20260304-01-uart-clock-names-551463132daa
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=dlan@kernel.org;
 h=from:subject:message-id; bh=4KgE52dPbV2gpFs6aV7KA/62JEm9ltLn1ws2XcJrOx0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpp90OSzQi7nGsdg9K58aE5UjVtEEL8S327ubuC
 npFkrjCvC+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaafdDhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3vrg//U3TtCvsfKSLVsD4OichzNLJtLFG4hQOnMYqDvayoPwLcQQaJcW8SP
 X65d2XRLofzH22yepa65GW4ILkEoVe94PHW6Cvg3lfyyfQj42uxRn7P8YcLceRX8g5OrpFFX+Ii
 uL4Kbo38hj3TN2H5NNsIQCYLPAbAiwzg1C+oe/FpfPj/2Z1UC88CxnY+ilvae+fN2iQhR3R6lr9
 RgTyZwfa1Cn2s0fyg28kfSxrioYpl/lSukjdEMbXOeWEhDYs9qzi+DRpaIWQ2tX4KIlomDeDZds
 50iFQfiEVX85z9BF5cVZzz4AqFUXn7k4LcW/G+cnu5e7op07Uv1gsNe6rg5bfPjUmIwatz/OqNu
 IfLbdiGaD/Tt/4FXh4yK/8XTCi6a2bTeOGzAAbPDX58+zIZBfEE1CD2o40xkW+jb3n8H62c6U1b
 aZijE7swdRkBO65TcnHoSSTPhkJ7gxkb5ggtHC4NVeYNvceHSKwQqLluNnM7yftxFZewclqQmFV
 kTNtZXQQdwmPVFO49PtSBdEVzgAptapdSO5S8jfaORCd6IIMNUAsYc9aicqNMOsjxUeeEttcWPV
 LT5m2gv8uii6x3mHfk508MeJOlvRb1i8mZ6UpBi21j77grIiRtgZQ29Vfy1ck5mnFa+42drefzv
 vKeLOcKSuBcc9M/mD2WXHa9fbCa3Kg=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The UART of SpacemiT K3 SoC has same clock property as K1 generation which
request two clock sources, fix the binding otherwise will get DT check
warnings.

Fixes: b5024e804ee0 ("dt-bindings: serial: 8250: add SpacemiT K3 UART compatible")
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 73851f19330d..e9e07c2356bc 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -63,7 +63,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: spacemit,k1-uart
+            enum:
+              - spacemit,k1-uart
+              - spacemit,k3-uart
     then:
       properties:
         clock-names:
@@ -76,6 +78,7 @@ allOf:
           contains:
             enum:
               - spacemit,k1-uart
+              - spacemit,k3-uart
               - nxp,lpc1850-uart
     then:
       required:

---
base-commit: ec1fb4e55df47ed043ab2ccc6787e39b9d67e49b
change-id: 20260304-01-uart-clock-names-551463132daa

Best regards,
-- 
Yixun Lan <dlan@kernel.org>

