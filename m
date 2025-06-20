Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B552E7F13;
	Fri, 20 Jun 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434321; cv=none; b=rXodaiXqx4epwyXu/0bYk+FWbtlPiZWUyxsUpe5RZzsV8HkFMUXA4AKO81BhRBo7eCvdgMDLDUf51I9GXfjLL6owAqh7QcqMTMF7ImYn99pXXSu3yV1LjnZ+ypGjm4ppKz4BO9qtGVqKi0QOmwIGr1nh8vDk5zQfrZ/wPQkRG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434321; c=relaxed/simple;
	bh=vsYN0kNwPk9M38AomU5wS4W5qcHymhLXI6Q9WrYbACc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FsrhlyFxxCOjkLZI3Nef84omYabaOOPhb4wVRxhx2coejKqs4G32IXYfQWcryc77HEsjaWNBs/jb6wYOifEu3ze4JJ/j2KeKVR0FNrfI9B2yWDVkS4QOp2VOo/6pVSenp5Hsg03VCpR5OErNxft+0ZvWmNeGRz4c+zjOLT+X+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNJCi0Jd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+D98VrXK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNJCi0Jd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+D98VrXK"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750434316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRasoAf86UvMVNSfJDyTQbAWje5bM+KDr1G1hgdDfEs=;
	b=HNJCi0Jd/ZLNOsQCSs/tAPCrfmflLF5AiXX3mwSEGz4cCYRZN6q/FhpOvb49AdmaBGvuHv
	Av3cHnDHDZTduSKOeQqFJ7cYMCN2eWwcmYdwPSDafQ3t1qu4s8i9ig13ZhrBRVxczOrrju
	7N0LHDXm88LCR7K9QGh7AuJsrZGW95ouYo2o7jJa/c3AlJPtza/EDNKODY86Do3I1aNum/
	qGWccPwOkhGInS8QsmQYadufeSmOz+DH0/mVC5U62ZbdBA9p0T4REbU9Yh99ywPGypcAA2
	2RFXBb2NkmCZPg8bZfxQylEPrkY8A7tjTUWXw3KbutCgKp1IgBRQU3jP+oYZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750434316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QRasoAf86UvMVNSfJDyTQbAWje5bM+KDr1G1hgdDfEs=;
	b=+D98VrXKw7IagiGrRJBS8PGYp+GEQTGnISyjliozgrXhhDELu8zjdPdSYVAP/Au+veoU3t
	l6wSABhaRK9NfVDg==
To: Petr Mladek <pmladek@suse.com>, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 5/7] arch: um: kmsg_dump: Don't check for CON_ENABLED
In-Reply-To: <aFAdGas9yGB4zhqc@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-5-f427c743dda0@suse.com>
 <aFAdGas9yGB4zhqc@pathway.suse.cz>
Date: Fri, 20 Jun 2025 17:51:15 +0206
Message-ID: <84tt4aifhw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-16, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-06-06 23:53:47, Marcos Paulo de Souza wrote:
>> All consoles found on for_each_console are registered, meaning that all of
>> them are CON_ENABLED. The code tries to find an active console, so check if the
>> console is not suspended instead.
>> 
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>  arch/um/kernel/kmsg_dump.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>> index 4190211752726593dd2847f66efd9d3a61cea982..f3025b2a813453f479d720618c630bee135d4e08 100644
>> --- a/arch/um/kernel/kmsg_dump.c
>> +++ b/arch/um/kernel/kmsg_dump.c
>> @@ -31,7 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>>  		 * expected to output the crash information.
>>  		 */
>>  		if (strcmp(con->name, "ttynull") != 0 &&
>> -		    (console_srcu_read_flags(con) & CON_ENABLED)) {
>> +		    (console_srcu_read_flags(con) & CON_SUSPENDED) == 0) {
>>  			break;
>
> I think that we should actually replace the check of the
> CON_ENABLE/CON_SUSPENDED flag with
>
> 		is_console_usable(con, console_srcu_read_flags(con), true)
>
> And it should be done at the beginning of the patchset before
> changing the semantic of the flags.
>
> Motivation:
>
> There is the following comment at the beginning of the function:
>
> 	/*
> 	 * If no consoles are available to output crash information, dump
> 	 * the kmsg buffer to stdout.
> 	 */
>
> The if-condition checks for:
>
>   + "ttynull" because this special console does not show any messages
>     by definition
>
>   + disabled/suspended consoles; note that this patchset is replacing
>     CON_ENABLED with CON_SUSPENDED flag because it the state is
>     changed during suspend.
>
> But it should check also for:
>
>   + whether the console is NBCON_console and does not have con->write_atomic
>     because such a console would not be able to show the messages
>     in panic().
>
> And it should also check the global "consoles_suspended" flag. Because
> consoles won't show anything when it is set.
>
> And all these is already done by "is_console_usable()" except for
> the check of "ttynull" which is very special.
>
> How does the sound, please?

FWIW, I agree with all these points.

John
