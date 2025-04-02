Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7B1EFFB8;
	Wed,  2 Apr 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576563; cv=none; b=MGkPeo3y6XqQ+QttqgUAoFxyCeN72HPeeRFL00Vys/OdNHVYFZFibs2/JoaGiCUDkcHNhXhocJNdKTviv6UEwjdAXIGwXD9K8Rhw5IGVHFBGCPypK2eCIKwRW3suPAYkBjJgOr8tq6lOyXivb1ZXKuNPWUtn9lSCPu0fJziAVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576563; c=relaxed/simple;
	bh=/yi6qknwAkRKgr33OUR1B3YE83fCvHQxZnnHq8SA7Tg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=dmo6pMWlEhOuO7Azx0hfEX2z4E4TH5+xH/U8NIfPmEOJ4LQzZWBPe5g1OFYr4ItSnpZ749J6a0ScwZ6xg8TrD3QO3kTw4dhCLkQK15z3lWYt3Go3wZQz7OaWbP9mW3Dbk3T7paelceTA4q1XOkGgwRnW8c7HIeQLqSobrOmbtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSFpR1l9kz5B1HV;
	Wed,  2 Apr 2025 14:49:19 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 5326n4Ea097953;
	Wed, 2 Apr 2025 14:49:04 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 2 Apr 2025 14:49:07 +0800 (CST)
Date: Wed, 2 Apr 2025 14:49:07 +0800 (CST)
X-Zmail-TransId: 2afc67ecdde3ffffffffc8e-6c736
X-Mailer: Zmail v1.0
Message-ID: <20250402144907313UlqFDoDa7TOFH0RRezphW@zte.com.cn>
In-Reply-To: <fe6ec03b-c1c5-417f-9aec-1b81731b3018@kernel.org>
References: 202504020933293306VVVuy_8HVKbwBOL2PFjW@zte.com.cn,fe6ec03b-c1c5-417f-9aec-1b81731b3018@kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <krzk@kernel.org>, <jirislaby@kernel.org>
Cc: <shao.mingyin@zte.com.cn>, <alim.akhtar@samsung.com>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IHNhbXN1bmc6IEZpeCBwb3RlbnRpYWwgYnVmZmVyIG92ZXJmbG93IGluIGNsa25hbWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5326n4Ea097953
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67ECDDEF.001/4ZSFpR1l9kz5B1HV

> No need, it was already on the lists many times.
> Same comments as for previous cases. Go search other discussions.

Hi,

Understood. I'll drop this patch.

Apologies for the inconvenience, and thank you and the other maintainers for your time and patience.

Best regards
Peng Jiang
