Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358742AA4;
	Sat, 30 Nov 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980968; cv=none; b=rq5UQ1mPaN2INsG0Pwo/SXYVgw+spJhxcCt7RqyzWnvVsOel3k9pzJOMYaBz7Wix8hmqCBgBcf3OEtsmNQG+zUS3qhBKEm7v3zw4qwhibDaFeCuOSeAKoFI/E6yeano6q7K80W9qfDtFDB2EC8veAK1ZhiCv/TC3x40Pi1z6HYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980968; c=relaxed/simple;
	bh=Y/3FiEAqUDzE6gD7GDA3Wbs0EK7/st1qU1h1vo5Mqm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhlvEKlze8wuEAiXgV2Q8P02H56US4ZB6AGgPvH1fkPjzkjqFH4bXt3FVVl1uVUgKVSExwPkS8XD2KZ9SIieSOrXvf7PcQMQ9AAsv2xYlegIUy87q4GlCE+SMbLbsNc3np1N7TxB3tChVYpCf12Cc1GoXz4b7QJf3w1CzgLsdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L6hvBwHP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L6hvBwHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC95C4CECC;
	Sat, 30 Nov 2024 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732980967;
	bh=Y/3FiEAqUDzE6gD7GDA3Wbs0EK7/st1qU1h1vo5Mqm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6hvBwHP0NX4PXo2XKgcgzhCefACRbxUf2cVq1SkDCkNDGGojHSPKl6CmJF+2eQGs
	 WnDX36+x5ynqmd/DXpMAB/5w+MtNl03fCiD0DjOUGWnR0gzsn3Jw4ax9YDV8kgYaqh
	 6YqwCMDcEkeSLPhF1U5TGlbp3APARfqmYRKxJ1u4=
Date: Sat, 30 Nov 2024 16:35:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
Message-ID: <2024113002-countless-stilt-ff36@gregkh>
References: <Z0lCihhE75lE9Zjd@kroah.com>
 <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiXUMgkaJyQiQbUBNR-fVQC8LO-QPJ7y-30oThQCBDLag@mail.gmail.com>

On Fri, Nov 29, 2024 at 12:28:07PM -0800, Linus Torvalds wrote:
> On Thu, 28 Nov 2024 at 20:26, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > TTY / Serial driver updates for 6.13-rc1
> 
> Greg - I've dropped this pull request since it sounds like it will
> need a bit of fixup.
> 
> But holler if you prefer I take it as-is and I guess we can fix it up later.

Please take it as-is, I'll send a revert right after -rc1 is out to
resolve this (it's only for early-console for one serial port type.)

thanks,

greg k-h
