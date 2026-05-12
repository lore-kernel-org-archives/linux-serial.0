Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E343911C8;
	Tue, 12 May 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591171; cv=none; b=Pyqq8GYrE2OM19SqrtCTuHO83Fr1IW9z1GeGodaOjRLB0Vfriwx8BWw8FWZNGKxBhEgHmXbBk8I9s8v+TGe8KF8OMoO2Ww/SXrHtaVOJdoZtfEHuCEYZmUepgf8GDtBKWVCHKmKpJBmSGVk4QMmOM18E+A6N/08d/Xcx7c1g3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591171; c=relaxed/simple;
	bh=nGlraGgnbAZD9nbmHtBNaxSTKkMZ7pgTtj67jhUK2us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQetSfo/bMHTNwlpD7wZTPVCXW9vIp3X2qaAW6+yBXm1Ae2xHQ5ThlcpCGaEYOqyo443cfIgaz19hBX5D6Dw3Cl2KaaN4Jxa9l3qWRP3E/cnmTDN1Sv2VHjdRsfwaMeDuDtv6Ux3n7SzVrG3wPxDAxFRHjIH2qkVike1WfTQk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=cGLoqIfQ; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="cGLoqIfQ"
Received: from [IPV6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec] (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id BDAB3780504;
	Tue, 12 May 2026 15:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778591167;
	bh=nGlraGgnbAZD9nbmHtBNaxSTKkMZ7pgTtj67jhUK2us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cGLoqIfQHIRlXDg7wRLbo4Skyhu6Zo6H61wxoireWn4cfK/X81CrQJA29fjwBVk+4
	 pAfUyoGALpoq7pc8CrZ6ca1vODxtWASYmmXYV/P8wOtutTJvJnMnqADDxOn7ARcKnL
	 +/eDLzdnpKnPYSSehyWBG7u7HxFSUnRkBcztKPY9nJvBZWuILOE1AtkBfTAS2sKmgX
	 hVThl4DuQn6EmWPrz5Wg8cjsHdmGmYVmuZ4hsPayoh03kxd1ICCpgqgQfl4ax2efWL
	 cgUFTXjfCQZtsdEfVDu+tZ/8PtBqk0O5d7jK/XEJhG6b0U9TXHzaIflBD8zUtVmNEf
	 6GF1JSkk7IxRg==
Message-ID: <122f6431-2241-4367-be28-bfd3b31f5333@free.fr>
Date: Tue, 12 May 2026 15:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] serial: 8250: BREAK + SysRq dispatch silently broken
 since 8324a54f604d
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
 <4bab4248-1c49-3f68-d327-fc00a4d7114b@linux.intel.com>
Content-Language: en-US
From: Jacques Nilo <jnilo@free.fr>
In-Reply-To: <4bab4248-1c49-3f68-d327-fc00a4d7114b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026, Ilpo Järvinen wrote:

 > I seem to have come blind to the (unlock function) names. I'm sorry
 > about breaking this.

No problem at all -- the asymmetry between the lock and unlock helper
names is exactly the kind of thing that's easy to miss in a refactor.

 > 8250_dw's handle_irq also uses guard() which was the reason for this
 > change in the first place so it should be fixed as well.

Confirmed -- dw8250_handle_irq() at drivers/tty/serial/8250/8250_dw.c:421
does the same guard(uart_port_lock_irqsave)(p) before
serial8250_handle_irq_locked(). Same bug.

 > > Option B -- fix the guard destructor in serial_core.h:
 >
 > There will be many such sites so this doesn't sound a great idea.
 >
 > I wonder why we couldn't instead do another DEFINE_GUARD() for the
 > sysrq case?

Agreed, that's cleaner. The lock side is identical -- only the unlock
needs the sysrq-aware variant -- so a second lock-guard macro keyed off
the unlock destructor fits well:

   DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave_sysrq, struct uart_port,
                       uart_port_lock_irqsave(_T->lock, &_T->flags),
uart_unlock_and_check_sysrq_irqrestore(_T->lock,
  _T->flags),
                       unsigned long flags);

