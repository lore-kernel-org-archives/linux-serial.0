Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DE5380F;
	Mon, 24 Jun 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218446; cv=none; b=RhDFpLzmc6Qt3LUmj9TkO6kzA9rCfZILFSqzXtDUibpETKKjYMaypeuyXJpNjMzwzFFlSchn8bXAbmnhBEFRyJGtwikC249ymtaIWht7En+pjS6iRLcCKZKo0fIKmttG2F+RrxS6PXlrLIcN3fF2dOkCQYha+piHUiPiBPLbxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218446; c=relaxed/simple;
	bh=Q0TAQop9UcGBFWqhcDc6hWj4iTLH8ixvN+t3k8BcBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUQS6vjoKt9tEAzaNofC8YXBYvlNNQiNc+h1C0K4jAdClzGp2FdIvWXftqu8L815p/Z0Jp253rRNiXr7vHfPURNqPBewCyD5ivoF7P6mxCjsbzyMR+U4dhot1HDw9Dn9LmrO9wSZ/OC8TIYQ9HEpG2BlZotTns76IvIEDTS9bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIMK5TBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIMK5TBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEC8C2BBFC;
	Mon, 24 Jun 2024 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719218445;
	bh=Q0TAQop9UcGBFWqhcDc6hWj4iTLH8ixvN+t3k8BcBrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIMK5TBfHUy/SHvGu3zvfeMTSDMS/jQliC4IPMlo7lUTodPGHD8YMUNW3VYeewz1m
	 r9VxqcAYVjg4+2qC1BxLMPe8HjgJeYsZwkanGzEuZfN0hfsvZesakJiIRkkF2Mhzyt
	 yL1N4MsWW3+mn7J2PkaaEDva9KGby95nGM7kvAOg=
Date: Mon, 24 Jun 2024 10:40:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lcx <lichunxiaona@mail.ustc.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: INFO: rcu detected stall in tty_ioctl
Message-ID: <2024062412-stray-spousal-e3c3@gregkh>
References: <fa4a7e17-ad33-4eb6-bfd3-c3e6bae13cec@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4a7e17-ad33-4eb6-bfd3-c3e6bae13cec@mail.ustc.edu.cn>

On Mon, Jun 24, 2024 at 04:22:36PM +0800, lcx wrote:
> Dear Linux maintainers and reviewers:
> 
> We would like to report a linux kernel bug, found by a modified version of syzkaller.
> 
> Kernel Version: a3e18a540541325a8c8848171f71e0d45ad30b2c(6.10-rc3)
> 
> Kernel Config: see attach, config
> 
> reproducing program: see attach, repro.c
> 
> Feel free to email us if any other information is needed. Hope the provided materials will help finding and fixing the bug.

Do you have a proposed fix for this?  That way you can get the proper
credit for resolving it, especially as you have an easy way to reproduce
it.

thanks,

greg k-h
