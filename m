Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497854AEBED;
	Thu,  3 Sep 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455181; cv=none; b=GeFUptqETGiqN16y8z7afvi5ktDfDbAinQWIQS9dvNM9o2vDf0DpuK9EZTy4nT/hxpe67CYB+qQC/VhgGVZrSUjtX7u6ErjhO17/SuU2kJk4+vENE5gJ276A/S8HLRCJr7gRuOpRxjMQzQBfYjU4S0Nr7qigU++FYV+nKsyoXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455181; c=relaxed/simple;
	bh=pZW7l6Uj82ZftAI/UWdI/ODCB0qdO9saQ+8yXZn8/F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA0Kjj70geW8tATh4xGmS1GiMUWDAlL3y+qqejXB07Y65/Nhlfwuixd3JBIsn3UH6pUfJRAp4f1oSmHTY5phdd4rTswm1efO7i2MiAovi32ZNe7sKSyeKc+0Kovv3hHAyAxJ3sRDWJmA32dWxr2g67Xq+V6gvBB7imjOs124pCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqxAOIJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqxAOIJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51201F000E9;
	Thu,  3 Sep 2026 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455179;
	bh=efqhbmv3xpMp4azc0GRp28vhADwOuPMinLyRDonoxxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HqxAOIJZIPhPYOIBv16bt1HRpjDsu9iK6mObj29wckauJ8zLgeBMUbzDEvaHt7y0F
	 V0Pq/12dmQZon/7e3MzhOvSfXek+3fM0zqpTnKStnIKuy6z+HRoEm09QKncCo4YgbH
	 vCdHjDWiKMvFtqIAcwwAE4ORt2tceJXGlSgMKGz7IxEj0QTz/vjWAYZU6HOkwjxH8r
	 bbiRLVzdc1WO2KOXT8Gmx7950altiivtwf+x55V/z5L4/JxeZqdw1CgAt9UxYNYBQ3
	 OBAT3Pcla2Riw9g/anKkM2zgNQEPy/peMujpXuPq71jjXnJ4y/gvHF2Q0ObZA9LkZS
	 f3UC9gKbnwi9w==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2AtF-00000006Iey-2aYL;
	Thu, 03 Sep 2026 19:06:17 +0200
Date: Thu, 3 Sep 2026 19:06:17 +0200
From: Johan Hovold <johan@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fix ioctl hangup race
Message-ID: <apmpCSDZWCsGMtP1@hovoldconsulting.com>
References: <20260903163439.1499055-1-johan@kernel.org>
 <20260903164532.0B6FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903164532.0B6FB1F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 04:45:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Using a `break` statement inside `scoped_guard()` incorrectly
> exits the macro's internal loop instead of the intended outer `for
> (;;)` loop, leading to an infinite wait or severe latency.

Bah. Another reason to dislike guards.

> Pre-existing issues:
> - [High] The TIOCMIWAIT ioctl is still vulnerable to the hangup race
> because `uart_wait_modem_status()` accesses hardware registers via
> `uart_enable_ms()`, despite the commit message claiming otherwise.

I missed that call. Will revisit.

Johan
