Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671F372;
	Sat, 11 Jan 2025 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574740; cv=none; b=Ex4e3ojPaZDxamX7RCit3WMXOBdgKkXq1tvRdMcIermxx8cp/Wwto/NMDxaN3fMjU4nyHapIpOCZSOURpGGMgtVSwafof81Yzk4KHD9X+YBEc37z4NcGw6X1bwl+eKKuSN8y1v/1pvkh0T98yEU4ivEVoSGp2S9TCqrh1O936yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574740; c=relaxed/simple;
	bh=IZ3ctqC+j/sUXiqtT6cFBkeHQdiMwAf7i/iJY61XDW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skv02lN8MvPAs0VtYq+Q1g6az2OmgenkmOq16yMQGatcFZBgjYODHIa/sHCdNrpPrUpBSI9UsLRLAl7WE/1t3KhxbelvG3fL1qjYdHbiElssLol8+j61aSf7tBArBtwSta2c2wRy2G+e2uIHLWMNkHK1KwEu0aFnGGpsdPiCvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VIilwKlw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VIilwKlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E15C4CED2;
	Sat, 11 Jan 2025 05:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736574740;
	bh=IZ3ctqC+j/sUXiqtT6cFBkeHQdiMwAf7i/iJY61XDW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIilwKlwQc4F2Ku3o+yjcCVOlM9hfjgC64lAw5MiWjBuSfAcVDnw0ALEtCd8ycROG
	 mXhuBEBRtRl2vI3NgHJv5pPTLcvtOcdKp7xAizNJw5vmJaWp6OVEpPJoorrjdkXNEg
	 WJ44pvHzLaIcuy6Azqoqylc5sWMrebzR7ZRaoOHg=
Date: Sat, 11 Jan 2025 06:52:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kexy Biscuit <kexybiscuit@aosc.io>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: mips_ejtag_fdc: Fix another passing incompatible
 pointer type warning
Message-ID: <2025011159-whole-undivided-26e9@gregkh>
References: <20250111-mips_ejtag_fdc-fix-v1-1-f4282a5ce239@aosc.io>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250111-mips_ejtag_fdc-fix-v1-1-f4282a5ce239@aosc.io>

On Sat, Jan 11, 2025 at 01:38:51AM +0800, Kexy Biscuit wrote:
> mips_ejtag_fdc_encode() method was changed to accept u8** since
> ce7cbd9a6c81, but not all occurrences were changed to adapt it.
> 
> Some of the warnings or errors was fixed in a previous commit, this
> commit fixes one more of them.
> 
> drivers/tty/mips_ejtag_fdc.c: In function ‘kgdbfdc_push_one’:
> drivers/tty/mips_ejtag_fdc.c:1224:38: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>  1224 |         word = mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, 1);
>       |                                      ^~~~
>       |                                      |
>       |                                      const char **
> drivers/tty/mips_ejtag_fdc.c:216:57: note: expected ‘const u8 **’ {aka ‘const unsigned char **’} but argument is of type ‘const char **’
>   216 | static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
>       |                                              ~~~~~~~~~~~^~~~
> 
> Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
> Fixes: 188942f05ce4 ("tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning")
> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
> ---
>  drivers/tty/mips_ejtag_fdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> index afbf7738c7c47c3377560a3288fa95083dd1c6b0..1cc775e74f92d2c5e7a7b4bb500ff2ae758da8e0 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -1215,7 +1215,7 @@ static int kgdbfdc_read_char(void)
>  /* push an FDC word from write buffer to TX FIFO */
>  static void kgdbfdc_push_one(void)
>  {
> -	const char *bufs[1] = { kgdbfdc_wbuf };
> +	const u8 *bufs[1] = { kgdbfdc_wbuf };
>  	struct fdc_word word;
>  	void __iomem *regs;
>  	unsigned int i;

Jiri beat you to it yesterday:
	https://lore.kernel.org/r/20250110115228.603980-1-jirislaby@kernel.org

