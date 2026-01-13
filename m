Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F435580E;
	Tue, 13 Jan 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343177; cv=none; b=cQwgp3dA2wRTodO2Z68NK7ZENjljjTkqA8n3MxnIw4v7IJDlJPfzifeLuA0gRoutHoQmziYrus0mYPasSyeTvZ9xzHNpTjslxFSfPM/xUAQrDy186yEvV2O9T7AdVfNbLyRJZSzn8AbqlEWRPRdS04vkWqK61BGrCE7aUwjxcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343177; c=relaxed/simple;
	bh=WCS1gUFqazlCTZYwN0/IDLbkTzKhRaU1clOA1skX9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u43NsAzXcztijl0yF4CfDPF0vcieFIb1sq2CMStGNR8AahKixsT91DRVgpGVp6h28+nHB+sctNbYnIp5/G6waIzLuIZXcOoMJrlMDRXXBzCIhFa14m0Bw2cryvFZkokdmimSPXiqHFFjgP9S42AAeeZxpYLMCCTUTujTcoh8vlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAjQsh2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAjQsh2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B47C116C6;
	Tue, 13 Jan 2026 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768343176;
	bh=WCS1gUFqazlCTZYwN0/IDLbkTzKhRaU1clOA1skX9OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAjQsh2Q8Zo8IrkWVzvZOinEeTF56+8fVVF4LG6nZDqUhljjuk4hSkg+KlH3JEjBI
	 A6klso1FXuHD1841HEoboi8VO7hBqMNWkn1ypIvsX7z01Azz0jZ+BMcyZbcL/Moghv
	 F6VfWNj1vOyHOZjy0Z399rj3BOJBbw5mWJ3srJEj3Q1RfoAhCkdbcR1WikzBO5Oe6v
	 HaAC/ZUHKm3wSqqpphM2HgIQKhZDe7dnioc5xIPJUHaa1C1B0yJQcVfi3h8mKKFuit
	 BP1HYDeJOqiU3BC475n2y51T6ubFW9QkAmu76wOKBLewGGTAxSyrTrxyGOGB6OGVQL
	 W5aAezq+Sc3eg==
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Guodong Xu <guodong@riscstar.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: (subset) [PATCH v4 00/11] riscv: spacemit: Add SpacemiT K3 SoC and K3 Pico-ITX board
Date: Tue, 13 Jan 2026 22:25:23 +0000
Message-ID: <20260113-prism-unvaried-abf3b4679e3a@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=dGkt94bjVYf12COX+6dHA67nfAJ4JApCVWihf8slfBY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlpx4Iz3wp4M1SZqzktZ5nzr3riytyZKtM+VhvcaM4UW /VsesfTjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyE4zQjw4VdTbFHuj64X5lZ 47Lp1K3PW1silW2KxfmZrUxUpix/4MrI8ObLZtPFV7SiqgoDbtco1Vx/ks95OF/Z66bb9oDFIZb h/AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Sat, 10 Jan 2026 13:18:12 +0800, Guodong Xu wrote:
> This series introduces basic support for the SpacemiT K3 SoC and the
> K3 Pico-ITX evaluation board.
> 
> This series (starting from v2) also adds descriptions about ISA extensions
> mandated by the RVA23 Profile Version 1.0 into riscv/extensions.yaml.
> There are extensive discussions about how to handle these new extensions
> in v2. In v3 (now v4), here is my best understading of what I think we have
> reached consensus on.
> 
> [...]

Applied 6-9 to riscv-dt-for-next :)

[06/11] dt-bindings: riscv: Add B ISA extension description
        https://git.kernel.org/conor/c/0cdb7fc1879b
[07/11] dt-bindings: riscv: Add descriptions for Za64rs, Ziccamoa, Ziccif, and Zicclsm
        https://git.kernel.org/conor/c/b321256a4f36
[08/11] dt-bindings: riscv: Add Ssccptr, Sscounterenw, Sstvala, Sstvecd, Ssu64xl
        https://git.kernel.org/conor/c/c712413333f8
[09/11] dt-bindings: riscv: Add Sha and its comprised extensions
        https://git.kernel.org/conor/c/89febd6a0276

Thanks,
Conor.
