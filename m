Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9F2E0917;
	Mon, 21 Jul 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113148; cv=pass; b=bDpNCE3VorVaI81/OcXSV+ib/wkLCK1zdNukEDTd/ZB3ne5w7omHk7qtiXh65v7lyAYTq0VT6s6mXlyf8v/me5Na4bbkm/u5nx4QhdJvBIKdcEl8DGW4kp/d/PKM7qjS3QzxIQrZAaCEa0bmiLje/QMDB+49d2mZghb79MO+MmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113148; c=relaxed/simple;
	bh=iy4AnDRSlJUF5GnacD/24Ahpd5pwxuoUMab2YIgFR6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUWwl0Nm37FrDBKNvbeDCDpwf8nNGT/fZqomSFkXuKc9FdT07Wvdt8Hwp4vNDjUhw3AY48d9AF16IHbXRWj0BN0vp21jhEOoF/2uMl2XcvdOnV9oReHUXIYuLCVkgxvGfqHcNIHy8owKb/pJvBw/l1IMwnAbtpazGK1bfEepuMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=eBfp+own; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="eBfp+own"
ARC-Seal: i=1; a=rsa-sha256; t=1753113130; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m+1kOkgI98FQiE+DAcuWq4X35VjVpO5tHRUEgsFgUbFtvrhrsefMBWPVJTwgYjE+5fV0gXJBpp1gbzkLvpF6AeABWmZQ2+4i/MS753GIH6cIIegB5isdh7N6Xj2ZtUK2Kjsnc6j0n1wxW4ii9AoqdzSV2w4KhHH9k9EfUoV3+mM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113130; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UM5Ba2zZn2jUtrAyvyggswxU+P1g0c0ysXSo+rp/07w=; 
	b=DzFfZkeFUfwCYpkmUeGmsd8v35kBZqUglOj6+SI2gf7UD5vF7airumyl5fEWca5FniBGzS5UjCMrVLwO6j+ntLnIMNJlc4T4MnscZiraheVUJkDdySM66f++dyoU2olKQohmbqeIgUuBcV5im3ZmKFBE+xMLMlV6i1woQxcw+tc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113130;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UM5Ba2zZn2jUtrAyvyggswxU+P1g0c0ysXSo+rp/07w=;
	b=eBfp+ownzL9jN2No4PU77ruhafYWGEUCiGyGP+bY4LoeDznGVS5Zw5Be1oy409E+
	+uOtWvdumRw6Lp0COF0T6r8nA+dtRsnpQ/OOejf0BcMzh7OURFz//QMv9QazjIaWDpJ
	3AYXh8bCo85NxNHsz/9JhCPo1VL2B/nzHUnDMHCw=
Received: by mx.zohomail.com with SMTPS id 1753113128485171.52271227419624;
	Mon, 21 Jul 2025 08:52:08 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:16 +0800
Subject: [PATCH RFC 10/10] riscv: defconfig: Enable Anlogic SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-10-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=717;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=iy4AnDRSlJUF5GnacD/24Ahpd5pwxuoUMab2YIgFR6I=;
 b=F7m4YRktHeWw0lYcRYa179RBWzXWWpelyXb6jm4svGOwIaksd4Rh1DgjJkDY8+Xh0CY0lJl0a
 dikF5QwDvx/CUizfQLfBP+0uuEs11Uf/bG5kZ8/hP28BqnqK4FoZf+Y
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Enable Anlogic SoC config in defconfig to allow the default upstream
kernel booting on Milianke MLKPAI-FS01 board.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fe8bd8afb4183ce871020fb2992a21a13bccbc87..9b096dde47a3a4328cd4c9abae6730780ec8fba2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -22,6 +22,7 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
+CONFIG_ARCH_ANLOGIC=y
 CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y

-- 
2.50.1

