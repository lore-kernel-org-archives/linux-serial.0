Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A931E520A;
	Tue,  8 Jul 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960945; cv=none; b=WxLpJhrceJjnkJp46Ut2t6iciaeBa14IpJkTTkKx8GuQetcjPW/FW5FHmeBJl1ccWDvXdI8AgAVbJWZjQEf/jCI9rJuyDFZXPsJKlg7wch9aIHdWtulSBdZXjYOxTfKh/UuyOXDoYzSBM8j+aB44d8HWa1SyPhH8GTAW7dSR8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960945; c=relaxed/simple;
	bh=hnYWVpaIxR3sAcv6lDEqJ3ovOnWIDMaeUr3G/UxM0J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J74B5FMc5a7UX4A/JuPqE8bgvHfmfBnLCNKurNZwHr1tNOszLoxJHSN7lSyK/Iy1DzJTNtsnvdIZb3NKI6qhOwBGrR3PEBSszJSuf6cBY8o6K4SOngBGhdqfjoLPiJfHNimfFj2Thzk6nN1VfIGluc/9xTLWQD/i0xsIfOV9pAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWgpQkOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWgpQkOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA6DC4CEED;
	Tue,  8 Jul 2025 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751960944;
	bh=hnYWVpaIxR3sAcv6lDEqJ3ovOnWIDMaeUr3G/UxM0J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWgpQkOJ0J4uiRmj8LXN0qq+iQ221p/K3SwaGwY9oIA+H8byYHLZV7taNZ1yp7Stj
	 RuqQL/kek6XkGoQDVo+BxkYrqoCEIpMaMBs9vKU0KVAodcH08QrEM3jjAaNhl/3f4B
	 fI3oogjsEDNRgOFxafYiV5TQsvkRH7jiMKV+6omA=
Date: Tue, 8 Jul 2025 09:49:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luka <luka.2016.cs@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [Bug] WARNING in vt_do_diacrit in Linux Kernel v6.14
Message-ID: <2025070805-stoning-overeager-39f1@gregkh>
References: <CALm_T+2AUcGgb+ukfGg5a3=ibQzRe93gHAzjh6XUubCePk=Mig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm_T+2AUcGgb+ukfGg5a3=ibQzRe93gHAzjh6XUubCePk=Mig@mail.gmail.com>

On Tue, Jul 08, 2025 at 03:21:36PM +0800, Luka wrote:
> Dear Linux Kernel Maintainers,
> 
> I hope this message finds you well.
> 
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.14.
> 
> Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)
> 
> Bug Location: drivers/tty/vt/keyboard.c
> 
> Bug report: https://pastebin.com/yuVJpati
> 
> Complete log: https://pastebin.com/qKnipvvK
> 
> Entire kernel config: https://pastebin.com/MRWGr3nv
> 
> Root Cause Analysis:
> The vt_do_diacrit() function in the virtual terminal subsystem
> performs a write to a user-space pointer via __put_user_4() without
> ensuring that the destination address is mapped and accessible.

Where?  I see calls to put_user() happening in that function, and the
return value is properly checked.  What lines exactly show the issue?

> Under conditions such as memory allocation failure or page table
> unavailability, this leads to a fault during execution of the mov
> %eax, (%rcx) instruction.

Again, a normal call to put_user() should be catching this.  Are you
sure you are looking at the latest kernel tree?

> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.

Please do.

thanks,

greg k-h
