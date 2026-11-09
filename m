Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192909;
	b=AJf81kR0ubBbC9v4tvQhvEkJKjetuHrVXLPJNU1ebem6zS0VYkRTbxAtfxwXBAqhIy2c
	 +O/2HjTj3HO2stZojmHs0j5zvCLmJjqbt1f2uBpk/VjA6y00MLQ5KIknVwpbxkzdfYXF1
	 JZdTb7BFKs0kZifQE+QWAn0RXttG2h3ABgXr0iAPtu0tschWGxsNzBM8Qmbpq1Cambi9r
	 JE4AXi9v+kmYMf4fxLcrAFdG32XJ/w661xXAup8lBnvb6wRqRMNU8gqefuyGNaH5TaC+9
	 cEgVb2ek2uEkWeFChfgNTCGwSM+8sUMqKeUhF1QIlTjGCHFTTy0/JEltbFlLN/4M1Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192909;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kI7NYgQuuFTeHXrZ9zRhIvS7hLT9PxIJ1Nkc0ImVrAM=;
	b=PaCkg4hr/KmWNLyXxggh6XJoy3jrcJ0CQDiifTUhhMHjKnnjAKC/TsFbg2hq6QkLICnU
	 B0nkoHu6swNLqf1ADDz0HFESF7dN90xaNyld2flz8Yyst8s9oEjYbwjsLVG5NXV8669ZU
	 7hnzoPLmKZSktKk8NAHnNalII+E1yAthDPfd32dq6JFVjyh9IROE/RDwOOCQ1GkXde+m/
	 vtXwaVa04tPwo4vNnkzepsr44Ix/8FMSxfQrP7UprkDJE6rKF3Yhf+ifYX8smga4Zlpx6
	 N0iY75xIrKqRY19Z1lyYQazWSRN5PUhbZon2jK+018dgGEmOj50ZkSEeHAJid9U3DdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDWV4o8v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD7606A323;
	Mon,  9 Nov 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDWV4o8v
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192908;
	b=DRtARona248pJKiNIYZoO/SE4nyT7gxrHo5O9KA529pM8nkx0PYS8eMIOYepWioMK8v1
	 tq4RQYFhgh0vE8125MRbYavDzFWRqLvrlyYl5cYBCmSu9KIw1X6axGwmGwR2PWZAFskDs
	 nHvZvPTva+COtCnLFRZkw/pA50MZPGQ/xTviDhxpM4C1voPABm38v68odwCYjjbKYg7jP
	 jOW0qcLtUmhgaQ8UmKdUnsoinx0oB4RqPe1RWvLeY8e5hYSck2qXOShtEGkTnDrmBc8kd
	 Io3IIQDGVybVZcbogVMJPS39bNzeLOruTwTtlGVKNpeoE4YBXHnkIQYb4na4ovB2IZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192908;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kI7NYgQuuFTeHXrZ9zRhIvS7hLT9PxIJ1Nkc0ImVrAM=;
	b=sbiOeQ9iuW7gm+T1CA1C+q2kDQHLRGo4n7itil6Sbv7PwCGF6WKm3fJrDXftSruIsSQT
	 dy+o/qVgl5PSdgsi0YkgqbOVl5OneRVYpkfbC0BVvzv4S/VYZLep1SpECzYiZOUU15hZE
	 yYb/w0E7ChYCwiOT3tBOBMWVEQfoJL+yveS9BQqgGo36LBAMZ7Z+MFdo+JZEdMOFZ/fVH
	 LkOtrD81RF7sMuMbQc2hlYz6c0YhquGwxSJVjiLyxLtXA3oPvnRjgp21U8PHXYtBqkbne
	 ubLddlkb9MFxQj/4zMuTBi26dBCkbLEPa29EG1W+SpB26hQhcSIpOxOIbJtC45AtEyA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 842581F008A1;
	Mon,  9 Nov 2026 02:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192908;
	bh=kI7NYgQuuFTeHXrZ9zRhIvS7hLT9PxIJ1Nkc0ImVrAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LDWV4o8vlT197OPb/RL7gcLCTGTLVJ6+iqF1rPdLukjEqcCv66sdi8Rsrv7N9u1Aq
	 3bTunV4iPKy+kvBkiuK5dxu7jSLJjJMdLI3THnBWG9sgnhmAjwkQythXv3vW45IX7a
	 ReNoNEKZSH8NrT0R7978HFpR2IJZKSKWptwWPXthFqwTxfBttGdlY5sqJaMZVlxFIL
	 fK2uqv3ZQ4p9zBgZdK+/5xYagGumeh6SA/h/6Rg/JUso7K7fPYEvrFu3i7ErP5Xs7O
	 VkHM2xyI/ynV3/vjPyvryA/TNLQ162z3eS90xklseONztfPmM4vBxFcGF6YR3ZTBCX
	 DIG2D2UEs/HoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 067DC4820F;
	Mon,  9 Nov 2026 02:55:07 +0000 (UTC)
