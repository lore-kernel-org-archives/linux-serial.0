Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5521E2843;
	Sun,  9 Feb 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739139235; cv=none; b=MKo0ve+3NCMpHJ07glOeumkWm6wPmG5KDF/KTUs8zhTMH2spVFQdBhYrpK+/o4A4erKIRRyJzCFHSACcmzDTdI9Sn+H6QIxPMmkylSh/XMss0e9zPu4oEbGkv4+u88nujSprXZ5Cn1hf2fU5cnTOwWUQaapdOY2S70lUuOxbatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739139235; c=relaxed/simple;
	bh=Oc8PH3TFSO1bL6d1wkCkWCK3aC1CldE9E8C1FkExY/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e5C6vNZujeXyJB7WIsWZRubkZGExdqLAkM6pLFQMp+PMuJkRICAidIduVrgrBOY2kOTiYN4ZEm+rXIpJpoyB4P6KgIRpaS0oaet3PWzmrz5KnomtoutGYIjmVXwOXcGdlOUxp926399eF14dF2kQrfGXDfg8xxILRY7WMuL9hbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1DFEdKd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1DFEdKd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D6D1C4CEDD;
	Sun,  9 Feb 2025 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739139235;
	bh=Oc8PH3TFSO1bL6d1wkCkWCK3aC1CldE9E8C1FkExY/s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=s1DFEdKdyIzrfbOaLNGWRghwQoPDmw77vQAy6+BzhdWOWShhMXwSn9lO9UxeeHHuh
	 rHmQDyMDPpAmcU8n+OjpywYvw8Ubr+7lk32s9TpSwxYeIquMUx9kMdMWcqDtrVhn/j
	 wRlMCU5HEdkTcTBgm9LYQyuFuKJESaHE5X3+OkrbRxkBw8FuQ7qSeXPMpC1tb9YZse
	 RPQW9JaM1+7M5+SsMp9b0CKWdKjS+9BGdE3GU5JfiuBlNLGzRA00t7m906AX7C62Sm
	 z910WoA+M2GqTkgdIp+1bQ/g+NonZorbjgLFsjDa0CWTkvtDtLM/g4oVO/cQrQaKxP
	 texuA+NweSnvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C75C0219B;
	Sun,  9 Feb 2025 22:13:55 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 09 Feb 2025 23:13:40 +0100
Subject: [PATCH] dt-bindings: serial: Allow fsl,ns16550 with broken FIFOs
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250209-uartfifo-v1-1-501a510a5f07@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJMoqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3dLEopK0zLR8XVPzpEQzi0QLsxTTRCWg8oKi1LTMCrBR0bG1tQB
 TRFOjWgAAAA==
X-Change-ID: 20250209-uartfifo-57ba68a86d5a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739139233; l=1503;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=V4qJYrQtaQiojtSYf/ifxE0jLBJR4+HF4WHFmCDMQ4U=;
 b=ItwFNaplItvd5ajPVusy1cLSxPUZOQmWwvAOpnVvX8aBvjoDqqiWUZzhwIAYyeQAV0IaPYvq8
 tBHElu7YnssAN5uuVUYlM8fdn7q1pJ0O79rl8MfVXLjmQg5ITWC/v3+
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

While testing on a Freescale MPC8314E board, I noticed that changing
the UART compatible string from ns16550 to ns16550a breaks the output,
suggesting that the FIFOs don't work correctly. To accommodate this
fact, move the definition of fsl,ns16550 to the section of 8250.yaml
that allows broken FIFOs.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 0bde2379e864749a20a2e1c962103bf8f5299e42..dc0d52920575ff851a24e56b808e50ee3a14743b 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -77,7 +77,6 @@ properties:
               - altr,16550-FIFO64
               - altr,16550-FIFO128
               - fsl,16550-FIFO64
-              - fsl,ns16550
               - andestech,uart16550
               - nxp,lpc1850-uart
               - opencores,uart16550-rtlsvn105
@@ -86,6 +85,7 @@ properties:
       - items:
           - enum:
               - ns16750
+              - fsl,ns16550
               - cavium,octeon-3860-uart
               - xlnx,xps-uart16550-2.00.b
               - ralink,rt2880-uart

---
base-commit: b142aa50047767e0ab2739102e913fff8207cae1
change-id: 20250209-uartfifo-57ba68a86d5a

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


