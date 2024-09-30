Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD541A84;
	Mon, 30 Sep 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702438; cv=none; b=M2eUkt+/2+fseKWFur7XjmlubRoH+stFpI4l1wPdjavT5yKpRJ3HztOkxjsEJtp7QwXtX7M6LI+7nsAmnpGVM4fYIBmkdZ2l25VgOjJ+SSG95ugLpk9WV81RcOutQHZoXMWJHX2pnuZADMc58MeUMUiwjpzPnrOZ31ECXZCxJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702438; c=relaxed/simple;
	bh=DfQWv74Bofv4LcwKSBOirEpzeBIhtH8ZvuwlHa3F6Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfS1MXzGSDC24Bf1Z2ZUZP+VOo+whavHpLUTGl6+tRBMdcftBn73A1M56lWwYiumthsEYjLJ45AOS4Mvm7CauFIYVgYv1QN9+b0YZ5dTBAFGwvEq0DihuxmSCY/g7h+llp3oWKnk7QCJpxfrz4MNihi38lY+a6Gm8IVmycRy8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuWQBEVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuWQBEVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A2BC4CEC7;
	Mon, 30 Sep 2024 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727702437;
	bh=DfQWv74Bofv4LcwKSBOirEpzeBIhtH8ZvuwlHa3F6Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuWQBEVvLd+gnosFw5oTxIpugsmfkcHombzdldMXrTjexi8oUZN/71xQxXyikyavm
	 LloYkQ2ao7Pgk18YdPZ7HVuFZcN84HiD2ftNmgJDiWdnL3g2ewJI5MsYBHnBZ113MP
	 5Li8nDPkF2MtSIHn3a/gjf+7K8VSEe/lC5HtRGms=
Date: Mon, 30 Sep 2024 15:20:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: winterver <295107659@qq.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] dio: Improve readability: rename dio_scodetophysaddr
Message-ID: <2024093049-police-petunia-91a6@gregkh>
References: <tencent_A926284D28E1F878F1888699245B2E06CF0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A926284D28E1F878F1888699245B2E06CF0A@qq.com>

On Mon, Sep 30, 2024 at 11:18:37AM +0800, winterver wrote:
> Rename dio_scodetophysaddr to dio_scode_to_physaddr.
> Also dio_scodetoipl -> dio_scode_to_ipl and dio_scode_to_name
> -> dio_scode_to_name, though they're not implemented yet.
> I've searched these names in the repo. There are only a few of references.
> I think it's OK and worth renaming them for readability.
> 
> Signed-off-by: winterver <295107659@qq.com>

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
