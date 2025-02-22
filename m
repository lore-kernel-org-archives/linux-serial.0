Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BA1EDA17;
	Sat, 22 Feb 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214181; cv=none; b=n98nJWnW7CGfDXSv10ylWcBpCzQCPYfPKJbR2dDKDQoZ6HXM98jT50cpSsYLUqVhATsyU87o7+26T8Eg83Ztukcxwtn1e42MVepAJEFWsnG5WE4B9E1W0UND285OnuiLFPxjqGEuB5iWQD/7ResD4wI3ISUVXjaqf/JTN5tEVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214181; c=relaxed/simple;
	bh=Wr2gkU2kZuNRF8CX7SKqGx0mUpASHHIDSMYrxK7yWhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUx1pfqGe+G0+0+mo4fAqw9WYiPCL9XeSoP8a0dIXe319EiyRZNTQf970BJmT4YS6JUR+MH8Y2VAtDSGBa1PpWwQITOefEu7wVh+hwjhSHY4vqraMyMWRdAWPS20tmkuINi8YIEHJsiY2XhtJD/xxsgI7tFfVJyN2ncB/8PUymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbd6GYSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbd6GYSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB8EC4CED1;
	Sat, 22 Feb 2025 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740214180;
	bh=Wr2gkU2kZuNRF8CX7SKqGx0mUpASHHIDSMYrxK7yWhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbd6GYSoGwe7w/CwHgkPPLibVGUhhGeIlFGz21FlTwVNOHSOKxaaY/9EYNg0v7xiZ
	 jlk78cv0kseJFl/JYznoSk1BPrsxX9Tl74HD4wgpVW6VIsZTFKmDUnJNoNwIhyZ3lK
	 A10jvkZnhd/aTXP3zKxGGkwDfIvkPicDICpF28hM=
Date: Sat, 22 Feb 2025 09:48:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Mackenzie <acm@muc.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: More than 256/512 glyphs on the Liinux console
Message-ID: <2025022243-street-joylessly-6dfa@gregkh>
References: <Z7idXzMcDhe_E5oN@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7idXzMcDhe_E5oN@MAC.fritz.box>

On Fri, Feb 21, 2025 at 03:35:59PM +0000, Alan Mackenzie wrote:
> 
> Dear Linux Maintainers,
> 
> The Linux console is currently restricted to 256/512 glyphs, the VGA
> standard from the 1980s.  I would like that restriction to be lifted, and
> believe that many other console users would agree.

First off, why?  What about the move to get rid of the vt code entirely,
if you do that, can't you get proper glyphs with the drm subsystem?

Doing huge changes for a subsystem that almost everyone agrees should
only be kept around for legacy reasons is a rough undertaking.

<snip>

> I would very much like further to develop and to refine this code to the
> point where it is suitable for inclusion in the mainline kernel.  What do
> you say?

Only you can decide what you want to work on.  If you have working
patches, and submit them so that they can be reviewed, we'll be glad to
do so.  But again, you are going to have to answer the reason "why"
first.

thanks,

greg k-h
