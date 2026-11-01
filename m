Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571384;
	b=HxXsRHguqk/N1zmjHtQF8brF+ytjBMbF/MNF8IIMo/Zr0KHiz3TycMyJE7AlUAEjd1tH
	 U5WTPx9CY5ps5zm00Vng98NQxUvUba6gg71nXHevz9qurLSCWPWqbwGBYu4Fmjb5r9Uf2
	 BAcPlja3lJZ5FHdVTpGXlr3swt8AQN1Xf2H7CsFnZufxte4am+VHOJ/2yyBbufeMzPb7d
	 Stlo6z9KyxEowlfJuvbzm8lReADMrdBep0F2r9xMuiKYeKaSeZYCJ6MS8mHem5GhEGzoj
	 nEflue7HYp1LoNtkM3HoBf0Q/1E3U8jSg4h0MIsEeXK+J5OvDSicJhJUu184myFVyvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571384;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fIWdtQoZgU+HOxQ8xPE7U0OO9UgX4aiH7YmUwuj+ArM=;
	b=VmHxHZ/zmtAdzs1rB3wOYJphZRDFv1fpd0ZkEK63IXOREEPApzocwCeLGDiSzELhXdK1
	 Y/nxkRlQC9/DcD1XORkhKlaP7UAi386EqzVPJ71BwMh/Z9qCfamRbQzz/CU5s/goOSfFm
	 eBqsjXRJ2OPCQABdOjLHJhL3kXGN4wFE2L8lXmcyxL5hV9hJ/naik/04e9sHZghszZmfE
	 B7lPfA2+Vh7a8eAhxQ6jbmqf8sw/26g/bdbxecHwMFM+B1ESRq9h2aFHC9zAf/MyVo9AR
	 8N+hUny/XLIpAE7JQBWPakEgEtSYxXAwAyvMKLNCWNAT9P8/C+yX1afLq0SbH7OZUwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E03HRJiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B681606C6CC;
	Sun,  1 Nov 2026 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E03HRJiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494FC1F00A1D;
	Sun,  1 Nov 2026 22:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571384;
	bh=fIWdtQoZgU+HOxQ8xPE7U0OO9UgX4aiH7YmUwuj+ArM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E03HRJiWMH7vhzLjAIAvdkSug+FbE0oqKaLpUuUiovEpCVsAAnofPD2ZY4nGlMBTL
	 MsomjHvrrseLRoGulL364cZHAd+rEebKk9OGO0M3Q5qd1LCM/2qapQHY82ORqPwvup
	 Eied/++HJpf91kTVLQ/Y4v2gvHTP9zUVoXb1bLDUS3++xUel388+HfAtrZWOjcOWak
	 de1VDzkC8toobp3DO+dh3bv2XFf7GLPh0eoW8E636a86a1F4GSPJUpoPPW+ATwW6WP
	 Yr2425Y6oR9vAaDACt9obbh8LjTJJ72SqGEaCC1uV5jD403ArDE6DLYdYhk0joVtl2
	 jfN5uoZ0iDBEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4020938003B8;
	Sun,  1 Nov 2026 22:16:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] serial: sifive: fix off-by-one in console port bounds
 check
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357138279.2624073.12379269503301547375.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:22 +0000
References: <20260827014524.19375-1-min_halo@163.com>
In-Reply-To: <20260827014524.19375-1-min_halo@163.com>
To: Zongmin Zhou <min_halo@163.com>
Cc: linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, pjw@kernel.org, samuel.holland@sifive.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 zhouzongmin@kylinos.cn

Hello:

This patch was applied to riscv/linux.git (fixes)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Thu, 27 Aug 2026 09:45:24 +0800 you wrote:
> From: Zongmin Zhou <zhouzongmin@kylinos.cn>
> 
> sifive_serial_console_ports[] is sized SIFIVE_SERIAL_MAX_PORTS (8), so
> valid indices are 0..7. The bounds check in sifive_serial_probe() uses
> "id > SIFIVE_SERIAL_MAX_PORTS", which lets id == 8 pass and causes an
> out-of-bounds write in __ssp_add_console_port() through
> sifive_serial_console_ports[ssp->port.line].
> 
> [...]

Here is the summary with links:
  - serial: sifive: fix off-by-one in console port bounds check
    https://git.kernel.org/riscv/c/bf961847813d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


