Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840E23D7C2;
	Mon, 19 Jan 2026 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806490; cv=none; b=W5LYmPNMrhTPDKZ96GJM/tBaTy4roUmGQsTC9rlnowMywIiha3E2vl+SdsPCyEutGKtHUrQFPTecp7czG8dkgjooSawKdPVBxhun6BahF0XlQ+kdCqwF+2+w6e3YOywxskxO0xneqITbskjXgYB51FlhhmKcSrfADjIHIUUL+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806490; c=relaxed/simple;
	bh=w5v5NJGubsnohnWB4hRbBIx4hFV70tcopy5GlPKAWAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7MV/8DLZ8sZWRdE3T3Z03JqwG55ex9v5kZFAVslzxy2KPlLcHe1apkNb67XuBfbDDxi6xbguFKKT2M6E6FXeDCSPTekPVfsnNdWkeH6g8J14segujn19MERwdtO9QzMVD27kZH3oKhk5e+aCh8HAjwoE/94/G7aP0NRNJ1YKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6OBGjvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6OBGjvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B127CC116C6;
	Mon, 19 Jan 2026 07:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768806490;
	bh=w5v5NJGubsnohnWB4hRbBIx4hFV70tcopy5GlPKAWAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U6OBGjvUhnsjsZ7cxtWIyBvKI5zgEO3lYAJATPVXCOWMzA+x3DdKsiGtArRiesw4y
	 rRJtautAjM0oUimCGI3ALYiTWQkyy3P/bsHGvj+bIOvtYkfN5IOM6MIn7y5d2uAKnU
	 b8e90f6YfTorNnI8Vno5OTFqa++hTi2FfLHvNGzavwzohHHb6id1AErHWNQ7CDbm8q
	 L+8RHsb0vP1fCmb5DAxvUbcxDX3ZauY3DltjyYGJpLK+6vvBnOkGtyz8ij/ipLz1Wn
	 v1RpyW8v/Fn6iP0ssyI+mdy00AAaca95qHiq4AmvqIdG5TK/+elMOYyzPqzrzBPLxU
	 dKq3jibcIcGQA==
Message-ID: <6182b524-6e15-40b8-b43c-1b2479f91b47@kernel.org>
Date: Mon, 19 Jan 2026 08:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] tty: tty_port: add workqueue to flip TTY buffer
To: Xin Zhao <jackzxcui1989@163.com>, gregkh@linuxfoundation.org,
 tj@kernel.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251223034836.2625547-1-jackzxcui1989@163.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20251223034836.2625547-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 12. 25, 4:48, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preempted by real-time
> tasks or other high-prio tasks.
> 
> flush_to_ldisc() needs to wake up the relevant data handle thread. When
> executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> does not disable preemption but disables migration in RT-Linux. This
> prevents the kworker thread from being migrated to other cores by CPU's
> balancing logic, resulting in long delays. The call trace is as follows:
>      __wake_up_common_lock
>      __wake_up
>      ep_poll_callback
>      __wake_up_common
>      __wake_up_common_lock
>      __wake_up
>      n_tty_receive_buf_common
>      n_tty_receive_buf2
>      tty_ldisc_receive_buf
>      tty_port_default_receive_buf
>      flush_to_ldisc
> 
> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.
> 
> Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
> default linked to default workqueue allocated when tty_register_driver().
> The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
> nice can be set dynamically. The execution timing of tty_port_link_wq() is
> not clearly restricted. The newly added function tty_port_link_driver_wq()
> checks whether the flip_wq of the tty_port has already been assigned when
> linking the default tty_driver's workqueue to the port. After the user has
> set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
> system will only use this custom workqueue, even if tty_driver does not
> have %TTY_DRIVER_CUSTOM_WORKQUEUE flag.
> 
> Introduce %TTY_DRIVER_CUSTOM_WORKQUEUE flag meaning not to create the
> default single tty_driver workqueue. Two reasons why need to introduce the
> %TTY_DRIVER_CUSTOM_WORKQUEUE flag:
> 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> fail when trying to create a workqueue with the same name. The pty is an
> example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> 2. Different tty ports may be used for different tasks, which may require
> separate core binding control via workqueues. In this case, the workqueue
> created by default in the tty driver is unnecessary. Enabling this flag
> prevents the creation of this redundant workqueue.
> 
> After applying this patch, we can set the related UART TTY flip buffer
> workqueue by sysfs. We set the cpumask to CPU cores associated with the
> IMU tasks, and set the nice to -20. Testing has shown significant
> improvement in the previously described issue, with almost no stuttering
> occurring anymore.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

This forgotten XMAS present LGTM ;).

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs
