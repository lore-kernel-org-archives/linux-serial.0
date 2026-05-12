Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B239FCC6;
	Tue, 12 May 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578152; cv=none; b=CnCBvJ+0eXd0fxwOAURjRBDqi+Vz8ymQFmxTRCYFJEOB4w1EYA8pkDkjrqnVrrWzsW+ZzURqDAcYY0x5oYxR4pUu9lLfXr61F81ajHVadKXA351LB3tQs7LpkE+MztobRihLmvoYpJNbK1m/1jFt9XJ783hr42fdgo2ksCbVI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578152; c=relaxed/simple;
	bh=7zvcKlQqTCRISlQVI7hiHCz0CNLeemKncLFgLYMC9vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUnJplECmals/JtcnxWzerDoc2VCJuYvifrTTpMBacgEjyqvOpBMEY76cFUMNkG+p16j0VYRA/kCDZ1C3GU/oxHtZ000SlIsYsc7vihpFX2vhBvmLhx/LxmD40JvU+hj3DAzghH/noi9TH3p9wggyBe3jmgiqvKePDmARkjr+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXBrrjm2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqGTUojt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXBrrjm2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqGTUojt"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778578147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHOmfgO8r/I+CGZKgsM9byfulgauMqanZrmQDWsmI+c=;
	b=jXBrrjm2f6KmF2Iguf/jhTcgh/iBv2R/gREAPlhKabsiGwI5zZ4UaznFiJPBUR1nuTnECB
	b5X2Fj4HRol8SyjaKsQqs5gCgqzftZRydFN/VlWb7nWQURrJmPhIzx20o2njjisnRUP94T
	QHAuu5RUr6Eubhs/TKJ8TyK8G/uf38bLi6iZyM1D2jWyymQC9vImFAmOx1HeZAh69vrmR7
	rHHlVjCFG9t5fLRODjGnOhQ9eQOXPAAGtHEZboVB5vN6ScQrzpvcn5i0q9IJOzCz4RqTmw
	AK1LfNhI4zGMzEUt4LdGg4IfmApt3+4gfyKvqEVYc77jc2mb0xv44nQ3f/qJDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778578147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHOmfgO8r/I+CGZKgsM9byfulgauMqanZrmQDWsmI+c=;
	b=gqGTUojtr4wsSDP1mbVm9FvBt1e/rCKaB/rPpqrmPGCG2D3uJTRt2zLsyaMoMaz70N3ghH
	bU2zThAeiTgJmJBg==
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko
 <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Joseph
 Tilahun <jtilahun@astranis.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH tty v5 3/3] serial: 8250: Add support for console flow
 control
In-Reply-To: <f9f408c5-72f5-4be8-7471-e9aee2935a5b@linux.intel.com>
References: <20260511152706.151498-1-john.ogness@linutronix.de>
 <20260511152706.151498-4-john.ogness@linutronix.de>
 <f9f408c5-72f5-4be8-7471-e9aee2935a5b@linux.intel.com>
Date: Tue, 12 May 2026 11:35:06 +0206
Message-ID: <87h5od9dst.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-05-11, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index 4f7bbdd900176..17fcff466e301 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -1175,6 +1175,14 @@ static inline bool uart_cons_flow_enabled(const s=
truct uart_port *uport)
>>  	return uport->cons_flow;
>>  }
>>=20=20
>> +static inline bool uart_console_hwflow_active(struct uart_port *uport)
>> +{
>> +	return uart_console(uport) &&
>> +	       !(uport->rs485.flags & SER_RS485_ENABLED) &&
>> +	       uart_cons_flow_enabled(uport) &&
>> +	       uart_cts_enabled(uport);
>> +}
>> +
>>  /*
>>   * The following are helper functions for the low level drivers.
>>   */
>
> Did you miss Andy's comments or choose to not act on them?

You mean these [0]? For the getter, yes. (Although I left the "is_" off
so that it matches other existing flag checking functions.)

For the setter, Andy suggested explicit enable/disable
variants. However, all the users enable/disable based on some
condition. That would mean that there would be a repeated pattern of:

	if (condition)
		uart_cons_flow_enable();
	else
		uart_cons_flow_disable();

So I decided to keep a single setter.

	uart_set_cons_flow_enabled(condition);

I renamed the setter so that it is clearer that only the enabled flag is
being set and not any other special procedures.

John Ogness

[0] https://lore.kernel.org/lkml/CAHp75Vf4YZVqXa7eH-RFeVsycdzoHijcWFnUbGv2P=
SmtPya1-w@mail.gmail.com
