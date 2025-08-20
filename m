Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1591E47A8
	for <linux-serial@vger.kernel.org>; Wed, 20 Aug 2025 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669545; cv=none; b=MmWtNFkz9WkvxFzAJJvhHrQVdpesrwkcUOV1TE6isdqauwQVB0CvnvCTbX97ItDKOxi2DAUmCDpDwRDDe8ijLOygmR6NudV9beIDoPJcj0bOcM3Q7VMjFBa7eiDHtFhHXd+PAGUfT2EEslYizwyOtod1JZ5VJ4IJ1eu+IElYojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669545; c=relaxed/simple;
	bh=thfPF7Rj6wiYSryC5WTMfnXJEDyNulVmGFPU8dOCyO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaAuOOr/Jf6IP3AC9uSTb05DhQiQgzwgVupLdvWmmiJo8/p4YDj75agF+9X+3IJi9zmK0wzQV+GYfF75324hlqsa4bXvEAlMA7XKiYoPX7VbxZA82X32rHVoPz3HnR3Nh4SxEPFd7bHzZT8I5oyGhKTN/zY/sICTGv3b8jpbHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhUhoqb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhUhoqb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676A9C4CEEB;
	Wed, 20 Aug 2025 05:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755669545;
	bh=thfPF7Rj6wiYSryC5WTMfnXJEDyNulVmGFPU8dOCyO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhUhoqb1vAvZSc7EwB7sWzqh0dTaskyZrCze0snf9kKkvNLfNbnz1RxEBkCiDLKgy
	 cZ65BVaRjU5oTQh1URlXlFvrEOWjRSOHGuxWWnL92zCC9bjqSNnkgqZYPLT2T+g2gE
	 iWSlG2QhBW8CGerxaBoJpX+N3OfvEVN8sK9VXPBY=
Date: Wed, 20 Aug 2025 07:59:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: adriana@arista.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.rg,
	ilpo.jarvinnen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	jirislaby@kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Message-ID: <2025082028-lagging-finalize-c2e3@gregkh>
References: <20250819191314.3452283-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191314.3452283-1-adriana@arista.com>

On Tue, Aug 19, 2025 at 12:13:14PM -0700, adriana@arista.com wrote:
> The USR register may report that UART is busy even if TX/TX FIFO is already
> empty so we will loop until all USR[0] (UART busy status) is cleared and USR[1]
> TX FIFO is empty (RX FIFO bits should be 0 in this case).
> Keeping the same timeout of 20ms as measurements with the 9600 baud when
> the console was busy it took max 1.9ms to get the UART free state.
> 
> ---
> Changes in v2:
> - Updated the mailing list.
> 
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---

Your signed-off-by needs to be above the --- line.  Take a look at a few
of the thousands of examples on the mailing list for how to get this
right.

One tiny comment:

> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 9c007a106330..8386436b813f 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -231,6 +231,9 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Synopsys DesignWare */
> +#define PORT_DWAPB		124

Why do you need to export this value to userspace?

thanks,

greg k-h
