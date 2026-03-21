Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67B316195;
	Sat, 21 Mar 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774075073; cv=none; b=ivA9RjEZdw2Nrf14D8CL6Bwl0Qv4BFeLpc2e25zzMfo+bGtQIujEIEy4ieujVpfVo5nA0Sg9+2U+spsVKrSBz+PCBJJkILNvXY8tWEAw3UahtCLERCZYkFX0vYYJiPyRxn3tRNAfLhsQ3SLMNtcYtfj4kesuK7wJ+7wZInMbex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774075073; c=relaxed/simple;
	bh=rm/rXBnNnci2H3OubAlbsz6nmsJwMYP2dm1/RdX2Uk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPcTR4OWxQAxznzsvfBZNaCPCJkPsLEi4uYs+kN83ws1tYKSKJ/P5wpW9KDJYSm+bLX2zQyyMvfDtZHPxA71S1XWVEdY3MBFHn6+G7LV9E5nzMbGsgtEyE5MJzRlHVVl9vjkiErS+Lj+Me9xli/MIOaAqqDTjiIfPIoCk/b0ATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1uyLCWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1uyLCWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24805C19421;
	Sat, 21 Mar 2026 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774075072;
	bh=rm/rXBnNnci2H3OubAlbsz6nmsJwMYP2dm1/RdX2Uk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1uyLCWa5WIS6llKpKzQV+hMRHeT02bjQYurZ5QStpUV5dnr/7pVM6ugWx298gob9
	 i8RNMI+byiwjIcj8UQSBiD8XHRWI5N4pP2xXFnIxtSuXRqiDQ7gmfifoZjyYJZ3hqX
	 uut3MBiiBA0y87PZaEapDXH6cZLy+kDp+MoA24PY=
Date: Sat, 21 Mar 2026 07:37:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: yuhaocheng035@gmail.com
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: Re: [PATCH] tty: vt: Fix slab-out-of-bounds write in do_con_write
Message-ID: <2026032158-trickily-absentee-74ee@gregkh>
References: <20260321062312.4290-1-yuhaocheng035@gmail.com>
 <2026032123-earplugs-stunning-0c6f@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032123-earplugs-stunning-0c6f@gregkh>

On Sat, Mar 21, 2026 at 07:32:34AM +0100, Greg Kroah-Hartman wrote:
> > +			return -1;
> 
> Do not make up error numbers :(

Ah, I see this value being returned elsewhere in this function,
nevermind, my fault.  But really, it should be an -ERROR value, not just
-1.

thanks,

greg k-h
