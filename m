Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F502288513
	for <linux-serial@vger.kernel.org>; Sat,  8 Nov 2025 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562775; cv=none; b=uBOJgfY8eWkRV+eosft7eMbw8qhPRrENCsLE5MqV9KNP2Fko7DGzaGbexaP3xIdyzkqRBJK1gr7QD5n3g+LaOdcETR08cI7QcrOTcz2lnSbjQyjxIt0xmvNQnRgkl3K2fgj3WGE3DfrOwdgaTm4jh3RoPCvv63+FirprejprwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562775; c=relaxed/simple;
	bh=u8FQD2Jf1qAwSuBCTJu/xLkfRZb0S3SL45idlbcIvc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhLxzykW76b/YwmR9kylDWdKi9yp9uHonA05spkQGWlb85sNEYzZSLcxT6x5nbYoZRmAI8J4MCTf+kx+V/1cq7rqNmjHTN3j+koQ83+x+3dZF0o1eXQ+PsMLw7M6H35HUfQbt2zEUiBQH7iPkD7koBG92VELKxUhDIC+SL/s0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2/AmNsQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2/AmNsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3154C4CEF5;
	Sat,  8 Nov 2025 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762562775;
	bh=u8FQD2Jf1qAwSuBCTJu/xLkfRZb0S3SL45idlbcIvc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x2/AmNsQFupvDvHgpin7FcWBh+P8dOWXNGiQBpyKiJbS1xUGKrsImaturzYYFl4+p
	 kl31KIG1gAvPARGAh14+y3jq4mIurNSu71/horR113KfKvgbsXrPXmrefjCKqR5OnX
	 2LrSvmcxtufOObH4ZQkjMtnGLzYlpKmpySrxmMQ4=
Date: Sat, 8 Nov 2025 09:46:10 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Magne Bruno <magne.bruno@addi-data.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 001/001] tty/serial/8250: add missing CPCI cards
Message-ID: <2025110842-reviving-finance-64e4@gregkh>
References: <20251107180409.76288-1-magne.bruno@addi-data.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107180409.76288-1-magne.bruno@addi-data.com>

On Fri, Nov 07, 2025 at 07:04:09PM +0100, Magne Bruno wrote:
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 152f914c599d..924ea92d17d7 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5996,6 +5996,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  		0,
>  		pbn_ADDIDATA_PCIe_8_3906250 },
>  
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_2_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_1_115200 },
> +
>  	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
>  		PCI_VENDOR_ID_IBM, 0x0299,
>  		0, 0, pbn_b0_bt_2_115200 },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..221a83d4e1ed 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2333,6 +2333,7 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500        0x7003
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
> @@ -2344,6 +2345,9 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7420       0x7011
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7500       0x7012
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7800       0x7013
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG     0x7024
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
>  
>  #define PCI_VENDOR_ID_PDC		0x15e9
>  
> 
> 
> 
> 
> 
> 
> ADDI-DATA GmbH - Airport Boulevard B210 - 77836 Rheinmünster (Germany) Amtsgericht Mannheim HRB210433 Geschäftsführer René Ohlmann
> UST-ID-Nr.: DE 143754253 WEEE-Reg.-Nr. DE 65862200
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
