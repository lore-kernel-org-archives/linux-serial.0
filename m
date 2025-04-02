Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BD22A4F1;
	Wed,  2 Apr 2025 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743575295; cv=none; b=LoNj0HdKfdMuGnSzpv7pmgD05wjx2CAEaAD16XtCU74nikO+0Rdz9ek+GZQK9H5mlbgntBAsZ7BGw3eODG8QWTNTAPuWrIQnReR/oYd3dyVd631/Tak8C7qP5/pIo9RZ8oSh4suGRvN4hc9MaSBF9EsfOFf+QRjZKSyeXhChtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743575295; c=relaxed/simple;
	bh=O37j3GYErRypi0GWWgfx6sbrClKTgTAhv6qUKuKZozY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=BFnAaGNB4/cEV7EQs8glV6kaevjcPER46+1/RVl+aBi4zjsZTZWfYh2kCjtSdn6Q2nSmmeyuEOSBWQ9q6tvtiJ39rJ3A8nZOXBhkAbgywamTp34MmuRb3WP4yW1TXte+f26ZMkfJ29vOg4JFSdRu3MH7ce39bM/1jBR6Sys/XAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSFL15sRGz5B1J6;
	Wed,  2 Apr 2025 14:28:09 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5326S1af020652;
	Wed, 2 Apr 2025 14:28:01 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 2 Apr 2025 14:28:03 +0800 (CST)
Date: Wed, 2 Apr 2025 14:28:03 +0800 (CST)
X-Zmail-TransId: 2afb67ecd8f3796-43267
X-Mailer: Zmail v1.0
Message-ID: <20250402142803400kEFf9oOyQ7Y4Gq456dQg4@zte.com.cn>
In-Reply-To: <d9a60a75-14f1-46df-b22e-6afb768a4381@kernel.org>
References: 202504020933293306VVVuy_8HVKbwBOL2PFjW@zte.com.cn,d9a60a75-14f1-46df-b22e-6afb768a4381@kernel.org
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <krzk@kernel.org>, <shao.mingyin@zte.com.cn>, <alim.akhtar@samsung.com>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IHNhbXN1bmc6IEZpeCBwb3RlbnRpYWwgYnVmZmVyIG92ZXJmbG93IGluIGNsa25hbWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5326S1af020652
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67ECD8F9.004/4ZSFL15sRGz5B1J6

>>> Same comments as with other patches, not possible, IMO. Plus this patch
>>> looks actually worse - commit msg is hardly readable.
>>>
>>> Best regards,
>>> Krzysztof
>> 
>> Hi Krzysztof,
>> Thank you for your feedback. Let me briefly re-explain the change:
>> The issue:
>> When building with W=1, we get a format-overflow warning because "clk_uart_baud%d" could write 15-17 bytes >(14 chars + 1-3 digits) into a 15-byte buffer.
> 
> Hi,
> 
> how did you come to "1-3 digits"?

Hi jirislaby,

Thanks for the follow-up! Let me clarify:

Since num_clks is an unsigned char, it could technically go up to 255. The compiler’s analysis seems to align with this.

While I’m not sure if real-world usage ever needs 3-digit values (like 100+), addressing the warning proactively seems worthwhile.

The change eliminates the compiler warning while adding minimal overhead. Better safe than sorry!

Happy to refine this further if you’d prefer a different approach.

Best regards
Peng Jiang
