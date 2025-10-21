Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3734A79D;
	Tue, 21 Oct 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064806; cv=none; b=dkc/X8z3S4Mf2tqE5h7WxZxOrvxdm72G7BcWW6V9/dGC32C+V+/1n9iwf71FbZZC/18nPhXJTkbxFtfGk121QxhSxPRy0jE/SuC2AgXhifyvddlQFs+cl2Hr9BK+eExHujUIOZ0uRrFWKLJGy/Xd1yjpPUlIQD4iPxxOMeVBVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064806; c=relaxed/simple;
	bh=iQKUJciZN4F+5srePv7O1TZ9g/h5yBEkErNBjzsQnYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKDNb1xiEonB1Ml/kjMKdWQrX6tyiOusHmh06vrCOTPWWjrUmWwBRMEyu1Vz4LUIdnRZ2vVRzQBwZGdcJF5iKX9IGNpvqYcUBTlKevmK2H15AyaHwTIMkIKkVLGUjt+cKtL37BQoOsa8fjoqV0mnz836EDuYHLOBzgRAGRt2p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDCJniG1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDCJniG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00308C4CEF1;
	Tue, 21 Oct 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761064806;
	bh=iQKUJciZN4F+5srePv7O1TZ9g/h5yBEkErNBjzsQnYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDCJniG1EELkZX+vW2UGtJz+KJ5i/fH1wfXjH9q2BxWIWyXPUiny/pXgc/0loJ9ON
	 UfjZw0fM0zZi7jxp/2nJvR1EwT0gNEa22D7oc+HdOquOB/XauHD+IvN9R3IfIylmLE
	 Q1SouB5vKJHqiRa4AQHmkzNOx5woUCwsA9Qv+btzNfvC2OPaCWU0PpycFThWxZVxEW
	 QXrQYuQRWalqzcSX//tjaFBGgQLNd1X691ImjxKY0Wiz/9SAEuC/2OaQL59vJ3HTmB
	 n6Sc3q1K0dGIlM5OkawZL0MPKn/iU+hNi4OUp9Qivm45Voe9GSDXrnRaFD2dRWOXbV
	 N42vXLmQnP+Wg==
Date: Tue, 21 Oct 2025 06:40:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Xin Zhao <jackzxcui1989@163.com>, hch@infradead.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on
 specific cpu
Message-ID: <aPe3ZBCcyc5XR7TO@slm.duckdns.org>
References: <2025102157-goal-grandma-36d4@gregkh>
 <20251021130513.871830-1-jackzxcui1989@163.com>
 <2025102107-player-baggie-37fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102107-player-baggie-37fc@gregkh>

Hello,

On Tue, Oct 21, 2025 at 06:26:53PM +0200, Greg KH wrote:
...
> True, which is something that the rt changes should have addressed.
> This sounds like an overall rt issue, not a serial port issue.  Have you
> asked about this on the rt mailing list?

Maybe it's mostly RT; however, because of the shared worker pool
implementation, workqueue can introduce high tail latencies, especially
depending on what mm is doing. When a work item is scheduled, there would
usually be a worker thread that can service it right away; however, there's
no guarantee and when it gets unlucky it may have to create a new kworker
for the pool, which can easily add some msecs of delay. If the system is
under even moderate memory pressure, that can shoot up considerably too.

I'm not convinced WQ_HIGHPRI is a good solution tho. It changes scheduling
priority and it likely reduces the probabilty of having to create a new
kworker as highpri pools are a lot less utilized. However, that can still
happen. If consistent low latency is really important, it should use
dedicated kthread workers with appropriate priority bump.

Thanks.

-- 
tejun
