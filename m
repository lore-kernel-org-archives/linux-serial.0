Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B033507C;
	Fri, 17 Oct 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715346; cv=none; b=B2aN3mQpu3On00n1zqkxBssJUCiJfxTTK7MKGK8OEShpMnp9NsTjL2VazxD7xwdsyu+cZoQLlDA8UyI+4dDDRWLwbQ2TI33tum1JeCwudNAgC9Pe27py9G2tBzues5xyslK6gBoRPCjOwV2k2pfEI/5tFRCd7kt8um62aJRWi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715346; c=relaxed/simple;
	bh=B8BTlhYmiDg4r1CkU5a1BLPIjrF7uRIotem9pyl0iXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF32NgpxGs4XOGHAZWbZZDjTA3snfqVnxrCVy3Wo1PELgrXhu80ddQyI+MngheG32nwGQXG3Pzrv+K0hN9hgnoygeDW5IZ4E5C3hxeJiJlY+4/NYT46muQ5jU2YRG3e2tDityGx4Ai2VVhdlmrMk4lEFXeL2FlG0G7sUDP6EWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCjVnOr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCjVnOr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F4C4CEFE;
	Fri, 17 Oct 2025 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715346;
	bh=B8BTlhYmiDg4r1CkU5a1BLPIjrF7uRIotem9pyl0iXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCjVnOr2a/M2q6/nxIcSPZjHVKROLteqa5b5R+I3ESkbUdY6AkL9LxmDoPJOQrUSj
	 M8/ICWYZ4ysgv5+croZsJaF5D20+Xvz20c6e9gXK/vc/kD/+a+9toONZHu79BHO1gC
	 Pi6zZNXfXDjGTzBdaEpSv0g63ziTmEHUpYMy+YPGN3RxRG4Vq+IsJw75M+kicBJDDE
	 U8k+1JytgWD40wU/2dusGw5rxHsUsgwA3zOjLsRfb8XjYQQvqaLuPoQVqqIbxcSWKR
	 3VxYZPrrx31PJAYKFoIXn8owqnX83oTcqLsSBrXEB0R1vMwsu1l0Vwo8Mw8IkTFpNW
	 NG4bpo84m5daQ==
Date: Fri, 17 Oct 2025 05:35:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: changlianzhi@uniontech.com, dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org, jiangshanlai@gmail.com,
	jirislaby@kernel.org, legion@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lkp@intel.com, mingo@kernel.org, myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev, oliver.sang@intel.com,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: Re: [PATCH v3 1/2] workqueue: Add initialization macro for work
 items that disabled by default
Message-ID: <aPJiUXSVepUgB3OL@slm.duckdns.org>
References: <aOVnoCnHa2vzB54g@slm.duckdns.org>
 <20251017075655.3781522-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017075655.3781522-1-pengyu@kylinos.cn>

On Fri, Oct 17, 2025 at 03:56:54PM +0800, Yu Peng wrote:
> In certain scenarios, workqueue tasks that are disabled by default are
> required. Similar to DECLARE_TASKLET_DISABLED, the DECLARE_WORK_DISABLED
> macro is added to achieve this functionality.
> 
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>

Applied to wq/for-6.19.

Thanks.

-- 
tejun
