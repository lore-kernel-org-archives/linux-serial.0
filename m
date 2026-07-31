Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365A3C1F36
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501455; cv=none; b=VUcSKNXg2Q+/5c6dD4xxjtKeVQGwXaZBxHX6fh9Dc6f6cr+OO/jXgjlVFOqj1xFjRygLejK9wF3XW5CocIu83ySFLLXvQmUYRR3/b9xtu5xyg9OBMDXWsyUC6A/n0i16h0oaCibm5AL2pt1O40f4MA1XAehMu56/epfE7VRGknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501455; c=relaxed/simple;
	bh=YqebT9clfnPMsC7yqrCtUYusj4Rz5asoem6l5jV5TlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHx1RyZ0I+UyC0AZUY6nKTL/ciCYOsTMsPN3NQegPvpQkmh6iBtdWBBeotn/SP9LxwklhNiy+pFldvaWdK6terChE7d51ZkO7vRvWMVAx75hlYB6++m4juVoBA41DMvRpVgWZ0g9mKjJGK01WUR8eRw4vUiIrSERl3d0fZNbZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz4ZHMw0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz4ZHMw0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so1613335a12.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501450; x=1786106250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxJ+yA42EHLQdUzb/+RpNk8wZMGnUA7//ORKkd+D1IE=;
        b=Hz4ZHMw0aOrm1r0slpGzgaDgIn9QEZTm1bne/4F7C0kHCoyRsnL8zLlG+eZUGeINR4
         o1HutbwOsUCa59j1poSqzGdSiFoO7ZsuyJf3gNOrFG618xiLCzukBskuldrQuY0J5Vkv
         MPhwhKhGOHLs9Vl6AOUm6+mmeMLtTSfGyRxRsYXtfYWPXePsqAqfPCZojLLDA2zRqos0
         KRMDoHB7ZXdu0sFxww632T75v2e7UtMCX8U5S+OgxjDC2YnVKfqSWf5Ei+5v50OYD5ag
         Sc8gDKza9uFRZ2n47On/Oj65SUhPe/ahnAgVOhOAekLcOxd7V660RjP5BNag7xq7EQct
         d4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501450; x=1786106250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxJ+yA42EHLQdUzb/+RpNk8wZMGnUA7//ORKkd+D1IE=;
        b=R/QA+ot0q6C/TpvkUCN+D1wJ0VjfGiVTISp4/VsYm97jt/tg/kd3OQBhj3+8jGqYyj
         leQNZCyCxuYSPgGpGADoVUdiAuoM5mxVMaYfC1AZb/9oX06n2dEe0R3MSGv/aaTciWoy
         paD9CPMjyvNK7+aA8GIJIlT7UHM0dtR74eZkKohBvnvK9Dp+fESeyfp+NkfxkCbzNtF2
         WKeh5rXqWcbntQEgfRB87JNS6MVNjD4DGCa/nVRvl3KOW0pIpkrLBlDUPQdfIdd4WLVM
         DALnAVRoY8+PZMdrPZwKfcdK85vRh6BxP1wsWAQqLzfYH4bh+BKzUXW+nyD8Sgb+Nx2m
         3/mA==
X-Forwarded-Encrypted: i=1; AHgh+RoOapcge+YCyVK7GJSjZ5m7TLMs2N9n4VuQ/rY9IEbu7dJjgNGPtyYHQnwxgMsRZpEWwx7+Kl18vv0YdYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnA/8klz6uVuKF+gcNg0o/CZiczUvUl7BdG8sLxwIPJxpyorma
	uP+N0ksUUi/ze55YLWqEKOLQs22nlzXGzoE97dDw+J+E0Ejjde2IQIaWIy4Hf/Gi
X-Gm-Gg: AR+sD11/9jS1RXHg3nR5FNBiTUWyGL2bPYq9aZR/SizMufbOcgylj/uNJYA2IoMDjEp
	Za5Pr/OAc6QBU9DigCcEy0ZVIlHQhvB0v4DrIwl1cM/cX324WWlSdvcFptzgTqQ/oKiKrCl9u9E
	OD/TK88ZqtTwJpWm9b2VCdz/lsqXceHSwsReGM8k5ptS7FZGzZEQVzS6H2UywP/YdOY1juPVLzF
	DXAehtTGrwxsXf67c4hSPCkh+Oy7bJg/utODqt6K78JqM31+lX2QICdMsJrOOAnepOs7JR3BrIN
	YRcKZSKKMum1SS/PTBQoAQLvRjMy2s63umW/AmB7+0/w59uKmbOHTxogCSK3xuY5fq3Bm/dIMVd
	jvSh92yiDgGj9FmLYmuSdihqr9Mihqy1ieCGQt6cIcuGm8CH2P08StzlEQ2lfQ+5XY8/x/CK43t
	5jUA3+3n4FNC94PNiotWLSCnSd+ATJ9seCBTP4/DOz47Fw5bdA1p92uyi7VkEgo/zaf13Pu1F80
	RoDxn0+9G9g+I6aulS3iI5bwysAf2fRYW584yWkiva56GIaeyJljZ3R+S04hn1fRgCBZ4AVBSFa
	mmt9487zlHGoTirHKMc4/x7uZQrD212c3WayrdRVqyM1UKao7k+PBkKkqXubWck4glt2Uvc=
X-Received: by 2002:a05:6402:51c8:b0:6a0:1704:de29 with SMTP id 4fb4d7f45d1cf-6a098d07135mr979233a12.33.1785501450131;
        Fri, 31 Jul 2026 05:37:30 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c660febsm1308537a12.28.2026.07.31.05.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:37:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:37:28 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: core: do fallible allocations before the
 console can be registered
Message-ID: <amyWRaZN2kSiv3YQ@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-2-kmehltretter@gmail.com>
 <2026073056-embargo-rejoicing-87c2@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073056-embargo-rejoicing-87c2@gregkh>

On Thu, Jul 30, 2026 at 04:28:10PM +0100, Greg Kroah-Hartman wrote:
> > Cc: stable@vger.kernel.org
> 
> As this can only be duplicated with fault-injection, it really doesn't
> need to go to any stable kernels, right?

Agreed, I'll drop it.

> 
> > +	if (!uport->tty_groups) {
> > +		kfree(uport->name);
> > +		uport->name = NULL;
> 
> Why set this to NULL?
> 

It's not necessary. I will remove it.

Thanks,
Karl
