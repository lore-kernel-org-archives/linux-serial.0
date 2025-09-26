Received: from mail-m15566.qiye.163.com (mail-m15566.qiye.163.com [101.71.155.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAA13C8EA;
	Fri, 26 Sep 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897557; cv=none; b=Dg03d3pJ6LIUzEtXe7bS1ocf4UIqWlCDd6jnAeF7CAy6rZgatvXpnbpRqTvNSvPHycHg/T5BQwElETQqoUtd3ahW1jq7501VBFgPbWMGggyz82dMkh08e3jnKo0/WP3nVlUSnc558JiC/QbI0M8fYpx2aW5aDY9qpsbb3+ug10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897557; c=relaxed/simple;
	bh=od9vShACd/JgNkVYzap2DkAP/CrTcrq1VvOTO30I0UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fa7j15ZnHAPLiuBA9ZpnWsQGFMHR5m7nUJ0c3lDwiNvKVtoXbJADyjEhdS8jO7YwFhb2fs0SxfYsPhmbw3NPZnX4KD1rhS9BOP1uEvDmoRcIMFHrvvYPl46y2EOe2wl6eg+bnDpZNcG6lVmYWjdVi5XL0e7MIFRW+a57pA1qh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anlogic.com; spf=pass smtp.mailfrom=anlogic.com; arc=none smtp.client-ip=101.71.155.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anlogic.com
Received: from leo-ubuntu21.localdomain (unknown [114.84.85.30])
	by smtp.qiye.163.com (Hmail) with ESMTP id 10cd375ea;
	Fri, 26 Sep 2025 22:39:08 +0800 (GMT+08:00)
From: "fushan.zeng" <fushan.zeng@anlogic.com>
To: conor@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	fushan.zeng@anlogic.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	junhui.liu@pigmoral.tech,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	palmer@dabbelt.com,
	palmer@sifive.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	tglx@linutronix.de,
	ruigang.wan@anlogic.com
Subject: Re: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Date: Fri, 26 Sep 2025 22:38:55 +0800
Message-Id: <20250926143855.4106-1-fushan.zeng@anlogic.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20250925-jaundice-uneasy-ff8b3b595879@spud>
References: <20250925-jaundice-uneasy-ff8b3b595879@spud>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a998676aceb0224kunmdf48913a39ec1b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHR5LVh0fGhlPGEJKTUJJGVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKSk9VQ09VQ05VSEtZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSExVSktLVU
	pCS0tZBg++

On Thu, 25 Sep 2025 18:09:59 +0100, Conor Dooley wrote:
> On Thu, Sep 25, 2025 at 11:06:50AM +0800, fushan.zeng wrote:
> > Thanks first.
> > Anloigc already has the open source SDK at https://gitee.com/anlogic/sdk,
> > and will submit it to mainline at suitable time.
> > The code should be a full feature version after lots of tests, not the
> > modified and simplified version from Anlogic open source.
> 
> The nature of the upstreaming process will require what you have to be
> broken down into multiple parts and be upstreamed at different times,
> depending on how long components take to review. This is normal and
> expected. Of course there should be through testing done, but I don't
> think that what is in this initial patchset really requires much
> testing - if it boots then it's probably sufficiently tested!
> 
> > And we hope that there won't be two different versions code of anlogic SO=
> Cs,
> > it may confuse customers.
> 
> If there's ever going to be complete upstream support for your device,
> then there will be two versions, because looking at just the dts files
> in the gitee sdk you linked I have noticed things that are not acceptable
> in upstream. As others have said, you are not entitled to control the
> upstreaming process for your device. The only way to have some control is
> to submit patches yourself and to engage with the review process for other
> components. It's in everybody's interest to keep differences with your
> SDK to a minimum, but you need to accept that there will always be
> differences because the upstream community simply has higher standards
> than those in your SDK as well as a requirement for portable code that
> you do not have.
> 
> > It is better that anlogic SOCs are long term maintained and supported
> > by Anlogic officially in mainline and for customers.
> 
> It's only better if Anlogic submits better quality patches (no evidence
> for that yet) or submits the patches more promptly than others (which
> clearly has not happened here), and offers review commentary etc at a
> higher standard and more frequently than a non-employee maintainer would
> be able to do (there's no evidence for that so far either, given you're
> trying to stall this patchset). Your claim seems to have no merit as
> there is no proof that you'd do a better job.
> 
> Thanks,
> Conor.

Hi all,
I realize that my previous message was inappropriate and may have
given the wrong impression - my apologies.

To clarify, I am not trying to control the community
or block upstream work. I misunderstood the right
way to express myself before, and I take my
previous mail back.

Thank you for your guidance and patience. As a
newcomer to the Linux community, I am still
learning how to properly contribute.

If Junhui has further technical questions, please
feel free to contact me in this thread. I am happy to
help and to welcome contributions from the
community.

Best regards,
fushan


