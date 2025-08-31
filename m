Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCDC4A1A;
	Sun, 31 Aug 2025 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756620434; cv=none; b=daypjGtKcYCwZrQh3wut/dlJLNcFEMBcMkBQcP/WQFH9OQbo3eYknCj7czdJPwwQlwmYdzNG0j8+F4EzSvGgpcrOWpaMyeruBJfwTYlKl6XH/WxwhYxKgZb8DcQPG5sklsm++Om/9afrykVTsJ5IqKuWlncBkO5ikIxAqYWlh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756620434; c=relaxed/simple;
	bh=ABopUsGvRIKCQV1pVsnu1etx9G+hckoqj745dqdbdv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg5nG7xrbnkzrJA6eHSRPzn60NmXHrUv+U6pGG7jdTQUpraT4K1bbcFmYghQNuqSRR/2htMdPF5hjt7sloPW2/EDzpAB6yYioNFrpw8xhKU4dZL04x9f+PBoGNicvHigPyENLCs7OgryATZB79WXYjaYaopymm0i8ihPAt8pIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx3x8bbl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx3x8bbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128C1C4CEED;
	Sun, 31 Aug 2025 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756620432;
	bh=ABopUsGvRIKCQV1pVsnu1etx9G+hckoqj745dqdbdv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kx3x8bblaAPaf/loZQgl3jUQIte6fkjPaGOyCwNFx+ROwOkvnPZEpoX84JoD37vuZ
	 l5CW+sopI2FVBFFjvT+j7jOA0a02CBnNjLX7jIClPNDT0VoDxrcESZYywdRB9uii32
	 m9VxGqSv3eWq60rd3gdhsIjjD0TDc9v6jBmr9U9tKySAPM7gGZHyAaBCPvDafZIh2O
	 kWjhZ3XZlbCYMr6ZT1rEHCwrjvGNvE+Fm/ZJkLaQdTA7Dv36hClRTcU5k2h+K+F9BN
	 YxTdj57G3FywFwNHImv7sTEK8nDvnnyFJTf/SXzKtokMskUREaq6qkY6qWoxMztQxr
	 TRs56u8kdAZuw==
Message-ID: <49070681-9111-404a-a965-ca2b2eb2988c@kernel.org>
Date: Sun, 31 Aug 2025 08:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] tty: Add KUnit test framework for TTY drivers
To: Abhinav Saxena <xandfury@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20250826-tty-tests-v1-0-e904a817df92@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250826-tty-tests-v1-0-e904a817df92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 08. 25, 0:51, Abhinav Saxena wrote:
> This patch series introduces a KUnit testing framework for the TTY
> subsystem, enabling deterministic, automated testing of TTY drivers and
> core functionality without requiring hardware or userspace interaction.
> 
> On an x86_64 build with CONFIG_GCOV enabled, these tests increased
> TTY subsystem coverage to approximately 10.6% line coverage and
> 14.7% function coverage [1].
> 
> Problem Statement
> -----------------
> Testing TTY drivers today requires:
> - User-space interaction through device nodes
> - Complex setup with ptys or real hardware
> - Limited ability to test error paths reliably and deterministically
> 
> This series solves these issues by providing in-kernel KUnit tests that
> exercise real TTY core paths under controlled, deterministic conditions.
> 
> What This Series Provides
> -------------------------
> 1. Reusable test helpers (`tty_test_helpers.h`):
>     - Minimal (~150 LOC) infrastructure that any TTY driver should be
>     able to use
>     - Automatic resource management
>     - Integrated into core files under KUnit guard, with
>       `EXPORT_SYMBOL_IF_KUNIT()` to keep the production symbol table
>       clean
> 
> 2. Mock TTY driver:
>     - Demonstrates how drivers can leverage the helpers
>     - Enables deterministic scenarios without hardware
> 
> 3. Core TTY tests:
>     - Validate open/close/read/write/termios paths
>     - Exercise hangup, resize, and error handling
>     - Ensure real kernel paths are tested, not mocked stubs
> 
> 4. ttynull driver tests:
>     - Validate data sink behavior of the null driver
>     - Provide a minimal driver contract baseline
> 
> 5. Optional coverage support:
>     - GCOV integration for test coverage analysis
> 
> Future Work
> -----------
> With this foundation merged, follow-up work can:
> - Add more coverage of TTY core functions
> - Enable each TTY driver to maintain its own KUnit suite
> - Introduce stress tests and race detection
> - Extend to include more tests for other tty drivers:
>    - UART drivers: test interrupt handling without hardware
>    - USB serial: validate disconnect and reconnect sequences
>    - PTY drivers: test resize, flow control, and hangups
>    - Virtual consoles: test Unicode and input handling
>    
> Testing
> -------
> - All patches pass `checkpatch.pl`
> - Verified on x86_64 with:
>      ./tools/testing/kunit/kunit.py run \
>          --kunitconfig=.kunit/ \
>          --kunitconfig=drivers/tty/tests/.kunitconfig \
>          --arch=x86_64
> - All tests pass (working around tty_read wrapper in progress)
> 
> Feedback welcome! :)

Wow, looks good. Has it found something yet :)?


FWIW
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs
