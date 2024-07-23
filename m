Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23426153582;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739518; cv=none; b=UCogVBd9UnX82FDGQ320z7H8xhbqiGsN45g5BwjS8+ImIkBu49cA9ZNHVidLBK4ChwgNqfwipbY3afEchB4UWZ4zH6ur7vIfyFOgeQ1umuDugfM0/dOg47DoC1VHvMOPjv/jrti3hZoxGkLMAZP3YVV7blXGFgSixWPvBTiAXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739518; c=relaxed/simple;
	bh=kSeQcsb2Iy9mD89DI1W9T/W97Me0c16VuTNwoa3LxLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RbRQQf9I8GRTsQq3ZslctnowvNrpFoshe8I4J36WHqGvTE5w3H1zUkcoBgAPO2ENGqPh2qQx3CCM4dIjo0xw8rNyE7e7CAi5NN/IoZTtczTZ7ohgKvi0+yxy5gWsB4T4zwOqt5Aj1fq3CZCJX2+EjtbZRGsIPFluGpXD4bsCGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoLyfYrs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoLyfYrs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FEC1C4AF0E;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739517;
	bh=kSeQcsb2Iy9mD89DI1W9T/W97Me0c16VuTNwoa3LxLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eoLyfYrsPmZ4wJcbTOllWPiC4ezzKszwpMpeBouBczI4KxP78lbuw6Rm9QzzsnXfJ
	 ncVEDyayw/Ji/3WF9egitc7fyjGxjysuPyy7C6Mp531OL04vpgKkoV08jqe9hSieAq
	 3C0rmxGiPiE2rGpo7DVOMOIH3aDPhogS/Pl6C1QcYr4GvXiZXOt5iAeo1lALnHF+IO
	 80zc5nX2Tr43BvuS1p7jaGcJ69OyXQVMz8VJsYki0rQg07xvbwQ+mH5OXPogvO2OiE
	 wO0UJ5T3DkDkvWzPZjmDuVTTLZO/HOBbcD3OuL0/yBh2vk6XUFR7C5B6/oibDUV5OD
	 9JWPx8Y1whATg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86B28C43140;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Add the core reset for UARTs of StarFive JH7110
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951654.10883.8693881019606490911.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <20240604084729.57239-1-hal.feng@starfivetech.com>
In-Reply-To: <20240604084729.57239-1-hal.feng@starfivetech.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 ilpo.jarvinen@linux.intel.com, p.zabel@pengutronix.de, conor+dt@kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 emil.renner.berthing@canonical.com, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue,  4 Jun 2024 16:47:26 +0800 you wrote:
> The UART of StarFive JH7110 needs two reset signals (apb, core) to
> initialize. This patch series adds the missing core reset.
> 
> Changes since v1:
> - Set maxItems to 1 for resets from other platforms.
> 
> History:
> v1: https://lore.kernel.org/all/20240517061713.95803-1-hal.feng@starfivetech.com/
> 
> [...]

Here is the summary with links:
  - [v2,1/3] dt-bindings: serial: snps-dw-apb-uart: Add one more reset signal for StarFive JH7110 SoC
    (no matching commit)
  - [v2,2/3] serial: 8250_dw: Use reset array API to get resets
    (no matching commit)
  - [v2,3/3] riscv: dts: starfive: jh7110: Add the core reset and jh7110 compatible for uarts
    https://git.kernel.org/riscv/c/4ed81d9dd75f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


