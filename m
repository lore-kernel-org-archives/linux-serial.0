Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8920EB;
	Wed,  2 Apr 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557626; cv=none; b=snSKWwRKjbjKpmBV6qqjzQrkYpIqnp2KZjxIACK98mGd6Fs/Ac0tOltyBELAaT+p3Bc/36mYcGbDrPHWktX/VcQydc6V1G5pSVKyNxoEpkac2uQOhQfCfjGzJzmm0RHRMixMMTI2FuQb32MgdA0bVfAe13ftvS7LwRP+DJAH9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557626; c=relaxed/simple;
	bh=wO8ad7zv4HsMRaMx4Vr/nPcP2lI7DLzTT8al31YJVEM=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=AsEIg2CwsqiDoGcCfUO/+Ydi1glpguqjCNmOZojAO4uGKNmQKgrquH7laVK57O16SZ2Af4uGDtMGb9NcJOXMJW0yZYsgDr8LcS2xaIeHQLVN7GAQx+m2Ys2aXTkwPRK4jgK84veUDkjy06TjVfH68Q+rSmk+1gLkHlncPDeqWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZS6pB6Yqyz8R03x;
	Wed,  2 Apr 2025 09:33:38 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5321XSfq021695;
	Wed, 2 Apr 2025 09:33:28 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 2 Apr 2025 09:33:29 +0800 (CST)
Date: Wed, 2 Apr 2025 09:33:29 +0800 (CST)
X-Zmail-TransId: 2afb67ec93e9fffffffffd3-81c64
X-Mailer: Zmail v1.0
Message-ID: <202504020933293306VVVuy_8HVKbwBOL2PFjW@zte.com.cn>
In-Reply-To: <017349ed-d1fd-418e-90ca-a7113cafd025@kernel.org>
References: 20250401192420169tLRsDis5R0RrVmdFnFuS9@zte.com.cn,017349ed-d1fd-418e-90ca-a7113cafd025@kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <krzk@kernel.org>
Cc: <shao.mingyin@zte.com.cn>, <alim.akhtar@samsung.com>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IHNhbXN1bmc6IEZpeCBwb3RlbnRpYWwgYnVmZmVyIG92ZXJmbG93IGluIGNsa25hbWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5321XSfq021695
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EC93F2.005/4ZS6pB6Yqyz8R03x

> Same comments as with other patches, not possible, IMO. Plus this patch
> looks actually worse - commit msg is hardly readable.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,
Thank you for your feedback. Let me briefly re-explain the change:
The issue:
When building with W=1, we get a format-overflow warning because "clk_uart_baud%d" could write 15-17 bytes (14 chars + 1-3 digits) into a 15-byte buffer.
The fix:
Increased clkname buffer size from 15 to 18 chars
(original 14 chars + 3 digits + null = 18)
Replaced sprintf() with snprintf() for safety
This keeps the pattern consistent while eliminating the warning. Tested with CONFIG_SERIAL_SAMSUNG=y builds.
Would you prefer any adjustments to this approach?

Best regards
