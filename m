Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDA3B2FC6;
	Mon, 22 Jun 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136951; cv=none; b=Dqha6XhWYhhp2Ns5MlFn3oYIZM1U9BwstL8Yox7HBRcHvSAbMxDMEVXCd7qydWte/4v3N9cl12LVayVNUcf0KzKXpEDYBda4V+kWpgEBTcdx2vd3J4uaH8n+f68JCYpi9C+/6l1AUowDJZyj3WPPQaymkaIAKGrJPXtsPRM3tZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136951; c=relaxed/simple;
	bh=Gz8V/i3Wk2rLr9+0xRKDXhMVhHz2EgoWEP1OJn7wYJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXCDmyDmxi9QF3iabdm6joXRgNr9A3VfTgMylv8u2QFzkqYTp5xJUEM9/xIeeGx6vTVbRla+p+NG+R+34k86iLyjZmWNXhqPJ9sJg6f5iE5VpHwDbjiqV+2zXIhGPeMh3Ubtq147wIS/qrACGl8R6LjlPhb2mI792rDt/jxQT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGbb9JVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGbb9JVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9241B1F00A3A;
	Mon, 22 Jun 2026 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782136950;
	bh=+/Mq+Cqp2Q9GIkR8/GWE/coagNgFZJ/3XscJBEBI0Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hGbb9JVgL94aYcZw17e0a71TiWc0UoYrS+11mHwJYgHwFmtvArYCGES03y7+zptP5
	 1vogrf5ltZIzazrGbq9OWYAFfVUl6tQ4i/k9sPIknv12jahrApwmozvTZKSyCUaKtF
	 3zU0vYpxRW//vpu8bdcvCzU4pq9W8In+3JLVsq9E=
Date: Mon, 22 Jun 2026 16:02:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in show_cons_active
Message-ID: <2026062257-grading-remember-bfde@gregkh>
References: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
 <2026060919-unchanged-raking-9225@gregkh>
 <CAHPqNmztcnHLLEV0v8JK1zspgWqaveaTpDtEMh8ehuv-3hZPqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmztcnHLLEV0v8JK1zspgWqaveaTpDtEMh8ehuv-3hZPqA@mail.gmail.com>

On Mon, Jun 22, 2026 at 09:53:02PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> Thank you for the feedback. I've added some analysis on this bug, and
> also added the original report, which is at the bottom of this email.
> 
> Analysis Summary:
> 
> The hang involves two tasks blocking on console_sem while holding
> console_mutex, and a third task path (unregister_console) that
> acquires console_mutex and then blocks on console_sem via
> __pr_flush(). The core problem is a lock inversion: __pr_flush()
> blocks on console_sem while holding console_list_lock (->
> console_mutex).
> 
> This can lead to a deadlock when any code path holds console_sem and
> subsequently needs console_mutex.

Great, can you create patches for this issue as you seem to be able to
reproduce the issue well?  That way you get credit for the fix and we
can understand the proposal here much better.

thanks,

greg k-h
