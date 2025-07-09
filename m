Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FE28B50B;
	Wed,  9 Jul 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056147; cv=none; b=cgQexa4ts1dzNd6xR3q24m+LqXA0rdZ/0V7G7TT9a9QdZzbn+G2wP47yqLwLQ+OqdeVBzpnHNy6h0ymXiYb56vyMA9ae/Q2vpwaEL7zRYrOv1zr41fERd5KtB8ZwPQxkA69WqszpqXdCyxg6a94JJNEqki4GiB0/iJG6qo3aBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056147; c=relaxed/simple;
	bh=+017oiMUTzcNGvL2ql5WZSYDo41lxsGGaD/fxm9DG7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzrBN0A5N/vFdwRjjGQL35iOSAQuRSmmoF28ZKcwrWKhv3SEEzaHbhO9k2uHNbCsxFf0Zz8q078VVvhi8vyKMAdww3lEKYjDNtSFnNs6c37h8NZFjlyIwKDagHx0ZOjAkcowy0tFF2KEeRdQJG9sgUTZjMoqEH6kdQZwlxZL4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GbFWwV9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GbFWwV9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540F5C4CEEF;
	Wed,  9 Jul 2025 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752056146;
	bh=+017oiMUTzcNGvL2ql5WZSYDo41lxsGGaD/fxm9DG7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbFWwV9fmYQ5jj46M19Z8KVdX+amQc7za0xXZvtGcMDfJ1bYvM8T1kI4omiRvUmTt
	 aj2hhr40i4WegB/Ec/iqzd08KZ+N4Gx9VJ0vZFgM77hglSoUSh4qgSgwHbShptMDUr
	 kSuZqnDl6qjogzL2IZrvJCebmoq86bY9N8qEh/1o=
Date: Wed, 9 Jul 2025 12:15:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luka <luka.2016.cs@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [Bug] WARNING in vt_do_diacrit in Linux Kernel v6.14
Message-ID: <2025070923-alabaster-trilogy-d011@gregkh>
References: <CALm_T+2AUcGgb+ukfGg5a3=ibQzRe93gHAzjh6XUubCePk=Mig@mail.gmail.com>
 <2025070805-stoning-overeager-39f1@gregkh>
 <d2c9f54e-9171-4970-b9c1-a6c70532e5ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c9f54e-9171-4970-b9c1-a6c70532e5ad@kernel.org>

On Wed, Jul 09, 2025 at 09:07:00AM +0200, Krzysztof Kozlowski wrote:
> On 08/07/2025 09:49, Greg KH wrote:
> > On Tue, Jul 08, 2025 at 03:21:36PM +0800, Luka wrote:
> >> Dear Linux Kernel Maintainers,
> >>
> >> I hope this message finds you well.
> >>
> >> I am writing to report a potential vulnerability I encountered during
> >> testing of the Linux Kernel version v6.14.
> >>
> >> Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)
> >>
> >> Bug Location: drivers/tty/vt/keyboard.c
> >>
> >> Bug report: https://pastebin.com/yuVJpati
> >>
> >> Complete log: https://pastebin.com/qKnipvvK
> >>
> >> Entire kernel config: https://pastebin.com/MRWGr3nv
> >>
> >> Root Cause Analysis:
> >> The vt_do_diacrit() function in the virtual terminal subsystem
> >> performs a write to a user-space pointer via __put_user_4() without
> >> ensuring that the destination address is mapped and accessible.
> > 
> > Where?  I see calls to put_user() happening in that function, and the
> > return value is properly checked.  What lines exactly show the issue?
> 
> Greg,
> 
> Please don't waste time on this bot. It is AI generated spam. The person
> learnt nothing from previous feedback.
> 
> I suggest ignoring completely.

Thanks for the warning.  Given the lack of response to our questions, I
kind of figured that was the case :(

greg k-h
