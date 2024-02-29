Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5A6D50B
	for <linux-serial@vger.kernel.org>; Thu, 29 Feb 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243521; cv=none; b=X+0sCPp23mWZ9dyGLk4eTFsWDa0wpjxkmYWHIUDzVKNRf73Li1a6wOZnoSlalNaPoQKT2CpNnlip+F8eC6N1nQotyxs/Qb5O+omkhHK441di86WbAEoNemLMyjbHO4+TX/GnE3ZvF8Rf61tU0TUN68zRoiJCAFuUEsRVwPnggd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243521; c=relaxed/simple;
	bh=F2BPPiJMQXzt3AwYgAAGsuXijKB6qYYGglWOSHI9w6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4REoI355gVHe+NE9HFTBAOT9pGdwVwAW78tY2Q7Y/AA+SBDZ4xebthofuwAr6S1gW7tv112AdPmsYSXRI4na22wv0bbNUWFqx+Dl2ks8xXkCR8w5BnBOlXlz/TZlYlAo55LydcOxUDSi2M1j2wrQF2Jjs9zwqpyxK4N0FNAL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vF4gtf86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vF4gtf86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAFDC433F1;
	Thu, 29 Feb 2024 21:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709243520;
	bh=F2BPPiJMQXzt3AwYgAAGsuXijKB6qYYGglWOSHI9w6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF4gtf86IVt5dKpULS3IzQzR5VGJEj+Jl31/K5+5+1V77mINsnZJ+rDR/VOlVQebG
	 +EetWLOZiKAv0IwZkN+zC6RGUyOd3r+jPE77VdpC+8T53E0dYC8UzHmkPcYeWQjVgk
	 aBBvKDVqqSjISN/EmAOexhNant5CxU7VkHbS8sho=
Date: Thu, 29 Feb 2024 22:51:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: fix unicode buffer corruption when deleting
 characters
Message-ID: <2024022936-chloride-concert-12a6@gregkh>
References: <88n6qo5r-2986-r273-9n4p-pr77q314727r@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88n6qo5r-2986-r273-9n4p-pr77q314727r@syhkavp.arg>

On Thu, Feb 29, 2024 at 04:05:51PM -0500, Nicolas Pitre wrote:
> This is the same issue that was fixed for the VGA text buffer in
> commit 39cdb68c64d8 ("vt: fix memory overlapping when deleting chars
> in the buffer"). The cure is also the same.

Please spell out what the "cure" is here, so we don't have to do and
look up another commit somewhere else :)

thanks,

greg k-h
