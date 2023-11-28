Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065B46BA9
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OpkOieHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC03C433C7;
	Tue, 28 Nov 2023 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701199309;
	bh=8htSTgHJFHOtKB9pxw5uowuakEUSv1IwnvcjP3ifGKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpkOieHlB8xbewmhWyPCtoFHzKuqW1Z9eevrRCNwsIhVdeI7vxe4Uq53LQmhNqrhg
	 UdcYfFCNXq/ryRaie1RLR3iqwKvvlIWo/zdGy71i30oTgoMPnAzkiAW0D2+rHjP0dE
	 xZ1q668XuZmNW0kEG6rzSgWQm0Rrr2Ai8RIpJpQg=
Date: Tue, 28 Nov 2023 19:21:47 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] tty/serial: Add RISC-V SBI debug console based
 earlycon
Message-ID: <2023112839-antitrust-coherence-98d8@gregkh>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
 <20231124070905.1043092-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124070905.1043092-4-apatel@ventanamicro.com>

On Fri, Nov 24, 2023 at 12:39:03PM +0530, Anup Patel wrote:
> We extend the existing RISC-V SBI earlycon support to use the new
> RISC-V SBI debug console extension.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/tty/serial/Kconfig              |  2 +-
>  drivers/tty/serial/earlycon-riscv-sbi.c | 27 ++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 4 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
