Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1B2E7379;
	Tue,  7 Jul 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437685; cv=none; b=szJBZL/2FGUqfp7L4n3u38ojwFohVAAsiPTR2HJortpogFbQVxrLu9vi5tvEiPFeedP4hV9u4Btk7f1ILYafbBLY4FyGVXtmtoFU4MqI01GBcV//tP3myhRn3Bu2/9HZQUHhQxtzgQt7e1NGW0TvDfibpeiuRu+XyiNjTRhViVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437685; c=relaxed/simple;
	bh=h64o+5isrhJPbq5vRmGfaHTVs6UmxCMAOJr4a4rUikg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+4RLSNo6SSL3c4AxtUEjyYLQz3c7XCe25myVaIWM12ZUwdlXqvODNmJsMvPAH54OoKwlCVHDVboqKTCzUPWrU1kXF9dqCvrSIyYRpI4SHWdmYeSqWE+HB9T54qAn2aJmF6zbpaVA7fdYJEZ5/mn2HcwS9RvKjp25qaKSsvs7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnqjSetN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LnqjSetN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751391F000E9;
	Tue,  7 Jul 2026 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783437681;
	bh=zfBXeTQUM0jEBraDbbkaPMwRRSidF1ZES61k6nKXxis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnqjSetNKR+lH9YlqqG+pB6uAvEuxPC1DdSIzV19+0BTpuzvjbKDBnMWUF0Vqe4MF
	 ySPPNTMCKKlH30pNmYXAqBhKdy6VybYOOik8FKgEwMWoOARtP1k+z62rgK4YevuSc1
	 JF+iGcLt4LT4KwtcHJErVUWgeN0Kgr5q3YEcUDq0=
Date: Tue, 7 Jul 2026 17:21:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] serial: 8250_pci: fix -Winitializer-overrides for
 Brainboxes UC-260/271/701/756 entries
Message-ID: <2026070710-bronzing-handwork-33fe@gregkh>
References: <20260528201250.135691-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528201250.135691-1-rosenp@gmail.com>

On Thu, May 28, 2026 at 01:12:50PM -0700, Rosen Penev wrote:
> PCI_VDEVICE() expands to set .class=0 and .class_mask=0, but the Brainboxes
>  UC-260/271/701/756 entries immediately override those fields. This causes
>  a build error with clang -Werror,-Winitializer-overrides.
> 
> Fix by expanding PCI_VDEVICE() manually, omitting the trailing
>  .class/.class_mask zeroes so each field is set exactly once.
> 
> Found with W=1
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 3e5bc9e8d269..0513f4b3c093 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5394,12 +5394,14 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  	 * Brainboxes UC-260/271/701/756
>  	 */
>  	{
> -		PCI_VDEVICE(INTASHIELD, 0x0D21),
> +		.vendor = PCI_VENDOR_ID_INTASHIELD, .device = 0x0D21,
> +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
>  		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
>  		.class_mask = 0xffff00,
>  		.driver_data = pbn_b2_4_115200,
>  	}, {
> -		PCI_VDEVICE(INTASHIELD, 0x0E34),
> +		.vendor = PCI_VENDOR_ID_INTASHIELD, .device = 0x0E34,
> +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
>  		.class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
>  		.class_mask = 0xffff00,
>  		.driver_data = pbn_b2_4_115200,
> -- 
> 2.54.0
> 

Does not apply to the current tree :(
