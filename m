Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3776182A8
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EcF2GKvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF45C433C9;
	Tue, 12 Dec 2023 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702369464;
	bh=dFRa/f34KkP3F+5AoKfSMUh3/t1KCT19KfTOTpa1WMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcF2GKvf6OikUrWe4Clges+wgn1NPxMnla4fhakwXV/uyOtAUthTHGMt/Pkq7YPY6
	 YYQegjeU/gsvTslHxiEVLVB+AkXWdfIayQ/QXGMzov6iX4BEk77fLdcNZN2VdtdCQ5
	 ZP3X3AvN951ln69Xa4PhuBD0TwSsHzxfYdTT4JUA=
Date: Tue, 12 Dec 2023 09:24:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman Zilka <roman.zilka@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty/vt: UTF-8 parsing update according to RFC 3629,
 modern Unicode
Message-ID: <2023121253-astonish-spearhead-9f41@gregkh>
References: <CANZiGuGZn4uPLw7=U95ZQtMFW3pWi4Bw4rrkCdq=X1641KLy9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZiGuGZn4uPLw7=U95ZQtMFW3pWi4Bw4rrkCdq=X1641KLy9g@mail.gmail.com>

On Tue, Dec 12, 2023 at 08:40:42AM +0100, Roman Zilka wrote:
> vc_translate_unicode(), vc_sanitize_unicode():
> 1. Limit codepoint space to 0x10FFFF. The old algorithm followed an ancient
>    version of Unicode.
> 2. Corrected vc_translate_unicode() doc (@rescan).
> 3. "Noncharacters", such as U+FFFE, U+FFFF, are no longer invalid in Unicode -
>    - accept them. Another option was to complete the set of noncharacters (used
>    to be those two, now there's more) and preserve the substitution. This is
>    indeed what Unicode suggests (v15.1, chap. 23.7) (not requires), but most
>    codepoints are !iswprint(), so substituting just the noncharacters seemed
>    futile. Also, I've never seen noncharacters treated in a special way.
> 4. Moved what remained of vc_sanitize_unicode() into vc_translate_unicode().
> 
> Signed-off-by: Roman Žilka <roman.zilka@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 36 +++++++-----------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
> 
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> -- 
> 2.41.0


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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
