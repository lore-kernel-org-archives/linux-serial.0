Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1621340;
	Fri, 10 May 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339584; cv=none; b=e66+yxDswLh4DThGRn5BY0ehRS6edL2WqDijlYpcp6o7DkvEytv7RGCFNETaLLnMdwtwitz2ikoTamlZTxJ1YZVQ9r773Nhdx6qyteIwZL5VNLqjpaZeMCwjpU9fDCTc/yjFZUJ7+xX9BfM/DUdNcp0nUp9iL0dHZyN2VhObUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339584; c=relaxed/simple;
	bh=ufReI0DgAjAMcbDug6FfffvNjd489WOvC5sRGF+O78o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc899Lf2jhrTyYPgntktOYrX704Uuut8f8LTkU9WHgLeEIOvhJezLMOsPHCybhfuBTa0pALA9RZwlBjGDY4jEGeN1oCjVvnAORzKf6aMsT8CynXdnEwiHk7XupC0/U/MFmPbE+D23QTpq0m5S2pbO67ey1A0V9TgapQ3p7/xBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wv8HD1Xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wv8HD1Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D58C113CC;
	Fri, 10 May 2024 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715339583;
	bh=ufReI0DgAjAMcbDug6FfffvNjd489WOvC5sRGF+O78o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wv8HD1XsRWe88oAkKVzUe2W1q7/7ed/sZgQ57tcPZP8w6n+wMPWOYtkWJBmBY2PFA
	 CZWRhR+09ftTacjEx+Ck1pi6g2Zyj7jAenEwnsPcD3XWiqJA7G82eLjglxMlMC6Q4p
	 vjKYCpg6SGz/UKiKr6wZBhPU06xOGUh/Wl/lqxQw=
Date: Fri, 10 May 2024 12:13:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <2024051046-decimeter-devotee-076a@gregkh>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510110405.15115-1-vadim.fedorenko@linux.dev>

On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> of serial core port device") changed the hierarchy of serial port devices
> and device_find_child_by_name cannot find ttyS* devices because they are
> no longer directly attached. Add some logic to restore symlinks creation
> to the driver for OCP TimeCard.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v2:
>  add serial/8250 maintainers
> ---
>  drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

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
