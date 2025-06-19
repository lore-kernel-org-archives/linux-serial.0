Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644E227E82;
	Thu, 19 Jun 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332061; cv=none; b=PrRTZ1eL4pbG+t//pimsCgY+eJUqL1h4oQOrkRyBKeXrLbrn8zUp2bSx95U1/rSeESGdKynSZyo9DCsnbxSXaFaOO7O5cE26n1QpIYfeirkviM7sM5D8KV/109oeCLRVEqygAFj7WFad8u4FMishPmR3htAp6vpqU813X4ePxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332061; c=relaxed/simple;
	bh=SuwzBYssjdm1y4bvlWEBpwSu5VUkT/HUMoOitgt2ua4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFjAV/H3zQo07jlz7zef53ipokqh09inWrzcTSRU8vV9Bs+A2Q11z/BLLjOq3eB2HwyIGAXH6qAAoCtHKDvhDHwbDHsa3ziyWgi2hd8Zs8X56oPLSFeSQvjB7kTe6rKoT8Y96LJkdevWEoW7geyMal61rcZiGDp+EySfGlSPAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbXuMU/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbXuMU/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC3EC4CEEA;
	Thu, 19 Jun 2025 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750332061;
	bh=SuwzBYssjdm1y4bvlWEBpwSu5VUkT/HUMoOitgt2ua4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbXuMU/FppWwpWPlRiRUCRV2nNgtXmaDTeciOjbY69+WpDZZ2Eg/YpsUT+wNc5Hs1
	 F6VUQeModegGdQqJ5Er4nqfd+1KrZILMbmfeX1JaxQZa9zAasBsiuZVEAL3+yAOz8T
	 3S18xiIy4RedoF5nrfjdjEuxUTuM2fNBo04oHm+o=
Date: Thu, 19 Jun 2025 13:20:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marwan Seliem <marwanmhks@gmail.com>
Cc: jirislaby@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: sysrq: Introduce compile-time crash-only mode
Message-ID: <2025061938-making-igloo-3326@gregkh>
References: <20250607151957.222347-1-marwanmhks@gmail.com>
 <20250611063349.25187-1-marwanmhks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611063349.25187-1-marwanmhks@gmail.com>

On Wed, Jun 11, 2025 at 09:33:49AM +0300, Marwan Seliem wrote:
> Hi Jiri,
> 
> Thank you for your review and feedback. Let me address your comments and provide more context about the use case for this change.
> 
> > I must admit I don't much understand the purpose of this. It can be
> > spelled as: you can crash the system only by sysrq-c from now on. Don't
> > use sysrq-r or others. Who did ask for this?
> 
> This change was created with embedded systems that have external subsystems in mind (like modems/co-processors) where we need:
>     - The ability to trigger a full system crash (via sysrq-c) to collect subsystem crash dumps
>     - While explicitly disabling all other sysrq functionality for security reasons

"security" involves crashing the system, so I fail to understand why one
is more "secure" than the other.

Sorry, someone needs to go back and talk to the people who think that
this is going to result in a more secure system as that's just not the
case at all.

> In these environments:
>     - Crash dumps are essential for debugging
> 	- Other sysrq commands pose unnecessary security risks

Again, I don't buy it, sorry.

> > Is it for real?
> 
> >From a pure security viewpoint, expert advice is to remove this Magic Sysrq functionality, 
> either with kernel.sysrq=0 in sysctl config file, or with a full kernel rebuild 
> with n value for CONFIG_MAGIC_SYSRQ parameter.
> This patch provides a middle ground that:
>     1) Resolves the Core Security Conflict
> 		The CRASH_ONLY mode provides the minimal debug capability while eliminating:
>             - Register dumps (disables 'p' command)
>             - Filesystem operations (disables 'u'/sync commands)
>             - All other privileged operations
>     2) Security Architecture Benefits
> 	
> 		Traditional: All-or-nothing  
> 		│─────────────┬─────────────│  
> 			Full disable			Full enable  
> 
> 		Our Approach: Principle of Least Privilege  
> 		│─────┬───────┬─────────────│  
> 			Off	Crash-only		Full enable  

I don't understand your graphs here, what are you trying to say?
Somehow still allowing someone to crash the system still is "secure"?

confused,

greg k-h
