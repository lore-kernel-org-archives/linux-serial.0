Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7F3563ED;
	Thu, 15 Jan 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476351; cv=none; b=mk6NG0chC9cQUwtaqi50BXdhOskWJ2SO1Ww+TJpOpnv+MHZHdH3XGOhydWggItuECtTcj+W2VkChe/AIvIw1rsDrqXrFv4nOL4boOJm4EI539DrZaU6i2pq8O03+6JRWMNrsd8sJu7Qw7AG2pvg6LzfKGx/Uy8E8t1ITeIb4q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476351; c=relaxed/simple;
	bh=tsiMe+WrOUZswY8BkAD7/xBsL195aghvXVpZPqnWwZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/IMTiUgEumshq4Ae0fSHhhQj29SoO6Qeelc8eK2OjpNd4mD5J+CTQvO+c5nEO8/kKGbGGkCQ2UN4RPxdHOLmzuMSsw7ij9uvu/C4Ofhl7NfOKVlEwHbCjYbrvnqDXA+H1FAmj0c8n5gRDqPCrOuTws1lf3mxLRehmGZ6OcqTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr6wYN62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr6wYN62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2694C116D0;
	Thu, 15 Jan 2026 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768476351;
	bh=tsiMe+WrOUZswY8BkAD7/xBsL195aghvXVpZPqnWwZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr6wYN62OrUcJSPDnzxsah1HEBpAn7LBQ1KMVqhxtlFUx1CkTyjB0MQFHBgVqSk5t
	 JPJDq6807eNbjq9cIfYsMjh+9xNza/phqCCGLMbCc7aaH4YFI6oe4kb0iT0qWYKulN
	 JXaNzBBHzOIpIeQThqjNHIvDN7EEeHbRasHUB9AREfgcK2fy6VyW3Qe7aF90CIootQ
	 SpfJmC8D1M7mUM5Rt7zB/jv9T0GC48auygRnEMBC/zbltlzHIxjCJum6Wt2BcJGbpv
	 O1AklQSrNCbcDau03UBKIcCSH55Xh9Ti1sBJypa1ucWPj6S6OJ7DL0Abdttk4Hj2M+
	 6u/G/JDJfjauA==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Thomas Gleixner <tglx@kernel.org>,
	Guodong Xu <guodong@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/7] riscv: spacemit: Add SpacemiT K3 SoC and K3 Pico-ITX board
Date: Thu, 15 Jan 2026 19:25:29 +0800
Message-ID: <176847617342.31179.10475730577206315668.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Jan 2026 14:51:39 +0800, Guodong Xu wrote:
> This series introduces basic support for the SpacemiT K3 SoC and the
> K3 Pico-ITX evaluation board.
> 
> In v5, patches 6-9 (dt-bindings) have been dropped as they were accepted
> by Conor and applied to riscv-dt-for-next.
> 
> The series has been rebased on linux-next tag: next-20260114.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: riscv: add SpacemiT X100 CPU compatible
      https://github.com/spacemit-com/linux/commit/14f77777687e182aa782db86220409f4c149e0b8
[2/7] dt-bindings: timer: add SpacemiT K3 CLINT
      https://github.com/spacemit-com/linux/commit/b647b5e6a7e6533c2974f9aa3255aa7879a7b5f4
[3/7] dt-bindings: interrupt-controller: add SpacemiT K3 APLIC
      https://github.com/spacemit-com/linux/commit/23b3bd93e1e14c1cf7146166c39bdb24e7d713c7
[4/7] dt-bindings: interrupt-controller: add SpacemiT K3 IMSIC
      https://github.com/spacemit-com/linux/commit/5c414d0c0987b95cc985b23e532f1341371eef86
[5/7] dt-bindings: riscv: spacemit: add K3 and Pico-ITX board bindings
      https://github.com/spacemit-com/linux/commit/66041d5fd564d94249d41bb6aa004ff1e3f25787
[6/7] riscv: dts: spacemit: add initial support for K3 SoC
      https://github.com/spacemit-com/linux/commit/0ef9a718421fbc464edb6e5f6d483e0915e18599
[7/7] riscv: dts: spacemit: add K3 Pico-ITX board support
      https://github.com/spacemit-com/linux/commit/8e149fcd4854204bbb82ee037cdfb62a9978587f

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
