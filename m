Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE98218AAA
	for <linux-serial@vger.kernel.org>; Fri, 15 Aug 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238441; cv=none; b=KbNLHZwFhnD+kDzM3sPNeRVqaOiyiTBpvdws56OzjQxI/mUbB9flXmX/nRK+fpm6sZ7Rwd+956/7iyzJ9VKA0+cu0hTVOaVYA6mto6qKlWFQkTWNNkD4NDvVMi5KTRq2+vp3IG6TuIJ/aDg/jGyPh/ck/P3wLXEJMMyHzwgg7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238441; c=relaxed/simple;
	bh=MTXcAq4EAJiO7VtKYZVIIriTLXwbdxkfm0yd3EqO2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsTLn1N32XixH245b/ewfOMQkVonKzcuAOhkRR6n3uW8Q03fXcewkk4LIbs2MJUwg/7HdmQTeX44nBuMs8X9cWAavfx2sqVCYEwWy9LTYPsDk5DixGq2mwxYmvgHLxD2qHXdFh93vdFuX9bl4aPlMo6YvkN9xXdFd12wtY036qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PG66S7pJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PG66S7pJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13847C4CEEB;
	Fri, 15 Aug 2025 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755238440;
	bh=MTXcAq4EAJiO7VtKYZVIIriTLXwbdxkfm0yd3EqO2Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG66S7pJBEqrgwzU9+J7wj39cn8joJQZFQEnd1IVWDH9yehw5YsUboZbXu0DSL7dm
	 /jspTi5WEbEdB1FZYeRTB6y/mqeD0fy86RjTdfVi1sbjRwv9xKhNLgiOGDmY9BTyJm
	 r/G07EPZ7g+VhXroq5kK5FC9f7wFphP/G/cOD7Y4=
Date: Fri, 15 Aug 2025 08:13:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Willem Grant <willemgrant@mailfence.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH] Cleared out formatting warnings/errors for
 drivers/tty/serial/jsm/jsm_neo.c
Message-ID: <2025081520-tiring-unvisited-869a@gregkh>
References: <20250814204509.20777-1-willemgrant@mailfence.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814204509.20777-1-willemgrant@mailfence.com>

On Thu, Aug 14, 2025 at 04:45:09PM -0400, Willem Grant wrote:
> Signed-off-by: Willem Grant <willemgrant@mailfence.com>
> ---
>  drivers/tty/serial/jsm/jsm_neo.c | 49 +++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 23 deletions(-)


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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
