Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE2228CA9;
	Tue,  7 Oct 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864738; cv=none; b=jh0s7ZiYvtIwXKq0cf33QSwadlXuagVBczFCYPgAexiL0FFj8SkLUoBsG3bhyJS2doqTe8AibSWvcCb6FP7fgL/iRwA+N5069crYPppDDHc3XrK0A9/TCvDnh4H87vSeSbtdyJE7ECrPLzkJy1OJmFfwkAuYR3vmEWQH8stEFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864738; c=relaxed/simple;
	bh=lKibQ7TOxB+xy9nfqRGPqErjMOERI26xw5gkpTCdGxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LECQd4mgLXK6PoPXA3Nl5Q4hxQWBua3+XfgauK8oJ3PiUoepckYNacLsVxq8bynxOL9xphmN/R/r8ISGwxwT953sGBiG5VLOg7Z78h2eqiDjGfoWOzpbJ7dCui3NvW8leuFuC/6yRv7No8EHI1dtxIw/LxJwnbaJnYF7iDmPYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmwELlNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmwELlNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6113DC4CEF1;
	Tue,  7 Oct 2025 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759864737;
	bh=lKibQ7TOxB+xy9nfqRGPqErjMOERI26xw5gkpTCdGxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmwELlNx9u07n5UU7SwBH2WJwK3hOGIugIL+M0d4DeHV/aosiawfcDDlVuSPjE54a
	 p2ePzP+9J0IqfOeVAdPMh74rB7oDDm7+x0O6lQCRojSVm4m/b3FSPkmeidDbBtIVEN
	 h7JNw7Kpgsu6p+rp+ax1mANyKxgtLax4BMuu9N/HuGFE9rmaaRVoRA0p59yrgDAvMG
	 7uKWj8UaYzspWiin0gQYjIEoxMFGyIcQKD2VHUPQVYW94Y8zoKj58lMqmV5gOSk3AG
	 ZECkfitobIOaLb1vJO0w7SGPC4JDqTx4J+6onYH/r1GC0c79HNoU2coopWhf9fyNS9
	 df2PaVggOovlQ==
Date: Tue, 7 Oct 2025 09:18:56 -1000
From: Tejun Heo <tj@kernel.org>
To: pengyu <pengyu@kylinos.cn>
Cc: jiangshanlai@gmail.com, oliver.sang@intel.com,
	changlianzhi@uniontech.com, dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, legion@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lkp@intel.com, mingo@kernel.org, myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] workqueue: Add initialization macro for work
 items that disabled by default
Message-ID: <aOVnoCnHa2vzB54g@slm.duckdns.org>
References: <202509301323.34d956e1-lkp@intel.com>
 <20251001102341.600251-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001102341.600251-1-pengyu@kylinos.cn>

On Wed, Oct 01, 2025 at 06:23:40PM +0800, pengyu wrote:
> In certain scenarios, workqueue tasks that are disabled by default are
> required. Similar to DECLARE_TASKLET_DISABLED, the DECLARE_WORK_DISABLED
> macro is added to achieve this functionality.
> 
> Signed-off-by: pengyu <pengyu@kylinos.cn>

Can you please use FIRST_NAME LAST_NAME <EMAIL> for the From and SOB tags?

Thanks.

-- 
tejun