From: Kohei Otsuka via B4 Relay <devnull+kohei.spacemachines.com@kernel.org>
Date: Mon, 09 Nov 2026 13:55:05 +1100
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: add Microchip Core16550
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-core16550-rs485-v2-1-a15933c7b907@spacemachines.com>
References: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
In-Reply-To: <20261109-core16550-rs485-v2-0-a15933c7b907@spacemachines.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 conor.dooley@microchip.com, Kohei Otsuka <kohei@spacemachines.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192905; l=1517;
 i=kohei@spacemachines.com; s=20261103; h=from:subject:message-id;
 bh=tVquJwmRACDuh480fTmlsHeIfkSp7Ofs4+cTK3nRbqo=;
 b=VIyOrtl+nYTF1R05LAEuQP9NoK+Lhy2kJMg60Iib8Tz2NG5p9x1VmbIxgETfVKy9VrJL4lkNK
 qKdH4GvU05TCp9YAFJA24IQhfht6sfutY8om5D/nbBZcVtoApSO8ExK
X-Developer-Key: i=kohei@spacemachines.com; a=ed25519;
 pk=1kit/vmX5JiLGH9NPcqlvT55ISWaLmNipdL5VrriRt0=
X-Endpoint-Received: by B4 Relay for kohei@spacemachines.com/20261103 with
 auth_id=1385
X-Original-From: Kohei Otsuka <kohei@spacemachines.com>
Reply-To: kohei@spacemachines.com
Content-Transfer-Encoding: 7bit

From: Kohei Otsuka <kohei@spacemachines.com>

Core16550 is a 16550-compatible UART soft IP core for Microchip FPGAs,
including the fabric of PolarFire SoC. Its registers, interrupts and
baud rate divisor follow the 16550A, so a driver that knows only
ns16550a operates it fully: transmit, receive, FIFOs and modem control
all work. What the generic driver cannot know is that the core raises
no interrupt on TEMT, which it needs to drop RTS after a frame in
software RS-485 mode (em485). ns16550a therefore stays a valid
fallback, with RS-485 RTS control the one feature that needs the
specific compatible.

Add microchip,core16550-rtl-v3 with ns16550a as the fallback. As for
Microchip's other FPGA fabric cores, the -rtl-v3 suffix is the major
RTL version of the IP, Core16550 3.x.

Link: https://github.com/linux4microchip/meta-mchp/issues/5
Signed-off-by: Kohei Otsuka <kohei@spacemachines.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..6f806b972f5c 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -137,6 +137,7 @@ properties:
               - ti,da830-uart
               - loongson,ls2k0500-uart
               - loongson,ls2k1500-uart
+              - microchip,core16550-rtl-v3
           - const: ns16550a
       - items:
           - enum:

-- 
2.53.0


