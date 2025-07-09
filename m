Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731D26B743;
	Wed,  9 Jul 2025 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044848; cv=none; b=dfm7YHYEMw9YAZVFJT5VUpYvSFNLwuhDn1KuOOKplMruK/q9S0xT5faO1vATn6iophhtLBRXL/faOoZATohY2L7yWIzr/53H2QQ9V+1oUw1EZUjAbmkWtyi42BJjqIUlaOaZQnbH6IRKeXvv5bnhdV2d5g0EZJL6RJmUsPz5mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044848; c=relaxed/simple;
	bh=eFitu3XM1K/JAnMSBgMH0zsEkRAZ3dmUgipkjMLB9QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm0c9fqqnD8875zd8n3BxbVSEr/hpt3KB8sHuWL6nKqoCxfY6Ox1DTs5wshGMlmMn4I64/i11gXUgzBZf9pB16sEjYu+B9FHJseDRLpnPmW+abcvoAo4VeriboRyBcl3xW1GainYInpKMV79uk6OsRAXeVt7HFH2KUYqde3OWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZbLgG3D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZbLgG3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66244C4CEF1;
	Wed,  9 Jul 2025 07:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044847;
	bh=eFitu3XM1K/JAnMSBgMH0zsEkRAZ3dmUgipkjMLB9QM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZbLgG3Dcbqv1dXoXE+NXDh8TUEsXWOFnGPbOwMeaJ7QPBzKEO4nNW150dnUcepp2
	 fxMR/omUoBrtAEm8f2G/5otXz58DDUaWKW5Ydp46Y0E/lH6dluVpfZsdrGx3ARp6DG
	 Y+OChtvtNpWDvZUEACHPrc1PYokSjLh+qnqG4YAg5SkCGH0xbCQ7i5HOLYCVgL4xi0
	 0e6OaJ1IUbbRQGyggUXZATbrmak0Pnl8YEz7lkr+eosx+PVexmHMHi3MrmYneCAB/v
	 e1lwwInT+B9DzdVvxOFrg5kQwMG5xJayrPSetH/+o7GAIa0/cXxboa7FIgj+uVtD3Y
	 QK7STvB7g9Utg==
Message-ID: <b88b5d86-21dc-428c-a514-9030ffd494a1@kernel.org>
Date: Wed, 9 Jul 2025 09:07:25 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] WARNING in vt_do_diacrit in Linux Kernel v6.14
To: Jiri Slaby <jirislaby@kernel.org>, Luka <luka.2016.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <CALm_T+2AUcGgb+ukfGg5a3=ibQzRe93gHAzjh6XUubCePk=Mig@mail.gmail.com>
 <3dfadb7b-fc5f-4165-a5ad-c3802585805e@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <3dfadb7b-fc5f-4165-a5ad-c3802585805e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2025 10:46, Jiri Slaby wrote:
> On 08. 07. 25, 9:21, Luka wrote:
>> Dear Linux Kernel Maintainers,
>>
>> I hope this message finds you well.
>>
>> I am writing to report a potential vulnerability I encountered during
>> testing of the Linux Kernel version v6.14.
>>
>> Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)
>>
>> Bug Location: drivers/tty/vt/keyboard.c
>>
>> Bug report: https://pastebin.com/yuVJpati
>>
>> Complete log: https://pastebin.com/qKnipvvK
>>
>> Entire kernel config: https://pastebin.com/MRWGr3nv
>>
>> Root Cause Analysis:
>> The vt_do_diacrit() function in the virtual terminal subsystem
>> performs a write to a user-space pointer via __put_user_4() without
>> ensuring that the destination address is mapped and accessible.
>> Under conditions such as memory allocation failure or page table
>> unavailability, this leads to a fault during execution of the mov
>> %eax, (%rcx) instruction.
> 
> Which is exactly how it should behave, right? If #PF, then it jumps to 
> __put_user_handle_exception and returns EFAULT.
Jiri,
Don't waste time. It's AI generated spam. Same as before.

Best regards,
Krzysztof