Callers that may capture sysrq_ch (currently serial8250_handle_irq and
dw8250_handle_irq) opt in by using guard(uart_port_lock_irqsave_sysrq);
the existing guard(uart_port_lock_irqsave) keeps its current plain-unlock
semantics for everyone else.

Naming-wise I'm not attached to "_sysrq" -- if you'd prefer something
shorter (e.g. uart_port_rx_lock_irqsave) or aligned with another
convention in the tree, happy to take direction.

 > I suppose thought the lockdep assert in serial8250_handle_irq_locked()
 > cannot discern that the correct one of them is being used by the
 > caller. But at least it's context comment should mention that the
 > correct guard/unlock variant should be used.

Right -- both guards take port->lock so lockdep can't distinguish them.
I'll update the Context: line on serial8250_handle_irq_locked() to spell
out the requirement, e.g.:

   /*
    * Context: port's lock must be held by the caller, and must be released
    * via guard(uart_port_lock_irqsave_sysrq) or
    * uart_unlock_and_check_sysrq_irqrestore() so a SysRq character
    * captured by serial8250_read_char() is dispatched on unlock.
    */

Plan, then, for a v1 patch series against tty-next:

   1. include/linux/serial_core.h: add the new lock-guard macro.
   2. drivers/tty/serial/8250/8250_port.c: switch serial8250_handle_irq()
      to guard(uart_port_lock_irqsave_sysrq); update the Context comment
      on serial8250_handle_irq_locked().
   3. drivers/tty/serial/8250/8250_dw.c: switch dw8250_handle_irq() to
      the same guard.

I'll mark it with Fixes: 8324a54f604d and Cc: stable for the kernels
that carry the regression. Let me know if the naming or the Context
wording wants adjusting before I send.

Thanks for the quick read,

Jacques

