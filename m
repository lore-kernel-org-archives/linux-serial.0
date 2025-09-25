Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com [220.197.31.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8DE55A;
	Thu, 25 Sep 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758769659; cv=none; b=U0YP/vYe2K6fgaHJOS76U61hmXMoz1U7eEM9lsL5wkXE6bzZiWI23lr7rfWEtCeImUKoHOOqIza8y854OA8Nb7FJRqqBnjO3MO2dP3kEMFj6Sp3sTEDN/iDeI5dfFzFvOmTkIKmlxQ1hGmTlX8LdiakrSdB1ZMtzSPdfXabuKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758769659; c=relaxed/simple;
	bh=/PpokXyihOUh3zc12heg8AmTxcQkZ1ISZd9xcUPvoOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbKRh4LUh0wtfJkfmxwyPEHlPZ2zWiQy3/2xPf4U5LsiCP5/xbgdeZzh54BzTU2rOSyR2KBhXoHJbY8O0a0H18KLqdudQ+RfUSdAOf3jddC4Qbi0rJcRCr8vHOSSXSaxcE7y5TFuECndTqLiUpONbCdtah0xvxz4CInqdoIvZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anlogic.com; spf=pass smtp.mailfrom=anlogic.com; arc=none smtp.client-ip=220.197.31.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anlogic.com
Received: from leo-wkm.. (unknown [210.22.154.122])
	by smtp.qiye.163.com (Hmail) with ESMTP id 10b5c3d81;
	Thu, 25 Sep 2025 11:07:23 +0800 (GMT+08:00)
From: "fushan.zeng" <fushan.zeng@anlogic.com>
To: junhui.liu@pigmoral.tech
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	conor@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	palmer@sifive.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Date: Thu, 25 Sep 2025 11:06:50 +0800
Message-Id: <20250925030650.35694-1-fushan.zeng@anlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a997ed7014c0224kunma317f75922ff69
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT01JVkMaGE9DH0tCH0geSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVSUlVSk5PVUpJSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0
	tVS1kG

On Mon, 22 Sep 2025 20:46:30 +0800, Junhui Liu wrote:
> This patch series introduces initial support for the Anlogic DR1V90 SoC
> [1] and the Milianke MLKPAI-FS01 [2] board.
> 
> The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
> UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
> programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
> the first platforms based on this SoC, with UART1 routed to a Type-C
> interface for console access.
> 
> Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
> and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor’s
> U-Boot. Because the vendor’s OpenSBI is loaded at 0x1f300000, we have
> to additionally reserve the DRAM region 0x1fe00000–0x1fffffff to prevent
> overlap if using vendor's OpenSBI.
> 
> Notice: A "no4lvl" bootarg or dependency patch [5] is currently required
> for successful boot on the DR1V90 platform, since the SoC hangs if the
> kernel attempts to use unsupported 4-level or 5-level paging modes.

Thanks first.
Anloigc already has the open source SDK at https://gitee.com/anlogic/sdk,
and will submit it to mainline at suitable time.
It is better that anlogic SOCs are long term maintained and supported
by Anlogic officially in mainline and for customers.
The code should be a full feature version after lots of tests, not the
modified and simplified version from Anlogic open source.
And we hope that there won't be two different versions code of anlogic SOCs,
it may confuse customers.
