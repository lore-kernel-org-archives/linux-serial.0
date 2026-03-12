Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C833BD64D;
	Thu, 12 Mar 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322814; cv=none; b=ES5a/IhLCDHbMDZJNKZGZZ235iB35B9RL3J4YwL6dkN+TYlG8Go66FDjrc3nFcCqcNPYfvPE4gJV3V+C3ObkwqvQVRgugtp6/VlwajxEPWYGRwi5g6VTZa39uGCPMxsnHW7ipAfxpdQJzUoe6leipy6Nkub+kpbYpdsWqbjrWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322814; c=relaxed/simple;
	bh=auD/eCtXGUQR9ttXMxv26kYGmM36Wc1Mqa+LGS1qDFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCAcQ9U2lXGbAsA8lMDD5bTkS+hIM1aFcfd8I8YVQYkvFhA/hKOhqUfSKwPINgHBGY/CO5TnefJ6Mi/hheKD9qIg9eEXv4RQ3bjK96QpYAwekN7NOYovmkcil9QOX6R44OwXW070MXXYvrngrV90v2PhJDxBF5b/WU/xW9cGrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zy0C4ihE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zy0C4ihE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AF2C2BC86;
	Thu, 12 Mar 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773322814;
	bh=auD/eCtXGUQR9ttXMxv26kYGmM36Wc1Mqa+LGS1qDFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zy0C4ihElqQvYnTY7sI0wJpAwMgYAHZIKua2chUATCQI+lgdoN/c49/YTV9+RP52z
	 39uKsieI6Ba3wu9tHbzmArfs5R2wRebYS/YAezNBN/f8aI0wQM+qqgF0fYNpGlFl2G
	 ze/HzMIP+JH7bblaUz6Jf6zsJ2avETNCV6NUdmEc=
Date: Thu, 12 Mar 2026 14:40:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qingfang Deng <dqfext@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	Ben Martel <benm@symmetric.co.nz>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: fix memory leak in do_go_offline()
Message-ID: <2026031201-shape-recital-5b38@gregkh>
References: <20260306034058.386747-1-dqfext@gmail.com>
 <20260312120036.GF5735@suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312120036.GF5735@suse.cz>

On Thu, Mar 12, 2026 at 01:00:36PM +0100, David Sterba wrote:
> On Fri, Mar 06, 2026 at 11:40:58AM +0800, Qingfang Deng wrote:
> > The ppp_channel is allocated and registered in do_go_online(). But when
> > the channel is unregistered in do_go_offline(), the driver forgets to
> > release its memory. This leads to a memory leak each time the network
> > goes online and then offline.
> > 
> > Fix this by adding a kfree call after unregistering the channel.
> > 
> > Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
> > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> 
> Thanks, but the driver is going to be deleted.
> 

Great, can you send a patch to do that?

thanks,

greg k-h
