Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A76248F77;
	Tue, 21 Oct 2025 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072618; cv=none; b=YKMtX3fViuivnRxqsAAI4EsOBGONRR2VowAFJ4LxC0juPpOD18iSa17HihM9shrVolTdP9BSH1YqyIBLc+MacU0Kp7fQqAIzevlusMYMhOgY3DgDo7CdDoZ00v240ICvC9hIkzPX7yOg2+UiSJwUw7amiHUew7LU+lK9JRKxsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072618; c=relaxed/simple;
	bh=wcXNN9Tb/OiH06JySXaZx0lKOkFhcvb+dpwn9O9zdM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLnCBtpaTR4HHQ6bMq80//1jodnlDhkNFvq/y5yzYO+tfxOSKBjNH3UPvmpxnBmsVu4/Vz6e7Q5du+JjrSZz11DT5rFe1wp+cnmO9ZqH1FozCIgCVyUOiwP/fCcdmR5bPvEUvOHx+E4eQv4ZXlHqFewmVq21Nkd9Kn+nF/02xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGggeOEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGggeOEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C803C4CEF1;
	Tue, 21 Oct 2025 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072617;
	bh=wcXNN9Tb/OiH06JySXaZx0lKOkFhcvb+dpwn9O9zdM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGggeOEjy6klojO4kEyLZtDJAZ76dXRjRfs5IuN7ozKLVzxg5wcjNPf4kHmHcmofO
	 6I7+ueKs8Dvl/DlxgY7kNcmPW+tPMgu3s7mP6NZ5X3Cp+EaLREQaOu3KuHHz0Waas5
	 Ijr+exJsViFaew6Mh25TXIBuAzWRVWQ3qGecJiBvds2M60u99x23cAFpJzJ84ewrOU
	 Rmif9I1Dn+m+9V9Ybyn7kGFlxQIcbJhMy2biQQBZJ7vwImPLIjiRQAooryhPOvJ9o0
	 6hYUW7MNTXAP1NIuioy/Unq05lSR/VtT1E5WdSjQGKiNh5jM1lKCxhzooN1fsOOD3X
	 hsgq171GmeQAQ==
Date: Tue, 21 Oct 2025 08:50:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, hch@infradead.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <aPfV6IXPk-j59AhQ@slm.duckdns.org>
References: <aPe3ZBCcyc5XR7TO@slm.duckdns.org>
 <20251021173933.1077124-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021173933.1077124-1-jackzxcui1989@163.com>

Hello,

On Wed, Oct 22, 2025 at 01:39:33AM +0800, Xin Zhao wrote:
...
> I also agree that tasks requiring continuous real-time execution should be
> handled by kthread workers. However, while the ideal situation is appealing,
> the reality is challenging. A large amount of driver code in the system uses
> the system's pwq and worker_pool management, as this API is very convenient.
> Refactoring the code carries significant change risks, and even with a team
> effort, it's hard to bear such risks.

kthread_work's API is really similar to workqueue to make it easy to switch
between the two. We probably didn't go far enough tho and it may make sense
to allow workqueue to always use dedicated fixed set of workers (e.g. by
allowing a workqueue to create a private pool of workers) when configured
from userspace so that this becomes a configuration problem which doesn't
require code changes.

> Adding flags like WQ_HIGHPRI or even introducing WQ_RT from a functional
> development perspective doesn't pose too much concern; we just need to focus

WQ_RT really doesn't make sense given that you can't even tell whether any
given work item would have a worker ready for it. What does RT priority do
when you need to go and create a new kworker?

Note that workqueue property changes don't need to be hard coded. If you
make the code use its own workqueue and set WQ_SYSFS, you can change its
properties from userspace through sysfs interface.

Thanks.

-- 
tejun
