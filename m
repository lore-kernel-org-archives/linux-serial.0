Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE846B90
	for <linux-serial@vger.kernel.org>; Tue, 28 Nov 2023 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apcQMQvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59392C433C7;
	Tue, 28 Nov 2023 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701199316;
	bh=dqrIyDGjRE0cy2kui/mwwdo0TB8vMyo0PwbLt9DYQUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apcQMQvKcvpQiO9Kl8uqaLIJ7uGEMWIvqzADtzYUnwpUJviEGVL3zckQlPyJv2Djb
	 Vy4P8ptpNyWbaacJtiMPQHAVFNY9DAK/k6jQ2I7y74yVTFEmS6wc9+LU3How9q0nJL
	 HUZPaAAM250jBNH3CjTCGmTyWFpG7Qgz0d56xXOA=
Date: Tue, 28 Nov 2023 19:21:54 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v5 4/5] tty: Add SBI debug console support to HVC SBI
 driver
Message-ID: <2023112849-reputable-outbreak-bb96@gregkh>
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
 <20231124070905.1043092-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124070905.1043092-5-apatel@ventanamicro.com>

On Fri, Nov 24, 2023 at 12:39:04PM +0530, Anup Patel wrote:
> From: Atish Patra <atishp@rivosinc.com>
> 
> RISC-V SBI specification supports advanced debug console
> support via SBI DBCN extension.
> 
> Extend the HVC SBI driver to support it.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/tty/hvc/Kconfig         |  2 +-
>  drivers/tty/hvc/hvc_riscv_sbi.c | 37 ++++++++++++++++++++++++++-------
>  2 files changed, 31 insertions(+), 8 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
