Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251F223323;
	Fri, 10 Jul 2026 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690102; cv=none; b=Ev8G6RuMoqn96P/WlPzO39sqDBoahB+FEBFZwdGSS3cVYaBNYdmOMkKnBjDV7MyPzTyG/FOdVuWUNzhU0ug+9s3Y6bmBVdfvUIn/jsCkgVsVzMldh3qtGQlGX98f+HFSF/VyduLjUmtARFw6a+Cv/D1StQOIgd072UmA7zBV04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690102; c=relaxed/simple;
	bh=s++izH1s6LktN9bFB9F36MD+HLx6u8TycDLYo5Y7pVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejELxX4/Fb+uUVtbHMI8D+mJILNHcB8lB00NW3j8k46eRmV7OFMMBz2u4q9LfA9IMdX5WfYgaV7cruYvJ3yjJGEOnTQUd5v5KzmdLA8f7FFZ1JBx0BrjwiQWMxL11Ssj6Fbkgu3jhOZHsPkl+qS2fQ8dwoM2te5bcfmy4ExlaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0eVhhdt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0eVhhdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5181F000E9;
	Fri, 10 Jul 2026 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783690101;
	bh=8np4we1WdzslrrBW5gM0GkUL25oDLahC/EIFeiLGWpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G0eVhhdt07aKusbY5WLE1GVhpDmkyLH3G1cs7lj0/SYz32Sce3sKaKtfT3wWfvnIg
	 ZdY2aP1bfw+J+vKr+f6tmmHEWCtAcLO1O4r7qNXP9EeX2bQfeX05BTZGfExQcLenFB
	 qMUtHYXBcYt+8Z7AynZF/cnMeDQFGvwJ1qJHDd04=
Date: Fri, 10 Jul 2026 15:28:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Zhaolong <wangzhaolong@fnnas.com>
Cc: Jing Wu <realwujing@gmail.com>, jirislaby@kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
Message-ID: <2026071046-glue-repeater-d56c@gregkh>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
 <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
 <20260708071138.3698581-1-realwujing@gmail.com>
 <20260708073938.3975921-1-realwujing@gmail.com>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.f7d28dac.3ec0.4c7f.8bb2.ce59501a4b8d@feishu.cn>
 <20260708080820.62288-1-realwujing@gmail.com>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.9be37cbd.7a04.4d7e.b20e.d3f90675af6e@feishu.cn>
 <2026071037-subprime-padding-3ba9@gregkh>
 <5cf37150673ea4d5c28f94db91cdf68504b50522.c00727f7.d760.4135.8321.a6234c57c54c@feishu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf37150673ea4d5c28f94db91cdf68504b50522.c00727f7.d760.4135.8321.a6234c57c54c@feishu.cn>

On Fri, Jul 10, 2026 at 09:15:19PM +0800, Wang Zhaolong wrote:
> Hi Greg,
> 
> > 
> > As I said before, I'm not going to take either until you all can agree.
> > 
> > And yes, a co-developed-by does require a signed-off-by.  Without you
> > all agreeing, none of this is going to be acceptable, sorry.
> > 
> 
> Understood.
> 
> I do not agree to a Co-developed-by tag with Jing/Qiliang.  My v1 was posted
> before that series and already contained the functional lock move.  I
> reviewed/tested parts of the other series against my reproducer, but I do not
> consider this a jointly developed patch.
> 
> I do not require my patch to be the one accepted upstream.  If another version
> is used, I am fine with keeping Reported-by and a Link to my original patch,
> and I can retest the final version against my QEMU ttyS1/ttyS3 shared IRQ
> reproducer if needed.  But I do not provide my Signed-off-by for a
> Co-developed-by tag.
> 
> > Also, all of these really look like they were created/found/whatever by
> > a LLM, which is not being documented, and for that reason alone I think
> > I need to reject all of these until that is properly addressed.
> > 
> 
> Regarding LLM assistance, my v1 explicitly included:
> 
> Assisted-by: Codex:gpt-5
> 
> That tag was dropped in later revisions while refreshing the patch. The bug itself
> was found and reproduced by me, not by an LLM.  I used the tool to help refine
> the patch text and write the reproducer/test code, then reviewed the code
> myself and validated the result with the QEMU ttyS1/ttyS3 shared IRQ
> reproducer before submitting.  I also spent time testing/reviewing the other
> series; for example, one earlier revision did not pass the reproducer, which I
> reported in that thread。

That's fine, but you still need to keep the Assisted-by: tag.  For that
reason alone I will not take this.

> I understand this may mean my patch is not taken.  I am fine with that.  I do not want
> to spend more community time on this dispute.
> 
> I will stop here and leave the technical record as-is.  I hope the regression
> can still be fixed upstream without spending more time on the dispute.

Hopefully someone sends a fix for this in a format that can be
accepted...

thanks,

greg k-h