Le 12/05/2026 à 14:58, Ilpo Järvinen a écrit :
> On Tue, 12 May 2026, Jacques Nilo wrote:
>
>> Hi,
>>
>> We hit what looks like a silent SysRq-over-serial regression on a 6.18
>> build of the 8250 driver. Posting as a report rather than a patch because
>> there are at least two reasonable fixes and I'd like a maintainer call
>> before sending one.
>>
>> Symptom
>> =======
>>
>> CONFIG_MAGIC_SYSRQ=y, CONFIG_MAGIC_SYSRQ_SERIAL=y,
>> CONFIG_SERIAL_8250_CONSOLE=y.
>>
>> A BREAK followed by a SysRq key on the console UART is consumed by the
>> kernel (BREAK counter in /proc/tty/driver/serial increments correctly)
>> but is never dispatched to handle_sysrq(). dmesg shows no "sysrq: ..."
>> line.
>>
>> `echo h > /proc/sysrq-trigger` still works, isolating the regression to
>> the serial input path. Verified end-to-end on an RTL8196E MIPS board
>> running 6.18.24; the affected code is in the generic 8250 core, so the
>> issue is not platform-specific.
>>
>> Path
>> ====
>>
>>    serial8250_default_handle_irq()
>>      -> serial8250_handle_irq() [8250_port.c:1835]
>>           guard(uart_port_lock_irqsave)(port);  [8250_port.c:1840]
>>           serial8250_handle_irq_locked()
>>             -> serial8250_rx_chars()
>>                -> serial8250_read_char()
>>                   -> uart_handle_break()                 -- arms port->sysrq
>>                   -> uart_prepare_sysrq_char(port, ch)   -- captures sysrq_ch
>>           /* guard scope ends -> port unlock */
>>
>> The captured port->sysrq_ch is dispatched to handle_sysrq() at unlock
>> time -- but only by uart_unlock_and_check_sysrq[_irqrestore]() (see
>> include/linux/serial_core.h:1239). The scope guard's destructor at
>> serial_core.h:797 is plain uart_port_unlock_irqrestore(), which skips
>> the dispatch:
>>
>>    DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
>>                        uart_port_lock_irqsave(_T->lock, &_T->flags),
>>                        uart_port_unlock_irqrestore(_T->lock, _T->flags),
>>                        unsigned long flags);
>>
>> So sysrq_ch stays in the struct until the next BREAK clears it.
>>
>> Bisection
>> =========
>>
>>    commit 8324a54f604d ("serial: 8250: Add serial8250_handle_irq_locked()")
>>
>> Pre-split serial8250_handle_irq() used explicit uart_port_lock_irqsave()
>> + uart_unlock_and_check_sysrq_irqrestore(). The split moved the body into
>> _locked() and replaced the explicit lock pair with
>> guard(uart_port_lock_irqsave), losing the sysrq-aware unlock.
>>
>> This was the very condition Johan Hovold's 853a9ae29e978 ("serial: 8250:
>> fix handle_irq locking", 2021) introduced
>> uart_unlock_and_check_sysrq_irqrestore() to address -- the new helper was
>> deliberately the sysrq-aware variant. The guard() conversion undoes that
>> intent.
> I seem to have come blind to the (unlock function) names. I'm sorry about
> breaking this.
>   
>> Reproducer
>> ==========
>>
>> On any 8250-driven console with CONFIG_MAGIC_SYSRQ_SERIAL=y:
>>
>>    # On the host side:
>>    python3 -c 'import os,fcntl,termios,time
>>    fd=os.open("/dev/ttyUSB0",os.O_RDWR|os.O_NOCTTY)
>>    fcntl.ioctl(fd,0x5427); time.sleep(0.3); fcntl.ioctl(fd,0x5428)
>>    time.sleep(0.05); os.write(fd,b"h"); time.sleep(0.3)'
>>
>>    # On the gateway:
>>    grep brk /proc/tty/driver/serial      # counter increments
>>    dmesg | grep sysrq:                   # empty -- no dispatch
>>
>> Two ways to fix
>> ===============
>>
>> Option A -- surgical, only fix serial8250_handle_irq():
>>
>>    int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>>    {
>>            unsigned long flags;
>>
>>            if (iir & UART_IIR_NO_INT)
>>                    return 0;
>>
>>            uart_port_lock_irqsave(port, &flags);
>>            serial8250_handle_irq_locked(port, iir);
>>            uart_unlock_and_check_sysrq_irqrestore(port, flags);
>>
>>            return 1;
>>    }
>>
>> Restores the pre-split behaviour. Doesn't touch the guard infrastructure.
>> Drawback: leaves uart_port_lock_irqsave() as a generic primitive that
>> silently swallows pending sysrq_ch in any other call site that processes
>> RX under the guard. There are no such sites today in 8250_port.c
>> (uart_prepare_sysrq_char is only reachable through serial8250_handle_irq),
>> but the trap remains.
> 8250_dw's handle_irq also uses guard() which was the reason for this
> change in the first place so it should be fixed as well.
>
>> Option B -- fix the guard destructor in serial_core.h:
>>
>>    DEFINE_LOCK_GUARD_1(uart_port_lock_irqsave, struct uart_port,
>>                        uart_port_lock_irqsave(_T->lock, &_T->flags),
>> uart_unlock_and_check_sysrq_irqrestore(_T->lock,
>>   _T->flags),
>>                        unsigned long flags);
>>
>> uart_unlock_and_check_sysrq_irqrestore() short-circuits to plain unlock
>> when !port->has_sysrq, so no overhead on non-sysrq ports. Fixes all
>> current and future guard(uart_port_lock_irqsave) users in one place.
>> Drawback: changes the semantics of a shared serial primitive. Some
>> callers in 8250_port.c run under that guard from non-RX contexts
>> (serial8250_set_mctrl, wait_for_xmitr, etc.); the only observable effect
>> there would be a one-time handle_sysrq() call if a previous BREAK left
>> sysrq_ch set -- functionally desirable, but a behaviour change worth
>> documenting.
> There will be many such sites so this doesn't sound a great idea.
>
> I wonder why we couldn't instead do another DEFINE_GUARD() for the sysrq
> case?
>
> I suppose thought the lockdep assert in serial8250_handle_irq_locked()
> cannot discern that the correct one of them is being used by the caller.
> But at least it's context comment should mention that the correct
> guard/unlock variant should be used.
>
>> I have a tested Option A patch against 6.18.24 (verified the dispatch
>> fires and produces the SysRq help dump). Happy to send it formally, or
>> to retarget to Option B if that's the preferred direction.
>>
>> Thanks,
>>
>> Jacques
>>
