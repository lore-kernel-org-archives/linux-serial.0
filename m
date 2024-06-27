Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44523BE;
	Thu, 27 Jun 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502417; cv=none; b=dT9XlOKXcb7QENXFx5cH4FlMdPScpVXOsaO/vXZXwMadrQvF6vjc9L2WNvonR9zaHrL7dZVTIiQ/poRy8gjhjrTqaG31ZI2EpAROcpwpX8uEXipZczYKhbfU9rYrAw10p1IQk44nBGh31IZVtmJYOBAoK9OJUAFtu3HT/2kzWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502417; c=relaxed/simple;
	bh=sjhvfdn3QVidrXxxOLsJ8Iays3T/xDMwydCui3MqP+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poT+OgS+LQUjqSvfgQjiCLPIbLLyzui/b4OLe8mw0UzYexoUMjpQXaIbG5W5HMybCvRScubVe0iPJrIF21EQCSo0TZvaYSKZL2HIBwqpKSzA735BOJt3nWzE96XO23t2Ws2dCxBCwPvya60vYJMaNwlcjKMGZKR2zCYdezNDdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:24 +0000
Subject: [PATCH v2 10/10] riscv: defconfig: enable SpacemiT SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-10-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=694; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=0K4ao+VU11AdvF+9uh5x4EN2IBtmFYnrwob9vqhF5jE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYX95TEqSfytY8nhsyKLbPKKtiu66fvm/DZGw
 igFFx7X+taJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F/V8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Z0PEACbVCFa7pvmng4Xz0
 58UY88QmMGAR0UL/tB5Ag4oPNQKQX0VdrLoYcRsv84toABHKLJJ02XgfR/xBKC6TmcFid+m8rro
 5FDSCQxgNZgDCZJST95bu1b+90Z2F7lkZ0CeD6LiJ4WPSb8zUNbjg3EUFQ3z1i47vEnWSbi3Nv2
 9Lep8tCguQudnUxrTUrSC+BckMqD6MZmvOxUwFu2qDahl7KFEIGklpwAX/8p4Qs9447MPdyGb7D
 jJO4znTG7VKvIyuLV6AcpanVkdNmr2+9346yhbKFCsNlX4t94cAW9+xjjbCuFDKTRoPG0PBgeNn
 f2dQc8GdrkjUUvqVIyJcd0TpwCIsQ+NQ0byZS1rZnXxAakNt1d1y0gixI2tUcZEek4eVAv+8gGZ
 YcGpF2CXHWfCoeQBEgUosB8GY+jiH7/8UG37ug3zuUZDWzaKxgZ5+jMjpb8oN/OaziKQoNwkjUp
 A2mcHuob7zMTgcgrTb3A6RSt1HRPruSyXpv8kVwLaWzasFZaKpUgKL2f2F8AxrSIJzKZFUMBRcZ
 ca9qPPkJ6oPJMSX/EyYkoBgQdsDV6eQtwlrOflRPYYOO0U0t3GBiUd3VN5MdAlblPZp0EZoAfZ1
 MYiDvhsUVmTIkfuiv6I77pyQ5F+p5etJoK6N5BnfHVzp6k2XOKIt/GFe+cEWV0TkbTdQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Enable SpacemiT SoC config in defconfig to allow the default upstream
kernel to boot on Banana Pi BPI-F3 board.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 12dc8c73a8acf..5287ae81bbb78 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
+CONFIG_ARCH_SPACEMIT=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y

-- 
2.45.2

