Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127410F1;
	Wed, 11 Sep 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062381; cv=none; b=AU0CCm7JJNMh6Dpd5XwT/vUvg2ZiuucG0IFqJ3LnVHStdk6g2oq4Nili8Cyudh4BS4odLAkeoTR99Xdzq3ANAiDXiHl4MKhRAJVD+ljVgt7WRIJ2Ar19QoNUjyAbvxCVwM41eOfJUn4WQfwXpfyhjOtTN8DN1XsrO44SJyIaUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062381; c=relaxed/simple;
	bh=70bensbxCy5JRKuyg5YPbmfoLrwN243SafFT09DfP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE27ImwgNHt+kGJUh4g1u3q2cr4K9DqLSDJyPjILhxMsTqszGDKwYJrxVtoD0yQQky+Z76fBtlZHKyl1M7wJRP2EYpABIAJHvUOZ5tGJo2mwh7kqXdmi3NjynV8SbGANnjB6VqggZTF2qymNQ9uqJJKqQFbhGuUfye4AsYwBv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfdaEA/A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfdaEA/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C45EC4CEC0;
	Wed, 11 Sep 2024 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726062380;
	bh=70bensbxCy5JRKuyg5YPbmfoLrwN243SafFT09DfP10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfdaEA/AfrqEkSgHwf3zYvZoslbT2P7QS7t3/I/e99ykbx00dHVx8uV9sWaN/nWqk
	 Dq36uacCasvBq/D1yzA0nCi+1YSzlbJVdEqqNTkOqFfqpGyZcXbTKo3xlK6osfAXbu
	 j7se9wReTzLGTcdRAS5+mDq0VLFoj3nT3d5rC28E=
Date: Wed, 11 Sep 2024 15:46:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-serial@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
Message-ID: <2024091106-rearview-most-5dcf@gregkh>
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906225435.707837-1-florian.fainelli@broadcom.com>

On Fri, Sep 06, 2024 at 03:54:33PM -0700, Florian Fainelli wrote:
> The write to RP2_GLOBAL_CMD followed by an immediate read of
> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
> however by then the device is already in reset and cannot respond to a
> memory cycle access.
> 
> On platforms such as the Raspberry Pi 4 and others using the
> pcie-brcmstb.c driver, any memory access to a device that cannot respond
> is met with a fatal system error, rather than being substituted with all
> 1s as is usually the case on PC platforms.
> 
> Swapping the delay and the read ensures that the device has finished
> resetting before we attempt to read from it.
> 
> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/tty/serial/rp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
