Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD535336A;
	Wed, 20 Aug 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755662812; cv=none; b=c1TQ8SMXNNIdy1L+GdQuUA+fQevpt4Fp3ImC//JvQN17UV3vIZUIYndVoKE2jZLHUqrV5t8WFJQv9LBzWDU5AcW7k125kNkCUu2OJ5lqRgwigW1gVzKcc2PoiMsSJwFg0SDJsqqW/SKjU19dLdHmZI9BHbHLBzsi719YE2Oj0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755662812; c=relaxed/simple;
	bh=8Q3Yn/H7CDkgcz3v0aIj4JvWkVxIIaD9QgAUt3wmjbg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gnYKktOt926tRHvrTV0PPPqDUaXGDzpH7h9wRxY1GTEkgKUVkWoSaH0hS6FqAAgFS4Xa3hF03r+mRrsetXfIT7BhBqSD2KiX5DNytUBeGKwQ0JLCEwjB+jKC8VRLJcsSS7iH4M4Q6+N6JWhfpkhEJ3SzJjD0knkNTOUaT1D6xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1Kxu23I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1Kxu23I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F82C4CEEB;
	Wed, 20 Aug 2025 04:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755662811;
	bh=8Q3Yn/H7CDkgcz3v0aIj4JvWkVxIIaD9QgAUt3wmjbg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=J1Kxu23IcVlCFCMIehjDZxGZLFd4BcHT+B64gp0NiOqTSbJsy4HTEbdkQ8l/Pc1bV
	 0sN6A4D0aSPVZ2sxfxUs0+HDbdwIzlfXo9C/NeBjdZFcjQp7dCPoIGNYSPwkQr3dNQ
	 8bXjNs/La+Qj4+Wy5aiSByojL6XM7FZBniXp+LnGhhbrd26pP4iLt+QOExw6sP4ipc
	 Db8hxKA8SpWn4WiTQYn6CWKsoc2j//R6AJlG2wRRdbggczyakzF4l1NBg7BH2EIaQE
	 SeblJzXkx6rJ1l0KKlkzFSLLvXaR7LipwYljpsrsFZ2eH5nbPCJykkASZBVW9xJmjz
	 mEOLo3EwXz7bg==
Message-ID: <3ef823f1-6c4c-4b38-92c4-5077a2d3149e@kernel.org>
Date: Wed, 20 Aug 2025 06:06:48 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
From: Jiri Slaby <jirislaby@kernel.org>
To: adriana@arista.com, linux-serial@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 gregkh@linuxfoundation.org, john.ogness@linutronix.de
References: <20250819191314.3452283-1-adriana@arista.com>
 <9a3e087c-3a1e-474a-b0ed-c69b5f174c43@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <9a3e087c-3a1e-474a-b0ed-c69b5f174c43@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Huh, you mangled even e-mails:

5.1.0 - Unknown address error 550-'5.1.1 
<ilpo.jarvinnen@linux.intel.com>: Recipient address rejected: User 
unknown in virtual mailbox table'

<linux-kernel@vger.kernel.rg>: Host or domain name not found. Name service
     error for name=vger.kernel.rg type=AAAA: Host not found

On 20. 08. 25, 6:01, Jiri Slaby wrote:
> On 19. 08. 25, 21:13, adriana@arista.com wrote:
>> This patch is proposing a custom configuration for Synopsys DesignWare
>> serial to be used by products with associated compatible string in the
>> device tree.
>>
>> The PORT_DWAPB config will be used instead of the default PORT_16550A
>> which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
>> bits for the FIFO configuration register. Having those flags is necessary
>> to clear FIFO when the serial port is reconfigured with do_set_termios.
> 
> How was this tested? I assume it does not even compile.
> 

-- 
js
suse labs

